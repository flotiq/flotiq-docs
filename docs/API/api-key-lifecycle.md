---
tags:
  - Developer
---

title: API key lifecycle
description: Best practices for creating, rotating, and revoking API keys in Flotiq.

# API key lifecycle

This page explains how to safely manage API keys from creation to revocation.

## Key types

Flotiq supports:

- **Application keys** for broad account-level access,
- **Scoped API keys** for integration-specific access.

For basic set up, see [API access & scoped keys](./index.md).

## Lifecycle stages

### 1. Create

Create a dedicated key per integration.
Do not share one key across multiple systems.

### 2. Scope

Apply the least privilege:

- grant only required content types,
- grant only required actions (`read`, `create`, `update`, `delete`),
- prefer read-only keys for frontend delivery.

### 3. Store

Store keys in a secrets manager or environment variables.
Do not commit keys to source control.

### 4. Monitor

Track key usage in your operational dashboards.
Investigate unusual request spikes, unknown origins, or repeated authorization failures.

### 5. Rotate

Rotate keys on schedule and after personnel or integration changes.
During rotation:

1. Create a replacement key.
2. Deploy integration updates.
3. Verify successful traffic with new key.
4. Remove or regenerate old key.

### 6. Revoke

Revoke keys immediately when compromised or no longer needed.

## Environment strategy

Use separate keys for:

- local development,
- staging,
- production.

This limits the impact of a leaked key and simplifies incident response.

## Incident response checklist

If a key is exposed:

1. Regenerate or remove the key immediately.
2. Replace the key in all affected services.
3. Review recent API activity for suspicious access.
4. Restrict scopes further where possible.

## Related docs

- [API access & scoped keys](./index.md)
- [Rate limits and API usage](./rate-limits.md)
- [Access control](../panel/access-control.md)

