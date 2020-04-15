
If you don't have any Content Type Definitions (CTD) yet, you see tiles with predefined CTDs from which you can choose your first one by clicking on the tile representing your chosen CTD.

![](images/TypeDefinitionsTiles.png){: .center .width75 .border}

Custom tile opens empty CTD.

If you already have at least one CTD, you can use the dropdown menu on the top right corner to add more predefined CTDs.

![](images/TypeDefinitionsAddButton.png){: .center .border}

## Blog Post

Type for storing simple blog posts. It contains properties storing title, slug, content and images for the post:

| Field name  | Field type | Additional attributes          | Comments                           |
|-------------|------------|--------------------------------|------------------------------------|
| title       | Text       | Required, Part of object title | Title of your post                 |
| slug        | Text       | Required, Unique               | URL of the post                    |
| content     | Rich Text  | Required                       | The post itself, with HTML content |
| thumbnail   | Relation   | Restrict to type: Media        | Thumbnail image                    |
| headerImage | Relation   | Restrict to type: Media        | Main image of the post             |

![](../Deep-Dives/images/3-minute-blog-content-type-all-fields.png){: .center .width75 .border}

Gatsby starter for blog post:

[GitHub](https://github.com/flotiq/gatsby-starter-blog){:target="_blank"}

[Working example](https://flotiq-blog.herokuapp.com/){:target="_blank"}

## Event

Type for storing simple events. It contains name, slug, address, date, description and gallery for the event:

| Field name  | Field type | Additional attributes             | Comments                                              |
|-------------|------------|-----------------------------------|-------------------------------------------------------|
| name        | Text       | Required, Part of object title    | Name of your event                                    |
| slug        | Text       | Required, Unique                  | URL of the event                                      |
| address     | Textarea   | Required                          | Address of the event                                  |
| date        | Text       | Required                          | Date of the event, you can use any format of the date |
| description | Rich Text  | -                                 | Description of the event, with HTML content           |
| gallery     | Relation   | Restrict to type: Media, Multiple | Gallery for the event                                 |

![](./images/PredefinedCTDEvent.png){: .center .width75 .border}

Gatsby starter for event calendar:

[GitHub](https://github.com/flotiq/gatsby-starter-event-calendar){:target="_blank"}

[Working example](https://flotiq-starter-for-events-cal.herokuapp.com/){:target="_blank"}

## Product

Type for storing simple products. It contains properties storing name, slug, price, description and images for the product:

| Field name     | Field type | Additional attributes                  | Comments                                          |
|----------------|------------|----------------------------------------|---------------------------------------------------|
| name           | Text       | Required, Unique, Part of object title | Name of your product                              |
| slug           | Text       | Required, Unique                       | URL of the product                                |
| price          | Number     | Required                               | Price of the product                              |
| description    | Rich Text  | -                                      | The description of the product, with HTML content |
| productImage   | Relation   | Restrict to type: Media                | Main image                                        |
| productGallery | Relation   | Restrict to type: Media, Multiple      | Gallery for the product                           |

![](./images/PredefinedCTDProduct.png){: .center .width75 .border}

Gatsby starter for products:

[GitHub](https://github.com/flotiq/gatsby-starter-products){:target="_blank"}

[Working example](https://flotiq-starter-products.herokuapp.com/){:target="_blank"}

## Project

Type for storing simple project portfolio entries. It contains properties storing name, slug, description and images for the project:

| Field name  | Field type | Additional attributes                  | Comments                                          |
|-------------|------------|----------------------------------------|---------------------------------------------------|
| name        | Text       | Required, Unique, Part of object title | Name of your project                              |
| slug        | Text       | Required, Unique                       | URL of the project                                |
| description | Rich Text  | -                                      | The description of the project, with HTML content |
| gallery     | Relation   | Restrict to type: Media, Multiple      | Gallery for the project                           |

![](./images/PredefinedCTDProject.png){: .center .width75 .border}

Gatsby starter for projects:

[GitHub](https://github.com/flotiq/gatsby-starter-projects){:target="_blank"}

[Working example](https://flotiq-starter-for-projects.herokuapp.com/){:target="_blank"}

## Recipe

Type for storing recipes. It contains properties storing name, slug, description, ingredients, steps, cooking time, servings and image for the recipe:

| Field name  | Field type | Additional attributes                  | Comments                                         |
|-------------|------------|----------------------------------------|--------------------------------------------------|
| name        | Text       | Required, Unique, Part of object title | Name of your recipe                              |
| slug        | Text       | Required, Unique                       | URL of the recipe                                |
| image       | Relation   | Restrict to type: Media                | Main image of your recipe                        |
| description | Rich Text  | -                                      | The description of the recipe, with HTML content |
| ingredients | List       | described in the table below           | Detailed list of the ingredients                 |
| steps       | List       | described in the table below           | Detailed list of the steps                       |
| cookingTime | Text       | -                                      | Cooking time of the recipe                       |
| servings    | Number     | -                                      | Servings of the recipe                           |

Ingredients list properties description:

| Field name  | Field type | Additional attributes                                                              | Comments                                 |
|-------------|------------|------------------------------------------------------------------------------------|------------------------------------------|
| amount      | Number     | -                                                                                  | Amount of the product needed             |
| unit        | Select     | Options: "", g, kg, ml, pcs, tablespoon, teaspoon, ounce, pound, cup, clove, pinch | Unit of the amount of the product needed |
| product     | Text       | -                                                                                  | Name of the product                      |

Steps list properties description:

| Field name  | Field type | Additional attributes   | Comments                |
|-------------|------------|-------------------------|-------------------------|
| image       | Relation   | Restrict to type: Media | Image for the step      |
| step        | Textarea   | -                       | Description of the step |


![](./images/PredefinedCTDRecipe.png){: .center .width75 .border}

Gatsby starter for recipes:

[GitHub](https://github.com/flotiq/gatsby-starter-recipes){:target="_blank"}

[Working example](https://flotiq-starter-recipes.herokuapp.com/){:target="_blank"}
