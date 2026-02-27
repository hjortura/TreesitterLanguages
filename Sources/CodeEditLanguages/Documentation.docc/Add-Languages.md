# Add Languages

This fork uses a resource-only `CodeEditLanguages` package.

## Overview

In this repository, adding a language has two parts:

1. Grammar/query source integration in `Packages/TreesitterLanguages`
2. Runtime language + parser-pack wiring in WriteMind

Parser symbols are not provided by `CodeEditLanguages` directly.

## 1) Grammar and query resources

1. Add the grammar package dependency in:
   - `Packages/TreesitterLanguages/CodeLanguages-Container/CodeLanguages-Container.xcodeproj`
2. Ensure query files exist upstream (`highlights.scm`, and optional `injections.scm`, `locals.scm`).
3. Refresh local resources:
   ```bash
   ./scripts/treesitter-workbench.sh rebuild-container --debug
   ```
4. Verify the language resource folder exists under:
   - `Packages/TreesitterLanguages/Sources/CodeEditLanguages/Resources/tree-sitter-<lang>/`

## 2) WriteMind runtime wiring

Update the language runtime in these files:

- `Packages/SwiftTreeSitter/Sources/WriteMindTreeSitterIntegration/TreeSitterLanguage.swift`
- `Packages/SwiftTreeSitter/Sources/WriteMindTreeSitterIntegration/TreeSitterLanguage+ParserSymbol.swift`
- `Packages/SwiftTreeSitter/Sources/WriteMindTreeSitterIntegration/CodeLanguage+Definitions.swift`
- `scripts/parser-pack-groups.sh`
- `Tools/ParserPackBuilder/Package.swift` (add grammar package/product to the appropriate pack target)

Then rebuild/install packs:

```bash
./scripts/treesitter-workbench.sh build-packs
```

## Validation

Run full validation:

```bash
./scripts/treesitter-workbench.sh full
```

This refreshes queries, rebuilds parser packs, and runs parser-pack validation/tests.
