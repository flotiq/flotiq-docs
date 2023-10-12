title: Webhooks
description: How to use webhooks in Flotiq

# Webhooks

## What is a Webhook?

Webhooks are a form of contacint external systems when an event occurs in Flotiq. It's one of many features that make integrations with thousands of other systems possible. With the addition of [synchronous webhooks](sync) it's also a fantastic way to extend Flotiq core functionality with your business logic.

We support 2 types of webhooks:

- [asynchronous](async) - this is the type you are probably most familiar with, you can think of those as notifications sent to external systems *after* an event happens in Flotiq, without altering the processing flow on Flotiq side,
- [synchronous](sync) - these webhooks are synchronous calls that are made to an external system *during* the processing of data in Flotiq, for example to perform data validation.

Follow the links above to read more about each type of webhooks and example use cases.