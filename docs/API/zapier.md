title: Flotiq Zapier integration | Flotiq docs
description: Flotiq allows you to easily integrate your content with any system.

# Zapier integrations

Thanks to Zapier it's become extremely easy to build complex pipelines that 
integrate multiple sources of content together. Flotiq's goal is to help you 
make the best use of your content, so we provide [Zapier integrations](https://zapier.com/apps/flotiq/integrations) 
for the following events:

* Content Object Created
* Content Object Updated.

This way you will be able to perform complex actions, triggered by your content,
without writing a single line of code.

## How to use Flotiq and Zapier

1. In your Zapier account hit "Create Zap".
2. In the form type Flotiq, to select Flotiq events as the trigger for the pipeline

![Select Flotiq as the source for Zapier](images/zapier/zapier-1.png)

3. Select which event you'd like to trigger on - we'll choose Content Object Created for now.

![Select Content Object Created event](images/zapier/zapier-2.png)

4. Authorize Zapier to access your Flotiq account - provide your ReadOnly API key.

![Authorize Zapier to access your Read Only Flotiq API](images/zapier/zapier-3.png)

5. Choose which Content Type you'd like to watch

![Choose the Content Type](images/zapier/zapier-4.png)

6. Load data samples and hit "Done editing"!

![Load data samples and proceed](images/zapier/zapier-5.png)

7. Choose the target integration, we'll pick Gmail for this tutorial

![Select target integration](images/zapier/zapier-6.png)

8. Select the action event, we chose Send email

![Select the action event](images/zapier/zapier-7.png)

9. Zapier let's you choose the fields of the content type you defined, choose which fields you'd like to be included in the email

![Select which Content Object fields should be passed to the next action](images/zapier/zapier-8.png)

10. That's it! Hit Continue, turn on your new Zap and watch your content flow through Zapier!
![Turn the Zap on](images/zapier/zapier-9.png)