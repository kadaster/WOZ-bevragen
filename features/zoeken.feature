# language: nl

Functionaliteit: zoeken van WOZ-objecten
  Zoeken van WOZ-objecten met de BAG adresseerbaar object identificatie (BAG identificatie van een verblijfsobject, standplaats of ligplaats) vindt WOZ-objecten die verbonden zijn met dit adresseerbaar object

  Zoeken van WOZ-objecten met postcode en huisnummer of nummeraanduidingIdentificatie vindt WOZ-objecten die worden aangeduid met dit adres

  Zoeken van WOZ-objecten levert lege property _embedded wanneer er niks gevonden wordt

  Rule: Zoeken met adresseerbaar object identificatie vindt WOZ-objecten die verbonden zijn met dit adresseerbaar object

    Voorbeeld: zoek WOZ-object met adresseerbaar object identificatie van een verbonden adresseerbaar object
      Gegeven de LV WOZ kent een WOZ-object met objectnummer "800012345678"
      En in de LV WOZ is dit WOZ-object verbonden met adresseerbare objecten "0518010000842214", "0518010000609764" en "0518010000852970"
      Als ik een WOZ-object zoek met "/wozobjecten?adresseerbaarObjectIdentificatie=0518010000609764"
      Dan bevat het antwoord het WOZ-object met identificatie "800012345678"

  Rule: Zoeken postcode en huisnummer of nummeraanduidingIdentificatie vindt WOZ-objecten die worden aangeduid met dit adres

    Abstract Scenario: zoek WOZ-object met <filter titel>
      Gegeven de LV WOZ kent een WOZ-object met objectnummer "800000051111"
      En de aanduiding WOZ-object heeft postcode "8000GB" en huisnummer 1 en huisletter "a" en huisnummertoevoeging "bis"
      Als ik een WOZ-object zoek met "<path>"
      Dan bevat het antwoord het WOZ-object met identificatie "800000051111"

      Voorbeelden:
      | filter titel | path |
      | postcode en huisnummer van de aanduiding | /wozobjecten?postcode=8000GB&huisnummer=1 |
      | postcode (lowercase) en huisnummer van de aanduiding | /wozobjecten?postcode=8000gb&huisnummer=1 |
      | postcode (met spatie) en huisnummer van de aanduiding | /wozobjecten?postcode=8000 GB&huisnummer=1 |
      | postcode en huisnummer en huisletter van de aanduiding | /wozobjecten?postcode=8000GB&huisnummer=1&huisletter=a |

  #   Voorbeeld: zoek WOZ-object met postcode en huisnummer en huisnummertoevoeging van de aanduiding
  #     Gegeven de LV WOZ kent een WOZ-object met objectnummer "000500000001"
  #     En de aanduiding WOZ-object heeft postcode "8000GB" en huisnummer 1 en huisletter "a" en huisnummertoevoeging "bis"
  #     Als ik een WOZ-object zoek met /wozobjecten?postcode=8000GB&huisnummer=1&huisnummertoevoeging=bis
  #     Dan bevat het antwoord het WOZ-object met identificatie "000500000001"

  #   Voorbeeld: zoek WOZ-object met postcode en huisnummer en huisletter en huisnummertoevoeging van de aanduiding
  #     Gegeven de LV WOZ kent een WOZ-object met objectnummer "000500000001"
  #     En de aanduiding WOZ-object heeft postcode "8000GB" en huisnummer 1 en huisletter "a" en huisnummertoevoeging "bis"
  #     Als ik een WOZ-object zoek met /wozobjecten?postcode=8000GB&huisnummer=1&huisletter=a&huisnummertoevoeging=bis
  #     Dan bevat het antwoord het WOZ-object met identificatie "000500000001"

  #   Voorbeeld: zoek WOZ-object met postcode en huisnummer en onjuiste huisletter
  #     Gegeven de LV WOZ kent een WOZ-object met objectnummer "000500000001"
  #     En de aanduiding WOZ-object heeft postcode "8000GB" en huisnummer 1 en huisletter "a" en huisnummertoevoeging "bis"
  #     Als ik een WOZ-object zoek met /wozobjecten?postcode=8000GB&huisnummer=1&huisletter=b
  #     Dan bevat het antwoord niet het WOZ-object met identificatie "000500000001"

  #   Voorbeeld: zoek WOZ-object met postcode en huisnummer en onjuiste huisnummertoevoeging
  #     Gegeven de LV WOZ kent een WOZ-object met objectnummer "000500000001"
  #     En de aanduiding WOZ-object heeft postcode "8000GB" en huisnummer 1 en huisletter "a" en huisnummertoevoeging "bis"
  #     Als ik een WOZ-object zoek met /wozobjecten?postcode=8000GB&huisnummer=1&huisnummertoevoeging=andere
  #     Dan bevat het antwoord niet het WOZ-object met identificatie "000500000001"

    Voorbeeld: zoek WOZ-object met nummeraanduidingIdentificatie van de aanduiding
      Gegeven de LV WOZ kent een WOZ-object met objectnummer "800000051111"
      En de aanduiding WOZ-object heeft nummeraanduidingIdentificatie "8513200000050111"
      Als ik een WOZ-object zoek met "/wozobjecten?nummeraanduidingIdentificatie=8513200000050111"
      Dan bevat het antwoord het WOZ-object met identificatie "800000051111"

  # Rule: zoeken met huisletter en huisnummertoevoeging is case-insensitive

  #   Voorbeeld: zoek WOZ-object met postcode en huisnummer en huisletter en huisnummertoevoeging in andere case dan in de aanduiding
  #     Gegeven de LV WOZ kent een WOZ-object met objectnummer "000500000001"
  #     En de aanduiding WOZ-object heeft postcode "8000GB" en huisnummer 1 en huisletter "a" en huisnummertoevoeging "bis"
  #     Als ik een WOZ-object zoek met /wozobjecten?postcode=8000GB&huisnummer=1&huisletter=A&huisnummertoevoeging=BIS
  #     Dan bevat het antwoord het WOZ-object met identificatie "000500000001"

  Rule: Zoeken van WOZ-objecten levert lege property _embedded wanneer er niks gevonden wordt

    Voorbeeld: zoeken met adresseerbaar object identificatie vindt geen WOZ-object
      Gegeven de LV WOZ kent GEEN WOZ-object verbonden met een adresseerbaar object met identificatie "0518010000123456"
      Als ik een WOZ-object zoek met "/wozobjecten?adresseerbaarObjectIdentificatie=0518010000123456"
      # Dan is de _embedded property van het antwoord leeg
      # En is de _links.self property gelijk aan "https://api.kadaster.nl/lvwoz-eto-apikey/api/v1/wozobjecten?adresseerbaarObjectIdentificatie=0518010000123456"
      Dan heeft het antwoord http-statuscode "200"
      En bevat het antwoord header "content-type" met waarde "application/hal+json"
      En is het antwoord gelijk aan:
      """
      {
        "_embedded": {},
        "_links": {
          "self": {
            "href": "https://api.kadaster.nl/lvwoz-eto-apikey/api/v1/wozobjecten?adresseerbaarObjectIdentificatie=0518010000123456"
          }
        }
      }
      """

    Abstract Scenario: zoeken met <zoektype> vindt geen WOZ-object
      Gegeven de LV WOZ kent GEEN WOZ-object <gegeven deel>
      Als ik een WOZ-object zoek met "<path>"
      Dan heeft het antwoord http-statuscode "200"
      En bevat het antwoord header "content-type" met waarde "application/hal+json"
      En is het antwoord gelijk aan:
      """
      {
        "_embedded": {},
        "_links": {
          "self": {
            "href": "https://api.kadaster.nl/lvwoz-eto-apikey/api/v1<path>"
          }
        }
      }
      """

      Voorbeelden:
      | zoektype                           | path                                                           | gegeven deel |
      | adresseerbaar object identificatie | /wozobjecten?adresseerbaarObjectIdentificatie=0518010000123456 | verbonden met een adresseerbaar object met identificatie "0518010000123456" |
      | postcode + huisnummer              | /wozobjecten?postcode=1234AB&huisnummer=99                     | met aanduiding met postcode "1234AB" en huisnummer 99 |
      | rsin                               | /wozobjecten?rsin=123456789                                    | met belanghebbendeEigenaar.rsin "123456789" |