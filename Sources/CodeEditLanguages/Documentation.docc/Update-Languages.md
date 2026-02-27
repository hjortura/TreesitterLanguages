# Update Languages

This article covers updating grammar package revisions and query resources for this fork.

## Overview

`CodeEditLanguages` is resource-only in this repository. Updating languages means:

1. Updating grammar package revisions in `CodeLanguages-Container` project
2. Refreshing copied query resources
3. Rebuilding parser packs used at runtime

## Update grammar revisions

1. Open:
   - `Packages/TreesitterLanguages/CodeLanguages-Container/CodeLanguages-Container.xcodeproj`
2. Use Xcode package update flow (`File > Packages > Update to Latest Package Versions`) if desired.
3. Commit `Package.resolved` changes from the project workspace.

## Refresh query resources

From repo root:

```bash
./scripts/treesitter-workbench.sh rebuild-container --debug
```

Optional (imports missing query files from nvim-treesitter):

```bash
./scripts/treesitter-workbench.sh rebuild-container --include-nvim
```

## Rebuild parser packs and validate

```bash
./scripts/treesitter-workbench.sh full
```

This runs query refresh, parser-pack build/install, and parser-pack validation/tests.
