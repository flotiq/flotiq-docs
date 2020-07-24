# API access

## API Key
There are two types of API keys - [Application Keys](#application-api-keys) and [User Defined Keys](#user-defined-api-keys). Both types of keys can be retrieved from the API Keys page in the Flotiq Panel (click on your avatar to open menu):

![](images/user-profile.png){: .center .border}

All keys restrict access to not only CRUD of the Content Objects, but also to their hydration and search; the same restrictions apply to GraphQL endpoint.

!!! note 
    _**Keys CAN NOT be obtained through programmatic API, and they are accessible only from the Flotiq Panel.**_

### Application API Keys

There are 2 Application API keys - read-write and read-only. Application keys are system-wide keys, and you can use them to manage Content Objects and Content Type Definitions. Although as the best practice, we recommend you use the Application read-only API key or User Defined API key whenever possible.

![](images/api-keys_1.png){: .center .width75 .border}

All keys can be copied using ![](images/copy_icon.png){: style="margin-bottom: -7px;"} button. 
You can open QR code with the key using ![](images/qr_button.png){: style="margin-bottom: -7px;"} button, 
and you can regenerate keys using ![](images/regenerate_button.png){: style="margin-bottom: -7px;"} button. 
Only user defined keys can be removed using ![](images/remove_button.png){: style="margin-bottom: -7px;"} button.

### User Defined API Keys

![](images/api-keys_2.png){: .center .width75 .border}

You can add your own API keys restricted to specific Content Objects (e.g. Media) and actions (create, read, update, delete). 

![](images/api-keys_3.png){: .center .width75 .border}

You can also mix and match access to any Content Objects from your account, to add new access rule for CO, click "Add Rule" button. When the key is complete, don't forget to save it using the "Save" button. 

![](images/api-keys_4.png){: .center .width75 .border}

Every key has to be saved separately.

To restrict access for already used keys you can remove all rules or remove the key. You can regenerate keys if you suspect somebody unauthorized had access to them.

And here you can see how it looks all in the User Interface:

![](images/api-keys.png){: .center .width75 .border}



