---
tags:
  - Developer
---

title: Migrating Flotiq data between Spaces | Flotiq docs
description: How to migrate data using CLI export&import through JSON features

# Flotiq CLI: Export and Import Data

Flotiq CLI provides a convenient way to export and import data from your Flotiq account, including Content Types, Content Objects, and media files. This process allows for backup, migration, or sharing of data across environments.

## Exporting Data to JSON Files

You can export your data from Flotiq into local JSON files using the following command:

```
flotiq export [directory] [flotiqApiKey]
```
{ data-search-exclude }

This command exports data from your Flotiq account to the specified directory. If the API key is limited to specific Content Types, only the data available for that key will be exported.

**Parameters:**

- `directory`: The path to the directory where the exported files will be saved.
- `flotiqApiKey`: A read-only or read-and-write API key for your Flotiq account.

**Flags:**

- `--only-definitions`: Use this flag to export only the Content Type Definitions, ignoring the Content Objects.

The exported files will include JSON representations of your Content Types and Content Objects, allowing easy access and further processing.

## Importing Data from JSON Files

To import previously exported data back into your Flotiq account, or migrate data between accounts, use the following command:

```
flotiq import [projectName] [flotiqApiKey]
```
{ data-search-exclude }


This command reads Content Types and Content Objects from the specified directory and imports them into your Flotiq account. The directory structure must include folders such as `ContentType[0-9]` containing `ContentTypeDefinition.json` files and `contentObject[0-9].json` files.

The number at the end of the directory or file names defines the import order. Additionally, a `./images` directory within the project should store any images that will be imported into your Flotiq Media Library.

The `flotiq import` command ensures that your data is correctly structured and imported into Flotiq without data loss or corruption.

## Manual Import/Export via API

While the CLI provides a straightforward way to handle data export and import, you can also perform these operations manually using the Flotiq API. When choosing this approach, however, be aware that image URLs in your Content Objects will need to be updated manually. This is because images will receive new IDs during the import process, which can result in broken links if not handled properly.

For more details on how to adjust image URLs and manage the import/export process via API, please refer to the attached documentation.

---

Using Flotiq CLI simplifies the management of your data, enabling efficient migrations and backups. However, if your project requires more custom handling, the manual API method provides flexibility, with the caveat of manually updating image references.
