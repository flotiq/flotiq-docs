---
tags:
  - Administrator
  - Developer
---

title: Access control
description: How authentication and authorization work across panel roles and API access.

# Access control

This page explains how access is controlled in Flotiq across users, roles, and API keys.

## Access control layers

Flotiq access model has three layers:

1. **Authentication**: verifies who is making the request.
2. **Authorization**: defines what actions are allowed.
3. **API key scope**: limits access for API integrations.

## Authentication methods

- Panel login (standard account flow)
- Enterprise SSO
- API keys for integration traffic

See [Authentication](./authentication.md) for sign-in flows.

## Authorization scopes

Flotiq applies permissions at two role scopes:

- **Organization scope**: management actions like users, Spaces, and billing.
- **Space scope**: content actions inside an assigned Space.

See [User Roles](./user-roles.md) and [Spaces and Organization](./spaces.md).

## API key scope

API keys should use the least privilege.

- Use scoped API keys for integration-specific access.
- Separate read-only and read-write use cases.
- Rotate compromised API keys immediately.

See [API access & scoped keys](../API/index.md) and [API key lifecycle](../API/api-key-lifecycle.md).

## Manage API keys in Panel

To manage API keys in the Flotiq Panel:

1. Open your Space in the Dashboard.
2. Go to `API Keys` in the left menu.
3. Create, scope, regenerate, or remove keys as needed.

Use separate scoped API keys for each integration and environment.

## Practical permission model

A common setup for production teams:

- `Organization Admin` for a small admin group,
- `Admin` or `Content Editor` at Space level for content teams,
- scoped API keys per integration (frontend, automation, ETL),
- separate API keys per environment (staging, production).

## Troubleshooting access issues

If a user or integration cannot perform an action:

1. Verify selected Space context.
2. Verify assigned user role at organization and Space levels.
3. Verify API key type and scope.
4. Verify endpoint expectations (panel action vs API action).

## Related docs

- [Authentication](./authentication.md)
- [User Roles](./user-roles.md)
- [Spaces and Organization](./spaces.md)
- [API access & scoped keys](../API/index.md)
- [API key lifecycle](../API/api-key-lifecycle.md)

