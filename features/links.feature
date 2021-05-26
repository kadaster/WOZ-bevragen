#language: nl

Functionaliteit: Links
  Als WOZ bevragen consumer
  Wil ik links naar resources in een respons
  Zodat ik makkelijk naar gerelateerde resources kan navigeren

  Scenario: Links naar andere Haal Centraal APIs
    Gegeven de WOZ-object met identificatie 800000093455 met de volgende kenmerken
    | kenmerk                                    | waarde           |
    | aanduiding.nummeraanduidingIdentificatie   | 8513200000087078 |
    | adresseerbaarObjectIdentificaties          | 8513010000083267 |
    | belanghebbendeEigenaar.burgerservicenummer | 355745264        |
    | kadastraalOnroerendeZaakIdentificaties     | 008000131270000  |
    | pandIdentificaties                         | 8513100000097213 |
    Als de WOZ-object wordt opgevraagd
    Dan bevat de response de volgende templated links
    | naam Link                 | href                                                                                                                      |
    | adres                     | https://api.bag.test.kadaster.nl/esd/huidigebevragingen/v1/adressen/{aanduiding.nummeraanduidingIdentificatie}"           |
    | adresseerbaarObjecten     | https://api.bag.test.kadaster.nl/esd/huidigebevragingen/v1/adresseerbareobjecten/{adresseerbaarObjectIdentificaties}      |
    | belanghebbendeEigenaar    | https://www.haalcentraal.nl/haalcentraal/api/brp/ingeschrevenpersonen/{belanghebbendeEigenaar.burgerservicenummer}        |
    | belanghebbendeGebruiker   |                                                                                                                           |
    | kadastraalOnroerendeZaken | https://api.brk.acceptatie.kadaster.nl/esd/bevragen/v1/kadastraalonroerendezaken/{kadastraalOnroerendeZaakIdentificaties} |
    | panden                    | https://api.bag.test.kadaster.nl/esd/huidigebevragingen/v1//panden/{pandidentificaties}                                   |