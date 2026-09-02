---
tags:
  - Developer
  - Content Creator
---

title: Flotiq MCP Server in Claude | Flotiq docs
description: Connect your Flotiq content to Claude using a custom connector.

# Flotiq MCP Server in Claude

This guide shows how to connect the [Flotiq MCP Server](index.md) to Claude as a custom connector. It works in the
Claude desktop app and on claude.ai.

## Prerequisites

1. [Flotiq account](https://editor.flotiq.com){:target="_blank"}
2. Claude plan that supports custom connectors

## Setup

### 1. Open the connector list

Go to **Settings &rarr; Customize &rarr; Connectors**, click **+** and choose **Add custom connector**.

![](../images/mcp/claude-custom-connector.png){: .center .width75 .border}

### 2. Enter the configuration

![](../images/mcp/claude-add-connector.png){: .center .width75 .border}

Click **Continue**.

![](../images/mcp/claude-add-connector2.png){: .center .width75 .border}

Leave **Advanced settings** untouched and click **Add**.

### 3. Sign in to Flotiq

Claude opens the Flotiq authorization page. Sign in with your Flotiq credentials, select
the [Space](../../panel/spaces.md) and the permission scope (`Read` or `Read & Write`), then click **Grant access**.

![](../images/mcp/claude-connect.png){: .center .width75 .border}

### 4. Adjust tool permissions

Open the connector in **Settings &rarr; Connectors &rarr; Flotiq** and set **Tool permissions** so Claude cannot change
your content without asking. A good starting point:

| Tool                 | Permission |
|----------------------|------------|
| `list_content_types` | Allow      |
| `get_content_type`   | Allow      |
| `get_object`         | Allow      |
| `list_objects`       | Allow      |
| `create_object`      | Ask        |
| `publish_object`     | Ask        |
| `update_object`      | Ask        |

![](../images/mcp/claude-tool-permissions.png){: .center .width75 .border}

## Using the tools

Ask Claude about your content - it will pick the right tools on its own:

![](../images/mcp/claude-usage.png){: .center .width75 .border}

## Related docs

- [Flotiq MCP Server overview](index.md)
- [Universe overview](../overview.md)
- [Get Started with API](../../API/get-started.md)
