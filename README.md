<a href="https://flotiq.com/">
    <img src="https://editor.flotiq.com/images/fq-logo.svg" alt="Flotiq logo" title="Flotiq" align="right" height="60" />
</a>

Flotiq documentation
========================

This is the [Flotiq](https://flotiq.com) documentation. It's available online [here](https://flotiq.com/docs/). 

We are improving our documentation along as Flotiq improves. We are trying our best to keep it as up to date and clear as it is possible. If you wish to help us with that task - PRs are welcome.

## Prerequisites

Starting the project with docker:
* Installed docker

Starting without docker:
* Installed python
* Installed git


## Installation

With docker:
`docker-compose up -d`
It will also start docs server.

Without docker:
```bash
pip install -r requirements.txt
```

To start server use:

```bash
# Use SOURCE_EDITOR_URL variable to point to speciffic dashboard url. By default, SOURCE_EDITOR_URL=https://editor.flotiq.com is used.
bash .github/scripts/get-plugins-docs.sh # Pull dynamically generated plugin docs. 
mkdocs serve # Start devlopment server. Use --dirtyreload option to speed up reloading, but be aware, that this might break navigation on the preview.
```

After that, the documentation should be available on http://localhost:4000.

## Troubleshooting 

If during installation without docker you will encounter error with no git present, add 2 environment variables:
* `GIT_PYTHON_GIT_EXECUTABLE` - with path to git e.g `/usr/bin/git`
* `GIT_PYTHON_REFRESH` - with value `quiet` to suppress more git errors


## Collaboration

If you wish to talk with us about this project, feel free to hop on [![Discord Chat](https://img.shields.io/discord/682699728454025410.svg)](https://discord.gg/FwXcHnX)  .
   
If you found a bug, please report it in [issues](https://github.com/flotiq/flotiq-docs/issues).

We also welcome any PR with documentation improvements (or typo fixes ;) ).

## Aliasing
Some files are dynamically generated (e.g. all pages describing events and classes for plugin API). Those pages can be referred with an alias:

```md
<!-- Refer to PluginInfo page -->
[[PluginInfo.md]] 

<!-- Refer to PluginInfo page with an alternative name -->
[[PluginInfo.md|Page about PluginInfo class]] 

<!-- Refer to header on PluginInfo page with an alternative name -->
[[PluginInfo.md#example-header|Example section on the page]]
```

You can also add an alias to any existing page by dyfining it in the meta section of the markdown file:

```md
<!-- Start of the markdown file -->
alias: some-example-alias
