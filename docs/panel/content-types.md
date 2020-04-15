# Content Types

On this page, we describe how to create **Content Type Definition** (**CTD**) using [Flotiq Dashboard](https://editor.flotiq.com){:target="_blank"}. 

We use simple Blog Post CTD as an example:

Example: 
!!! note "Example: Content Type Definition for Blog Post"
    * id – string, unique, required, Flotiq Dashboard adds this automatically
    * title – string, required, part of the object title
    * slug – string, unique, required 
    * content – string, required
    * thumbnail - relation to Media type
    * headerImage - relation to Media type

You need an activated account to see the CTD page in the Dashboard. This documentation page does not describe how to create CTDs using API if you want to learn about it head to the [Working with Content Types API](../API/content-types.md)

## Creating Content Type Definitions

The Content Modeler is a convenient tool for modelling CTDs, which you can access through the ``Type definitions`` menu entry.
The Modeler interacts with the ``/api/v1/internal/contenttype`` endpoint on behalf of the user and seamlessly integrate into the Content Management Platform.

Click Type definitions in the menu on the left to get to CTDs list:

![](images/TypeDefinitionsMenu.png){: .center .border}

If you don't have any CTDs yet, you see tiles with predefined CTDs. Select your first one or create such from scratch by choosing `Custom`. It is also possible to create additional CTD by clicking `Add definition` button in the top right corner of the page. To learn more about predefined CTDs, head [here](./predefined-content-types.md)

![](images/TypeDefinitionsTiles.png){: .center .width75 .border}

In this example, click `Blog Post` predefined type.

![](images/AddContentTypeDefinitions.png){: .center .width75 .border}

It has five properties:

1. title

2. slug

3. content

4. thumbnail

5. headerImage
    

Click pencil icon to edit title property. As you see title is required property of Text type. It will render Text Input in Blog Post Content Object form:

![](images/AddContentTypeDefinitionsTitle.png){: .center .width75 .border}

Also, because `Part of object title` is checked, objects listing; to use them in the relation of other objects; use this property value to describe the object. Learn more about connecting objects via relations in [managing Content Objects](content-objects.md#Relations). You can find more about property settings [below](#property-settings).

The slug property is also required, but also must be unique across all your blogpost objects in the system.
Of course, if someone else would make blogpost CTD with the unique value of the slug, you could make an object with the same slug as the owner of the second blogpost CTD.

![](images/AddContentTypeDefinitionsSlug.png){: .center .width75 .border}

The content property is set to generate Rich Text input (we use CKEditor in Flotiq):

![](images/AddContentTypeDefinitionsContent.png){: .center .width75 .border}

The thumbnail property is the relation to Media CTD - a system type definition that anyone can use but sees only their entries. It can only have one element added.

![](images/AddContentTypeDefinitionsThumbnail.png){: .center .width75 .border}

The headerImage is set up exactly like the thumbnail; the only difference is the property name.

![](images/AddContentTypeDefinitionsHeaderImage.png){: .center .width75 .border}

You can add more fields by clicking the `Add property` button, which opens the modal window, where you can define the property name, data type, and it's basic validation. It opens the same modal as for editing of the property.

After saving your CTD, Dashboard redirects you on the CTDs list, where you can click on the tile to list Content Objects or click on the cog to edit CTD.

![](images/TypeDefinitionsList.png){: .center .width75 .border}

Predefined CTD tiles are no longer visible. You can use the dropdown menu on the top right corner to add more of such types.

![](images/TypeDefinitionsAddButton.png){: .center .border}

## Updating Content Type Definitions

You can always edit your CTDs. Click the cog icon on the CTD tile to do that, but you should be aware that **previously added objects would not be consistent with the schema**. Flotiq automatically updates the search index after the CTD update. If you would change the types of properties it can lead to data loss in the search index, as the property data have to be wiped out to keep the index working correctly, it can especially occur when you change the type from Text to Relation or vice versa. The safe type change is between string types (Text, Textarea, RichText, Email) and between Number and string types (but changing string to number leads to data loss).

## Property settings

Here you can find the explanation of property settings and for what types of properties they apply:

| Setting              | Possible for types                                         | Required                                      | Unique | Description |
| -------------------- | ---------------------------------------------------------- | --------------------------------------------- |------- | ----------- |
| Property key         | all                                                        |   yes                                         |  yes   | Name of the property have to be unique throughout the definition. |
| Property type        | all                                                        |   yes                                         |  no    | Type of the property, its options are described in the table below. |
| Unique               | Text, Textarea, Rich Text, Email, Number, Select, Relation |   no                                          |  no    | Information if the value of the property should be unique across all objects of this type |
| Required             | all                                                        |   no                                          |  no    | Information if the value should exist in the object, for strings it has to non-empty string |
| Part of object title | Text, Textarea, Email, Number, Select                      |   no                                          |  no    | Information if the value of this property should be used when displaying a list of objects in the relation creation |
| Regex pattern        | Text                                                       |   no                                          |  no    | Validation information, the pattern that every string should follow to be the correct value for the property (it follows [ECMA 262](https://www.ecma-international.org/ecma-262/5.1/#sec-7.8.5){:target="_blank"} specification, but [here](https://json-schema.org/understanding-json-schema/reference/regular_expressions.html#example){:target="_blank"} you can find more user-friendly description). E.g.` ^\d{3}-\d{2}-\d{4}$` for ensuring that string is Social Security Number (SSN) in the 123-45-6789 format - Note that the regular expression is enclosed in the ^…$ tokens, where ^ means the beginning of the string, and $ means the end of the string. Without ^…$, the pattern works as a partial match, that is, matches any string that contains the specified regular expression. For example, pattern: pet matches pet, petstore and carpet. The ^…$ token forces an exact match. |
| Read-only            | Text, Textarea, Email, Number, Radio, Checkbox, Select     |   no                                          |  no    | Information if the Dashboard user can insert the value only on creating of the object or also on update (you can always edit it through API) if checked user can insert value only on object creation |
| Hidden               | Text, Textarea, Email, Number, Radio, Checkbox, Select     |   no                                          |  no    | If checked property can be changed only through API, the form input will not be rendered in object form in Dashboard | 
| Default value        | Text, Textarea, Number, Select                             |   no                                          |  no    | Sets default value in object forms it is not respected when sending incomplete object through API |
| Help text            | all                                                        |   no                                          |  no    | Additional description shown under generated input, it is also displayed in API documentation |
| Options              | Radio, Select                                              |   no                                          |  no    | Options to choose from in generated object form |
| Multiple             | Relation                                                   |   no                                          |  no    | Information if the list of objects in relation should be bigger than one |
| Restrict to type     | Relation                                                   |   yes (only when Property type == Relation)   |  no    | Information on which types can be attached as the relation |

Property types:

| Type      | Description |
| --------- | ----------- |
| Text      | String type, generating Text Input in object form |
| Textarea  | Long string type accepting new line characters, generating Textarea in object form |
| Rich Text | Long string type accepting HTML, generating CKEditor in object form |
| Email     | String type, generating Email Input in object form |
| Number    | Number type accepting only integers, generating Number Input |
| Radio     | String type, generating Radio Input in object form |
| Checkbox  | Boolean type, generating single Checkbox in object form |
| Select    | String type, generating Select Dropdown in object form |
| Relation  | Array type accepts only objects specified in `Restrict to type`, items in relation array cannot be duplicated |
| List      | Object type generates subforms in object form; the inside object can have all types of properties except List. Properties of the inside object cannot be required, unique, read-only or hidden, cannot be part of the object title either. |
