---
tags:
  - Content Creator
---

# Field types

There are 16 types of controls in the dashboard, all described in detail below:

* [Text](#text)
* [Long text](#long-text)
* [Markdown](#markdown)
* [Rich text](#rich-text)
* [Email](#email)
* [Number](#number)
* [Radio button](#radio-button)
* [Checkbox](#checkbox)
* [Select](#select)
* [Relation](#objects-relations)
* [Media relation](#media-relations)
* [List](#list)
* [Geo](#geo)
* [Date](#date)
* [Block](#block)
* [Simple list](#simple-list)

All required fields are marked with a red asterisk - *.
You can save Content Object only when you insert values in all required fields.

Interaction buttons of Content Objects are in the top right corner of the edit screen:

![](../images/co-form/EditButtons.png){: .center .width50 .border}

To save and stay on the form, click the `Save` button.

To save and leave the form, click the arrow on the right of the `Save` button and then click the `Save and leave` button.

To leave the form without changing anything, click the `Cancel` button.

## Text

Standard text input.

## Long text

Standard textarea input, preserving newlines as `\n`.

## Markdown

Input for the markdown.
You can write in markdown or use WYSIWYG to generate one; the switch is on the right bottom corner of the control.
Flotiq does not validate the Markdown code.

Markdown controls:

![](../images/co-form/markdown/Controls.png){: .center .border .width50}

* Full screen - opens the full-screen markdown editor, helpful when editing long texts.
* Heading - switch edited line to a heading (`# heading 1`)
* Bold text - bolds texts (`**text**`)
* Italic text - slants text (`*text*`)
* Strikethrough text - cross out text (`--text--`)
* Insert horizontal line - inserts horizontal line (`***`)
* Blockquote - insert blockquote block (`>`)
* Bulleted list - insert unordered list (`* list item`)
* Ordered list - insert ordered list (`1. list item`)
* Checkbox list (task) - insert list with checkboxes (`*[] list item`)
* Indent - makes indentation bigger
* Outdent - makes indentation smaller
* Insert table (2x2 - 10x15) - inserts table with the header and at least one row
* Insert image - please use it only for adding images from outside of the Flotiq (switching the tab to `URL`),
  as it puts base64 of the image into the markdown, if you wish to add an image from Flotiq, use the `Open media library` button
* Insert link - inserts link, (`[link description](link url)`)
* Open media library - opens Media Library, where you can add new files or select the ones already added
* Inline code - insert inline code formatting (`` `inline code` ``)
* Insert code block - insert code block formatting

For better explanation of markup please refer to [Markup Guide](https://www.markdownguide.org/basic-syntax/){:target="_blank"} by Matt Cone.

## Rich text

Rich text control help format text and generates HTML markup.
Formatting works similar to MS Word or Google Docs formatting.

### Rich text controls

![](../images/co-form/richtext/Controls.png){: .center .border .width50}

First row:

* Bold text - bolds the text
* Italic text - slants the text
* Underline text - underline the text
* Strikethrough text - cross out the text
* Remove format - remove all formatting from the text
* Ordered list - adds ordered list, to change the level of the list, use tab
* Bullet list - adds unordered list, to change the level of the list, use tab
* Aligning text - align whole paragraph or header
    * Left
    * Center
    * Right
    * Justified
* Insert horizontal line - adds a horizontal line
* Add/remove link - adds a link to selected text. If selected text is already linked, you can change the options or remove the link
* Paragraph format - formats whole paragraph
    * Normal
    * Heading 1
    * Heading 2
    * Heading 3
    * Heading 4
    * Formatted
* Font - change font of the selected text
    * Default
    * Arial
    * Comic Sans Ms
    * Courier New
    * Georgia
    * Lucida SAns Unicode
    * Tahoma
    * Times New Roman
    * Trebuchet MS
    * Verdana
* Font Size - change size of the selected text
    * Auto
    * 8, 9, 10, 11, 12, 14, 16, 18, 20, 22, 24, 26, 28, 36, 48, 72

Second row:

* Font/background color

  ![](../images/co-form/richtext/ColorControl.png){: .center .border .width25}

* Image - add image by providing image URL
* Media library - opens Media Library, where you can add new files or select the ones already added

* Link object - opens modal with existing objects. Once object is selected a new span is embedded into the editor HTML. The span contains following attributes:
    * `data-relation-object-id` - object id
    * `data-relation-object-type` - object type
    * `data-relation-url` - object data url

  Note that the span is empty and its up to you to handle it on your page programmatically.

* Display source - shows editable HTML markup of field contents; please change it with caution.

### Image options

After image is added, you can double-click to format it. You can add alternative text, change the dimensions, position and border of the image. You can also add a hyperlink to it by switching to the `Link` tab.

![](../images/co-form/richtext/ImageProperties.png){: .center .border .width50}

You can make the editor bigger by dragging the grey arrow in the bottom right corner of the control.

## Email

Text input with email validation.

## Number

Number input. The range is from `-2^53 + 1` to `2^53 - 1`, safe precision is `10^-10`.

## Radio button

Standard radio button control.

## Checkbox

Standard checkbox control.

## Select

Standard select control. Depending on `multiple` meta property you can choose only one or many options.

## Relation

Flotiq has two types of relations in the dashboard (they are managed in the same way in the json object),
content object relation and media relation:

![](../images/co-form/datasource/Relations.png){: .center .width75 .border}

If you want to remove the linked object, click the `trash` icon on the object's right side.
You can change the order of objects in relation using drag and drop, click on the right side of the relation panel to do that.
You can edit it by clicking the `pencil` button, and swap to another object using `swap` button. To copy object ID use `copy link` button.

### Objects relations

You can either open the form for object creation using the `Add (object name)` button:

![](../images/co-form/datasource/RelationAddModal.png){: .center .width75 .border}

After saving the object, the system automatically links it to the object you are editing/creating right now.

Or you can also click the `Pick (object name)` button and link the object created earlier:

![](../images/co-form/datasource/LinkExistingObject.png){: .center .border}

To add the object, click on the desired object and then the `Add` button.
You can search and sort objects using the controls on top of the modal.

!!! note    
  You can add all objects of the same type at once.

### Media relations

The `Add new media and link` button opens Media Library, where you can add new files or select the ones already added.

![](../images/co-form/datasource/MediaLibraryModal.png){: .center .width75 .border}

To add the media object, click on the desired file and the `Save changes` button.
Newly uploaded files are automatically selected; you only need to click the `Save changes` button.

## List

If the object has a list property, Flotiq generates series of sub-forms with properties described in such list:

![](../images/co-form/list/List.png){: .center .width75 .border}

To add the new object to the list, click the `Add item` button.
You can change the order of objects in the list using the up and down arrow in the top right corner of object form.
You can remove the object from the list using the trash icon in the top right corner of the object form.

If the list property contains a `list` child property, the nested form will be displayed.
![](../images/co-form/list/NestedList.png){: .center .width75 .border}

## Geo

Control for geolocation points. You can find the address using `Find on map` input or by dragging the marker on the map.
You can put the coordinates in `Latitude` and `Longitude` inputs below the map if you know the coordinates without searching.

![](../images/co-form/geo/GeoControl.png){: .center .width75 .border}

## Date

Date control. You can write the date and time or choose them from the popups.

![](../images/co-form/date/DateControl.png){: .center .width75 .border}

## Block

Developers friendly content builder.
You can add texts, headers, lists, media, YouTube videos, quotes, warnings and delimiters.
The control generates json description of the blocks used.

![](../images/co-form/block/AddBlocks.png){: .center .width50 .border}

To add the block different from standard text, click the `+` button and choose the block from the controls.

Block controls:

![](../images/co-form/block/Controls.png){: .center .border .width25}

You can tune every block by clicking the dots button after clicking on the block.
In all the tune menus, you can move the block up (`arrow up` button),
remove the block (`X` button) and move the block down (`arrow down` button).

* Text - block for standard paragraph content.

  ![](../images/co-form/block/TextTunes.png){: .border .width25 .center}

  The tunes allow to align the text in the paragraph (left, center and right).

  You can change the block type by selecting part of the text and opening the convert menu by clicking the `T` button.
  You can also bold (`B` button) or slant (`i` button) selected text or add a link to it (chain button).

  ![](../images/co-form/block/TextConversion.png){: .border .width25 .center}

* Heading - block for standard header content.

  ![](../images/co-form/block/HeaderTunes.png){: .border .width25 .center}

  The tunes allow to change the level of the header, add an anchor link to it or align the text in the header (left, center and right).

  You can change the block type by selecting part of the text and opening the convert menu by clicking the `H` button.
  You can also bold (`B` button) or slant (`i` button) selected text or add a link to it (chain button).

  ![](../images/co-form/block/HeaderConversion.png){: .border .width25 .center}

* List - block for ordered and unordered lists; you can increase the level of the list using tab.

  ![](../images/co-form/block/ListTunes.png){: .border .width25 .center}

  The tunes allow changing the type of the list.

  You can bold (`B` button) or slant (`i` button) text or add a link to it (chain button) by selecting part of the text.

  ![](../images/co-form/block/ListConversion.png){: .border .width25 .center}

* Media - block for files (images, videos, audio, pdf)

  After you choose this block, the `Media library` button will appear.
  To choose an image, video or text file, you need to click that button and find the file you need to attach to the block.

  You can add a border, stretch or add background to the file in the tunes' menu.

  ![](../images/co-form/block/MediaTunes.png){: .border .width25 .center}

* YouTube video - block for videos from YouTube; this block has only common tune settings.
* Quote - block for quotes with captions

  ![](../images/co-form/block/QuoteTunes.png){: .border .width25 .center}

  The tunes allow aligning the text in the quote (left and center).

* Warning - block for warnings with place for the name and message; this block has only common tune settings.
* Delimiter - block indicating delimiter; it does not have any content; this block has only common tune settings.
* Code - block indicating code block; this block has only common tune settings.
* Table - block for table

  ![](../images/co-form/block/TableTunes.png){: .border .width25 .center}

  The tunes allow adding information whether the table has header or not.

## Simple list

Array of standard text inputs wit possibility of choosing the order, in other places referred as Options control.
