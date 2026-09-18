# AshFallen ↔ JoshOS-Stage0 sync policy

`joshuaparris-max/AshFallen` is the canonical Josh OS integration repository.

`Parris-Tech-Services/JoshOS-Stage0` is an extracted Stage-0 product/ISO workspace.

Because parts of this repository were copied from AshFallen, unmanaged duplication will create contradictory behaviour and documentation. This file defines how to avoid that.

## Three classes of file

Every overlapping file should be classified as one of:

### 1. Canonical copy

AshFallen owns the content. JoshOS-Stage0 mirrors it.

Examples may include:

- design-token source;
- stable product concepts;
- shared shell model once settled.

These should have automated drift detection.

### 2. Derived/generated

The JoshOS-Stage0 version is generated/adapted from canonical input.

Examples:

- CSS generated from design tokens;
- extraction-specific packaged assets;
- Stage-0 build metadata.

Do not hand-edit generated outputs.

### 3. Intentional fork

JoshOS-Stage0 is experimenting independently.

Examples:

- a UX experiment;
- extraction-specific CI;
- packaging experiments.

The divergence must be recorded and either:

- promoted upstream;
- discarded; or
- explicitly retained as JoshOS-Stage0-only.

“Forgot to sync” is not an intentional fork.

## Immediate audit

Create a table covering at least:

| Path family | Canonical owner | Sync method | Intentional differences |
|---|---|---|---|
| `design/tokens.json` | AshFallen | exact-match CI | none unless ADR says otherwise |
| generated token CSS | generated | regenerate | output formatting only |
| `shell/` | AshFallen product concepts | selective promote/sync | experiments allowed temporarily |
| `scripts/build-iso.sh` | AshFallen product ISO | deliberate comparison | repo metadata/extraction packaging |
| product docs | AshFallen | links/summaries | JoshOS-Stage0-specific notes only |
| extraction CI | JoshOS-Stage0 | local | expected |

## Drift CI

Add a workflow/script that can:

1. fetch a pinned or current AshFallen revision;
2. compare paths marked exact-match;
3. fail with a useful diff;
4. report intentional-fork paths without failing;
5. print the upstream revision being compared.

Do not silently auto-merge upstream during CI.

## Promotion workflow

For a successful JoshOS-Stage0 experiment:

1. describe the concept and evidence;
2. port the smallest coherent change to AshFallen;
3. validate canonical CI;
4. update JoshOS-Stage0 from canonical;
5. remove local divergence unless it remains intentionally experimental.

## Version marker

Add an extraction metadata file such as:

```text
UPSTREAM_REPO=joshuaparris-max/AshFallen
UPSTREAM_COMMIT=<sha>
EXTRACTION_PURPOSE=stage0-product
```

The exact format can be machine-readable JSON/TOML later.

## Current known risk

The Stage-0 ISO build scripts have already diverged. AshFallen recently removed a VirtualBox guest package from its ArchISO package list to avoid a package conflict, while this extraction needs to be checked separately.

That is exactly the kind of drift this policy exists to make visible.

## Long-term decision

Eventually choose one of two clean states:

### A. JoshOS-Stage0 remains useful

Keep it as a deliberately thin extraction whose canonical inputs are synced/generated.

### B. JoshOS-Stage0 has served its purpose

Archive it once the canonical product workflow in AshFallen is faster and clearer than maintaining a second live-image repo.

Do not keep two “canonical” Josh desktops.
