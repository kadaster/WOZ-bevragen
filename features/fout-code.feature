#language: nl

Functionaliteit: Fout code

    Als developer van een consumer applicatie
    Wil ik bij fouten een fout code
    Zodat ik in de consumer applicatie programmatisch op fout responses kan reageren

Abstract Scenario: Geen of ongeldig X-API-Key header
Als '/wozobjecten' <scenario> wordt aangeroepen
Dan heeft het antwoord http-statuscode "401"
Dan bevat de response de volgende kenmerken
    | naam   | waarde         |
    | status | 401            |
    | code   | authentication |
En bevat de response geen invalidParams

Voorbeelden:
| scenario                  |
| zonder X-API-Key header   |
| met lege X-API-Key header |

Abstract Scenario: Geen parameters opgegeven
    Als '<path>' wordt aangeroepen
    Dan bevat de response de volgende kenmerken
        | naam   | waarde         |
        | status | 400            |
        | code   | paramsRequired |
    En bevat de response geen invalidParams

    Voorbeelden:
    | path                           |
    | /wozobjecten                   |
    | /wozobjecten?bestaatniet=12345 |

Abstract Scenario: Verplichte parameters combinatie is niet opgegeven
    Als '<path>' wordt aangeroepen
    Dan bevat de response de volgende kenmerken
        | naam   | waarde            |
        | status | 400               |
        | code   | paramsCombination |
    Dan bevat de response de volgende invalidParams
        | name    | code     |
        | <param> | required |

    Voorbeelden:
    | path                         | param      |
    | /wozobjecten?postcode=1234AA | huisnummer |
    | /wozobjecten?huisnummer=1    | postcode   |

Abstract Scenario: Parameter is niet correct
    Als '<path>' wordt aangeroepen
    Dan bevat de response de volgende kenmerken
        | naam   | waarde        |
        | status | 400           |
        | code   | invalidParams |
    En bevat de response de volgende invalidParams
        | name    | code   |
        | <param> | <code> |

    Voorbeelden:
    | path                                                                 | param                            | code    |
    | /wozobjecten?postcode=AA&huisnummer=1                                | postcode                         | pattern |
    | /wozobjecten?postcode=1234AA&huisnummer=a                            | huisnummer                       | integer |
    | /wozobjecten?postcode=1234AA&huisnummer=1&huisnummertoevoeging=abisc | huisnummertoevoeging             | pattern |
    | /wozobjecten?postcode=1234AA&huisnummer=1&huisletter=1               | huisletter                       | pattern |
    | /wozobjecten?rsin=1                                                  | rsin                             | pattern |
    | /wozobjecten?kvkNummer=abc                                           | kvkNummer                        | pattern |
    | /wozobjecten?adresseerbaarObjectIdentificatie=123                    | adresseerbaarObjectIdentificatie | pattern |
    | /wozobjecten?nummeraanduidingIdentificatie=abc                       | nummeraanduidingIdentificatie    | pattern |
    | /wozobjecten?rsin=123456789&fields=bestaatniet                       | fields                           | fields  |

Scenario: Niet bestaande wozobject
    Als '/wozobjecten/123456789012' wordt aangeroepen
    Dan bevat de response de volgende kenmerken
        | naam   | waarde   |
        | status | 404      |
        | code   | notFound |
    En bevat de response geen invalidParams
