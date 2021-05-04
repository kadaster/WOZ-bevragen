#language: nl
Functionaliteit: Gebruiksvriendelijke foutmeldingen

    Als developer van een consumer applicatie
    Wil ik gebruiksvriendelijke en duidelijke foutmeldingen
    Zodat ik deze één op één kan gebruiken in de UI van mijn applicatie

Rule: minimaal één optionele parameter is opgegeven

    Scenario: Er zijn geen parameters opgegeven
        Als '/wozobjecten' wordt aangeroepen
        Dan bevat de response de volgende kenmerken
        | naam   | waarde                                                                                                                                             |
        | title  | Tenminste één parameter moet worden opgegeven.                                                                                                     |
        | status | 400                                                                                                                                                |
        | detail | Parameter 'rsin', 'kvkNummer', 'adresseerbaarObjectIdentificatie', 'nummeraanduidingIdentificatie' of 'postcode' en 'huisnummer' is niet opgegeven |
        En bevat de response geen invalidParams

Rule: alleen gespecificeerde parameters mogen worden opgegeven

    Scenario: Niet gespecificeerd parameter
        Als '/wozobjecten?identificatie=123456789' wordt aangeroepen
        Dan bevat de response de volgende kenmerken
        | naam   | waarde                                                       |
        | title  | Een of meerdere parameters zijn niet correct.                |
        | status | 400                                                          |
        | detail | Zoeken met parameter 'identificatie' wordt niet ondersteund. |
        En bevat de response de volgende invalidParams
        | name          | reason                 |
        | identificatie | wordt niet ondersteund |

Rule: opgegeven parameter(s) heeft een waarde

    Scenario: Er is geen waarde voor één parameter opgegeven
        Als '/wozobjecten?rsin=' wordt aangeroepen
        Dan bevat de response de volgende kenmerken
        | naam   | waarde                                         |
        | title  | Een of meerdere parameters zijn niet correct.  |
        | status | 400                                            |
        | detail | Waarde voor parameter 'rsin' is niet opgegeven |
        En bevat de response de volgende invalidParams
        | name | reason                |
        | rsin | geen waarde opgegeven |

    Scenario: Er is geen waarde voor meerdere parameters opgegeven
        Als '/wozobjecten?rsin=&fields=' wordt aangeroepen
        Dan bevat de response de volgende kenmerken
        | naam   | waarde                                                    |
        | title  | Een of meerdere parameters zijn niet correct.             |
        | status | 400                                                       |
        | detail | Waarde voor parameters 'rsin', 'fields' is niet opgegeven |
        En bevat de response de volgende invalidParams
        | name   | reason                |
        | rsin   | geen waarde opgegeven |
        | fields | geen waarde opgegeven |

Rule: fields parameter bevat geen onbekende kenmerk namen

    Abstract Scenario: Er is één of meerdere onbekende kenmerk namen opgegeven
        Als '/wozobjecten?rsin=0345100002016017&fields=<fields waarde>' wordt aangeroepen
        Dan bevat de response de volgende kenmerken
        | naam   | waarde                                                |
        | title  | Een of meerdere parameters zijn niet correct.         |
        | status | 400                                                   |
        | detail | Parameter 'fields' bevat een (deels) ongeldige waarde |
        En bevat de response de volgende invalidParams
        | name   | reason                |
        | fields | <reason omschrijving> |

        Voorbeelden:
        | fields waarde              | reason omschrijving                                          |
        | bestaatniet                | ongeldige waarde: 'bestaatniet' opgegeven                    |
        | bestaatniet,bestaatookniet | ongeldige waarden: 'bestaatniet', 'bestaatookniet' opgegeven |

Rule: type van parameter waarde is correct

    Scenario: type van waarde van een parameter is niet correct
        Als '/wozobjecten?postcode=1234AA&huisnummer=A' wordt aangeroepen
        Dan bevat de response de volgende kenmerken
        | naam   | waarde                                               |
        | title  | Een of meerdere parameters zijn niet correct.        |
        | status | 400                                                  |
        | detail | Parameter 'huisnummer' is niet van het correcte type |
        En bevat de response de volgende invalidParams
        | name       | reason                   |
        | huisnummer | waarde 'A' is geen getal |

Rule: Een zoek actuele woz objecten aanroep mag slechts één identificatie parameter bevatten

    Abstract Scenario: Er zijn meerdere identificatie parameters opgegeven
        Als '/wozobjecten<query string>' wordt aangeroepen
        Dan bevat de response de volgende kenmerken
        | title  | Een of meerdere parameters zijn niet correct. |
        | status | 400                                           |
        | detail | <fout detail>                                 |

        Voorbeelden:
        | query string                                        | fout detail                                                                         |
        | ?rsin=12345&kvkNummer=12345                         | Alleen parameter 'rsin' of 'kvkNummer' moet worden opgegeven                        |
        | ?adresseerbaarObjectIdentificatie=123456&rsin=12345 | Alleen parameter 'adresseerbaarObjectIdentificatie' of 'rsin' moet worden opgegeven |

Rule: Zoeken met postcode kan alleen in combinatie met huisnummer?

    Scenario: huisnummer is niet opgegeven
        Als '/wozobjecten?postcode=1234AA' wordt aangeroepen
        Dan bevat de response de volgende kenmerken
        | title  | Minimale combinatie van parameters moet worden opgegeven.       |
        | status | 400                                                             |
        | detail | Zoeken met 'postcode' kan alleen in combinatie met 'huisnummer' |
        En bevat de response de volgende invalidParams
        | name       | reason                 |
        | huisnummer | parameter is verplicht |

    Scenario: postcode is niet opgegeven
        Als '/wozobjecten?huisnummer=1' wordt aangeroepen
        Dan bevat de response de volgende kenmerken
        | title  | Minimale combinatie van parameters moet worden opgegeven.       |
        | status | 400                                                             |
        | detail | Zoeken met 'huisnummer' kan alleen in combinatie met 'postcode' |
        En bevat de response de volgende invalidParams
        | name     | reason                 |
        | postcode | parameter is verplicht |

Rule: alle parameter fouten in een request worden samen geretourneerd

    Scenario: er zijn meerdere verschillende fout soorten
        Als '/wozobjecten?rsin=abc&fields=bestaatniet' wordt aangeroepen
        Dan bevat de response de volgende kenmerken
        | naam   | waarde                                                                                                                                                                                |
        | title  | Een of meerdere parameters zijn niet correct.                                                                                                                                         |
        | status | 400                                                                                                                                                                                   |
        | detail | Alleen parameter 'adresseerbaarObjectIdentificatie' of 'nummeraanduidingIdentificatie' moet zijn opgegeven.<br />Parameters 'fields', 'expand' bevatten een (deels) ongeldige waarde. |
        En bevat de response de volgende invalidParams
        | name   | reason                                    |
        | rsin   | waarde 'A' is geen getal?                 |
        | fields | ongeldige waarde: 'bestaatniet' opgegeven |
