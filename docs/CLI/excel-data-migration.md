---
tags:
  - Content Creator
  - Developer
---

title: Flotiq - MSExcel Migration | Flotiq docs
description: How to migrate Flotiq data to/from MS Excel file

# Migrating data between Flotiq and MS Excel

You can migrate your data between Flotiq and MS Excel with Flotiq CLI. To migrate your data you need a Flotiq account (you can [register here](http://editor.flotiq.com/register.html)) and your "Read Only API Key" or "Read and write API key", depending on whether you want to import or export your data (more about API keys [here](../API/index.md)).

If you wish to use our Flotiq - Excel migrator directly, you can use our [flotiq-excel-migrator](https://www.npmjs.com/package/flotiq-excel-migrator){:target="_blank"} npm package.

## Export Flotiq data to MS Excel

`flotiq excel-export` command will export Content Objects from the given Content Type to an MS Excel file in .xlsx format.

The command looks like this:

```bash
flotiq excel-import [ctdName] [filePath] [flotiqApiKey]
```
{ data-search-exclude }

Command logs the following information:

* FilePath
* Total number of Content Objects for export
* Number of Content Objects successfully exported
* errors data

!!! note
    Exported CTD is saved as plain text of properties id's. No metadata is being exported.

!!! note
    `Max string length` for all values is set to 30.000 because MS Excel has trouble handling text with length > 30 000 in one cell.

### Export parameters

`ctdName` - API name of Content Type Definition you wish to export,

`filePath` - the directory to which the .xlsx file is to be saved. Type in "." if you want to save the file inside the current directory,

`flotiqApiKey` - API key to your Flotiq account with read permission.

### Export flags

`--limit=[number]` or `--l=[number]` - number of Content Objects to export counting from the top row, default: 10.000,

`--hideResults` or `--hr` - information about the export process will not appear in the console.

!!! Responses
    When successful:
    ```
    {
        directoryPath: '[_dirname]//test.xlsx',
        errors: null,
        coTotal: 3,
        co_success: 3
    }
    ```
    { data-search-exclude }

## Import data from MS Excel to Flotiq

`flotiq excel-import` command will import Content Objects from an MS Excel file to the given Content Type.

The command looks like this:

```bash
flotiq excel-import [ctdName] [filePath] [flotiqApiKey]
```
{ data-search-exclude }

Command logs the following information:
For every sheet in the workbook:

* Number of Content Objects successfully imported
* Number of errors in Content Object import
* errors data (object)

### Import Parameters

`ctdName` - API name of Content Type Definition you wish to import data to,

`filePath` - the directory to the .xlsx file you wish to import data from,

`flotiqApiKey` - API key to your Flotiq account with read and write permissions.

### Import Flags

`--limit=[number]` or `--l=[number]` - number of Content Objects imported counting from the top row, default: 10 000,

`--batchLimit` or `--bl` - limit the number of Content Objects imported per batch call, default: 100.

`--updateExisting` or `--ue` - If content objects with a given id already exist in the Flotiq account, they will be updated.

`--hideResults` or `--hr` - information about the import process will not appear in the console.

!!! Responses
    When successful:
    ```
    {
        Sheet1: {
            sheetImportedCoCount: 98,
            sheetErrorsCount: 2,
            sheetErrors: [ [Object] ]
        }
        Sheet2: {
            sheetImportedCoCount: 100,
            sheetErrorsCount: 0,
            sheetErrors: []
            }
    }
    ```
    { data-search-exclude }

### Notes

* valid XLSX file looks just like the one that exportXlsx saves. The first row on the sheet (header) should have the names of CTD's properties. Every following row is a separate Content Object, for example:

| id | name | age |
|--|--|--|
| person-1 | John | 30 |
| person-2 | Alex | 20 |

* importXlsx allows you to import many sheets from the same workbook. However, these sheets must be dedicated to the same CTD and have this CTD's properties in the header.
* Parameter LIMIT limits the number of Content Objects you will import from XLSX works individually for every sheet in the workbook.

## Data mapping

The form in which Flotiq data is exported to / imported from xlsx varies on property type:

| Flotiq field property | Form in which data is exported to xlsx |
|--|--|
| Text | Text |
| Textarea | Text |
| Markdown | Text (with markdown syntax) |
| Rich text | Text (with HTML tags) |
| Email | Text |
| Number | Number (with ms excel's default decimal separator) |
| Radio | Text |
| Checkbox | TRUE / FALSE |
| Select | Text |
| Relation | API Url's in the form of text, separated with commas, for example: `/api/v1/content/[ctdName]/[coName1],/api/v1/content/[ctdName]/[coName2]` |
| List | JSON |
| Geo | JSON |
| Media | API Url in form of text, separated with commas, for example: `/api/v1/content/_media/[mediaId1],/api/v1/content/_media/[mediaId2]` |
| Date time | Date |
| Block | JSON |
