# language: nl

Feature: leveren van waarden bij een WOZ-object
  Per waardepeildatum wordt één waarde opgenomen.
  Voor een waardepeildatum wordt de waarde genomen met de meest recente ingangsdatum met betrekking tot die waardepeildatum.
  Voor een waardepeildatum en ingangsdatum wordt de waarde genomen met de meest recente beschikkingsdatum.

  Waarden worden opgenomen gesorteerd op waardepeildatum met de meest recente waardepeildatum eerst.

  N.B. De provider van de API kan een maximum aantal op te nemen waarden bepalen.
  N.B. Niet elke waarde bij het WOZ-object hoeft te komen uit een beschikking op naam van de actuele belanghebbende(n).

  indicatieBezwaarBeroep krijgt de waarde true wanneer StatusBeschikking een van de volgende waarden heeft:
    - bezwaar ingediend
    - beroep aangetekend
    - hoger beroep aangetekend
    - cassatie ingesteld


  Scenario: meerdere jaren met zelfde eigenaar en zonder bezwaar of beroep
    Gegeven WOZ-object met objectnummer "051800823525" heeft de volgende beschikkingen voor eigenaar R. Geels   :
      | Peildatum  | WOZ-waarde   | Belanghebbende | Ingangsdatum | Datum beschikking |
      | 01-01-2019 | 431.000 euro | R. Geels       | 01-01-2020   | 11-02-2020        |
      | 01-01-2018 | 390.000 euro | R. Geels       | 01-01-2019   | 12-02-2019        |
      | 01-01-2017 | 340.000 euro | R. Geels       | 01-01-2018   | 13-02-2018        |
      | 01-01-2016 | 340.000 euro | R. Geels       | 01-01-2017   | 14-02-2017        |
      | 01-01-2015 | 310.000 euro | R. Geels       | 01-01-2016   | 16-02-2016        |
      | 01-01-2014 | 308.000 euro | R. Geels       | 01-01-2015   | 17-02-2015        |
    Als het WOZ object wordt opgevraagd met /wozobjecten/051800823525
    Dan bevat het antwoord:
    """
    "waarden": [
      {
        "vastgesteldeWaarde": 431000,
        "waardepeildatum": "2019-01-01"
      },
      {
        "vastgesteldeWaarde": 390000,
        "waardepeildatum": "2018-01-01"
      },
      {
        "vastgesteldeWaarde": 340000,
        "waardepeildatum": "2017-01-01"
      },
      {
        "vastgesteldeWaarde": 340000,
        "waardepeildatum": "2016-01-01"
      },
      {
        "vastgesteldeWaarde": 310000,
        "waardepeildatum": "2015-01-01"
      },
      {
        "vastgesteldeWaarde": 308000,
        "waardepeildatum": "2014-01-01"
      }
    ]
    """

  Scenario: WOZ-object wijzigt gedurende een jaar van eigenaar: bij beschikkingen met zelfde waardepeildatum gebruiken we de beschikking met de meest recente ingangsdatum
    Gegeven WOZ-object met objectnummer "002500003118" heeft de volgende beschikkingen voor P. Keizer:
      | Peildatum  | WOZ-waarde   | Belanghebbende | Ingangsdatum | Datum beschikking |
      | 01-01-2018 | 160.000 euro | P. Keizer      | 01-01-2019   | 12-02-2019        |
      | 01-01-2017 | 155.000 euro | P. Keizer      | 01-01-2018   | 13-02-2018        |
      | 01-01-2016 | 149.000 euro | P. Keizer      | 01-01-2017   | 14-02-2017        |
    En dit WOZ-object heeft per 17-03-2019 een nieuwe eigenaar W. Rijnsbergen
    En de nieuwe eigenaar heeft een beschikking gevraagd over peildatum 01-01-2018
    En WOZ-object met objectnummer "002500003118" heeft de volgende beschikkingen voor W. Rijnsbergen
      | Peildatum  | WOZ-waarde   | Belanghebbende | Ingangsdatum | Datum beschikking |
      | 01-01-2019 | 171.000 euro | W. Rijnsbergen | 01-01-2020   | 11-02-2020        |
      | 01-01-2018 | 160.000 euro | W. Rijnsbergen | 17-03-2019   | 06-04-2019        |
    Als het WOZ object wordt opgevraagd met /wozobjecten/002500003118
    Dan bevat het antwoord:
    """
    "waarden": [
      {
        "vastgesteldeWaarde": 171000,
        "waardepeildatum": "2019-01-01"
      },
      {
        "vastgesteldeWaarde": 160000,
        "waardepeildatum": "2018-01-01"
      },
      {
        "vastgesteldeWaarde": 155000,
        "waardepeildatum": "2017-01-01"
      },
      {
        "vastgesteldeWaarde": 149000,
        "waardepeildatum": "2016-01-01"
      }
    ]
    """

  Scenario: Belanghebbende krijgt verlaging van de WOZ-waarde na bezwaar: bij beschikkingen met zelfde waardepeildatum en zelfde ingangsdatum gebruiken we de meest recente beschikking
    Gegeven WOZ-object met objectnummer "082600014669" heeft de belanghebbende eigenaar bezwaar ingediend over de WOZ-waarde op 01-01-2017
    En dat bezwaar is afgehandeld met de status "bezwaar afgehandeld, vastgestelde waarde veranderd"
    En de belanghebbende eigenaar heeft bezwaar ingediend over de WOZ-waarde op 01-01-2018
    En dat bezwaar heeft de status "bezwaar ingediend"
    En WOZ-object met objectnummer "082600014669" heeft de volgende beschikkingen:
      | Peildatum  | WOZ-waarde   | Belanghebbende | Ingangsdatum | Datum beschikking |
      | 01-01-2019 | 195.000 euro | R. Geels       | 01-01-2020   | 13-01-2020        |
      | 01-01-2017 | 152.000 euro | R. Geels       | 01-01-2018   | 03-02-2019        |
      | 01-01-2018 | 176.000 euro | R. Geels       | 01-01-2019   | 14-01-2019        |
      | 01-01-2017 | 171.000 euro | R. Geels       | 01-01-2018   | 15-01-2018        |
      | 01-01-2016 | 164.000 euro | R. Geels       | 01-01-2017   | 16-01-2017        |
    Als het WOZ object wordt opgevraagd met /wozobjecten/082600014669
    Dan bevat het antwoord:
    """
    "waarden": [
      {
        "vastgesteldeWaarde": 195000,
        "waardepeildatum": "2019-01-01"
      },
      {
        "vastgesteldeWaarde": 176000,
        "indicatieBezwaarBeroep": true,
        "waardepeildatum": "2018-01-01"
      },
      {
        "vastgesteldeWaarde": 152000,
        "waardepeildatum": "2017-01-01"
      },
      {
        "vastgesteldeWaarde": 164000,
        "waardepeildatum": "2016-01-01"
      }
    ]
    """

  Scenario: verlaging van de WOZ-waarde na beroep niet zichtbaar door latere ingangsdatum nieuwe belanghebbende eigenaar
    Gegeven WOZ-object met objectnummer "050300024029" heeft met ingang van 01-05-2019 een nieuwe eigenaar W. Jansen
    En de gemeente heeft een beschikking gestuurd naar de nieuwe eigenaar over 01-01-2018 met ingangsdatum 01-05-2019
    En de vorige eigenaar R. Krol heeft beroep ingediend over de WOZ-waarde op 01-01-2018
    En dat beroep is afgehandeld met de status "uitspraak beroep, vastgestelde waarde veranderd"
    En WOZ-object met objectnummer "050300024029" heeft de volgende beschikkingen:
      | Peildatum  | WOZ-waarde   | Belanghebbende | Ingangsdatum | Datum beschikking |
      | 01-01-2018 | 190.000 euro | R. Krol        | 01-01-2019   | 27-08-2020        |
      | 01-01-2019 | 266.000 euro | W. Jansen      | 01-01-2020   | 13-01-2020        |
      | 01-01-2018 | 223.000 euro | W. Jansen      | 01-05-2019   | 03-06-2019        |
      | 01-01-2018 | 223.000 euro | R. Krol        | 01-01-2019   | 14-01-2019        |
      | 01-01-2017 | 189.000 euro | R. Krol        | 01-01-2018   | 15-01-2018        |
    Als het WOZ object wordt opgevraagd met /wozobjecten/050300024029
    Dan bevat het antwoord:
    """
    "waarden": [
      {
        "vastgesteldeWaarde": 266000,
        "waardepeildatum": "2019-01-01"
      },
      {
        "vastgesteldeWaarde": 223000,
        "waardepeildatum": "2018-01-01"
      },
      {
        "vastgesteldeWaarde": 189000,
        "waardepeildatum": "2017-01-01"
      }
    ]
    """
