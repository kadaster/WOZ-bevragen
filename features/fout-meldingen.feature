#language: nl
Functionaliteit: Gebruiksvriendelijke foutmeldingen

    Als developer van een consumer applicatie
    Wil ik gebruiksvriendelijke en duidelijke foutmeldingen
    Zodat ik deze één op één kan gebruiken in de UI van mijn applicatie

Rule: minimaal één optionele parameter is opgegeven

    # Scenarionr. foutmeldingen-1
    Scenario: Er zijn geen parameters opgegeven
    Als '/wozobjecten' wordt aangeroepen
    Dan bevat de response de volgende kenmerken
        | naam   | waarde                                                                                                                                                                          |
        | title  | Tenminste één parameter moet worden opgegeven.                                                                                                                                  |
        | status | 400                                                                                                                                                                             |
        | detail | Er moet minimaal één van de parameters 'rsin', 'kvkNummer', 'adresseerbaarObjectIdentificatie', 'nummeraanduidingIdentificatie' of 'postcode' met 'huisnummer' worden opgegeven |
    En bevat de response geen invalidParams

    # Scenarionr. foutmeldingen-2
    Abstract Scenario: Niet gespecificeerd parameter
    Als '/wozobjecten?<parameter>=123456789' wordt aangeroepen
    Dan bevat de response de volgende kenmerken
        | naam   | waarde                                                                                                                                                                          |
        | title  | Tenminste één parameter moet worden opgegeven.                                                                                                                                  |
        | status | 400                                                                                                                                                                             |
        | detail | Er moet minimaal één van de parameters 'rsin', 'kvkNummer', 'adresseerbaarObjectIdentificatie', 'nummeraanduidingIdentificatie' of 'postcode' met 'huisnummer' worden opgegeven |
    En bevat de response geen invalidParams

    Voorbeelden:
        | description                                                                      | parameter     |
        | gebruik van een WOZ-object kenmerk die niet wordt ondersteund als zoek parameter | identificatie |
        | willekeurig string als zoek parameter                                            | bestaatniet   |

Rule: opgegeven parameter(s) heeft een waarde

    # Scenarionr. foutmeldingen-3
    Scenario: Er is geen waarde voor één parameter opgegeven
    Als '/wozobjecten?rsin=' wordt aangeroepen
    Dan bevat de response de volgende kenmerken
        | naam   | waarde                                        |
        | title  | Een of meerdere parameters zijn niet correct. |
        | status | 400                                           |
    En bevat de response de volgende invalidParams
        | name | reason                |
        | rsin | geen waarde opgegeven |

    # Scenarionr. foutmeldingen-4
    Scenario: Er is geen waarde voor meerdere parameters opgegeven
    Als '/wozobjecten?rsin=&fields=' wordt aangeroepen
    Dan bevat de response de volgende kenmerken
        | naam   | waarde                                        |
        | title  | Een of meerdere parameters zijn niet correct. |
        | status | 400                                           |
    En bevat de response de volgende invalidParams
        | name   | reason                |
        | rsin   | geen waarde opgegeven |
        | fields | geen waarde opgegeven |

Rule: fields parameter bevat geen onbekende kenmerknamen

    # Scenarionr. foutmeldingen-5
    Abstract Scenario: Er is één of meerdere onbekende kenmerknamen opgegeven
    Als '/wozobjecten?rsin=0345100002016017&fields=<fields waarde>' wordt aangeroepen
    Dan bevat de response de volgende kenmerken
        | naam   | waarde                                        |
        | title  | Een of meerdere parameters zijn niet correct. |
        | status | 400                                           |
    En bevat de response de volgende invalidParams
        | name   | reason                |
        | fields | <reason omschrijving> |

    Voorbeelden:
        | fields waarde              | reason omschrijving                                          |
        | bestaatniet                | ongeldige waarde: 'bestaatniet' opgegeven                    |
        | bestaatniet,bestaatookniet | ongeldige waarden: 'bestaatniet', 'bestaatookniet' opgegeven |

Rule: type van parameter waarde is correct

    # Scenarionr. foutmeldingen-6
    Scenario: type van waarde van een parameter is niet correct
    Als '/wozobjecten?postcode=1234AA&huisnummer=A' wordt aangeroepen
    Dan bevat de response de volgende kenmerken
        | naam   | waarde                                        |
        | title  | Een of meerdere parameters zijn niet correct. |
        | status | 400                                           |
    En bevat de response de volgende invalidParams
        | name       | reason                                     |
        | huisnummer | waarde 'A' is geen getal tussen 1 en 99999 |

Rule: parameter waarde voldoet aan de opgegeven validaties van de parameter

    # Scenarionr. foutmeldingen-7
    Scenario: parameter waarde is kleiner dan de gedefinieerde minimum waarde
    Als '/wozobjecten?postcode=8000GB&huisnummer=1&page=0' wordt aangeroepen
    Dan bevat de response de volgende kenmerken
        | naam   | waarde                                        |
        | title  | Een of meerdere parameters zijn niet correct. |
        | status | 400                                           |
    En bevat de response de volgende invalidParams
        | name | reason                                                     |
        | page | waarde '0' is kleiner dan de toegestane minimum waarde (1) |

    # Scenarionr. foutmeldingen-8
    Scenario: parameter waarde is groter dan de gedefinieerde maximum waarde
    Als '/wozobjecten?postcode=8000GB&huisnummer=1&pageSize=101' wordt aangeroepen
    Dan bevat de response de volgende kenmerken
        | naam   | waarde                                        |
        | title  | Een of meerdere parameters zijn niet correct. |
        | status | 400                                           |
    En bevat de response de volgende invalidParams
        | name     | reason                                                        |
        | pageSize | waarde '101' is groter dan de toegestane maximum waarde (100) |

Rule: Een zoek actuele WOZ-objecten aanroep mag slechts één identificatie parameter bevatten

    # Scenarionr. foutmeldingen-9
    Abstract Scenario: Er zijn meerdere identificatie parameters opgegeven
    Als '/wozobjecten<query string>' wordt aangeroepen
    Dan bevat de response de volgende kenmerken
        | title  | De combinatie van opgegeven parameters is niet toegestaan.             |
        | status | 400                                                                    |
        | detail | Er zijn meerdere zoekingangen opgegeven. Graag 1 zoekingang gebruiken. |
        | code   | unsupportedCombi                                                       |
    En bevat de response geen invalidParams

    Voorbeelden:
        | query string                                                      | param1                           | param2    |
        | ?rsin=857567433&kvkNummer=68727720                                | rsin                             | kvkNummer |
        | ?adresseerbaarObjectIdentificatie=0226010000038820&rsin=857567433 | adresseerbaarObjectIdentificatie | rsin      |

Rule: Zoeken met postcode kan alleen in combinatie met huisnummer

    # Scenarionr. foutmeldingen-10
    Scenario: huisnummer is niet opgegeven
    Als '/wozobjecten?postcode=1234AA' wordt aangeroepen
    Dan bevat de response de volgende kenmerken
        | title  | Minimale combinatie van parameters moet worden opgegeven. |
        | status | 400                                                       |
    En bevat de response de volgende invalidParams
        | name       | reason                 |
        | huisnummer | parameter is verplicht |

    # Scenarionr. foutmeldingen-11
    Scenario: postcode is niet opgegeven
    Als '/wozobjecten?huisnummer=1' wordt aangeroepen
    Dan bevat de response de volgende kenmerken
        | title  | Minimale combinatie van parameters moet worden opgegeven. |
        | status | 400                                                       |
    En bevat de response de volgende invalidParams
        | name     | reason                 |
        | postcode | parameter is verplicht |

Rule: alle parameter fouten in een request worden samen geretourneerd

    # Scenarionr. foutmeldingen-12
    Scenario: er zijn meerdere verschillende fout soorten
    Als '/wozobjecten?rsin=abc&fields=bestaatniet' wordt aangeroepen
    Dan bevat de response de volgende kenmerken
        | naam   | waarde                                        |
        | title  | Een of meerdere parameters zijn niet correct. |
        | status | 400                                           |
    En bevat de response de volgende invalidParams
        | name   | reason                                    |
        | rsin   | waarde 'abc' is geen 9 cijferig getal     |
        | fields | ongeldige waarde: 'bestaatniet' opgegeven |

Rule: Raadplegen met valide wozobject identificatie

    # Scenarionr. foutmeldingen-13
    Abstract Scenario: invalide wozobject identificatie
    Als '/wozobjecten/<identificatie>' wordt aangeroepen
    Dan bevat de response de volgende kenmerken
        | naam   | waarde                                        |
        | title  | Een of meerdere parameters zijn niet correct. |
        | status | 400                                           |
    En bevat de response de volgende invalidParams
        | name          | reason   |
        | identificatie | <reason> |

    Voorbeelden:
        | identificatie | reason                                           |
        | 1             | waarde '1' is geen 12 cijferig getal             |
        | 1234567890123 | waarde '1234567890123' is geen 12 cijferig getal |
        | A1234@567890  | waarde 'A1234@567890' is geen 12 cijferig getal  |

    # Scenarionr. foutmeldingen-14
    Scenario: niet gevonden
    Als '/wozobjecten/123456789012' wordt aangeroepen
    Dan bevat de response de volgende kenmerken
        | naam   | waarde                                                     |
        | title  | Opgevraagde resource bestaat niet.                         |
        | status | 404                                                        |
        | detail | Er bestaat geen wozobject met identificatie '123456789012' |
