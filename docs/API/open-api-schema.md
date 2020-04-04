title: Get your own Open Api Schema | Flotiq docs
description: How to get your open api schema

# Getting your Open API Schema

If you want to get your Open API Schema from Flotiq you have to make a call at following endpoint (using Postman or Insomnia):

```
https://api.flotiq.com/api/v1/internal/open-api-schema.json
```

Remember to put you API_KEY in headers to make this call properly.

Or run simple curl request in terminal:

```
curl -X GET "https://api.flotiq.com/api/v1/internal/open-api-schema.json" 
     -H 'accept: */*' 
     -H 'X-AUTH-TOKEN: YOUR_API_KEY' 
     -H 'Content-Type: application/json'
```
