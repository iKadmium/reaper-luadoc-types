# REAPER API LuaDoc Type Definitions

[![Update REAPER API Documentation](https://github.com/iKadmium/reaper-luadoc-types/actions/workflows/update-api-docs.yml/badge.svg)](https://github.com/iKadmium/reaper-luadoc-types/actions/workflows/update-api-docs.yml)

This project automatically generates comprehensive LuaDoc type definitions for the REAPER API, enabling full autocompletion and type checking in VS Code with the Lua language server.

## Features

- 🔄 **Automatic Updates**: GitHub workflow runs daily to check for REAPER API changes
- 📦 **Automatic Releases**: Creates GitHub releases when API changes are detected
- 📝 **Complete Type Definitions**: All 700+ REAPER API functions with proper type annotations
- 🏷️ **Named Return Values**: Functions with multiple returns show parameter names (e.g., `boolean retval, integer fxindex, integer parmidx`)
- 📖 **Full Descriptions**: Complete function documentation with cross-references
- 🎯 **VS Code Integration**: Works seamlessly with Lua language server for autocompletion
- 🔧 **Special Functions**: Includes special Lua functions like `reaper.atexit()`, `reaper.defer()`, and `gfx.*` functions
- 🏷️ **Version Tracking**: Releases are tagged with the REAPER version (e.g., `v7.39`)

## Usage

### Download from Releases (Recommended)

The easiest way to get the latest REAPER API type definitions is to download them from the [Releases page](https://github.com/iKadmium/reaper-luadoc-types/releases). Each release is tagged with the corresponding REAPER version (e.g., `v7.39`) and includes:

- `reaper-api.lua` - Complete type definitions file
- Installation instructions
- Version-specific documentation

### For REAPER Script Development

1. Download the latest `reaper-api.lua` from [Releases](https://github.com/iKadmium/reaper-luadoc-types/releases)
2. Copy it to your REAPER scripts directory or VS Code workspace
3. Install the [Lua extension](https://marketplace.visualstudio.com/items?itemName=sumneko.lua) in VS Code
4. The type definitions will automatically provide autocompletion and documentation

### Manual Generation

If you want to generate the type definitions yourself:

```bash
cd generator
bun install
bun generate
```

This will:
- Fetch the latest REAPER API documentation from https://www.reaper.fm/sdk/reascript/reascripthelp.html
- Parse all function signatures, parameters, and return types
- Generate comprehensive LuaDoc annotations
- Output to `luadoc/reaper-api.lua`

### Command Line Options

```bash
# Use local HTML file
bun generate api.html

# Use remote URL (default)
bun generate https://www.reaper.fm/sdk/reascript/reascripthelp.html

# Show help
bun generate --help
```

## Project Structure

```
├── generator/           # TypeScript generator source code
│   ├── index.ts        # Main entry point and CLI
│   ├── parser.ts       # HTML parsing logic
│   ├── luadoc.ts       # LuaDoc generation
│   └── api.html        # Local copy of REAPER API docs
├── luadoc/             # Generated output
│   └── reaper-api.lua  # Complete REAPER API type definitions
└── .github/workflows/  # Automation
    ├── update-api-docs.yml # Daily update workflow
    └── create-release.yml  # Automatic release workflow
```

## Automated Workflow

This project includes full automation:

1. **Daily Updates**: Checks for REAPER API changes every day at 6 AM UTC
2. **Pull Request Creation**: When changes are detected, automatically creates a PR with updated type definitions
3. **Automatic Releases**: When the PR is merged, automatically creates a GitHub release tagged with the REAPER version (e.g., `v7.39`)
4. **Version Extraction**: The release version is automatically extracted from the REAPER version in the generated lua file header

### Workflow Files

- **`update-api-docs.yml`**: Daily scheduled workflow that fetches the latest REAPER API documentation and creates PRs for changes
- **`create-release.yml`**: Triggered when `luadoc/reaper-api.lua` changes on the main branch, creates releases with proper versioning

## How It Works

1. **HTML Parsing**: Extracts function signatures from REAPER's HTML documentation
2. **Type Mapping**: Converts HTML types to proper Lua types with intelligent type inference
3. **Return Type Analysis**: Parses complex return signatures like `"boolean retval, integer fxindex, integer parmidx"`
4. **Description Extraction**: Captures complete function descriptions including cross-references
5. **LuaLS Generation**: Outputs proper `---@param` and `---@return` annotations for the Lua language server

## Generated Output Example

```lua
---@class MediaTrack
---@class MediaItem
---@class TrackEnvelope

---@class reaper
reaper = {}

---@param project ReaProject
---@param track MediaTrack
---@param index integer
---@return boolean retval, integer fxindex, integer parmidx
--- Get information about a specific FX parameter knob (see CountTCPFXParms).
function reaper.GetTCPFXParm(project, track, index) end

---@param is_new_value integer
---@param filename string
---@param sectionID integer
---@param cmdID integer
---@param mode integer
---@param resolution integer
---@param val integer
---@param contextstr string
---@return integer, string, integer, integer, integer, integer, integer, string
--- Returns contextual information about the script, typically MIDI/OSC input values.
function reaper.get_action_context() end
```

## Contributing

This project is fully automated! The GitHub workflow runs daily and will automatically create PRs when the REAPER API documentation is updated. Simply review and merge the automated PRs to keep the type definitions current.

## License

MIT License - feel free to use these type definitions in your REAPER projects!
