title: Contentful - Flotiq data migration | Flotiq docs
description: How to migrate Flotiq data from Contentful account

# Migrate Contentful's content to Flotiq

With Flotiq CLI, you can move your data from Contentful to Flotiq with a single command.
To migrate data, you will need the following:

* A Flotiq account (you can [register here](http://editor.flotiq.com/register.html))
* Flotiq's "Read and write API key" (more about API keys [here](../API/index.md))
* Contentful Space ID (more on how to find your CF's space id [here](https://www.contentful.com/help/find-space-id/)){:target="_blank"}
* Contentful Content Management Token (more on how to get your CF's content management token in the section "How to get a Personal Access Token: the Web App" on Contentful's [Personal Access Tokens page](https://www.contentful.com/help/personal-access-tokens/)){:target="_blank"}

## Usage

Once you are done getting hold of all of the keys, all you need to do is run a simple command in Flotiq CLI, which looks like this:

```bash

flotiq contentful-import [flotiqApiKey] [contentfulSpaceId] [contentfulContentManagementToken] [translation (optional)]
```

`translation` - is Contentful's space locale that will be exported to Flotiq. If skipped, the command will export Contentful's default locale - `en-us`. You can find more information on Contentful's locale [here](https://www.contentful.com/help/working-with-translations/){:target="_blank"}

## Imported data

The migrator will export from Contentful the following data from Flotiq:

* Content Type Definitions (from Contentful's `Content Model`)
* Content Objects (from Contentful's `Content`) - this includes relations to other exported content
* Media

!!! note
    The migrator will export only a single space from Contentful. You must run the command several times with all Contentful Space IDs to export all Contentful spaces.

## Result

When the migrator finishes its work, it will log into your console three tables which summarize the migration of Content Types, Media and Content Objects.
Both Content Types and Media tables will show the success count, and error count of the total number of entities migrated. Also, for every error that has occurred, it will present the error code, name, and additional description with a pointer to an entity that caused the problem, for example, Contentful asset ID.
The table for Content Objects will show you separate success and error count for each Content Type you are migrating.