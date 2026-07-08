---
tags:
  - Developer
---

title: Advanced workflow patterns
description: Advanced workflow and scheduling patterns for Flotiq integrations.

# Advanced workflow patterns

This page extends the basic [Workflows](./content-publishing-workflow.md) page with integration-focused patterns.

## Choose the right state model

Before implementation, confirm whether you need:

- **Draft & Public** for simple publish and unpublish flows,
- **Custom workflows** for multistep editorial approval.

Do not combine both models on one Content Type Definition.

## Recommended state design

For editorial teams, a practical flow is:

1. `draft`
2. `review`
3. `public`
4. `archive`

Keep transitions explicit and minimal. Each extra transition increases integration complexity.

## Transition safety in integrations

When automating transitions through `/api/v1/workflow/:content_type/:object_id`:

- fetch current state first,
- verify enabled transitions,
- submit only one state action per request,
- handle race conditions if multiple systems can update the same object.

## Public-read pipelines

If your delivery layer should only read approved content:

- use a workflow that includes `public`,
- query with `x-visibility: public`,
- avoid preview headers in production consumers.

This prevents draft content leaks.

## Scheduling and publication operations

For time-based publishing workflows:

- keep scheduling logic in one integration service,
- use idempotent job execution,
- store object id and expected state before running transition,
- log transition failures with object id and action name.

## Rollback strategy

For safe rollback in production:

- snapshot key fields before transition,
- keep version metadata in integration logs,
- define a fallback transition path (for example `public` to `draft` or `archive`) before launch.

## Operational checklist

- Validate all transition actions in a staging Space.
- Confirm external consumers respect `x-visibility` policy.
- Monitor failed transition responses.
- Document who owns each transition in your team.

## Related docs

- [Content publishing workflow](./content-publishing-workflow.md)
- [Draft & Public](../draft-public/draft-public.md)
- [API and content versioning](../versioning.md)

