title: How to list deleted Content Objects | Flotiq docs
description: How to list deleted Content Objects in Flotiq

# Listing ids of deleted Content Objects through API

To list ids of the deleted Content Objects, you use `/removed` endpoint. It lists all of the deleted Content Objects of the Content Type. You can filter Content Objects using `deletedAfter` query parameter containing the date after which the Content Objects were deleted, date must be in the format accepted by the [DateTime::format](https://www.php.net/manual/en/datetime.format.php) function.

Example query without the `deletedAfter` parameter:

`curl -X GET "https://api.flotiq.com/api/v1/content/blogposts/removed" -H "accept: application/json" -H "X-AUTH-TOKEN: YOUR_API_TOKEN"`

Example query with the `deletedAfter` parameter:

`curl -X GET "https://api.flotiq.com/api/v1/content/blogposts/removed?deletedAfter=2020-06-17%2009:00:00" -H "accept: application/json" -H "X-AUTH-TOKEN: YOUR_API_TOKEN"`

Example response:

`["blogposts-1","blogposts-2"]`
