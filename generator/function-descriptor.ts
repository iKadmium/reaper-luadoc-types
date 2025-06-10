export interface FunctionDescriptor {
    name: string; // The name of the function
    description: string; // A brief description of what the function does
    parameters: FunctionArgument[]; // An array of arguments that the function accepts
    returns: FunctionArgument[]
}

export interface FunctionArgument {
    name: string; // The name of the argument
    value: string; // The value of the argument
    type: string; // The type of the argument (e.g., 'string', 'number', 'boolean', etc.)
    description?: string; // An optional description of the argument
    required: boolean; // Whether the argument is required or optional
}