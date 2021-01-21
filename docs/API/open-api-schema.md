title: Get your own Open Api Schema | Flotiq docs
description: How to get your open api schema

You can generate Full Open API Schema for every Content Type Definition in your account or scope it making User Defined API key as described [here](/API/#user-defined-api-keys).

## Getting your Full Open API Schema

If you want to get your Open API Schema from Flotiq you have to make a call at following endpoint (using Postman or Insomnia):

`
https://api.flotiq.com/api/v1/open-api-schema.json
`

Remember to put your Read Only API key in headers to make this call properly.

Or run simple curl request in terminal:

```
curl -X GET "https://api.flotiq.com/api/v1/open-api-schema.json" 
     -H 'accept: */*' 
     -H 'X-AUTH-TOKEN: YOUR_API_KEY' 
     -H 'Content-Type: application/json'
```

## Getting your Scoped Open API Schema

If you want to get your Scoped Open API Schema from Flotiq you have to make a call at following endpoint (using Postman or Insomnia):

`
https://api.flotiq.com/api/v1/open-api-schema.json
`

Remember to put your User Defined API key in headers to make this call properly.

Or run simple curl request in terminal:

```
curl -X GET "https://api.flotiq.com/api/v1/open-api-schema.json" 
     -H 'accept: */*' 
     -H 'X-AUTH-TOKEN: YOUR_API_KEY' 
     -H 'Content-Type: application/json'
```
