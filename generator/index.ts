import { readFile, writeFile } from 'fs/promises';
import { parseContent } from './parser';
import { generateLuaDoc } from './luadoc';
import path from 'path';

/**
 * Determines if a string is a URL
 */
function isUrl(input: string): boolean {
    try {
        new URL(input);
        return true;
    } catch {
        return false;
    }
}

/**
 * Fetches content from a URL or reads from a file
 */
async function getContent(input: string): Promise<string> {
    if (isUrl(input)) {
        console.log(`Fetching content from URL: ${input}`);
        const response = await fetch(input);
        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }
        return await response.text();
    } else {
        console.log(`Reading content from file: ${input}`);
        return await readFile(input, 'utf-8');
    }
}

/**
 * Main function
 */
async function main() {
    const args = process.argv.slice(2);

    if (args[0] === '--help' || args[0] === '-h') {
        console.log('REAPER API LuaDoc Generator');
        console.log('');
        console.log('Usage: bun run index.ts <file-path-or-url>');
        console.log('');
        console.log('Examples:');
        console.log('  bun run index.ts api.html');
        console.log('  bun run index.ts https://www.reaper.fm/sdk/reascript/reascripthelp.html');
        console.log('');
        console.log('This tool parses REAPER API HTML documentation and generates');
        console.log('LuaDoc type definitions for VS Code autocompletion.');
        process.exit(args.length === 0 ? 1 : 0);
    }
    else if (args.length == 0) {
        console.log('No file path or URL provided. Using https://www.reaper.fm/sdk/reascript/reascripthelp.html by default.');
    }

    const input = args[0] || 'https://www.reaper.fm/sdk/reascript/reascripthelp.html';

    if (!input) {
        console.error('Please provide a file path or URL');
        process.exit(1);
    }

    try {
        const content = await getContent(input);
        const parseResult = await parseContent(content);

        // Don't include timestamp when running in CI to avoid false positives in change detection
        const isCI = process.env.CI === 'true' || process.env.GITHUB_ACTIONS === 'true';
        const includeTimestamp = !isCI;

        const luadoc = generateLuaDoc(Object.values(parseResult.functions), parseResult.version, includeTimestamp);
        const outputFile = path.join("..", "luadoc", "reaper-api.lua");
        await writeFile(outputFile, luadoc, 'utf-8');

        let message = `LuaDoc generated successfully and saved to ${outputFile}`;
        if (parseResult.version) {
            message += ` (REAPER v${parseResult.version})`;
        }
        if (isCI) {
            message += ` [CI mode - timestamp excluded]`;
        }
        console.log(message);

    } catch (error) {
        console.error('Error:', error instanceof Error ? error.message : String(error));
        process.exit(1);
    }
}

// Run the main function if this file is executed directly
if (import.meta.main) {
    await main();
}

