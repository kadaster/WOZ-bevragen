#language: nl
Functionaliteit: Bepaal relevante waarden voor een WOZ-object

Scenario: geen waarden
	Gegeven een WOZ-object bevat geen waarden
	Als de relevante waarden zijn bepaald voor het WOZ-object
	Dan bevat het WOZ-object geen waarden

Scenario: leeg waarden lijst
	Gegeven een WOZ-object bevat de volgende waarden
	| vastgesteldeWaarde | waardepeildatum | ingangsdatum | beschikkingsStatussen |
	Als de relevante waarden zijn bepaald voor het WOZ-object
	Dan bevat het WOZ-object de volgende waarden
	| vastgesteldeWaarde | waardepeildatum | ingangsdatum | beschikkingsStatussen |

Scenario: meerdere jaren met zelfde eigenaar en zonder bezwaar of beroep
	Gegeven een WOZ-object bevat de volgende waarden
	| vastgesteldeWaarde | waardepeildatum | ingangsdatum | beschikkingsStatussen |
	| 431000             | 2019-01-01      | 2020-01-01   | beschikking_genomen   |
	| 390000             | 2018-01-01      | 2019-01-01   | beschikking_genomen   |
	| 340000             | 2017-01-01      | 2018-01-01   | beschikking_genomen   |
	| 340000             | 2016-01-01      | 2017-01-01   | beschikking_genomen   |
	| 310000             | 2015-01-01      | 2016-01-01   | beschikking_genomen   |
	| 308000             | 2014-01-01      | 2015-01-01   | beschikking_genomen   |
	Als de relevante waarden zijn bepaald voor het WOZ-object
	Dan bevat het WOZ-object de volgende waarden
	| vastgesteldeWaarde | waardepeildatum | ingangsdatum | beschikkingsStatussen |
	| 431000             | 2019-01-01      | 2020-01-01   | beschikking_genomen   |
	| 390000             | 2018-01-01      | 2019-01-01   | beschikking_genomen   |
	| 340000             | 2017-01-01      | 2018-01-01   | beschikking_genomen   |
	| 340000             | 2016-01-01      | 2017-01-01   | beschikking_genomen   |
	| 310000             | 2015-01-01      | 2016-01-01   | beschikking_genomen   |
	| 308000             | 2014-01-01      | 2015-01-01   | beschikking_genomen   |

Scenario: WOZ-object wijzigt gedurende een jaar van eigenaar: bij meerdere waarden met zelfde waardepeildatum gebruiken we de waarde met de meest recente ingangsdatum
	Gegeven een WOZ-object bevat de volgende waarden
	| vastgesteldeWaarde | waardepeildatum | ingangsdatum | beschikkingsStatussen |
	| 171000             | 2019-01-01      | 2020-01-01   | beschikking_genomen   |
	| 163000             | 2018-01-01      | 2019-03-17   | beschikking_genomen   |
	| 160000             | 2018-01-01      | 2019-01-01   | beschikking_genomen   |
	| 155000             | 2017-01-01      | 2018-01-01   | beschikking_genomen   |
	| 149000             | 2016-01-01      | 2017-01-01   | beschikking_genomen   |
	Als de relevante waarden zijn bepaald voor het WOZ-object
	Dan bevat het WOZ-object de volgende waarden
	| vastgesteldeWaarde | waardepeildatum | ingangsdatum | beschikkingsStatussen |
	| 171000             | 2019-01-01      | 2020-01-01   | beschikking_genomen   |
	| 163000             | 2018-01-01      | 2019-03-17   | beschikking_genomen   |
	| 155000             | 2017-01-01      | 2018-01-01   | beschikking_genomen   |
	| 149000             | 2016-01-01      | 2017-01-01   | beschikking_genomen   |

Scenario: Belanghebbende krijgt verlaging van de WOZ-waarde na bezwaar
	Gegeven een WOZ-object bevat de volgende waarden
	| vastgesteldeWaarde | waardepeildatum | ingangsdatum | beschikkingsStatussen |
	| 195000             | 2019-01-01      | 2020-01-01   | beschikking_genomen   |
	| 176000             | 2018-01-01      | 2019-01-01   | bezwaar_ingediend     |
	| 152000             | 2017-01-01      | 2018-01-01   | bezwaar_veranderd     |
	| 164000             | 2016-01-01      | 2017-01-01   | beschikking_genomen   |
	Als de relevante waarden zijn bepaald voor het WOZ-object
	Dan bevat het WOZ-object de volgende waarden
	| vastgesteldeWaarde | waardepeildatum | ingangsdatum | beschikkingsStatussen | indicatieBezwaarBeroep |
	| 195000             | 2019-01-01      | 2020-01-01   | beschikking_genomen   |                        |
	| 176000             | 2018-01-01      | 2019-01-01   | bezwaar_ingediend     | true                   |
	| 152000             | 2017-01-01      | 2018-01-01   | bezwaar_veranderd     |                        |
	| 164000             | 2016-01-01      | 2017-01-01   | beschikking_genomen   |                        |

Scenario: verlaging van de WOZ-waarde na beroep niet zichtbaar door latere ingangsdatum nieuwe belanghebbende eigenaar
	Gegeven een WOZ-object bevat de volgende waarden
	| vastgesteldeWaarde | waardepeildatum | ingangsdatum | beschikkingsStatussen |
	| 266000             | 2019-01-01      | 2020-01-01   | beschikking_genomen   |
	| 223000             | 2018-01-01      | 2019-05-01   | beschikking_genomen   |
	| 190000             | 2018-01-01      | 2019-01-01   | beroep_veranderd      |
	| 189000             | 2017-01-01      | 2018-01-01   | beschikking_genomen   |
	Als de relevante waarden zijn bepaald voor het WOZ-object
	Dan bevat het WOZ-object de volgende waarden
	| vastgesteldeWaarde | waardepeildatum | ingangsdatum | beschikkingsStatussen |
	| 266000             | 2019-01-01      | 2020-01-01   | beschikking_genomen   |
	| 223000             | 2018-01-01      | 2019-05-01   | beschikking_genomen   |
	| 189000             | 2017-01-01      | 2018-01-01   | beschikking_genomen   |

Scenario: een vernietigde beschikking wordt genegeerd
	Gegeven een WOZ-object bevat de volgende waarden
	| vastgesteldeWaarde | waardepeildatum | ingangsdatum | beschikkingsStatussen  |
	| 295000             | 2019-01-01      | 2020-01-01   | beschikking_genomen    |
	| 210000             | 2018-01-01      | 2019-07-01   | beschikking_vernietigd |
	| 283000             | 2018-01-01      | 2019-01-01   | beschikking_genomen    |
	| 274000             | 2017-01-01      | 2018-01-01   | beschikking_genomen    |
	Als de relevante waarden zijn bepaald voor het WOZ-object
	Dan bevat het WOZ-object de volgende waarden
	| vastgesteldeWaarde | waardepeildatum | ingangsdatum | beschikkingsStatussen |
	| 295000             | 2019-01-01      | 2020-01-01   | beschikking_genomen   |
	| 283000             | 2018-01-01      | 2019-01-01   | beschikking_genomen   |
	| 274000             | 2017-01-01      | 2018-01-01   | beschikking_genomen   |

Scenario: een vernietigde beschikking wordt genegeerd, maar de andere beschikking(en) voor dezelfde peildatum en ingangsdatum niet
	Gegeven een WOZ-object bevat de volgende waarden
	| vastgesteldeWaarde | waardepeildatum | ingangsdatum | beschikkingsStatussen                       |
	| 317000             | 2019-01-01      | 2020-01-01   | beschikking_genomen                         |
	| 282000             | 2018-01-01      | 2019-07-01   | beschikking_vernietigd, bezwaar_gehandhaafd |
	| 306000             | 2018-01-01      | 2019-01-01   | beschikking_genomen                         |
	| 266000             | 2017-01-01      | 2018-01-01   | beschikking_genomen                         |
	Als de relevante waarden zijn bepaald voor het WOZ-object
	Dan bevat het WOZ-object de volgende waarden
	| vastgesteldeWaarde | waardepeildatum | ingangsdatum | beschikkingsStatussen                       |
	| 317000             | 2019-01-01      | 2020-01-01   | beschikking_genomen                         |
	| 282000             | 2018-01-01      | 2019-07-01   | beschikking_vernietigd, bezwaar_gehandhaafd |
	| 266000             | 2017-01-01      | 2018-01-01   | beschikking_genomen                         |

Scenario: meerdere vernietigde beschikkingen met zelfde peildatum en ingangsdatum worden genegeerd
	Gegeven een WOZ-object bevat de volgende waarden
	| vastgesteldeWaarde | waardepeildatum | ingangsdatum | beschikkingsStatussen                          |
	| 455000             | 2019-01-01      | 2020-01-01   | beschikking_genomen                            |
	| 440000             | 2018-01-01      | 2019-07-01   | beschikking_vernietigd, beschikking_vernietigd |
	| 430000             | 2018-01-01      | 2019-01-01   | beschikking_genomen                            |
	| 410000             | 2017-01-01      | 2018-01-01   | beschikking_genomen                            |
	Als de relevante waarden zijn bepaald voor het WOZ-object
	Dan bevat het WOZ-object de volgende waarden
	| vastgesteldeWaarde | waardepeildatum | ingangsdatum | beschikkingsStatussen |
	| 455000             | 2019-01-01      | 2020-01-01   | beschikking_genomen   |
	| 430000             | 2018-01-01      | 2019-01-01   | beschikking_genomen   |
	| 410000             | 2017-01-01      | 2018-01-01   | beschikking_genomen   |

Abstract Scenario: indicatieBezwaarBeroep wanneer een van de statussen bezwaar, (hoger)beroep of cassatie ingesteld maar niet afgehandeld is.
	Gegeven een WOZ-object bevat de volgende waarden
	| vastgesteldeWaarde | waardepeildatum | ingangsdatum | beschikkingsStatussen |
	| 317000             | 2019-01-01      | 2020-01-01   | <status>              |
	Als de relevante waarden zijn bepaald voor het WOZ-object
	Dan bevat het WOZ-object de volgende waarden
	| vastgesteldeWaarde | waardepeildatum | ingangsdatum | beschikkingsStatussen | indicatieBezwaarBeroep |
	| 317000             | 2019-01-01      | 2020-01-01   | <status>              | true                   |

    Voorbeelden:
    | statuscode | status                   |
    | 10         | bezwaar_ingediend        |
    | 20         | beroep_aangetekend       |
    | 23         | hoger_beroep_aangetekend |
    | 30         | cassatie_ingesteld       |

Abstract Scenario: indicatieBezwaarBeroep wordt niet opgenomen wanneer er geen bezwaar, (hoger)beroep of cassatie is ingesteld, of deze is afgehandeld.
	Gegeven een WOZ-object bevat de volgende waarden
	| vastgesteldeWaarde | waardepeildatum | ingangsdatum | beschikkingsStatussen |
	| 317000             | 2019-01-01      | 2020-01-01   | <status_enum>         |
	Als de relevante waarden zijn bepaald voor het WOZ-object
	Dan heeft de waarden van het WOZ-object geen property indicatieBezwaarBeroep

    Voorbeelden:
    | status_enum                  | statuscode | status                                                |
    | beschikking_genomen          | 01         | beschikking genomen                                   |
    | beschikking_herzien          | 03         | herzieningsbeschikking                                |
    | bezwaar_gehandhaafd          | 11         | bezwaar afgehandeld, beschikking gehandhaafd          |
    | bezwaar_veranderd            | 12         | bezwaar afgehandeld, vastgestelde waarde veranderd    |
    | waarde_ambtshalve_verminderd | 13         | waardeambtshalveverminderd                            |
    | beroep_gehandhaafd           | 21         | uitspraak beroep, beschikking gehandhaafd             |
    | beroep_veranderd             | 22         | uitspraak beroep, vastgestelde waarde veranderd       |
    | hoger_beroep_gehandhaafd     | 24         | uitspraak hoger beroep, beschikking gehandhaafd       |
    | hoger_beroep_veranderd       | 25         | uitspraak hoger beroep, vastgestelde waarde veranderd |
    | hoge_raad_gehandhaafd        | 31         | arrest Hoge Raad, beschikking gehandhaafd             |
    | hoge_raad_veranderd          | 32         | arrest Hoge Raad, vastgestelde waarde veranderd       |
    | hoge_raad_geding_verwezen    | 33         | arrestHogeRaad,gedingverwezen                         |
    | voorlopige_aanslag           | 99         | waarde te gebruiken voor voorlopige aanslag           |

Scenario: indicatieBezwaarBeroep wanneer er meerdere statussen zijn bij een waardepeildatum en ingangsdatum
	Gegeven een WOZ-object bevat de volgende waarden
	| vastgesteldeWaarde | waardepeildatum | ingangsdatum | beschikkingsStatussen                         |
	| 437000             | 2019-01-01      | 2020-01-01   | beroep_gehandhaafd, beroep_aangetekend        |
	| 392000             | 2018-01-01      | 2019-01-01   | hoger_beroep_aangetekend, beschikking_genomen |
	Als de relevante waarden zijn bepaald voor het WOZ-object
	Dan bevat het WOZ-object de volgende waarden
	| vastgesteldeWaarde | waardepeildatum | ingangsdatum | beschikkingsStatussen                         | indicatieBezwaarBeroep |
	| 437000             | 2019-01-01      | 2020-01-01   | beroep_gehandhaafd, beroep_aangetekend        | true                   |
	| 392000             | 2018-01-01      | 2019-01-01   | hoger_beroep_aangetekend, beschikking_genomen | true                   |

Scenario: indicatieBezwaarBeroep wanneer er bezwaar, (hoger)beroep of cassatie loopt bij niet de meest recente ingangsdatum
	Gegeven een WOZ-object bevat de volgende waarden
	| vastgesteldeWaarde | waardepeildatum | ingangsdatum | beschikkingsStatussen |
	| 215000             | 2018-01-01      | 2019-05-01   | beschikking_genomen   |
	| 215000             | 2018-01-01      | 2019-01-01   | beroep_aangetekend    |
	Als de relevante waarden zijn bepaald voor het WOZ-object
	Dan bevat het WOZ-object de volgende waarden
	| vastgesteldeWaarde | waardepeildatum | ingangsdatum | beschikkingsStatussen |
	| 215000             | 2018-01-01      | 2019-05-01   | beschikking_genomen   |
