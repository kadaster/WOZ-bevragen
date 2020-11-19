---
layout: page-with-side-nav
title: Haal Centraal WOZ bevragen
---
# Haal Centraal WOZ bevragen

## Introductie
Deze API WOZ bevragen maakt het mogelijk gegevens uit de landelijke voorziening WOZ (Waardering Onroerende Zaken) op te vragen.

Deze API is ontwikkeld vanuit het programma Haal Centraal. Doel van het programma Haal Centraal is om de verstrekking van basisgegevens aan binnengemeentelijke afnemers te outsourcen naar Landelijke Registraties (RvIG, Kadaster, KVK). Dit moet leiden tot een forse reductie van lokale kopieën bij gemeenten.

## Documentatie
* [Technische specificaties](./specificatie/genereervariant/openapi.yaml) (Open API Specificaties en JSON schema) en in [Swagger-formaat](https://petstore.swagger.io/?url=https://raw.githubusercontent.com/VNG-Realisatie/Haal-Centraal-WOZ-bevragen/master/specificatie/genereervariant/openapi.yaml)
* [Goals Canvas](WOZBevragen_GoalsCanvas.xlsx) met een overzicht van beoogd gebruik van de API (wat en hoe)
* Functionele specificaties voor de [WOZ-waarden](./features/waarden.feature) die de API teruggeeft
* Functionele specificaties voor het [zoeken van WOZ-objecten](./features/zoeken.feature)

## Contactpersonen:
* Product owner: [@CathyDingemanse](https://github.com/CathyDingemanse)

### Toegevoegde waarde voor gemeenten
- sneller aansluiten afnemers
- goedkoper aansluiten afnemers (x aantal binnegemeentelijke aansluiters x 355 gemeenten)
- lagere investeringen (geen lokale kopie/ gegevensmagazijn)
- lagere beheerkosten (geen gegevensbeheer lokale kopieën)
- hogere ROI: hergebruik API Landelijke Registratie door alle gemeenten
- betere technologie-business alignment (Landelijke Registratie voert sneller een wijziging door dan 355 afzonderlijke gemeenten)
- meer focus op de businessvraag van afnemers (i.p.v. op betrouwbaarheid etc. lokale kopieën)
- maximale compliancy op de gemeentelijke softwaremarkt (aansluiting gemeente x = 100% herbruikbaar in gemeente y)

### Toegevoegde waarde voor leveranciers
- leveranciers kunnen zich richten op het bieden van toegevoegde waarde voor burgers, bedrijven en medewerkers i.p.v. plumbing concerns.

## Bronnen
* [Landelijke API strategie voor de overheid](https://geonovum.github.io/KP-APIs/)

## Licentie
Copyright &copy; VNG Realisatie 2018
Licensed under the [EUPL](https://github.com/VNG-Realisatie/Haal-Centraal-WOZ-bevragen/blob/master/LICENCE.md)
