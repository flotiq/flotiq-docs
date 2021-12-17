title: How to list Content Objects | Flotiq docs
description: How to list Content Objects in Flotiq

# Getting single Content Object

Once a <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">Content Type</abbr>
has been defined in the system - the user can get single
<abbr title="Content Object - an instance of a Content Type.">Content Object</abbr>  of that Content Type.
This is done either directly through the API or via the convenient Content Entry tools provided within the
Content Management Platform.

!!! note
    You can use your `Application Read Only API KEY` to perform this action
    or `User API KEY` scoped to accept read on the Content Type you wish to list.
    Read more about [API keys and scoped API keys](/docs/API/).

## Getting single Content Object through the API

For a <abbr title="Content Type - a model of data that has been defined inside the Content Repository.">Content Type</abbr>
defined according to the [create Content Type example](/docs/API/content-type/creating-ctd), a very simple `GET` request can be sent
to the supporting endpoint `https://api.flotiq.com/api/v1/content/{name}/{id}`
(where `name` is the name of the content type definition and `id` is the ID of the object to retrieve) to get Content Object.

!!! Example

    === "CURL"

        ``` 
        curl --location --request GET "https://api.flotiq.com/api/v1/content/blogposts/blogposts-456712" \
        --header "accept: application/json" \
        --header "X-AUTH-TOKEN: YOUR_API_TOKEN"
        ```

    === "C# + Restasharp"

        ```
        var client = new RestClient("https://api.flotiq.com/api/v1/content/blogpostsblogposts-456712");
        var request = new RestRequest(Method.GET);
        request.AddHeader("X-AUTH-TOKEN", "YOUR_API_KEY");
        IRestResponse response = client.Execute(request);
        ```
    
    === "Go + Native"

        ```
        package main

        import (
            "fmt"
            "net/http"
            "io/ioutil"
        )
        
        func main() {
        
            url := "https://api.flotiq.com/api/v1/content/blogpostsblogposts-456712"
        
            req, _ := http.NewRequest("GET", url, nil)

            req.Header.Add("X-AUTH-TOKEN", "YOUR_API_KEY")
        
            res, _ := http.DefaultClient.Do(req)
        
            defer res.Body.Close()
            body, _ := ioutil.ReadAll(res.Body)
        
            fmt.Println(res)
            fmt.Println(string(body))
        
        }
        ```
    
    === "Java + Okhttp"
        
        ```
        OkHttpClient client = new OkHttpClient();

        Request request = new Request.Builder()
            .url("https://api.flotiq.com/api/v1/content/blogpostsblogposts-456712")
            .get()
            .addHeader("X-AUTH-TOKEN", "YOUR_API_KEY")
            .build();
        
        Response response = client.newCall(request).execute();
        ```

    === "Java + Unirest"
      
        ```
        HttpResponse<String> response = Unirest.get("https://api.flotiq.com/api/v1/content/blogpostsblogposts-456712")
            .header("X-AUTH-TOKEN", "YOUR_API_KEY")
            .asString();
        ```

    === "Node + Request"
      
        ```
        const request = require('request');

        const options = {
            method: 'DELETE',
            url: 'https://api.flotiq.com/api/v1/content/blogposts/blogposts-456712',
            headers: {'X-AUTH-TOKEN': 'YOUR_API_KEY'},
        };
        
        request(options, function (error, response, body) {
            if (error) throw new Error(error);
            
            console.log(body);
        });
        ```

    === "PHP + CURL"
    
        ```
        <?php

        $curl = curl_init();
        
        curl_setopt_array($curl, [
            CURLOPT_URL => "https://api.flotiq.com/api/v1/content/blogposts/blogposts-456712",
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => "",
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 30,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => "DELETE",
            CURLOPT_HTTPHEADER => [
                    "X-AUTH-TOKEN: YOUR_API_KEY",
                ],
        ]);
        
        $response = curl_exec($curl);
        $err = curl_error($curl);
        
        curl_close($curl);
        
        if ($err) {
            echo "cURL Error #:" . $err;
        } else {
            echo $response;
        }
        ```

Request parameters

| Parameter | Description                                                                                                                           |
| --------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| hydrate   | If you want to hydrate data sources in the object, you need to set it to `1`; it will hydrate one level of data sources in the object |

!!! Responses

    === "200 OK"

        Returned when the object was found

        ```
        {
          "id": "blogposts-456712",
            "internal": {
                "contentType": "blogposts",
                "createdAt": "2021-04-09T13:30:48+00:00",
                "updatedAt": "2021-04-09T13:30:48+00:00",
                "deletedAt": ""
            },
            "title": "New object",
            "postContent": "This will be the new <b>content</b>"
          }
        }
        ```

    === "401 Unauthorized"

        Returned when API key was missing or incorrect
  
        ```
        {
            "code": 401,
            "massage": "Unauthorized"
        }
        ```

    === "404 Not found"

        Returned when content type definition wasn't found

        ```
        {
            "code": 404,
            "massage": "Not found"
        }
        ```

### Hydrating object

If you wish to receive underlying objects attached to the object you are retrieving, you need to send a request with query parameter `hydrate` set to `1`.
There is only 1 level of hydration. The example below shows an example response for the product with a category, product image and product gallery.

!!! Example

    === "CURL"

        ``` 
        curl -X GET "https://api.flotiq.com/api/v1/content/product/product-1" -H "X-AUTH-TOKEN: YOUR_API_KEY" -H "accept: application/json"
        ```

    === "C# + Restasharp"

        ```
        var client = new RestClient("https://api.flotiq.com/api/v1/content/product/product-1");
        var request = new RestRequest(Method.GET);
        request.AddHeader("X-AUTH-TOKEN", "YOUR_API_KEY");
        IRestResponse response = client.Execute(request);
        ```
    
    === "Go + Native"

        ```
        package main

        import (
            "fmt"
            "net/http"
            "io/ioutil"
        )
        
        func main() {
        
            url := "https://api.flotiq.com/api/v1/content/product/product-1"
        
            req, _ := http.NewRequest("GET", url, nil)

            req.Header.Add("X-AUTH-TOKEN", "YOUR_API_KEY")
        
            res, _ := http.DefaultClient.Do(req)
        
            defer res.Body.Close()
            body, _ := ioutil.ReadAll(res.Body)
        
            fmt.Println(res)
            fmt.Println(string(body))
        
        }
        ```
    
    === "Java + Okhttp"
        
        ```
        OkHttpClient client = new OkHttpClient();

        Request request = new Request.Builder()
            .url("https://api.flotiq.com/api/v1/content/product/product-1")
            .get()
            .addHeader("X-AUTH-TOKEN", "YOUR_API_KEY")
            .build();
        
        Response response = client.newCall(request).execute();
        ```

    === "Java + Unirest"
      
        ```
        HttpResponse<String> response = Unirest.get("https://api.flotiq.com/api/v1/content/product/product-1")
            .header("X-AUTH-TOKEN", "YOUR_API_KEY")
            .asString();
        ```

    === "Node + Request"
      
        ```
        const request = require('request');

        const options = {
            method: 'DELETE',
            url: 'https://api.flotiq.com/api/v1/content/product/product-1',
            headers: {'X-AUTH-TOKEN': 'YOUR_API_KEY'},
        };
        
        request(options, function (error, response, body) {
            if (error) throw new Error(error);
            
            console.log(body);
        });
        ```

    === "PHP + CURL"
    
        ```
        <?php

        $curl = curl_init();
        
        curl_setopt_array($curl, [
            CURLOPT_URL => "https://api.flotiq.com/api/v1/content/product/product-1",
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => "",
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 30,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => "DELETE",
            CURLOPT_HTTPHEADER => [
                    "X-AUTH-TOKEN: YOUR_API_KEY",
                ],
        ]);
        
        $response = curl_exec($curl);
        $err = curl_error($curl);
        
        curl_close($curl);
        
        if ($err) {
            echo "cURL Error #:" . $err;
        } else {
            echo $response;
        }
        ```

!!! Response

    === "200 OK"

        ```
        {
          "id": "product-1",
          "name": "Wild fruit",
          "slug": "wild-fruit",
          "price": 12,
          "category": [
            {
              "id": "category-2",
              "name": "Black tea",
              "slug": "black-tea",
              "image": [
                {
                  "type": "internal",
                  "dataUrl": "/api/v1/content/_media/_media-5eb3b2cb85196"
                }
              ],
              "internal": {
                "createdAt": "2020-05-07T07:03:52+00:00",
                "deletedAt": "",
                "updatedAt": "2020-05-07T08:29:14+00:00",
                "contentType": "category",
                "workflow_state": "saved"
              }
            }
          ],
          "internal": {
            "createdAt": "2020-05-07T07:03:55+00:00",
            "deletedAt": "",
            "updatedAt": "2020-07-10T08:23:49+00:00",
            "contentType": "product",
            "workflow_state": "saved"
          },
          "description": "<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc interdum erat vitae aliquet euismod. Curabitur hendrerit, eros sed iaculis aliquam, ante magna placerat ante, at fermentum augue nulla non justo. Curabitur arcu sem, venenatis eget lobortis a, aliquet nec nunc. Nam tristique, est ac dictum iaculis, mauris nunc pellentesque lacus, in pulvinar enim turpis in dolor. Morbi porta, mi vitae euismod volutpat, nisi sem mollis ligula, nec faucibus erat est vitae ante. Maecenas fringilla sodales tortor a varius. Fusce ipsum lorem, pharetra id tempus non, luctus in elit.</p>\n\n<p>Aliquam lectus arcu, accumsan quis libero vel, placerat faucibus orci. Aenean vitae mattis turpis, id egestas arcu. Integer non purus dui.</p>\n\n<ul>\n\t<li>Etiam porttitor massa id velit semper, vitae posuere leo egestas.</li>\n\t<li>Nunc congue, quam vestibulum cursus luctus, turpis sem feugiat odio, eu placerat ex tellus vitae elit.</li>\n\t<li>Phasellus sodales purus sed auctor feugiat. Morbi varius pretium ligula id semper. In ac scelerisque erat.</li>\n\t<li>Quisque a metus ut nibh finibus hendrerit.</li>\n</ul>\n\n<p>Nam in quam et libero mollis venenatis viverra a odio. Aenean in lacus id libero pretium scelerisque ac cursus est. Quisque egestas leo ut ex sollicitudin, at porta nunc tincidunt. Nulla posuere, enim eu commodo gravida, orci erat egestas lorem, sit amet imperdiet lectus massa quis libero. Maecenas a hendrerit nunc. Cras eu quam metus. Etiam volutpat, leo nec faucibus sollicitudin, sapien lacus bibendum lorem, maximus porttitor ligula tortor a orci. Aenean non diam ornare, condimentum nisi sed, viverra justo. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Cras commodo efficitur metus, in interdum purus. Cras sed risus eget arcu dapibus consequat. Aenean quis aliquam dia.</p>\n",
          "productImage": [
            {
              "id": "_media-5eb3b2cb53e21",
              "url": "/image/0x0/_media-5eb3b2cb53e21.jpg",
              "size": 574633,
              "type": "image",
              "width": 1920,
              "height": 1275,
              "source": "disk",
              "fileName": "_media-5e8d9bf8e731d.jpg",
              "internal": {
                "createdAt": "2020-05-07T07:03:40+00:00",
                "deletedAt": "",
                "updatedAt": "2020-05-07T07:03:40+00:00",
                "contentType": "_media",
                "workflow_state": "saved"
              },
              "mimeType": "image/jpeg",
              "extension": "jpg",
              "externalId": ""
            }
          ],
          "productGallery": [
            {
              "id": "_media-5eb3b2cb53e21",
              "url": "/image/0x0/_media-5eb3b2cb53e21.jpg",
              "size": 574633,
              "type": "image",
              "width": 1920,
              "height": 1275,
              "source": "disk",
              "fileName": "_media-5e8d9bf8e731d.jpg",
              "internal": {
                "createdAt": "2020-05-07T07:03:40+00:00",
                "deletedAt": "",
                "updatedAt": "2020-05-07T07:03:40+00:00",
                "contentType": "_media",
                "workflow_state": "saved"
              },
              "mimeType": "image/jpeg",
              "extension": "jpg",
              "externalId": ""
            },
            {
              "id": "_media-5eb3b2cb94093",
              "url": "/image/0x0/_media-5eb3b2cb94093.jpg",
              "size": 415013,
              "type": "image",
              "width": 1920,
              "height": 1259,
              "source": "disk",
              "fileName": "_media-5e8d9c642c913.jpg",
              "internal": {
                "createdAt": "2020-05-07T07:03:40+00:00",
                "deletedAt": "",
                "updatedAt": "2020-05-07T07:03:40+00:00",
                "contentType": "_media",
                "workflow_state": "saved"
              },
              "mimeType": "image/jpeg",
              "extension": "jpg",
              "externalId": ""
            },
            {
              "id": "_media-5eb3b2cbd798a",
              "url": "/image/0x0/_media-5eb3b2cbd798a.jpg",
              "size": 384246,
              "type": "image",
              "width": 1920,
              "height": 1280,
              "source": "disk",
              "fileName": "_media-5e8d9c6589de6.jpg",
              "internal": {
                "createdAt": "2020-05-07T07:03:40+00:00",
                "deletedAt": "",
                "updatedAt": "2020-05-07T07:03:40+00:00",
                "contentType": "_media",
                "workflow_state": "saved"
              },
              "mimeType": "image/jpeg",
              "extension": "jpg",
              "externalId": ""
            }
          ]
        }
        ```

    === "401 Unauthorized"

        Returned when API key was missing or incorrect
  
        ```
        {
            "code": 401,
            "massage": "Unauthorized"
        }
        ```

    === "404 Not found"

        Returned when the content object wasn't found

        ```
        {
            "code": 404,
            "massage": "Not found"
        }
        ```

[Register to start creating your content objects](https://editor.flotiq.com/register.html){: .flotiq-button}
