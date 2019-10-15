# API access

## API Key
There are 2 API keys - read-write and read-only, which can be retrieved from the user profile page in the Flotiq UI:

![](images/user-profile.png){: style="height:150px;"}

then simply copy your API key from the form field:

![](images/api-keys.png){: style="height:150px;"}

As a best practice we recommend you use the Read Only API key whenever possible and only switch to the RW key in case you need to upload or modify existing content.

## Postman

Postman supports OpenAPI Schema 3.0 format and can easily import the JSON definition of the [public CMS API](https://new-cms-staging.api.dev.cdwv.pl/api/v1/internal/open-api-schema.json). 

!!! note 
    There is one manual operation that has to be performed on the JSON file, at the moment. You need to remove the reference to ``file://json-schema-draft-07.json`` from the JSON. After removing that line, simply use Postman's Import feature and point it to the file without the broken reference.

The API Schema can be imported using Postman's Import feature:

![](http://minio.dev.cdwv.pl:80/hackmd/uploads/upload_8ee650fa5f7c5dd765147319d98591c6.png)

Which should end with a collection being created in Postman. The API endpoints will become visible as separate folders in this collection:

![](http://minio.dev.cdwv.pl:80/hackmd/uploads/upload_51c7b136eb43b0f6bbaec162223028ac.png)

After importing the OpenAPI schema, there are two steps needed to use the API through Postman:

1. Providing the ``baseUrl`` variable.

![](http://minio.dev.cdwv.pl:80/hackmd/uploads/upload_547776fc7ed6e9e255d9b20a66289227.png)

2. Setting the API key in the ``X-AUTH-TOKEN`` header.

To provide authorization for the whole collection, you can provide the API key through the Edit Collection window:

![](http://minio.dev.cdwv.pl:80/hackmd/uploads/upload_9f6cdc21cfb012b421c8368a3bb26a7f.png)

![](http://minio.dev.cdwv.pl:80/hackmd/uploads/upload_57e8d2a319533e428ec60e15ed1ccf35.png)

Once filled in - the ``X-AUTH-TOKEN`` header will be populated with all requests in this collection.

!!! note
    In some cases Postman will set the authorization for individual requests as ``Bearer Token``, if this is the case - you will have to go to the Authorization tab of the specific request and switch the Authorization Type to ``Inherit from parent``.
    
    ![](http://minio.dev.cdwv.pl:80/hackmd/uploads/upload_35f3e9f3a61de2b1b2af19d61e0a54a6.png)
