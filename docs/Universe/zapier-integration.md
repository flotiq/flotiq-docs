---
tags:
  - Developer
---

title: Zapier integration
description: How to connect Flotiq with Zapier for trigger-based and action-based automations.

# Zapier integration

Use Zapier to connect Flotiq with external tools without custom middleware.

## Supported integration patterns

Flotiq Zapier app supports:

- Content Object Created trigger,
- Content Object Updated trigger,
- Content Object Removed trigger,
- Create New Content Object action.

## Authentication model

When connecting Flotiq in Zapier:

- use a read-only API key for trigger-only Zaps,
- use a read-write scoped API key for create/update actions.

For key setup, see [API access & scoped keys](../API/index.md) and [API key lifecycle](../API/api-key-lifecycle.md).

## Setup flow

1. Create a Zap.
2. Select `Flotiq` as app.
3. Choose trigger or action event.
4. Connect Flotiq account with appropriate API key.
5. Select Content Type Definition (CTD).
6. Test sample data.
7. Configure destination app and field mapping.
8. Enable the Zap.

## Operational recommendations

- Create one API key per Zap or per automation domain.
- Keep separate Zapier connections for staging and production.
- Validate field mappings after CTD (content structure) changes.
- Rotate integration keys periodically.

## Troubleshooting

If triggers do not fire or actions fail:

1. Verify API key scope and permissions.
2. Verify selected CTD exists in the same Space.
3. Re-test trigger sample after schema changes.
4. Check Zap task history for exact error payload.

## Legacy step-by-step tutorial

For screenshot-based walkthrough, see [Zapier integrations (version 1.2.0)](./zapier.md).

## Related docs

- [API access & scoped keys](../API/index.md)
- [API key lifecycle](../API/api-key-lifecycle.md)
- [Access control](../panel/access-control.md)
- [Pabbly](./pabbly.md)
- [n8n](./n8n.md)

