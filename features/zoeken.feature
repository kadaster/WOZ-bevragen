# language: nl

Feature: zoeken van WOZ-objecten
  Zoeken van WOZ-objecten met de BAG adresseerbaar object identificatie (BAG identificatie van een verblijfsobject, standplaats of ligplaats):
    - vindt WOZ-objecten waarbij de aanduiding WOZ-object is ontleend aan dit adresseerbaar object
    - vindt WOZ-objecten die verbonden zijn met dit adresseerbaar object

  Zoeken van WOZ-objecten met postcode en huisnummer of nummeraanduidingIdentificatie:
    - vindt WOZ-objecten die worden aangeduid met dit adres


  Scenario: zoek WOZ-object met adresseerbaar object identificatie van de aanduiding
    Gegeven de LV WOZ kent een WOZ-object met objectnummer "051812345678"
    En de aanduiding WOZ-object is ontleend aan adresseerbaar object identificatie "0518010000842214"
    Als ik een WOZ-object zoek met /wozobjecten?adresseerbaarObjectIdentificatie=0518010000842214
    Dan bevat het antwoord het WOZ-object met identificatie "051812345678"

  Scenario: zoek WOZ-object met adresseerbaar object identificatie van een verbonden adresseerbaar object
    Gegeven de LV WOZ kent een WOZ-object met objectnummer "051812345678"
    En de aanduiding WOZ-object is ontleend aan adresseerbaar object identificatie "0518010000842214"
    En in de LV WOZ is dit WOZ-object verbonden met adresseerbare objecten "0518010000842214", "0518010000609764" en "0518010000852970"
    Als ik een WOZ-object zoek met /wozobjecten?adresseerbaarObjectIdentificatie=0518010000852970
    Dan bevat het antwoord het WOZ-object met identificatie "051812345678"

  Scenario: zoek WOZ-object met postcode en huisnummer van de aanduiding
    Gegeven de LV WOZ kent een WOZ-object met objectnummer "051812345678"
    En de aanduiding WOZ-object heeft postcode "2517GL" en huisnummer 84
    Als ik een WOZ-object zoek met /wozobjecten?postcode=2517GL&huisnummer=84
    Dan bevat het antwoord het WOZ-object met identificatie "051812345678"

  Scenario: zoek WOZ-object met nummeraanduidingIdentificatie van de aanduiding
    Gegeven de LV WOZ kent een WOZ-object met objectnummer "051812345678"
    En de aanduiding WOZ-object heeft nummeraanduidingIdentificatie "0518200000842215"
    Als ik een WOZ-object zoek met /wozobjecten?nummeraanduidingIdentificatie=0518200000842215
    Dan bevat het antwoord het WOZ-object met identificatie "051812345678"
