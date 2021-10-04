---
layout: page-with-side-nav
title: Getting Started
---
# Getting Started

De 'WOZ Bevragen' API is gespecificeerd met behulp van de OpenAPI Specifications (OAS3).

Om aan te sluiten kun je de volgende stappen doorlopen:
1. [Bekijk de functionaliteit en specificaties](#functionaliteit-en-specificaties)
2. [Implementeer de API](#bouw-de-api)
3. [Probeer en test de API](#probeer-en-test-de-api)

## Functionaliteit en specificaties
Je kunt een visuele representatie van de specificatie bekijken met [Swagger UI]({{ site.baseurl }}/swagger-ui) of [Redoc]({{ site.baseurl }}/redoc).

* Je kunt een visuele representatie van de specificatie bekijken met [Swagger UI](https://vng-realisatie.github.io/Haal-Centraal-WOZ-bevragen/swagger-ui) en in [Redoc](https://vng-realisatie.github.io/Haal-Centraal-WOZ-bevragen/redoc)
* Je kunt de [Technische specificaties](https://github.com/VNG-Realisatie/Haal-Centraal-WOZ-bevragen/tree/master/specificatie/genereervariant/openapi.yaml) downloaden
* Je kunt de [functionele documentatie](https://vng-realisatie.github.io/Haal-Centraal-WOZ-bevragen/features) vinden in [features](https://vng-realisatie.github.io/Haal-Centraal-WOZ-bevragen/features).

## Bouw de API
We hebben [client code](https://github.com/VNG-Realisatie/Haal-Centraal-WOZ-bevragen/tree/master/code){:target="_blank" rel="noopener"} voor API-clients in enkele varianten. Hiermee kan je direct aan de slag met het gebruiken van de API.

Zit jouw gewenste ontwikkelomgeving er niet bij, dan kan je zelf ook code genereren vanuit de "[genereervariant](https://github.com/VNG-Realisatie/Haal-Centraal-WOZ-bevragen/tree/master/specificatie/genereervariant/openapi.yaml){:target="_blank" rel="noopener"}" van de API-specificaties.

## Probeer en test de API
Om te testen heb je een API-key nodig. Deze plaats je in requests in de header "x-api-key".

De url van de testomgeving is https://api.acceptatie.kadaster.nl/lvwoz/api/v1.

Bijvoorbeeld (met een fictieve API-key):
curl --location --request GET 'https://api.acceptatie.kadaster.nl/lvwoz/api/v1/wozobjecten/800000093455' --header 'x-api-key: a123bcd456efg789hij0'

Er is een aantal testgevallen beschikbaar in de acceptatieomgeving. Een overzicht van de testgevallen vind je in [test/cases](https://github.com/VNG-Realisatie/Haal-Centraal-WOZ-bevragen/tree/master/test/cases).

## Woz.BevragenProxy

Een WOZ-object opgevraagd via de WOZ Bevragen API bevat alle vastgestelde waarden per waardepeildatum voor het WOZ-object. Om voor een WOZ-object alleen de relevante actuele waarde per waardepeildatum op te vragen, kan gebruik worden gemaakt van de Woz.BevragenProxy.
De Woz.BevragenProxy routeert een WOZ-object bevraging naar de WOZ Bevragen API en filtert de niet-relevante waarden uit de response voordat deze wordt geretourneerd naar de bevrager. De wijze waarop dit wordt gedaan is beschreven in het [waarden.feature](https://github.com/VNG-Realisatie/Haal-Centraal-WOZ-bevragen/tree/master/features/waarden.feature) bestand.

In de volgende paragrafen is beschreven hoe de Woz.BevragenProxy t.b.v. test doeleinden op een lokale machine kan worden geïnstalleerd en geconfigureerd.

### Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop)
- API-key voor het aanroepen van de WOZ Bevragen API op de test omgeving 

### Bouwen van de Woz.BevragenProxy Container Image

- Clone de Haal Centraal WOZ bevragen repository:
  ```sh
  git clone https://github.com/VNG-Realisatie/Haal-Centraal-WOZ-bevragen.git
  ```
- Vervang in het src/config/Woz.BevragenProxy/ocelot.json bestand de **woz-api-key** placeholder met je API-key
- Build de Woz.BevragenProxy Container Image. Dit kan enige tijd duren.
  ```sh
  docker-compose build
  ```
### Opstarten van de Woz.BevragenProxy Container

- Start de Woz.BevragenProxy met de volgende statement
  ```sh
  docker-compose up -d
  ```
- Roep de WOZ Bevragen API aan met als base url: *http://localhost:5000*. Een aanroep met curl ziet er als volgt uit:
  ```sh
  curl --location --request GET 'http://localhost:5000/wozobjecten/800000003118'
  ``` 
