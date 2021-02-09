# language: nl

Feature: Als gebruiker wil ik de naam zien van de geleverde belanghebbende
  In belanghebbendeEigenaar en belanghebbendeGebruiker wordt de naam geleverd.
  Een belanghebbende kan een natuurlijk persoon zijn, een niet-natuurlijk persoon of een vestiging.

  Scenario: de naam van een natuurlijk persoon is de voorletters, voorvoegsel en geslachtsnaam
    Gegeven de belanghebbendeEigenaar van het WOZ object met identificatie "002500003118" is de natuurlijk persoon met burgerservicenummer "999991234"
    En deze persoon heeft als voorletters "A.B.C."
    En deze persoon heeft als voorvoegsel geslachtsnaam "in het"
    En deze persoon heeft als geslachtsnaam "Veld"
    Als het WOZ object wordt opgevraagd met /wozobjecten/002500003118
    Dan bevat het antwoord:
    """
    "belanghebbendeEigenaar": {
         "burgerservicenummer": "999991234",
         "naam": "A.B.C. in het Veld",
         "type": "natuurlijk_persoon"
    }
    """

  Scenario: de naam van een natuurlijk persoon zonder voorvoegsel in de naam
    Gegeven de belanghebbendeEigenaar van het WOZ object met identificatie "082600014669" is de natuurlijk persoon met burgerservicenummer "999995678"
    En deze persoon heeft als voorletters "D."
    En deze persoon heeft geen waarde voor voorvoegsel geslachtsnaam
    En deze persoon heeft als geslachtsnaam "Groenen"
    Als het WOZ object wordt opgevraagd met /wozobjecten/082600014669
    Dan bevat het antwoord:
    """
    "belanghebbendeEigenaar": {
         "burgerservicenummer": "999995678",
         "naam": "D. Groenen",
         "type": "natuurlijk_persoon"
    }
    """

  Scenario: de naam van een niet-natuurlijk persoon is de statutaire naam
    Gegeven de belanghebbendeEigenaar van het WOZ object met identificatie "050300024029" is de niet-natuurlijk persoon met rsin "858311537"
    En deze niet-natuurlijk persoon heeft als statutaire naam "Test Stichting Bolderbast"
    Als het WOZ object wordt opgevraagd met /wozobjecten/050300024029
    Dan bevat het antwoord:
    """
    "belanghebbendeEigenaar": {
         "rsin": "858311537",
         "kvkNummer": "69599068",
         "naam": "Test Stichting Bolderbast",
         "type": "niet_natuurlijk_persoon"
    }
    """

  Scenario: de naam van een vestiging is de handelsnaam
    Gegeven de belanghebbendeEigenaar van het WOZ object met identificatie "051800823525" is de vestiging met vestigingsnummer "000037143557"
    En deze vestiging heeft als handelsnaam "Test NV Katrien"
    Als het WOZ object wordt opgevraagd met /wozobjecten/050300024029
    Dan bevat het antwoord:
    """
    "belanghebbendeEigenaar": {
         "vestigingsnummer": "000037143557",
         "kvkNummer": "68727720",
         "naam": "Test NV Katrien",
         "type": "vestiging"
    }
    """
