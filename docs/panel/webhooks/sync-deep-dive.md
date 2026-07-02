---
tags:
  - Developer
---

title: Synchronous webhooks deep dive
description: Operational guidance for synchronous webhook design, reliability, and troubleshooting.

# Synchronous webhooks deep dive

This page complements [Synchronous webhooks](./sync.md) with operational guidance.

## Execution model

Sync webhooks run during the same request that creates, updates, or deletes content.
A create, update, or delete request is not completed until all matching sync webhooks finish.

This means webhook latency directly affects API response time.

## Processing order and chaining

If multiple sync webhooks match one event:

- webhooks are processed sequentially,
- there is no guaranteed processing order,
- all webhooks must complete successfully for request processing to continue.

Design each webhook as independent. Do not assume webhook A always runs before webhook B.

## Mutating vs validating design

Use **mutating** webhooks when you need to enrich or normalize payloads.
Use **validating** webhooks when you need to block invalid data.

Quick decision guide:

- Choose **mutating** when you want to change incoming data before save.
- Choose **validating** when you only want to allow or block save.
- Split complex logic into separate mutating and validating endpoints.

Recommended split:

- keep mutating logic deterministic and side effect free,
- keep validating logic strict and fast,
- return clear errors for users and API consumers.

## Timeout and failure behavior

When a webhook target fails, returns invalid JSON, or does not follow expected response format, Flotiq rejects the request.

Recommended timeout budget: keep webhook processing under 2 seconds for normal cases and under 5 seconds for rare slow paths.

To reduce failures:

- enforce response schema in your webhook service,
- set strict timeout budgets,
- monitor error rates and response time percentiles,
- add circuit-breaker behavior in external dependencies used by webhook handlers.

### Failure playbook

| Failure type                   | Immediate action                                               |
|--------------------------------|----------------------------------------------------------------|
| Invalid JSON response          | Validate response serializer and return strict JSON schema     |
| HTTP status other than 200/400 | Fix handler to return supported status codes                   |
| Timeout                        | Reduce external calls and add cached lookup for reference data |
| High error rate                | Disable failing webhook temporarily and restore after fix      |

## Reliability patterns

- Keep handlers idempotent.
- Avoid remote calls that are not required for validation.
- Precompute reference data where possible.
- Log `contentTypeName`, `event`, and `sequenceNumber` for each request.

## Debugging checklist

1. Confirm webhook type is `Synchronous`.
2. Confirm target endpoint responds with HTTP `200` or HTTP `400` and valid JSON body.
3. Confirm payload returned by mutating webhook still matches the Content Type Definition (CTD) schema.
4. Review webhook target logs for matching `sequenceNumber`.

## Related docs

- [Synchronous webhooks](./sync.md)
- [Sync examples](./sync-examples.md)
- [Webhooks overview](./index.md)

