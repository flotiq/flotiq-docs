---
tags:
  - Developer
---

title: Flotiq MCP Server in Codex | Flotiq docs
description: Add the Flotiq MCP Server to your Codex CLI configuration.

# Flotiq MCP Server in Codex

This guide shows how to add the [Flotiq MCP Server](index.md) to the Codex CLI.

## Prerequisites

1. [Flotiq account](https://editor.flotiq.com){:target="_blank"}
2. Codex CLI installed

## Setup

Add the following to your `~/.codex/config.toml` file:

```toml
experimental_use_rmcp_client = true

[mcp_servers.flotiq]
url = "https://mcp.flotiq.com/mcp"
```

{ data-search-exclude }

!!! Note
    `experimental_use_rmcp_client` is required - without it Codex uses the legacy MCP client, which does not support remote
    HTTP servers with OAuth.

Restart Codex. On the first tool call it opens the Flotiq authorization page in your browser - sign in, select
the [Space](../../panel/spaces.md) and the permission scope (`Read` or `Read & Write`), then click **Grant access**.

## Check the configuration

Start Codex and ask it about your content, for example:

```
check how many content types i have in flotiq
```

{ data-search-exclude }

## Related docs

- [Flotiq MCP Server overview](index.md)
- [Universe overview](../overview.md)
- [Get Started with API](../../API/get-started.md)
