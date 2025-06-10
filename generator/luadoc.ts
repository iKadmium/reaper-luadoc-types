import type { FunctionDescriptor } from "./function-descriptor";

// Built-in Lua types that don't need class declarations
const BUILTIN_TYPES = new Set([
    'any',
    'boolean',
    'number',
    'string',
    'table',
    'function',
    'userdata',
    'thread',
    'nil',
    'void',
    'integer' // Add integer as a built-in type
]);

function isBuiltinType(type: string): boolean {
    // Remove "optional " prefix if present
    const cleanType = type.replace(/^optional\s+/, '');
    
    // Check if it's a built-in type
    if (BUILTIN_TYPES.has(cleanType)) {
        return true;
    }
    
    // Filter out invalid type names (containing dots or other special characters)
    if (cleanType.includes('.') || cleanType.includes(' ') || !cleanType.match(/^[a-zA-Z_][a-zA-Z0-9_]*$/)) {
        return true; // Treat as built-in to exclude from class declarations
    }
    
    return false;
}

export function generateLuaDoc(functions: FunctionDescriptor[]): string {
    // Collect all unique types used in the API
    const customTypes = new Set<string>();

    for (const func of functions) {
        // Collect parameter types
        for (const param of func.parameters) {
            if (!isBuiltinType(param.type)) {
                customTypes.add(param.type);
            }
        }

        // Collect return types
        for (const ret of func.returns) {
            if (!isBuiltinType(ret.type)) {
                customTypes.add(ret.type);
            }
        }
    }

    let luadoc = '';

    // Generate class declarations for custom types (sorted for consistency)
    const sortedCustomTypes = Array.from(customTypes).sort();
    for (const type of sortedCustomTypes) {
        luadoc += `---@class ${type}\n`;
    }

    if (sortedCustomTypes.length > 0) {
        luadoc += '\n';
    }

    // Add global reaper class declaration
    luadoc += `---@class reaper\n`;
    luadoc += `reaper = {}\n\n`;

    for (const func of functions) {
        // Add LuaLS/EmmyLua style documentation
        for (const param of func.parameters) {
            luadoc += `---@param ${param.name} ${param.type}`;
            if (param.description) {
                luadoc += ` ${param.description}`;
            }
            luadoc += `\n`;
        }

        if (func.returns.length > 0) {
            luadoc += `---@return `;
            luadoc += func.returns.map(ret => ret.type).join(', ');
            luadoc += `\n`;
        }

        // Add description as a comment if available
        if (func.description) {
            luadoc += `--- ${func.description}\n`;
        }

        // Add function declaration with "reaper." prefix
        luadoc += `function reaper.${func.name}(`;

        if (func.parameters.length > 0) {
            luadoc += func.parameters.map(param => param.name).join(', ');
        }

        luadoc += `) end\n\n`;
    }

    return luadoc;
}