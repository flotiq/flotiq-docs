
If you don't have any Content Type Definitions (CTD) yet, you see tiles with predefined CTDs from which you can choose your first one by clicking on the tile representing your chosen CTD.

![](images/TypeDefinitionsTiles.png){: .center .width75 .border}

Custom tile opens empty CTD.

If you already have at least one CTD you can use the dropdown menu on the top right corner to add more predefined CTDs.

![](images/TypeDefinitionsAddButton.png){: .center .border}

## Blog Post

Type for storing simple blog posts. It contains properties storing title, slug, content and images for post.

| Field name  | Field type | Additional attributes          | Comments               |
|-------------|------------|--------------------------------|------------------------|
| title       | Text       | Required, Part of object title | Title of your post     |
| slug        | Text       | Required, Unique               | URL of the post        |
| content     | Richtext   | -                              | The post itself        |
| thumbnail   | Relation   | Restrict to type: Media        | Thumbnail image        |
| headerImage | Relation   | Restrict to type: Media        | Main image of the post |

Gatsby starter for blog post:

[GitHub](https://github.com/flotiq/gatsby-starter-blog){:target="_blank"}

[Working example](https://flotiq-blog.herokuapp.com/){:target="_blank"}

## Event

Gatsby starter for event calendar:

[GitHub](https://github.com/flotiq/gatsby-starter-event-calendar){:target="_blank"}

[Working example](https://flotiq-starter-for-events-cal.herokuapp.com/){:target="_blank"}

## Product

Gatsby starter for products:

[GitHub](https://github.com/flotiq/gatsby-starter-products){:target="_blank"}

[Working example](https://flotiq-starter-products.herokuapp.com/){:target="_blank"}

## Project

Gatsby starter for projects:

[GitHub](https://github.com/flotiq/gatsby-starter-projects){:target="_blank"}

[Working example](https://flotiq-starter-for-projects.herokuapp.com/){:target="_blank"}

## Recipe

Gatsby starter for recipes:

[GitHub](https://github.com/flotiq/gatsby-starter-recipes){:target="_blank"}

[Working example](https://flotiq-starter-recipes.herokuapp.com/){:target="_blank"}
