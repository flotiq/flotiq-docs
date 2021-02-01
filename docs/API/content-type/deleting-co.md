title: How to delete Content Objects | Flotiq docs
description: How to delete Content Objects in Flotiq


# Deleting content objects

Deleting of the object is done as the soft delete. All items will be still in the database, but not accessible by the API. It can be restored directly in the database, by setting `deleted_at` as `NULL` by the system administrator, if you need to bring back the deleted object, you can contact us on <a href="mailto:hello@flotiq.com">hello@flotiq.com</a>, please include your email, content type name and object id in the email.

## Deleting single object

Deleting is done by sending `DELETE` request to `https://api.flotiq.com/api/v1/content/{CTD name}/{object ID}`, where:

* `CTD name` is the name of the content type definition
* `object ID` is the ID of the object to remove

For example: 

```
curl -X DELETE "https://api.flotiq.com/api/v1/content/blogposts/blogposts-1" -H "accept: application/json" -H "X-AUTH-TOKEN: YOUR_API_TOKEN"
``` 

For successful delete Flotiq will return `204 OK` response, for non-existing objects `404 Not Found` response, and for objects in relation within another object `400 Validation error` response.

## Batch deleting

Batch deleting can remove up to 100 objects at a time.
If you need to batch delete items you need to send `POST` request to `https://api.flotiq.com/api/v1/content/{CTD name}/batch-delete`, where:

* `CTD name` is the name of the content type definition

Body of the request must contain the array of object ids to remove, for example: `['blogposts-1', 'blogposts-2]`.

If the system deleted all objects, the endpoint would return `200 OK` response with:
```
{
    "deletedCount": numOfDeletedObjects
}
```
where:

* `numOfDeletedObjects` is number of deleted objects as integer

For example:
```
{
    "deletedCount": 2
}
```

If any of the objects could not be removed (as being used in the relation or as not existing), the system will remove all items that exist and are not in the relation within another object; for the rest of objects, the endpoint will return `400 Validation error` response with:
```
{   
    "errors": [
        listOfErrors
    ]
}
```
where:

* `listOfErrors` is the list of errors, each line have information about id

For example:
```
{
    "errors": [
        "Content object: \"blogposts-1\" doesn't exist",
        "Content object: \"blogposts-2\" is used in another content object."
    ]
}
```

Request example:

```
curl -X POST "https://api.flotiq.com/api/v1/content/blogposts/batch-delete" -H "accept: schema" -H "X-AUTH-TOKEN: YOUR_API_TOKEN" -H "Content-Type: application/json" -d "[\"blogposts-1\",\"blogposts-2\"]"
```
