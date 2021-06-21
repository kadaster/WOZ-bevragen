# language: nl

Functionaliteit: zoeken van WOZ-objecten
  Zoeken van WOZ-objecten met de BAG adresseerbaar object identificatie (BAG identificatie van een verblijfsobject, standplaats of ligplaats):
    - vindt WOZ-objecten waarbij de aanduiding WOZ-object is ontleend aan dit adresseerbaar object
    - vindt WOZ-objecten die verbonden zijn met dit adresseerbaar object

  Zoeken van WOZ-objecten met postcode en huisnummer of nummeraanduidingIdentificatie:
    - vindt WOZ-objecten die worden aangeduid met dit adres

  Zoeken van WOZ-objecten levert lege property _embedded wanneer er niks gevonden wordt

  Regel: Zoeken met adresseerbaar object identificatie vindt WOZ-objecten waarbij de aanduiding WOZ-object is ontleend aan dit adresseerbaar object

    Voorbeeld: zoek WOZ-object met adresseerbaar object identificatie van de aanduiding
      Gegeven de LV WOZ kent een WOZ-object met objectnummer "051812345678"
      En de aanduiding WOZ-object is ontleend aan adresseerbaar object identificatie "0518010000842214"
      Als ik een WOZ-object zoek met /wozobjecten?adresseerbaarObjectIdentificatie=0518010000842214
      Dan bevat het antwoord het WOZ-object met identificatie "051812345678"

  Regel: Zoeken met adresseerbaar object identificatie vindt WOZ-objecten die verbonden zijn met dit adresseerbaar object

    Voorbeeld: zoek WOZ-object met adresseerbaar object identificatie van een verbonden adresseerbaar object
      Gegeven de LV WOZ kent een WOZ-object met objectnummer "051812345678"
      En de aanduiding WOZ-object is ontleend aan adresseerbaar object identificatie "0518010000842214"
      En in de LV WOZ is dit WOZ-object verbonden met adresseerbare objecten "0518010000842214", "0518010000609764" en "0518010000852970"
      Als ik een WOZ-object zoek met /wozobjecten?adresseerbaarObjectIdentificatie=0518010000852970
      Dan bevat het antwoord het WOZ-object met identificatie "051812345678"

  Regel: Zoeken postcode en huisnummer of nummeraanduidingIdentificatie vindt WOZ-objecten die worden aangeduid met dit adres

    Voorbeeld: zoek WOZ-object met postcode en huisnummer van de aanduiding
      Gegeven de LV WOZ kent een WOZ-object met objectnummer "051812345678"
      En de aanduiding WOZ-object heeft postcode "2517GL" en huisnummer 84
      Als ik een WOZ-object zoek met /wozobjecten?postcode=2517GL&huisnummer=84
      Dan bevat het antwoord het WOZ-object met identificatie "051812345678"

    Voorbeeld: zoek WOZ-object met nummeraanduidingIdentificatie van de aanduiding
      Gegeven de LV WOZ kent een WOZ-object met objectnummer "051812345678"
      En de aanduiding WOZ-object heeft nummeraanduidingIdentificatie "0518200000842215"
      Als ik een WOZ-object zoek met /wozobjecten?nummeraanduidingIdentificatie=0518200000842215
      Dan bevat het antwoord het WOZ-object met identificatie "051812345678"

  Regel: Zoeken van WOZ-objecten levert lege property _embedded wanneer er niks gevonden wordt

    Voorbeeld: zoeken met adresseerbaar object identificatie vindt geen WOZ-object
      Gegeven de LV WOZ kent GEEN WOZ-object met aanduiding ontleend aan een adresseerbaar object met identificatie "0518010000123456"
      En de LV WOZ kent GEEN WOZ-object verbonden met een adresseerbaar object met identificatie "0518010000123456"
      Als ik een WOZ-object zoek met /wozobjecten?adresseerbaarObjectIdentificatie=0518010000123456
      Dan heeft het antwoord http-statuscode "200"
      En bevat het antwoord header "Content-Type: application/hal+json"
      En is het antwoord gelijk aan:
      """
      {
        "_links": {
            "self": {
                "href": "http://api.acceptatie.kadaster.nl/haalcentraal-api/wozobjecten?adresseerbaarObjectIdentificatie=0518010000123456"
            }
        },
        "_embedded": {}
      }
      """

    Voorbeeld: zoeken met postcode en huisnummer vindt geen WOZ-object
      Gegeven de LV WOZ kent GEEN WOZ-object met aanduiding met postcode "1234AB" en huisnummer 99
      Als ik een WOZ-object zoek met /wozobjecten?postcode=1234AB&huisnummer=99
      Dan heeft het antwoord http-statuscode "200"
      En bevat het antwoord header "Content-Type: application/hal+json"
      En is het antwoord gelijk aan:
      """
      {
        "_links": {
            "self": {
                "href": "http://api.acceptatie.kadaster.nl/haalcentraal-api/wozobjecten?postcode=1234AB&huisnummer=99"
            }
        },
        "_embedded": {}
      }
      """

    Voorbeeld: zoeken met rsin vindt geen WOZ-object
      Gegeven de LV WOZ kent GEEN WOZ-object met belanghebbendeEigenaar.rsin "123456789"
      Als ik een WOZ-object zoek met /wozobjecten?rsin=123456789
      Dan heeft het antwoord http-statuscode "200"
      En bevat het antwoord header "Content-Type: application/hal+json"
      En is het antwoord gelijk aan:
      """
      {
        "_links": {
            "self": {
                "href": "http://api.acceptatie.kadaster.nl/haalcentraal-api/wozobjecten?rsin=123456789"
            }
        },
        "_embedded": {}
      }
      """