---
tags:
  - Developer
---

title: API and content versioning
description: Versioning behavior for APIs and content updates in Flotiq.

# API and content versioning

Flotiq uses versioned endpoints and tracks content changes over time.
This helps keep integrations stable while data evolves.

## API endpoint versioning

API endpoints include version prefixes.

Examples:

- REST endpoints: `/api/v1/...`
- GraphQL endpoints: `/api/v2/graphql`

Always set integrations to a specific API version.

## Content change history

Content objects are versioned as changes are saved.
Use this to review historical state and support rollback workflows in your applications.

Typical versioning use cases:

- audit trail for editorial changes,
- rollback after accidental edits,
- compare pre-publish and post-publish state.

## Integration guidelines

- Do not assume object state is immutable.
- Persist object identifiers, not response snapshots.
- Re-fetch object state before destructive actions.
- Validate publish status in workflow-driven pipelines.

## GraphQL version note

Flotiq GraphQL uses `/api/v2/graphql` endpoints.
Use the latest stable version unless a migration plan requires older behavior.

## Related docs

- [Get Started with API](./get-started.md)
- [GraphQL](./graph-ql.md)
- [Draft & Public](./draft-public/draft-public.md)
- [Content publishing workflow](./workflow/content-publishing-workflow.md)

