title: Lifecycle webhooks
description: How to use lifecycle webhooks in Flotiq

# Lifecycle webhooks

!!! note
    Flotiq lifecycle webhooks can be customized in enterprise version only.
    Reach out to us to discuss possible implementation.

## What is a Lifecycle webhook?
Lifecycle webhooks to odmiana webhooków które wykonują się synchronicznie.
To znaczy że gdy podczas modyfikacji CO zostanie uruchomiony lifecycle webhook to proces modyfikacji CO poczeka na response z webhooka.
Response z wykonania webhooka posłuży do modyfikacji CO.

## Jak to działa?
Tworzymy nowy webhook o typie "Synchronisus", pozostałe pola wypełniammy i używamy tak samo jak w przypadku zwykłych webhooków.
![](../images/webhooks-lifecycle/WebhooksLifecycle.png)

Teraz przed modyfikacją/tworzeniem/usunięciem content obiektu jego treść zostanie wysłana na wspazany przez webhooka adres.
Request ten ma następujący schemat:
```
{
    "type":"request",
    "subject":"content-object",
    "event": "pre-create",
    "sequenceNumber": 0,
    "payload": {
        ...
    }
}
```
Pola:

* type - typ
* subject - content object
* event - event na którym został wysłany request: pre-create, pre-update, pre-delete
* sequenceNumber - liczba przetworzeń obiektu
* payload - dane obiektu

Endpoint webhooka powinien odpowiedzieć responsem o schemacie:
```
HTTP 200:
{
    "type":"response",
    "subject":"content-object",
    "event": "pre-create",
    "sequenceNumber": 0,
    "response": {},
    "payload": {
        ...
    }
}

HTTP 400:
{
    "type":"response",
    "subject":"content-object",
    "event": "pre-create",
    "sequenceNumber": 0,
    "response": {
    "errors": []
    "payload": {
        ...
    }
}
```

Pola:

* type - typ, stała "respones"
* subject - content object, kopia z requestu
* event - event który wywołał respons, kopia z responsu
* sequenceNumber - liczba przetworzeń payloudu, jeśli ten sam obiekt będzie ptrzetwarzany wielokrotnie liczba ta będzie zwiększana
* response - kopia wysłanego nie przetworzonego payloadu
* payload - przetworzony payload którym zostanie zastąpiony content object

// wiele webhooków - kolejność
