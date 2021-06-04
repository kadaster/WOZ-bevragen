# language: nl

Functionaliteit: leveren van waarden bij een WOZ-object
  Deze feature beschrijft hoe uit de door de API geleverde waarden (beschikkingen) de relevante actuele waarde per waardepeildatum kan worden bepaald.

  Per waardepeildatum wordt één waarde bepaald.
  Voor een waardepeildatum wordt de waarde genomen met de meest recente ingangsdatum met betrekking tot die waardepeildatum.

  Een waarde met alleen een of meerdere beschikking status (beschikkingsStatussen) "vernietigingbeschikking" (02) en geen enkele andere status, wordt genegeerd.

  Waarden worden gesorteerd op waardepeildatum met de meest recente waardepeildatum eerst.
  
  N.B. De API levert waarden aflopend gesorteerd op waardepeildatum en daarbinnen op ingangsdatum.
  N.B. De API levert alleen actuele waarden. Dit betekent dat voor een waardepeildatum en ingangsdatum alleen de waarde wordt genomen met de meest recente beschikkingsdatum. Ook levert de API alleen de actuele beschikkingsStatussen.
  N.B. De provider van de API kan een maximum aantal op te nemen waarden bepalen.
  N.B. Niet elke waarde bij het WOZ-object hoeft te komen uit een beschikking op naam van de actuele belanghebbende(n).

  indicatieBezwaarBeroep krijgt de waarde true wanneer ten minste één beschikking status van de betreffende WOZ-waarde een van de volgende waarden heeft:
    - bezwaaringediend (10)
    - beroepaangetekend (20)
    - hogerberoepaangetekend (23)
    - cassatieingesteld (30)


  Scenario: meerdere jaren met zelfde eigenaar en zonder bezwaar of beroep
    Gegeven WOZ object met identificatie "051800823525" heeft de volgende beschikkingen:
    | Peildatum  | WOZ-waarde   | Ingangsdatum | Datum beschikking |
    | 01-01-2019 | 431.000 euro | 01-01-2020   | 11-02-2020        |
    | 01-01-2018 | 390.000 euro | 01-01-2019   | 12-02-2019        |
    | 01-01-2017 | 340.000 euro | 01-01-2018   | 13-02-2018        |
    | 01-01-2016 | 340.000 euro | 01-01-2017   | 14-02-2017        |
    | 01-01-2015 | 310.000 euro | 01-01-2016   | 16-02-2016        |
    | 01-01-2014 | 308.000 euro | 01-01-2015   | 17-02-2015        |
    Als het WOZ object wordt opgevraagd met /wozobjecten/051800823525
    Dan levert de API de volgende waarden:
    """
    [
      {
        "vastgesteldeWaarde": 431000,
        "waardepeildatum": "2019-01-01",
        "ingangsdatum": "2020-01-01",
        "beschikkingsStatussen": [ "beschikking_genomen" ]
      },{
        "vastgesteldeWaarde": 390000,
        "waardepeildatum": "2018-01-01",
        "ingangsdatum": "2019-01-01",
        "beschikkingsStatussen": [ "beschikking_genomen" ]
      },{
        "vastgesteldeWaarde": 340000,
        "waardepeildatum": "2017-01-01",
        "ingangsdatum": "2018-01-01",
        "beschikkingsStatussen": [ "beschikking_genomen" ]
      },{
        "vastgesteldeWaarde": 340000,
        "waardepeildatum": "2016-01-01",
        "ingangsdatum": "2017-01-01",
        "beschikkingsStatussen": [ "beschikking_genomen" ]
      },{
        "vastgesteldeWaarde": 310000,
        "waardepeildatum": "2015-01-01",
        "ingangsdatum": "2016-01-01",
        "beschikkingsStatussen": [ "beschikking_genomen" ]
      },{
        "vastgesteldeWaarde": 308000,
        "waardepeildatum": "2014-01-01",
        "ingangsdatum": "2015-01-01",
        "beschikkingsStatussen": [ "beschikking_genomen" ]
      }
    ]
    """
    En zijn de daaruit bepaalde relevante waarden:
    """
    [
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
    En WOZ-object met objectnummer "002500003118" heeft de volgende beschikkingen voor de oude eigenaar:
    | Peildatum  | WOZ-waarde   | Ingangsdatum | Datum beschikking |
    | 01-01-2018 | 160.000 euro | 01-01-2019   | 12-02-2019        |
    | 01-01-2017 | 155.000 euro | 01-01-2018   | 13-02-2018        |
    | 01-01-2016 | 149.000 euro | 01-01-2017   | 14-02-2017        |
    En WOZ-object met objectnummer "002500003118" heeft de volgende beschikkingen voor de nieuwe eigenaar:
    | Peildatum  | WOZ-waarde   | Ingangsdatum | Datum beschikking |
    | 01-01-2019 | 171.000 euro | 01-01-2020   | 11-02-2020        |
    | 01-01-2018 | 163.000 euro | 17-03-2019   | 06-04-2019        |
    Als het WOZ object wordt opgevraagd met /wozobjecten/002500003118
    Dan levert de API de volgende waarden:
    """
    [
      {
        "vastgesteldeWaarde": 171000,
        "waardepeildatum": "2019-01-01",
        "ingangsdatum": "2020-01-01",
        "beschikkingsStatussen": [ "beschikking_genomen" ]
      },{
        "vastgesteldeWaarde": 163000,
        "waardepeildatum": "2018-01-01",
        "ingangsdatum": "2019-03-17",
        "beschikkingsStatussen": [ "beschikking_genomen" ]
      },{
        "vastgesteldeWaarde": 160000,
        "waardepeildatum": "2018-01-01",
        "ingangsdatum": "2019-01-01",
        "beschikkingsStatussen": [ "beschikking_genomen" ]
      },{
        "vastgesteldeWaarde": 155000,
        "waardepeildatum": "2017-01-01",
        "ingangsdatum": "2018-01-01",
        "beschikkingsStatussen": [ "beschikking_genomen" ]
      },{
        "vastgesteldeWaarde": 149000,
        "waardepeildatum": "2016-01-01",
        "ingangsdatum": "2017-01-01",
        "beschikkingsStatussen": [ "beschikking_genomen" ]
      }
    ]
    """
    En zijn de daaruit bepaalde relevante waarden:
    """
    [
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
    En dat bezwaar is afgehandeld met de status "bezwaar afgehandeld, vastgestelde waarde veranderd" (12)
    En de belanghebbende eigenaar heeft bezwaar ingediend over de WOZ-waarde met peildatum 01-01-2018
    En dat bezwaar heeft de status "bezwaaringediend" (20)
    En WOZ-object met objectnummer "082600014669" heeft de volgende beschikkingen:
    | Peildatum  | WOZ-waarde   | Ingangsdatum | Datum beschikking |
    | 01-01-2019 | 195.000 euro | 01-01-2020   | 13-01-2020        |
    | 01-01-2017 | 152.000 euro | 01-01-2018   | 03-02-2019        |
    | 01-01-2018 | 176.000 euro | 01-01-2019   | 14-01-2019        |
    | 01-01-2017 | 171.000 euro | 01-01-2018   | 15-01-2018        |
    | 01-01-2016 | 164.000 euro | 01-01-2017   | 16-01-2017        |
    Als het WOZ object wordt opgevraagd met /wozobjecten/082600014669
    Dan levert de API de volgende waarden:
    """
    [
      {
        "vastgesteldeWaarde": 195000,
        "waardepeildatum": "2019-01-01",
        "ingangsdatum": "2020-01-01",
        "beschikkingsStatussen": [ "beschikking_genomen" ]
      },{
        "vastgesteldeWaarde": 176000,
        "waardepeildatum": "2018-01-01",
        "ingangsdatum": "2019-01-01",
        "beschikkingsStatussen": [ "bezwaar_ingediend" ]
      },{
        "vastgesteldeWaarde": 152000,
        "waardepeildatum": "2017-01-01",
        "ingangsdatum": "2018-01-01",
        "beschikkingsStatussen": [ "bezwaar_veranderd" ]
      },{
        "vastgesteldeWaarde": 164000,
        "waardepeildatum": "2016-01-01",
        "ingangsdatum": "2017-01-01",
        "beschikkingsStatussen": [ "beschikking_genomen" ]
      }
    ]
    """
    En zijn de daaruit bepaalde relevante waarden:
    """
    [
      {
        "vastgesteldeWaarde": 195000,
        "waardepeildatum": "2019-01-01"
      },
      {
        "vastgesteldeWaarde": 176000,
        "waardepeildatum": "2018-01-01",
        "indicatieBezwaarBeroep": true
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
    En de gemeente heeft een beschikking gestuurd naar de nieuwe eigenaar over waardepeildatum 01-01-2018 met ingangsdatum 01-05-2019
    En de vorige eigenaar heeft beroep ingediend over de WOZ-waarde op waardepeildatum 01-01-2018
    En dat beroep is afgehandeld met de status "uitspraak beroep, vastgestelde waarde veranderd" (22)
    En WOZ-object met objectnummer "050300024029" heeft de volgende beschikkingen voor de oude eigenaar:
    | Peildatum  | WOZ-waarde   | Ingangsdatum | Datum beschikking |
    | 01-01-2018 | 190.000 euro | 01-01-2019   | 14-10-2019        |
    | 01-01-2018 | 223.000 euro | 01-01-2019   | 12-02-2019        |
    | 01-01-2017 | 189.000 euro | 01-01-2018   | 13-02-2018        |
    En WOZ-object met objectnummer "050300024029" heeft de volgende beschikkingen voor de nieuwe eigenaar:
    | Peildatum  | WOZ-waarde   | Ingangsdatum | Datum beschikking |
    | 01-01-2019 | 266.000 euro | 01-01-2020   | 11-02-2020        |
    | 01-01-2018 | 223.000 euro | 01-05-2019   | 23-06-2019        |
    Als het WOZ object wordt opgevraagd met /wozobjecten/050300024029
    Dan levert de API de volgende waarden:
    """
    [
      {
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
        "vastgesteldeWaarde": 190000,
        "waardepeildatum": "2018-01-01",
        "ingangsdatum": "2019-01-01",
        "beschikkingsStatussen": [ "beroep_veranderd" ]
      },{
        "vastgesteldeWaarde": 189000,
        "waardepeildatum": "2017-01-01",
        "ingangsdatum": "2018-01-01",
        "beschikkingsStatussen": [ "beschikking_genomen" ]
      }
    ]
    """
    En zijn de daaruit bepaalde relevante waarden:
    """
    [
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
      Gegeven WOZ-object met objectnummer "051800027395" heeft een beschikking met ingangsdatum 01-07-2019
      En deze beschikking heeft als status "vernietigingbeschikking" (02)
      En WOZ-object met objectnummer "051800027395" heeft de volgende beschikkingen:
      | Peildatum  | WOZ-waarde   | Ingangsdatum | Datum beschikking |
      | 01-01-2019 | 295.000 euro | 01-01-2020   | 13-01-2020        |
      | 01-01-2018 | 210.000 euro | 01-07-2019   | 24-07-2019        |
      | 01-01-2018 | 283.000 euro | 01-01-2019   | 14-01-2019        |
      | 01-01-2017 | 274.000 euro | 01-01-2018   | 15-01-2018        |
      Als het WOZ object wordt opgevraagd met /wozobjecten/051800027395
      Dan levert de API de volgende waarden:
      """
      [
        {
          "vastgesteldeWaarde": 295000,
          "waardepeildatum": "2019-01-01",
          "ingangsdatum": "2020-01-01",
          "beschikkingsStatussen": [ "beschikking_genomen" ]
        },{
          "vastgesteldeWaarde": 210000,
          "waardepeildatum": "2018-01-01",
          "ingangsdatum": "2019-07-01",
          "beschikkingsStatussen": [ "beschikking_vernietigd" ]
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
      En zijn de daaruit bepaalde relevante waarden:
      """
      [
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
      Gegeven WOZ-object met objectnummer "002500024901" heeft een beschikking met ingangsdatum 01-07-2019
      En voor een andere belanghebbende is er ook een beschikking met ingangsdatum 01-07-2019
      En deze beschikking heeft als status "vernietigingbeschikking" (02)
      En WOZ-object met objectnummer "002500024901" heeft de volgende beschikkingen:
      | Peildatum  | WOZ-waarde   | Ingangsdatum | Datum beschikking | Status |
      | 01-01-2019 | 317.000 euro | 01-01-2020   | 13-01-2020        | 01     |
      | 01-01-2018 | 282.000 euro | 01-07-2019   | 04-09-2019        | 02     |
      | 01-01-2018 | 282.000 euro | 01-07-2019   | 24-07-2019        | 01     |
      | 01-01-2018 | 306.000 euro | 01-01-2019   | 14-01-2019        | 01     |
      | 01-01-2017 | 266.000 euro | 01-01-2018   | 15-01-2018        | 01     |
      Als het WOZ object wordt opgevraagd met /wozobjecten/002500024901
      Dan levert de API de volgende waarden:
      """
      [
        {
          "vastgesteldeWaarde": 317000,
          "waardepeildatum": "2019-01-01",
          "ingangsdatum": "2020-01-01",
          "beschikkingsStatussen": [ "beschikking_genomen" ]
        },{
          "vastgesteldeWaarde": 282000,
          "waardepeildatum": "2018-01-01",
          "ingangsdatum": "2019-07-01",
          "beschikkingsStatussen": [ "beschikking_vernietigd", "bezwaar_gehandhaafd" ]
        },{
          "vastgesteldeWaarde": 306000,
          "waardepeildatum": "2018-01-01",
          "ingangsdatum": "2019-01-01",
          "beschikkingsStatussen": [ "beschikking_genomen" ]
        },{
          "vastgesteldeWaarde": 266000,
          "waardepeildatum": "2017-01-01",
          "ingangsdatum": "2018-01-01",
          "beschikkingsStatussen": [ "beschikking_genomen" ]
        }
      ]
      """
      En zijn de daaruit bepaalde relevante waarden:
      """
      [
        {
          "vastgesteldeWaarde": 317000,
          "waardepeildatum": "2019-01-01"
        },
        {
          "vastgesteldeWaarde": 282000,
          "waardepeildatum": "2018-01-01"
        },
        {
          "vastgesteldeWaarde": 266000,
          "waardepeildatum": "2017-01-01"
        }
      ]
      """

    Scenario: meerdere vernietigde beschikkingen met zelfde peildatum en ingangsdatum worden genegeerd
      Gegeven WOZ-object met objectnummer "051800027395" heeft een beschikking met ingangsdatum 01-07-2019
      En voor een andere belanghebbende is er ook een beschikking met ingangsdatum 01-07-2019
      En beide beschikkingen met ingangsdatum 01-07-2019 hebben als status "vernietigingbeschikking" (02)
      En WOZ-object met objectnummer "051800027395" heeft de volgende beschikkingen:
      | Peildatum  | WOZ-waarde   | Ingangsdatum | Datum beschikking | Status |
      | 01-01-2019 | 455.000 euro | 01-01-2020   | 13-01-2020        | 01     |
      | 01-01-2018 | 440.000 euro | 01-07-2019   | 04-09-2019        | 02     |
      | 01-01-2018 | 440.000 euro | 01-07-2019   | 24-07-2019        | 02     |
      | 01-01-2018 | 430.000 euro | 01-01-2019   | 14-01-2019        | 01     |
      | 01-01-2017 | 410.000 euro | 01-01-2018   | 15-01-2018        | 01     |
      Als het WOZ object wordt opgevraagd met /wozobjecten/051800027395
      Dan levert de API de volgende waarden:
      """
      [
        {
          "vastgesteldeWaarde": 455000,
          "waardepeildatum": "2019-01-01",
          "ingangsdatum": "2020-01-01",
          "beschikkingsStatussen": [ "beschikking_genomen" ]
        },{
          "vastgesteldeWaarde": 440000,
          "waardepeildatum": "2018-01-01",
          "ingangsdatum": "2019-07-01",
          "beschikkingsStatussen": [ "beschikking_vernietigd", "beschikking_vernietigd" ]
        },{
          "vastgesteldeWaarde": 430000,
          "waardepeildatum": "2018-01-01",
          "ingangsdatum": "2019-01-01",
          "beschikkingsStatussen": [ "beschikking_genomen" ]
        },{
          "vastgesteldeWaarde": 410000,
          "waardepeildatum": "2017-01-01",
          "ingangsdatum": "2018-01-01",
          "beschikkingsStatussen": [ "beschikking_genomen" ]
        }
      ]
      """
      En zijn de daaruit bepaalde relevante waarden:
      """
      [
        {
          "vastgesteldeWaarde": 455000,
          "waardepeildatum": "2019-01-01"
        },
        {
          "vastgesteldeWaarde": 430000,
          "waardepeildatum": "2018-01-01"
        },
        {
          "vastgesteldeWaarde": 410000,
          "waardepeildatum": "2017-01-01"
        }
      ]
      """

    Abstract Scenario: indicatieBezwaarBeroep wanneer een van de statussen bezwaar, (hoger)beroep of cassatie ingesteld maar niet afgehandeld is.
      Gegeven een beschikking heeft de status "<status>" (<statuscode>)
      Als het WOZ object wordt opgevraagd
      Dan levert de API in de betreffende waarde de property "beschikkingsStatussen" met de waarde ["<status>"]
      En heeft de daaruit bepaalde relevante waarde property "indicatieBezwaarBeroep" met de waarde true

      Voorbeelden:
        | statuscode | status                   |
        | 10         | bezwaar_ingediend        |
        | 20         | beroep_aangetekend       |
        | 23         | hoger_beroep_aangetekend |
        | 30         | cassatie_ingesteld       |

    Abstract Scenario: indicatieBezwaarBeroep wordt niet opgenomen wanneer er geen bezwaar, (hoger)beroep of cassatie is ingesteld, of deze is afgehandeld.
      Gegeven een beschikking de status "<status>" (<statuscode>) heeft
      Als het WOZ object wordt opgevraagd
      Dan levert de API in de betreffende waarde de property "beschikkingsStatussen" met de waarde ["<status_enum>"]
      En bevat de daaruit bepaalde relevante waarde geen property "indicatieBezwaarBeroep"

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
      Gegeven WOZ-object met objectnummer "23280647970000" heeft de volgende beschikkingen:
      | Peildatum  | WOZ-waarde   | Ingangsdatum | Datum beschikking | Status |
      | 01-01-2019 | 437.000 euro | 01-01-2020   | 06-12-2020        | 21     |
      | 01-01-2019 | 437.000 euro | 01-01-2020   | 13-01-2020        | 20     |
      | 01-01-2018 | 392.000 euro | 01-01-2019   | 14-01-2019        | 01     |
      | 01-01-2018 | 392.000 euro | 01-01-2019   | 14-01-2019        | 23     |
      Als het WOZ object wordt opgevraagd met /wozobjecten/23280647970000
      Dan levert de API de volgende waarden:
      """
      [
        {
          "vastgesteldeWaarde": 437000,
          "waardepeildatum": "2019-01-01",
          "ingangsdatum": "2020-01-01",
          "beschikkingsStatussen": [ "beroep_gehandhaafd", "beroep_aangetekend" ]
        },{
          "vastgesteldeWaarde": 392000,
          "waardepeildatum": "2018-01-01",
          "ingangsdatum": "2019-01-01",
          "beschikkingsStatussen": [ "hoger_beroep_aangetekend", "beschikking_genomen" ]
        }
      ]
      """
      En zijn de daaruit bepaalde relevante waarden:
      """
      [
        {
          "vastgesteldeWaarde": 437000,
          "waardepeildatum": "2019-01-01",
          "indicatieBezwaarBeroep": true
        },
        {
          "vastgesteldeWaarde": 392000,
          "waardepeildatum": "2018-01-01",
          "indicatieBezwaarBeroep": true
        }
      ]
      """

    Scenario: indicatieBezwaarBeroep wanneer er bezwaar, (hoger)beroep of cassatie loopt bij niet de meest recente ingangsdatum
      Gegeven WOZ-object met objectnummer "22310827210003" heeft met ingang van 01-05-2019 een nieuwe eigenaar
      En de gemeente heeft een beschikking gestuurd naar de nieuwe eigenaar over waardepeildatum 01-01-2018 met ingangsdatum 01-05-2019
      En de vorige eigenaar heeft beroep ingediend over de WOZ-waarde op waardepeildatum 01-01-2018
      En WOZ-object met objectnummer "22310827210003" heeft de volgende beschikkingen:
      | Peildatum  | WOZ-waarde   | Ingangsdatum | Datum beschikking | Status |
      | 01-01-2018 | 215.000 euro | 01-05-2019   | 28-05-2019        | 01     |
      | 01-01-2018 | 215.000 euro | 01-01-2019   | 14-01-2019        | 20     |
      Als het WOZ object wordt opgevraagd met /wozobjecten/22310827210003
      Dan levert de API de volgende waarden:
      """
      [
        {
          "vastgesteldeWaarde": 215000,
          "waardepeildatum": "2018-01-01",
          "ingangsdatum": "2019-05-01",
          "beschikkingsStatussen": [ "beschikking_genomen" ]
        },{
          "vastgesteldeWaarde": 215000,
          "waardepeildatum": "2018-01-01",
          "ingangsdatum": "2019-01-01",
          "beschikkingsStatussen": [ "beroep_aangetekend" ]
        }
      ]
      """
      En zijn de daaruit bepaalde relevante waarden:
      """
      [
        {
          "vastgesteldeWaarde": 215000,
          "waardepeildatum": "2018-01-01"
        }
      ]
      """
