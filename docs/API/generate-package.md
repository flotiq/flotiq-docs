title: Generate your own package
description: If you didn't found a package, on your Flotiq dashboard, that suits your needs then you can generate it by yourself for the framework/language you like.

# Generate your own package using OpenApiGenerator

On your Flotiq dashboard you can find a few logos that represents certain frameworks or languages. 

![Available frameworks and languages](images/frameworkslogos.png)

Currently available are:

* C#
* Go
* Java
* Node
* Php
* Python
* Angular
* Postman

If any of these positions don't satisfy your needs you can generate your own package by running the following commands:

`npm install @openapitools/openapi-generator-cli@cli-4.2.3 -g`

This will instal an OpenApi generator that will generate such package for you. List of available is mentioned [here](https://openapi-generator.tech/docs/generators)

`openapi-generator generate -g <name> -i <path_to_open_api_schema_json> --skip-validate-spec -o <output_path>`

Parameters description:
`<name>` - name of framework/language you want to generate package for (ex. typescript-angular)
`<path_to_open_api_schema_json>` - path to generated OpenApiSchema file.
`<output_path>` - specify where you want to output your generated package   

Alternatively you can go to [Swagger Editor](https://editor.swagger.io), paste the contents of you open-api-schema.json file there and generate a package that you are interested in.