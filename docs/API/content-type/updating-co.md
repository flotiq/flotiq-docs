title: How to update Content Objects | Flotiq docs
description: How to update Content Objects in Flotiq

# Updating content through the API

When updating the object (`PUT` requests), all properties have to be present in the request body, as the object data are replaced with the request body. The id property should never be changed in `PUT` requests. Validation of update request works the same as in saving requests.
