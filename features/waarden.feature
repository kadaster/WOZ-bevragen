# language: nl

Feature: leveren van waarden bij een WOZ-object
  Deze feature beschrijft hoe uit de door de API geleverde waarden (beschikkingen) de relevante actuele waarde per waardepeildatum kan worden bepaald.

  Per waardepeildatum wordt één waarde bepaald.
  Voor een waardepeildatum wordt de waarde genomen met de meest recente ingangsdatum met betrekking tot die waardepeildatum.

  Een waarde met alleen een of meerdere beschikking status (beschikkingsStatussen) "vernietigingbeschikking" (02) en geen enkele andere status, wordt genegeerd.

  Waarden worden gesorteerd op waardepeildatum met de meest recente waardepeildatum eerst.

  N.B. De API levert alleen actuele waarden. Dit betekent dat voor een waardepeildatum en ingangsdatum alleen de waarde wordt genomen met de meest recente beschikkingsdatum. Ook levert de API alleen de actuele beschikkingsStatussen.
  N.B. De provider van de API kan een maximum aantal op te nemen waarden bepalen.
  N.B. Niet elke waarde bij het WOZ-object hoeft te komen uit een beschikking op naam van de actuele belanghebbende(n).

  indicatieBezwaarBeroep krijgt de waarde true wanneer ten minste één beschikking status van de betreffende WOZ-waarde een van de volgende waarden heeft:
    - bezwaaringediend (10)
    - beroepaangetekend (20)
    - hogerberoepaangetekend (23)
    - cassatieingesteld (30)


  Scenario: meerdere jaren met zelfde eigenaar en zonder bezwaar of beroep
    Gegeven /wozobjecten/051800823525 levert de volgende waarden:
    """
    [
      {
        "vastgesteldeWaarde": 308000,
        "waardepeildatum": "2014-01-01",
        "ingangsdatum": "2015-01-01",
        "beschikkingsStatussen": [ "beschikking_genomen" ]
      },{
        "vastgesteldeWaarde": 310000,
        "waardepeildatum": "2015-01-01",
        "ingangsdatum": "2016-01-01",
        "beschikkingsStatussen": [ "beschikking_genomen" ]
      },{
        "vastgesteldeWaarde": 340000,
        "waardepeildatum": "2016-01-01",
        "ingangsdatum": "2017-01-01",
        "beschikkingsStatussen": [ "beschikking_genomen" ]
      },{
        "vastgesteldeWaarde": 340000,
        "waardepeildatum": "2017-01-01",
        "ingangsdatum": "2018-01-01",
        "beschikkingsStatussen": [ "beschikking_genomen" ]
      },{
        "vastgesteldeWaarde": 390000,
        "waardepeildatum": "2018-01-01",
        "ingangsdatum": "2019-01-01",
        "beschikkingsStatussen": [ "beschikking_genomen" ]
      },{
        "vastgesteldeWaarde": 431000,
        "waardepeildatum": "2019-01-01",
        "ingangsdatum": "2020-01-01",
        "beschikkingsStatussen": [ "beschikking_genomen" ]
      }
    ]
    """
    Als de relevante waarden worden bepaald voor de geleverde waarden
    Dan levert dit de waarden:
    """
    "waarden": [
      {
        "vastgesteldeWaarde": 431000,
        "waardepeildatum": "2019-01-01"
      },{
        "vastgesteldeWaarde": 390000,
        "waardepeildatum": "2018-01-01"
      },{
        "vastgesteldeWaarde": 340000,
        "waardepeildatum": "2017-01-01"
      },{
        "vastgesteldeWaarde": 340000,
        "waardepeildatum": "2016-01-01"
      },{
        "vastgesteldeWaarde": 310000,
        "waardepeildatum": "2015-01-01"
      },{
        "vastgesteldeWaarde": 308000,
        "waardepeildatum": "2014-01-01"
      }
    ]
    """

  Scenario: WOZ-object wijzigt gedurende een jaar van eigenaar: bij meerdere waarden met zelfde waardepeildatum gebruiken we de waarde met de meest recente ingangsdatum
    Gegeven WOZ-object met objectnummer "002500003118"
    En dit WOZ-object heeft per 17-03-2019 een nieuwe eigenaar
    En de nieuwe eigenaar heeft een beschikking gevraagd over peildatum 01-01-2018
    En de beschikking over peildatum 01-01-2018 voor de nieuwe eigenaar heeft een andere vastgestelde waarde dan de oude eigenaar
    En /wozobjecten/002500003118 levert de volgende waarden:
    """
    [
      {
        "vastgesteldeWaarde": 149000,
        "waardepeildatum": "2016-01-01",
        "ingangsdatum": "2017-01-01",
        "beschikkingsStatussen": [ "beschikking_genomen" ]
      },{
        "vastgesteldeWaarde": 155000,
        "waardepeildatum": "2017-01-01",
        "ingangsdatum": "2018-01-01",
        "beschikkingsStatussen": [ "beschikking_genomen" ]
      },{
        "vastgesteldeWaarde": 160000,
        "waardepeildatum": "2018-01-01",
        "ingangsdatum": "2019-01-01",
        "beschikkingsStatussen": [ "beschikking_genomen" ]
      },{
        "vastgesteldeWaarde": 163000,
        "waardepeildatum": "2018-01-01",
        "ingangsdatum": "2019-03-17",
        "beschikkingsStatussen": [ "beschikking_genomen" ]
      },{
        "vastgesteldeWaarde": 171000,
        "waardepeildatum": "2019-01-01",
        "ingangsdatum": "2020-01-01",
        "beschikkingsStatussen": [ "beschikking_genomen" ]
      }
    ]
    """
    Als de relevante waarden worden bepaald voor de geleverde waarden
    Dan levert dit de waarden:
    """
    "waarden": [
      {
        "vastgesteldeWaarde": 171000,
        "waardepeildatum": "2019-01-01"
      },
      {
        "vastgesteldeWaarde": 163000,
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

  Scenario: Belanghebbende krijgt verlaging van de WOZ-waarde na bezwaar
    Gegeven WOZ-object met objectnummer "082600014669" heeft de belanghebbende eigenaar bezwaar ingediend over de WOZ-waarde met peildatum 01-01-2017
    En dat bezwaar is afgehandeld met de status "12: bezwaar afgehandeld, vastgestelde waarde veranderd"
    En de belanghebbende eigenaar heeft bezwaar ingediend over de WOZ-waarde met peildatum 01-01-2018
    En dat bezwaar heeft de status "10: bezwaaringediend"
    En /wozobjecten/082600014669 levert de volgende waarden:
    """
    [
      {
        "vastgesteldeWaarde": 195000,
        "waardepeildatum": "2019-01-01",
        "ingangsdatum": "2020-01-01",
        "beschikkingsStatussen": [ "beschikking_genomen" ]
      },{
        "vastgesteldeWaarde": 152000,
        "waardepeildatum": "2017-01-01",
        "ingangsdatum": "2018-01-01",
        "beschikkingsStatussen": [ "bezwaar_veranderd" ]
      },{
        "vastgesteldeWaarde": 176000,
        "waardepeildatum": "2018-01-01",
        "ingangsdatum": "2019-01-01",
        "beschikkingsStatussen": [ "bezwaaringediend" ]
      },{
        "vastgesteldeWaarde": 164000,
        "waardepeildatum": "2016-01-01",
        "ingangsdatum": "2017-01-01",
        "beschikkingsStatussen": [ "beschikking_genomen" ]
      }
    ]
    """
    Als de relevante waarden worden bepaald voor de geleverde waarden
    Dan levert dit de waarden:
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
    Gegeven WOZ-object met objectnummer "050300024029" heeft met ingang van 01-05-2019 een nieuwe eigenaar
    En de gemeente heeft een beschikking gestuurd naar de nieuwe eigenaar over 01-01-2018 met ingangsdatum 01-05-2019
    En de vorige eigenaar heeft beroep ingediend over de WOZ-waarde op 01-01-2018
    En dat beroep is afgehandeld met de status "uitspraak beroep, vastgestelde waarde veranderd"
    En /wozobjecten/050300024029 levert de volgende waarden:
    """
    [
      {
        "vastgesteldeWaarde": 190000,
        "waardepeildatum": "2018-01-01",
        "ingangsdatum": "2019-01-01",
        "beschikkingsStatussen": [ "beroep_veranderd" ]
      },{
        "vastgesteldeWaarde": 266000,
        "waardepeildatum": "2019-01-01",
        "ingangsdatum": "2020-01-01",
        "beschikkingsStatussen": [ "beschikking_genomen" ]
      },{
        "vastgesteldeWaarde": 223000,
        "waardepeildatum": "2018-01-01",
        "ingangsdatum": "2019-05-01",
        "beschikkingsStatussen": [ "beschikking_genomen" ]
      },{
        "vastgesteldeWaarde": 189000,
        "waardepeildatum": "2017-01-01",
        "ingangsdatum": "2018-01-01",
        "beschikkingsStatussen": [ "beschikking_genomen" ]
      }
    ]
    """
    Als de relevante waarden worden bepaald voor de geleverde waarden
    Dan levert dit de waarden:
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

    Scenario: een vernietigde beschikking wordt genegeerd
      Gegeven /wozobjecten/051800027395 levert de volgende waarden:
      """
      [
        {
          "vastgesteldeWaarde": 210000,
          "waardepeildatum": "2018-01-01",
          "ingangsdatum": "2019-07-01",
          "beschikkingsStatussen": [ "vernietigingbeschikking" ]
        },{
          "vastgesteldeWaarde": 295000,
          "waardepeildatum": "2019-01-01",
          "ingangsdatum": "2020-01-01",
          "beschikkingsStatussen": [ "beschikking_genomen" ]
        },{
          "vastgesteldeWaarde": 283000,
          "waardepeildatum": "2018-01-01",
          "ingangsdatum": "2019-01-01",
          "beschikkingsStatussen": [ "beschikking_genomen" ]
        },{
          "vastgesteldeWaarde": 274000,
          "waardepeildatum": "2017-01-01",
          "ingangsdatum": "2018-01-01",
          "beschikkingsStatussen": [ "beschikking_genomen" ]
        }
      ]
      """
      Als de relevante waarden worden bepaald voor de geleverde waarden
      Dan levert dit de waarden:
      """
      "waarden": [
        {
          "vastgesteldeWaarde": 295000,
          "waardepeildatum": "2019-01-01"
        },
        {
          "vastgesteldeWaarde": 283000,
          "waardepeildatum": "2018-01-01"
        },
        {
          "vastgesteldeWaarde": 274000,
          "waardepeildatum": "2017-01-01"
        }
      ]
      """

    Scenario: een vernietigde beschikking wordt genegeerd, maar de andere beschikking(en) voor dezelfde peildatum en ingangsdatum niet
      Gegeven /wozobjecten/002500024901 levert de volgende waarden:
      """
      [
        {
          "vastgesteldeWaarde": 210000,
          "waardepeildatum": "2018-01-01",
          "ingangsdatum": "2019-07-01",
          "beschikkingsStatussen": [ "vernietigingbeschikking", "bezwaar_gehandhaafd" ]
        },{
          "vastgesteldeWaarde": 295000,
          "waardepeildatum": "2019-01-01",
          "ingangsdatum": "2020-01-01",
          "beschikkingsStatussen": [ "beschikking_genomen" ]
        },{
          "vastgesteldeWaarde": 283000,
          "waardepeildatum": "2018-01-01",
          "ingangsdatum": "2019-01-01",
          "beschikkingsStatussen": [ "beschikking_genomen" ]
        },{
          "vastgesteldeWaarde": 274000,
          "waardepeildatum": "2017-01-01",
          "ingangsdatum": "2018-01-01",
          "beschikkingsStatussen": [ "beschikking_genomen" ]
        }
      ]
      """
      Als de relevante waarden worden bepaald voor de geleverde waarden
      Dan levert dit de waarden:
      """
      "waarden": [
        {
          "vastgesteldeWaarde": 295000,
          "waardepeildatum": "2019-01-01"
        },
        {
          "vastgesteldeWaarde": 210000,
          "waardepeildatum": "2018-01-01"
        },
        {
          "vastgesteldeWaarde": 274000,
          "waardepeildatum": "2017-01-01"
        }
      ]
      """

    Scenario: meerdere vernietigde beschikkingen met zelfde peildatum en ingangsdatum worden genegeerd
      Gegeven /wozobjecten/051800027395 levert de volgende waarden:
      """
      [
        {
          "vastgesteldeWaarde": 210000,
          "waardepeildatum": "2018-01-01",
          "ingangsdatum": "2019-07-01",
          "beschikkingsStatussen": [ "vernietigingbeschikking", "vernietigingbeschikking" ]
        },{
          "vastgesteldeWaarde": 295000,
          "waardepeildatum": "2019-01-01",
          "ingangsdatum": "2020-01-01",
          "beschikkingsStatussen": [ "beschikking_genomen" ]
        },{
          "vastgesteldeWaarde": 283000,
          "waardepeildatum": "2018-01-01",
          "ingangsdatum": "2019-01-01",
          "beschikkingsStatussen": [ "beschikking_genomen" ]
        },{
          "vastgesteldeWaarde": 274000,
          "waardepeildatum": "2017-01-01",
          "ingangsdatum": "2018-01-01",
          "beschikkingsStatussen": [ "beschikking_genomen" ]
        }
      ]
      """
      Als de relevante waarden worden bepaald voor de geleverde waarden
      Dan levert dit de waarden:
      """
      "waarden": [
        {
          "vastgesteldeWaarde": 295000,
          "waardepeildatum": "2019-01-01"
        },
        {
          "vastgesteldeWaarde": 283000,
          "waardepeildatum": "2018-01-01"
        },
        {
          "vastgesteldeWaarde": 274000,
          "waardepeildatum": "2017-01-01"
        }
      ]
      """

    Scenario: indicatieBezwaarBeroep wanneer een van de statussen bezwaar, (hoger)beroep of cassatie ingesteld maar niet afgehandeld is.
      Gegeven /wozobjecten/051800027395 levert de volgende waarden:
      """
      [
        {
          "vastgesteldeWaarde": 445000,
          "waardepeildatum": "2020-01-01",
          "ingangsdatum": "2021-01-01",
          "beschikkingsStatussen": [ "beschikking_genomen" ]
        },{
          "vastgesteldeWaarde": 437000,
          "waardepeildatum": "2019-01-01",
          "ingangsdatum": "2020-01-01",
          "beschikkingsStatussen": [ "beroep_gehandhaafd", "beroep_veranderd" ]
        },{
          "vastgesteldeWaarde": 392000,
          "waardepeildatum": "2018-01-01",
          "ingangsdatum": "2019-01-01",
          "beschikkingsStatussen": [ "beschikking_genomen", "hogerberoepaangetekend" ]
        },{
          "vastgesteldeWaarde": 385000,
          "waardepeildatum": "2017-01-01",
          "ingangsdatum": "2018-01-01",
          "beschikkingsStatussen": [ "beschikking_genomen" ]
        }
      ]
      """
      Als de relevante waarden worden bepaald voor de geleverde waarden
      Dan levert dit de waarden:
      """
      "waarden": [
        {
          "vastgesteldeWaarde": 445000,
          "waardepeildatum": "2020-01-01"
        },{
          "vastgesteldeWaarde": 437000,
          "waardepeildatum": "2019-01-01"
        },
        {
          "vastgesteldeWaarde": 392000,
          "waardepeildatum": "2018-01-01",
          "indicatieBezwaarBeroep": true
        },
        {
          "vastgesteldeWaarde": 385000,
          "waardepeildatum": "2017-01-01"
        }
      ]
      """
