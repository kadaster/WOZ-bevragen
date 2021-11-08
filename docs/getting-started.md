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
5. [Sluit aan op productie](#aansluiten-op-productie)

## Aanmelden om aan te sluiten
Meld je aan bij het kadaster om [aan te sluiten en voor toegang tot de testomgeving](???????????????????????????). Je ontvangt dan o.a. een API-key die nodig is voor toegang tot de testomgeving.

## Functionaliteit en specificaties
Je kunt een visuele representatie van de specificatie bekijken met [Swagger UI]({{ site.baseurl }}/swagger-ui) of [Redoc]({{ site.baseurl }}/redoc).

Je kunt de [functionele documentatie](./features) vinden in de [features](./features).

### Resource WOZ-object 
Je kunt op de volgende manieren WOZ objecten (met WOZ waardes) zoeken en raadplegen:

- Opvragen van 1 specifiek WOZ-object met een identificatie van het WOZ object.
- Opvragen van 1 specifiek WOZ-object met de identificatie van het adres.
- Opvragen van 1 specifiek WOZ-object met de postcode en het huisnummer eventueel aangevuld met huisletter en/of huisnummertoevoeging.
- Opvragen van collectie WOZ-objecten met een niet-natuurlijk persoon (rsin) of een maatschappelijke activiteit (kvknr) die in het Handelsregister is ingeschreven.
- Opvragen van collectie WOZ-objecten in eigendom van een bij het Handelsregister ingeschreven maatschappelijke activiteit of een van de daaronder vallende ondernemingen en vestigingen.
- Opvragen van collectie WOZ-objecten met de identificatie van een adresseerbaar object (verblijfsobject, ligplaats, standplaats).

### Algemeen
Verder zijn er nog een paar algemene functies die gelden voor alle bovenstaande aanvragen:
- Gebruik van de fields parameter om de response te filteren. (Voor werking, zie feature [fields](https://github.com/VNG-Realisatie/Haal-Centraal-common/blob/v1.2.0/features/fields.feature))
- Velden die altijd worden geleverd.

|Resource                           |Velden                         |
|-----                              |------                         |
|wozobjecten                        |identificatie, _links.self     |

- [HAL links](https://tools.ietf.org/html/draft-kelly-json-hal-08), die soms [templated](https://github.com/VNG-Realisatie/Haal-Centraal-common/blob/v1.2.0/features/uri-templating.feature) worden geleverd.

## Bouw de API
We hebben [client code](https://github.com/VNG-Realisatie/Haal-Centraal-WOZ-bevragen/tree/master/code){:target="_blank" rel="noopener"} voor API-clients in enkele varianten. Hiermee kan je direct aan de slag met het gebruiken van de API.

Zit jouw gewenste ontwikkelomgeving er niet bij, dan kan je zelf ook code genereren vanuit de "[genereervariant](https://github.com/VNG-Realisatie/Haal-Centraal-WOZ-bevragen/blob/master/specificatie/genereervariant/openapi.yaml){:target="_blank" rel="noopener"}" van de API-specificaties.

## Probeer en test de API
De werking van de API is het makkelijkst te testen met behulp van [Postman](https://www.getpostman.com/).
We hebben al een project voor je gemaakt die je kan gebruiken: [WOZ-Bevragen-postman-collection.json](../test/WOZ-Bevragen-postman-collection.json). Hierin moet je alleen de endpoints en authenticatie (API-key) nog invullen.
We hebben al een [Postman collection](https://github.com/VNG-Realisatie/Haal-Centraal-WOZ-bevragen/blob/master/test/WOZ-Bevragen-postman-collection.json){:target="_blank" rel="noopener"} voor je klaargezet. Deze kun je importeren in Postman.

### Configureer de url en api key

1. Klik bij "Waardering onroerende zaken" op de drie bolletjes.
2. Klik vervolgens op Edit
3. Selecteer tabblad "Authorization"
4. Kies TYPE "API Key"
5. Vul in Key: "x-api-key", Value: de API key die je van het Kadaster hebt ontvangen, Add to: "Header"
6. Selecteer tabblad "Variables"
7. Vul bij baseUrl INITIAL VALUE en bij CURRENT VALUE de url
8. Klik op de knop Update

De testomgeving van de API is te benaderen via de volgende urls:
- _Beveiligde verbinding met alleen API-key: https://api.kadaster.nl/lvwoz-eto/huidigebevragingen_
    - Voor deze connectie met de testomgeving van deze API is vereist:
        - Een geldige API-key. Deze wordt bij de request opgenomen in request header "X-Api-Key". Wanneer je je aanmeldt voor het gebruiken van de API ontvang je de API-key.

### Testgevallen
Onderstaande tabellen bevatten testgevallen voor specifieke situaties waarmee de werking van de API kan worden getest op de test omgeving.

<table>
	<tr>
		<th>Testgeval</th>
		<th>WOZ-objectidentificatie</th>
		<th>Postcode / huisnummer (evt. huisnummertoevoeging)</th>
		<th>Bijzonderheden</th>
	</tr>                                                                    
	<tr>
		<td>Natuurlijk persoon als belanghebbend eigenaar</td>
		<td>800000093455</td>
		<td>8513GB 2</td>
    <td><li>1 adresseerbaar object identificatie</li><li>1 pandidentificatie</li></td>
	</tr>
	<tr>
		<td>Natuurlijk persoon als belanghebbend eigenaar</td>
		<td>800000014669</td>
		<td>2517GN 28</td>
    <td><li>4 waarden</li><li>1 adresseerbaar object identificatie</li></td>
	</tr>
	<tr>
		<td>Natuurlijk persoon als belanghebbend eigenaar</td>
		<td>800000003118</td>
		<td>2211TS 10</td>
    <td><li>5 waarden</li><li>1 adresseerbaar object identificatie</li></td>
	</tr>
	<tr>
		<td>Niet natuurlijk persoon als belanghebbend eigenaar</td>
		<td>800000051111</td>
		<td>8000GB 1</td>
    <td><li>4 waarden</li><li>1 adresseerbaar object identificatie</li><li>belanghebbend gebruiker</li><li>3 kadastraal onroerende zaken</li><li>3 pandidentificaties</li></td>
	</tr>
	<tr>
		<td>Niet natuurlijk persoon als belanghebbend eigenaar</td>
		<td>800000200021</td>
		<td>8621AC 2 LP02</td>
    <td><li>huisnummertoevoeging</li></td>
	</tr>
	<tr>
		<td>Niet natuurlijk persoon als belanghebbend eigenaar</td>
		<td>800000200022</td>
		<td>8621AC 2 SP03</td>
    <td></td>
	</tr>
	<tr>
		<td>Vestiging als belanghebbend eigenaar</td>
		<td>800000823525</td>
		<td>2211TS 8</td>
    <td><li>6 waarden</li><li>1 adresseerbaar object identificatie</li></td>
	</tr>
	<tr>
		<td>Geen belanghebbend eigenaar</td>
		<td>800012345678</td>
		<td>2517GL 84</td>
    <td><li>3 adresseerbaar object identificaties</li></td>
	</tr>
</table>

### URL
De productieomgeving van de API is te benaderen via de volgende url: ??????????????????????????
