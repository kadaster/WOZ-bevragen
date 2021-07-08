#language: nl
Functionaliteit: Bepaal relevante waarden voor een WOZ-object

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
