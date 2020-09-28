# language: nl

Feature: zoeken van WOZ-objecten
  WOZ-objecten zoeken op kadastraal onroerende zaak identificatie, waarbij ook WOZ-objecten worden gevonden waarbij niet de kadastraal onroerende zaak identificatie, maar we de kadastrale aanduiding bekend is.

  Zoeken van WOZ-objecten met de BAG adresseerbaar object identificatie:
    - vindt WOZ-objecten die worden aangeduid met dit adresseerbaar object
    - vindt WOZ-objecten die verbonden zijn met die adresseerbaar object

  Zoeken van WOZ-objecten met postcode en huisnummer:
    - vindt WOZ-objecten die worden aangeduid met dit adres
    - vindt WOZ-objecten die verbonden zijn met het adresseerbaar object op dit adres
    - vindt WOZ-objecten waarbij dit het hoofdadres is van een verbonden adresseerbaar object
    - vindt WOZ-objecten waarbij dit een nevenadres is van een verbonden adresseerbaar object


  Scenario: zoek WOZ-object op kadastraal onroerende zaakidentificatie
    Gegeven de LV WOZ kent een WOZ-object met objectnummer "051812345678" en kadastrale aanduiding "'s-Gravenhage N 8272 A3"
    En in de LV WOZ heeft dit WOZ-object geen waarde bij Kadastraal onroerende zaakidentificatie
    En de BRK kent een kadastraal object met identificatie "22310827210003" en kadastrale aanduiding "'s-Gravenhage N 8272 A3"
    Als ik een WOZ-object zoek met /wozobjecten?kadastraalOnroerendeZaakIdentificatie=22310827210003
    Dan bevat het antwoord het WOZ-object met identificatie "051812345678"

  Scenario: zoek WOZ-object met adresseerbaar object identificatie van de aanduiding
    Gegeven de LV WOZ kent een WOZ-object met objectnummer "051812345678" en aanduiding adresseerbaar object identificatie "0518010000842214"
    Als ik een WOZ-object zoek met /wozobjecten?adresseerbaarObjectIdentificatie=0518010000842214
    Dan bevat het antwoord het WOZ-object met identificatie "051812345678"

  Scenario: zoek WOZ-object met adresseerbaar object identificatie van een verbonden verblijfsobject
    Gegeven de LV WOZ kent een WOZ-object met objectnummer "051812345678" en aanduiding adresseerbaar object identificatie "0518010000842214"
    En in de LV WOZ heeft is dit WOZ-object verbonden met verblijfsobjecten "0518010000842214", "0518010000609764" en "0518010000852970"
    Als ik een WOZ-object zoek met /wozobjecten?adresseerbaarObjectIdentificatie=0518010000852970
    Dan bevat het antwoord het WOZ-object met identificatie "051812345678"

  Scenario: zoek WOZ-object met postcode en huisnummer van de aanduiding
    Gegeven de LV WOZ kent een WOZ-object met objectnummer "051812345678" en aanduiding postcode "2517GL" en huisnummer 84
    Als ik een WOZ-object zoek met /wozobjecten?postcode=2517GL&huisnummer=84
    Dan bevat het antwoord het WOZ-object met identificatie "051812345678"

  Scenario: zoek WOZ-object met postcode en huisnummer van een verbonden verblijfsobject
    Gegeven de LV WOZ kent een WOZ-object met objectnummer "051812345678" en aanduiding postcode "2517GL" en huisnummer 84
    En in de LV WOZ heeft is dit WOZ-object verbonden met verblijfsobjecten "0518010000842214", "0518010000609764" en "0518010000852970"
    En in de BAG heeft verblijfsobject "0518010000852970" als hoofdadres postcode "2517GK", huisnummer 3 en huisletter "T"
    Als ik een WOZ-object zoek met /wozobjecten?postcode=2517GK&huisnummer=3
    Dan bevat het antwoord het WOZ-object met identificatie "051812345678"

  Scenario: zoek WOZ-object op postcode en huisnummer van een nevenadres van een verbonden verblijfsobject
    Gegeven de LV WOZ kent een WOZ-object met objectnummer "001412345678" en aanduiding postcode "9724EM" en huisnummer 1
    En in de LV WOZ heeft is dit WOZ-object verbonden met verblijfsobject "0014010011067299"
    En in de BAG heeft verblijfsobject "0014010011067299" als hoofdadres postcode "9724EM" en huisnummer 1
    En in de BAG heeft verblijfsobject "0014010011067299" als nevenadres postcode "9724CS" en huisnummer 20
    Als ik een WOZ-object zoek met /wozobjecten?postcode=9724CS&huisnummer=20
    Dan bevat het antwoord het WOZ-object met identificatie "0014010011067299"
