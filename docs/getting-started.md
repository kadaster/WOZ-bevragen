---
layout: page-with-side-nav
title: Getting Started
---
# Getting Started

De 'WOZ Bevragen' API is gespecificeerd met behulp van de OpenAPI Specifications (OAS3).

Om aan te sluiten kun je de volgende stappen doorlopen:
1. [Meld je aan bij het kadaster om toegang te krijgen](#aanmelden-om-aan-te-sluiten)
2. [Bekijk de functionaliteit en specificaties](#functionaliteit-en-specificaties)
3. [Implementeer de API](#bouw-de-api)
4. [Probeer en test de API](#probeer-en-test-de-api)

## Aanmelden om aan te sluiten
Meld je aan bij het kadaster om [aan te sluiten en voor toegang tot de testomgeving](TODO TODO TODO TODO TODO). Je ontvangt dan o.a. een API-key die nodig is voor toegang tot de testomgeving.

## Functionaliteit en specificaties
Je kunt een visuele representatie van de specificatie bekijken met [Swagger UI]({{ site.baseurl }}/swagger-ui) of [Redoc]({{ site.baseurl }}/redoc).

* Je kunt een visuele representatie van de specificatie bekijken met [Swagger UI](https://vng-realisatie.github.io/Haal-Centraal-WOZ-bevragen/swagger-ui) en in [Redoc](https://vng-realisatie.github.io/Haal-Centraal-WOZ-bevragen/redoc)
* Je kunt de [Technische specificaties](https://github.com/VNG-Realisatie/Haal-Centraal-WOZ-bevragen/tree/master/specificatie/genereervariant/openapi.yaml) downloaden
* Je kunt de [functionele documentatie](https://vng-realisatie.github.io/Haal-Centraal-WOZ-bevragen/features) vinden in [features](https://vng-realisatie.github.io/Haal-Centraal-WOZ-bevragen/features).

## Bouw de API
We hebben [client code](https://github.com/VNG-Realisatie/Haal-Centraal-WOZ-bevragen/tree/master/code){:target="_blank" rel="noopener"} voor API-clients in enkele varianten. Hiermee kan je direct aan de slag met het gebruiken van de API.

Zit jouw gewenste ontwikkelomgeving er niet bij, dan kan je zelf ook code genereren vanuit de "[genereervariant](https://github.com/VNG-Realisatie/Haal-Centraal-WOZ-bevragen/tree/master/specificatie/genereervariant/openapi.yaml){:target="_blank" rel="noopener"}" van de API-specificaties.

## Probeer en test de API
Om te testen heb je een API-key nodig. Deze plaats je in requests in de header "apikey". Een API key kan je bij het Kadaster [aanvragen](TODO TODO TODO TODO TODO).

De url van de testomgeving is https://api.acceptatie.kadaster.nl/lvwoz/api/v1.

Bijvoorbeeld (met een fictieve API-key):
curl --location --request GET 'https://api.acceptatie.kadaster.nl/lvwoz/api/v1/wozobjecten/800000093455' --header 'apikey: a123bcd456efg789hij0'

Er is een aantal testgevallen beschikbaar in de acceptatieomgeving. Een overzicht van de testgevallen vind je in [test/cases](https://github.com/VNG-Realisatie/Haal-Centraal-WOZ-bevragen/tree/master/test/cases).