# Update Languages

This article covers updating grammar package revisions and query resources for this fork.

## Overview

`CodeEditLanguages` is resource-only in this repository. Updating languages means:

1. Updating grammar package revisions in `Tools/ParserPackBuilder/Package.swift`
2. Refreshing copied query resources
3. Rebuilding parser packs used at runtime

## Update grammar revisions

1. Open:
   - `Tools/ParserPackBuilder/Package.swift`
2. Update grammar dependency versions/commits as needed.
3. Run `swift package resolve --package-path Tools/ParserPackBuilder` to refresh checkouts.

## Refresh query resources

From repo root:

```bash
./scripts/parser-pack-workflow.sh sync-queries --debug
```

Optional (imports missing query files from nvim-treesitter):

```bash
./scripts/parser-pack-workflow.sh sync-queries --include-nvim
```

## Rebuild parser packs and validate

```bash
./scripts/parser-pack-workflow.sh full
```

This runs query refresh, parser-pack build/install, and parser-pack validation/tests.
