import type { FunctionDescriptor, FunctionArgument } from "./function-descriptor";
import { JSDOM } from 'jsdom';

// Lua reserved keywords that need to be renamed if used as parameter names
const LUA_RESERVED_KEYWORDS = new Set([
    'and', 'break', 'do', 'else', 'elseif', 'end', 'false', 'for',
    'function', 'if', 'in', 'local', 'nil', 'not', 'or', 'repeat',
    'return', 'then', 'true', 'until', 'while'
]);

export async function parseContent(content: string): Promise<Record<string, FunctionDescriptor>> {
    const dom = new JSDOM(content);
    const document = dom.window.document;

    const functions: Record<string, FunctionDescriptor> = {};

    // Find all Lua function divs
    const luaFunctionDivs = document.querySelectorAll('div.l_func');

    for (const luaDiv of luaFunctionDivs) {
        try {
            const functionDescriptor = parseLuaFunction(luaDiv, document);
            if (functionDescriptor) {
                functions[functionDescriptor.name] = functionDescriptor;
            }
        } catch (error) {
            console.warn(`Failed to parse function: ${error}`);
        }
    }

    return functions;
}

function parseLuaFunction(luaDiv: Element, document: Document): FunctionDescriptor | null {
    // Get the code element containing the function signature
    const codeElement = luaDiv.querySelector('code');
    if (!codeElement) {
        return null;
    }

    const signature = codeElement.textContent?.trim();
    if (!signature) {
        return null;
    }

    // Extract function name and parameters from signature
    // Example: "boolean reaper.AudioAccessorValidateState(AudioAccessor accessor)"
    const functionMatch = signature.match(/reaper\.(\w+)\s*\((.*?)\)/);
    if (!functionMatch || !functionMatch[1] || functionMatch[2] === undefined) {
        return null;
    }

    const functionName = functionMatch[1];
    const parametersString = functionMatch[2].trim();

    // Extract return type (everything before "reaper.")
    const returnTypeMatch = signature.match(/^(.*?)\s+reaper\./);
    const returnType = returnTypeMatch && returnTypeMatch[1] ? returnTypeMatch[1].trim() : 'void';

    // Parse parameters
    const parameters = parseParameters(parametersString);

    // Parse return type
    const returns = parseReturnType(returnType);

    // Get description - look for the function anchor and description
    const description = getDescriptionForFunction(functionName, document);

    return {
        name: functionName,
        description,
        parameters,
        returns
    };
}

function getDescriptionForFunction(functionName: string, document: Document): string {
    // Find the anchor with the function name
    const anchor = document.querySelector(`a[name="${functionName}"]`);
    if (!anchor) {
        return '';
    }

    const window = document.defaultView;
    if (!window) {
        return '';
    }

    // Find the p_func div following this anchor
    let current = anchor.nextElementSibling;
    let pFuncDiv: Element | null = null;

    // Look for the p_func div that comes after this function's anchor
    while (current) {
        if (current.classList.contains('p_func')) {
            pFuncDiv = current;
            break;
        }
        current = current.nextElementSibling;
    }

    if (!pFuncDiv) {
        return '';
    }

    // Now look for the description text that comes after p_func
    let sibling = pFuncDiv.nextSibling;
    while (sibling) {
        if (sibling.nodeType === window.Node.TEXT_NODE) {
            const text = sibling.textContent?.trim();
            if (text && text.length > 15) {
                return cleanDescriptionText(text);
            }
        } else if (sibling.nodeType === window.Node.ELEMENT_NODE) {
            const element = sibling as Element;
            // Stop if we hit the next function anchor
            if (element.tagName === 'A' && element.getAttribute('name')) {
                break;
            }

            // Skip br tags and look for meaningful text
            if (element.tagName !== 'BR') {
                const text = element.textContent?.trim();
                if (text && text.length > 15 &&
                    !element.classList.contains('c_func') &&
                    !element.classList.contains('e_func') &&
                    !element.classList.contains('l_func') &&
                    !element.classList.contains('p_func')) {
                    return cleanDescriptionText(text);
                }
            }
        }
        sibling = sibling.nextSibling;
    }

    return '';
}

function sanitizeParameterName(name: string): string {
    // If the parameter name is a Lua reserved keyword, append an underscore
    if (LUA_RESERVED_KEYWORDS.has(name.toLowerCase())) {
        return `${name}_`;
    }
    return name;
}

function parseParameters(parametersString: string): FunctionArgument[] {
    if (!parametersString || parametersString.trim() === '') {
        return [];
    }

    const parameters: FunctionArgument[] = [];

    // Split by comma, but be careful of nested types
    const paramParts = parametersString.split(',').map(p => p.trim());

    for (const paramPart of paramParts) {
        if (!paramPart) continue;

        // Extract type and name
        // Example: "AudioAccessor accessor" or "number startTime"
        const paramMatch = paramPart.match(/^(.*?)\s+(\w+)$/);
        if (paramMatch && paramMatch[1] && paramMatch[2]) {
            const type = paramMatch[1].trim();
            let name = paramMatch[2].trim();

            name = sanitizeParameterName(name);

            parameters.push({
                name,
                value: '', // We don't have default values in the signature
                type: mapLuaType(type),
                required: true // Assume all parameters are required unless specified otherwise
            });
        }
    }

    return parameters;
}

function parseReturnType(returnType: string): FunctionArgument[] {
    if (!returnType || returnType === 'void') {
        return [];
    }

    // Handle complex return type strings like "boolean retval, boolean mute ="
    // Remove trailing equals and other non-type content
    const cleanReturnType = returnType.replace(/\s*=\s*$/, '').trim();

    // Split by commas to handle multiple return values
    const parts = cleanReturnType.split(',').map(part => part.trim());

    const returns: FunctionArgument[] = [];

    for (const part of parts) {
        if (!part) continue;

        // Extract type and name from patterns like "boolean retval" or "optional string info"
        const typeMatch = part.match(/^(optional\s+)?(\w+)(?:\s+\w+)?$/);
        if (typeMatch && typeMatch[2]) {
            const isOptional = !!typeMatch[1];
            const type = typeMatch[2];

            returns.push({
                name: 'return',
                value: '',
                type: mapLuaType(type),
                required: !isOptional
            });
        } else {
            // Fallback: treat the whole part as a type if we can't parse it
            const simpleType = part.split(/\s+/)[0]; // Take first word as type
            if (simpleType) {
                returns.push({
                    name: 'return',
                    value: '',
                    type: mapLuaType(simpleType),
                    required: true
                });
            }
        }
    }

    return returns;
}

function mapLuaType(type: string): string {
    // Map HTML italic tags and clean up types
    const cleanType = type.replace(/<\/?i>/g, '').trim();

    // Map common types to more standard names
    const typeMap: Record<string, string> = {
        'boolean': 'boolean',
        'number': 'number',
        'string': 'string',
        'AudioAccessor': 'AudioAccessor',
        'MediaTrack': 'MediaTrack',
        'MediaItem': 'MediaItem',
        'Take': 'Take',
        'PCM_source': 'PCM_source'
    };

    return typeMap[cleanType] || cleanType;
}

function getDescription(luaDiv: Element): string {
    // Find the parent container and look for description text after all function divs
    let current = luaDiv.parentElement;
    if (!current) {
        return '';
    }

    const document = luaDiv.ownerDocument;
    const window = document.defaultView;
    if (!window) {
        return '';
    }

    // The description usually follows right after the last function div (p_func)
    // Let's walk through siblings looking for the p_func, then get the next text
    let pFuncDiv = current.parentElement?.querySelector('div.p_func');
    if (pFuncDiv) {
        // Look for text content after p_func div
        let sibling = pFuncDiv.nextSibling;
        while (sibling) {
            if (sibling.nodeType === window.Node.TEXT_NODE) {
                const text = sibling.textContent?.trim();
                if (text && text.length > 15) {
                    return cleanDescriptionText(text);
                }
            }
            sibling = sibling.nextSibling;
        }

        // If no direct text sibling, check the next element
        let nextElement = pFuncDiv.nextElementSibling;
        if (nextElement && !nextElement.querySelector('a[name]')) {
            const text = nextElement.textContent?.trim();
            if (text && text.length > 15) {
                return cleanDescriptionText(text);
            }
        }
    }

    // Fallback: look for any text after our lua div
    let sibling = luaDiv.nextSibling;
    while (sibling) {
        if (sibling.nodeType === window.Node.TEXT_NODE) {
            const text = sibling.textContent?.trim();
            if (text && text.length > 15) {
                return cleanDescriptionText(text);
            }
        }
        sibling = sibling.nextSibling;
    }

    return '';
}

function cleanDescriptionText(text: string): string {
    return text
        .replace(/\s+/g, ' ')
        .replace(/\.\s*<br.*?>/gi, '.')
        .replace(/<[^>]*>/g, '')
        .replace(/\s*\.\s*$/, '.')
        .trim();
}