---
tags:
  - Developer
---

title: Rate limits and API usage
description: How API request limits work and how to design integrations around them.

# Rate limits and API usage

Flotiq applies API usage limits to protect platform stability.
Design integrations to handle throttling (temporary request blocking) and avoid request bursts.

## Limit model

Limits depend on plan and are calculated for a rolling usage window.

!!! note
    For current plan limits, see [Pricing](https://flotiq.com/pricing){:target="_blank"}.

## What happens when you hit limits

When limits are exceeded, requests can be rejected with limit-related error responses.
Applications should treat these as temporary and retry later.

### Response handling patterns

| Situation                  | What to do                                      |
|----------------------------|-------------------------------------------------|
| Temporary limit reached    | Retry with backoff and jitter                   |
| Repeated limit responses   | Reduce request frequency and batch reads        |
| Login throttling triggered | Pause retries for that user and retry later     |
| Unexpected traffic spikes  | Audit API key usage and rotate compromised keys |

## Integration best practices

- Cache responses where possible.
- Batch reads instead of many single-object calls.
- Use webhooks for event-driven updates.
- Implement retry with backoff.
- Monitor usage and alert before limit exhaustion.

## Retry with backoff example

```bash
# Example pattern: exponential backoff in pseudo-shell steps
# 1st retry: wait 1s
# 2nd retry: wait 2s
# 3rd retry: wait 4s
```
{ data-search-exclude }

## Login endpoint throttling

Authentication endpoints can have dedicated throttling rules (temporary limits on repeated requests).
If login requests are throttled, slow down retries and avoid parallel retries for one user identity.

## Monitoring signals

Track these signals in your monitoring system:

- count of limit-related failures over time,
- retry success rate after backoff,
- top integrations by request volume,
- login throttling events by user or IP source.

## Related docs

- [API access & scoped keys](./index.md)
- [Search API](./search.md)
- [Webhooks overview](../panel/webhooks/index.md)

