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

export function generateLuaDoc(functions: FunctionDescriptor[], version?: string, includeTimestamp: boolean = true): string {
    // Collect all unique types used in the API
    const customTypes = new Set<string>();
    const reaperArrayMethods: FunctionDescriptor[] = [];
    const regularFunctions: FunctionDescriptor[] = [];

    // Separate ReaperArray methods from regular functions
    for (const func of functions) {
        // Check if it's a ReaperArray method (has self parameter of type ReaperArray)
        if (func.parameters && func.parameters.length > 0 && func.parameters[0] &&
            func.parameters[0].name === 'self' && func.parameters[0].type === 'ReaperArray') {
            reaperArrayMethods.push(func);
        } else {
            regularFunctions.push(func);
        }

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

    // Add header comment with generation info
    luadoc += '---@diagnostic disable\n';
    luadoc += '\n';
    luadoc += '-- REAPER API LuaDoc Type Definitions\n';
    luadoc += '-- Auto-generated from REAPER API documentation\n';
    if (version) {
        luadoc += `-- Generated from REAPER v${version}\n`;
    }
    if (includeTimestamp) {
        luadoc += `-- Generated on: ${new Date().toISOString()}\n`;
    }
    luadoc += '-- \n';
    luadoc += '-- This file provides type definitions for VS Code autocompletion\n';
    luadoc += '-- when working with REAPER Lua scripts.\n';
    luadoc += '\n';

    // Generate class declarations for custom types (sorted for consistency)
    const sortedCustomTypes = Array.from(customTypes).filter(type => type !== 'ReaperArray').sort();
    for (const type of sortedCustomTypes) {
        luadoc += `---@class ${type}\n`;
    }

    if (sortedCustomTypes.length > 0) {
        luadoc += '\n';
    }

    // Generate ReaperArray class with its methods
    if (reaperArrayMethods.length > 0) {
        luadoc += `---@class ReaperArray\n`;
        luadoc += `local ReaperArray = {}\n\n`;

        // Generate ReaperArray methods
        for (const func of reaperArrayMethods) {
            // Add parameter documentation (skip 'self' parameter)
            const methodParams = func.parameters.slice(1); // Remove 'self' parameter
            for (const param of methodParams) {
                luadoc += `---@param ${param.name} ${param.type}`;
                if (param.description) {
                    luadoc += ` ${param.description}`;
                }
                luadoc += `\n`;
            }

            if (func.returns.length > 0) {
                luadoc += `---@return `;
                luadoc += func.returns.map(ret => {
                    // If the return value has a meaningful name (not just 'return'), include it
                    if (ret.name && ret.name !== 'return') {
                        return `${ret.type} ${ret.name}`;
                    } else {
                        return ret.type;
                    }
                }).join(', ');
                luadoc += `\n`;
            }

            // Add description as a comment if available
            if (func.description) {
                luadoc += `--- ${func.description}\n`;
            }

            // Add method declaration
            luadoc += `function ReaperArray:${func.name}(`;
            if (methodParams.length > 0) {
                luadoc += methodParams.map(param => param.name).join(', ');
            }
            luadoc += `) end\n\n`;
        }
    } else {
        // Add basic ReaperArray class if no methods found
        luadoc += `---@class ReaperArray\n\n`;
    }

    // Add global reaper class declaration
    luadoc += `---@class reaper\n`;
    luadoc += `reaper = {}\n\n`; for (const func of regularFunctions) {
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
            luadoc += func.returns.map(ret => {
                // If the return value has a meaningful name (not just 'return'), include it
                if (ret.name && ret.name !== 'return') {
                    return `${ret.type} ${ret.name}`;
                } else {
                    return ret.type;
                }
            }).join(', ');
            luadoc += `\n`;
        }

        // Add description as a comment if available
        if (func.description) {
            luadoc += `--- ${func.description}\n`;
        }

        // Add function declaration - handle special functions that already have prefix
        const functionName = func.name.startsWith('reaper.') || func.name.startsWith('gfx.')
            ? func.name
            : `reaper.${func.name}`;
        luadoc += `function ${functionName}(`;

        if (func.parameters && func.parameters.length > 0) {
            luadoc += func.parameters.map(param => param.name).join(', ');
        }

        luadoc += `) end\n\n`;
    }

    return luadoc;
}