---
tags:
  - Developer
---

title: Advanced duplication patterns
description: Advanced guidance for duplicating Content Objects safely at scale.

# Advanced duplication patterns

This page extends [Duplication](./duplication.md) with operational patterns for larger datasets and integration-heavy projects.

## Use duplication for

- creating content variants from a proven baseline,
- preparing region or language-specific copies,
- speeding up campaign and catalog operations.

## Relation handling strategy

Before duplicating at scale, decide relation behavior for each relation type:

- **duplicate relation target** when related data should diverge,
- **keep shared relation** when data should remain centralized.

For unsupported relation duplication (for example media or tag-like shared references), keep references shared and update only when necessary.

## Unique and required fields

After duplication, Flotiq updates unique and required values with generated suffixes.
Treat this as a safety fallback, not a final naming strategy.

Recommended post-duplication steps:

1. Normalize identifiers (`slug`, SKU-like fields, external IDs).
2. Verify business-critical unique constraints.
3. Confirm required fields meet publishing rules.

## Quality checks after duplication

- Verify relation integrity in the duplicated object.
- Validate workflows or draft/public state before publishing.
- Confirm generated metadata does not leak to end users.

## Batch operation notes

For bulk operations, use controlled batches and review results between batches.
This helps detect Content Type Definition (CTD) or validation issues early.

## Related docs

- [Duplication](./duplication.md)
- [Scheduling publication](./publication-scheduling.md)
- [Generating slugs](./slugs.md)
- [API and content versioning](../../API/versioning.md)

