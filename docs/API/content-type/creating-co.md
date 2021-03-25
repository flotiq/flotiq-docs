title: How to add Content Objects | Flotiq docs
description: How to add Content Objects in Flotiq

# Content Objects

Once a <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">Content Type</abbr> has been defined in the system - the user can create <abbr title="Content Object - an instance of a Content Type.">Content Objects</abbr>  of that Content Type. This is done either directly through the API or via the convenient Content Entry tools provided within the Content Management Platform.

## Authoring content through the API

The supporting endpoints of a given <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">Content Type</abbr> allow the user to perform basic REST operations 

![](../images/endpoints.png){: .center .width75 .border}


For a <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">Content Type</abbr> defined according to the example described above, a very simple POST payload can be sent to the supporting endpoint to create a new Content Object:

``` json
{
  "id": "123123123",
  "title": "New object",
  "postContent": "This will be the new <b>content</b>"
}
```

Full curl request:

```
curl -X POST "https://api.flotiq.com/api/v1/internal/contenttype" -H 'accept: */*' -H 'X-AUTH-TOKEN: YOUR_API_KEY' -H "Content-Type: application/json' --data-binary '{"name":"blogposts","label":"Blog Posts","schemaDefinition":{"type":"object","allOf":[{"$ref":"#/components/schemas/AbstractContentTypeSchemaDefinition"},{"type":"object","properties":{"title":{"type":"string"},"postContent":{"type":"string"}}}],"required":["title","postContent"],"additionalProperties":false},"metaDefinition":{"propertiesConfig":{"title":{"label":"Title","inputType":"text","unique":true},"postContent":{"label":"Post content","inputType":"richtext","unique":false}},"order":["title","postContent"]}}"
```


which should result in a ``200`` server response containing the details of the created object:

![](http://minio.dev.cdwv.pl:80/hackmd/uploads/upload_a505c0503a97ac4961b81daee835d9c6.png){: .center .width75 .border}


If a property is required in the <abbr title="Content Type Definition - a JSON payload that defines the Content Type and it's validation rules">Content Type Definition</abbr> of the object being added, API will respond with `400` response and will list validation errors in the response body.

For example for request with payload with the missing title:
```json
{
  "id": "123123123",
  "postContent": "This will be the new <b>content</b>"
}
```

The server will respond with:
```json
{
  "title": [
    "The property title is required"
  ]
}
```

If a property should be unique, API will respond with `400` response and will list validation errors in the response body, exactly like with required fields.

If you would post the same object as in the first example the server will response with:

```json
{
  "title": [
    "This value is already used"
  ],
  "id": [
    "This value is already used"
  ]
}
```


## Batch content upload

There is a way to add up to 100 of Content Objects at once. It is possible by using `/batch` endpoint (in our example the URL would be `https://api.flotiq.com/api/v1/content/blogposts/batch`). It can be only `insert` or `insert or update` operation. To use `insert or update` you need to set `updateExisting` to `true` in the query. 

All objects must meet the same conditions as when adding a single object. The only difference is an array of objects in the request body instead of one object.

Updating one blog post and adding one new:

!!! Example
    
    ```
    curl 'https://api.flotiq.com/api/v1/content/blogposts/batch?updateExisting=true' -H 'accept: application/json' -H 'X-AUTH-TOKEN: YOUR_API_TOKEN' -H 'Content-Type: application/json' --data-binary '[{"id":"123123123","title":"New object","postContent":"This will be the new <b>content</b>"},{"id":"123123124","title":"New object 2","postContent":"This will be the brand new <b>content</b>"}]'
    ```
    
    response (code: 200):
    ```json
    {
        "batch_total_count": 2,
        "batch_success_count": 2,
        "batch_error_count": 0,
        "errors": []
    }
    ```
    
Trying updating one blog post and adding one new with wrong data:
    
!!! Example
    
    ```
    curl 'https://api.flotiq.com/api/v1/content/blogposts/batch?updateExisting=true' -H 'accept: application/json' -H 'X-AUTH-TOKEN: YOUR_API_TOKEN' -H 'Content-Type: application/json' --data-binary '[{"id":"123123123","title":"New object"},{"id":"123123124","title":"New object 2","postContent":"This will be the brand new <b>content</b>"}]'
    ```
    
    response (code: 400):
    ```json
    {
        "batch_total_count": 2,
        "batch_success_count": 1,
        "batch_error_count": 1,
        "errors": [
          {
            "id": "123123123",
            "errors": {
              "postContent": [
                "The property postContent is required"
              ]
            }
          }
        ]
    }
    ```

Trying updating one blog post and adding one new with duplicated id:
    
!!! Example
    
    ```
    curl 'https://api.flotiq.com/api/v1/content/blogposts/batch?updateExisting=true' -H 'accept: application/json' -H 'X-AUTH-TOKEN: YOUR_API_TOKEN' -H 'Content-Type: application/json' --data-binary '[{"id":"123123123","title":"New object","content": "This will be the new <b>content</b>"},{"id":"123123123","title":"New object 2","postContent":"This will be the brand new <b>content</b>"}]'
    ```
    
    response (code: 400):
    ```json
    {
      "data": [
        "There are duplications in object data, key: id"
      ]
    }
    ```

Response parameters:

| Parameter           | Description |
| ------------------- | ----------- |
| batch_total_count   | number of elements sent in the request, present when there are no duplications in data |
| batch_success_count | number of correct elements sent in the request, present when there are no duplications in data |
| batch_error_count   | number of incorrect elements sent in the request, present when there are no duplications in data |
| errors              | array of errors in the elements, errors are objects containing the id of the object and list of errors, present when there are no duplications in data |
| data                | present only when there are duplications in data, listing keys containing duplications (see example above) | 
