# Testgevallen

Hier staan per operatie de beschikbare testgevallen waarbij per property is aangegeven of het testgeval hierop een waarde heeft.

De bovenste rij van elke tabel bevat de identificaties van de test-resources.
De linker kolom(men) bevatten de namen van properties van de resource.
Aan het einde van een propertynaam toegevoegde
- "{}" betekent dat dit property een object (gegevensgroep) is.
- "[]" betekent dat dit property een array is.
- "[{}]" betekent dat dit property een array van objecten is.
- "()" betekent dat dit property een enumeratie is.

Bij een testgeval betekent
- "X" dat dit testgeval een waarde heeft voor het betreffende gegeven.
- Een getal dat het aantal items van het gegeven het testgeval heeft.
- Tekst dat dit de enumeratiewaarde is van het gegeven bij dit testgeval.

**Operaties:**

- [raadpleegActueelWozobject](#raadpleegActueelWozobject)

## raadpleegActueelWozobject

||||000500055044|800000051111|800000093455|000500055046|800000200021|800000200022|000500000001|800000014669|800000003118|800000823525|800012345678|800000024029|800000027395|800000024901|800047970000|800027210003|
|--- |--- |--- |--- |--- |--- |--- |--- |--- |--- |--- |--- |--- |--- |--- |--- |--- |--- |--- |
|aanduiding{}|||X|X|X|X|X|X|X|X|X|X|X|X|X|X|X|X|
||huisletter|||X|||||X|||||X|X|X|X|X|
||huisnummer||X|X|X|X|X|X|X|X|X|X|X|X|X|X|X|X|
||huisnummertoevoeging|||X|||X|X|X|||||X|X|X|X|X|
||postcode||X|X|X|X|X|X|X|X|X|X|X|X|X|X|X|X|
||straat||X|X|X|X|X|X|X|X|X|X|X|X|X|X|X|X|
||woonplaats||X|X|X|X|X|X|X|X|X|X|X|X|X|X|X|X|
||locatieomschrijving|||||||||||||X|X|X|X|X|
||nummeraanduidingIdentificatie||X|X|X|X|X|X|X|X|X|X|X|X|X|X|X|X|
|adresseerbaarObjectIdentificaties[]|||1|1|1|1|||1|1|1|1|3|1|1|1|1|1|
|belanghebbendeEigenaar{}|||X|X|X|X|X|X|X|X|X|X||X|X|X|X|X|
||burgerservicenummer||X||X|X|||X|X|X|||X|X|X|X|X|
||geheimhoudingPersoonsgegevens(?)||True|||True|||True||||||||||
||kvkNummer|||||||||||X|||||||
||naam||X|X|X|X|X|X|X|X|X|X||X|X|X|X|X|
||rsin|||X|||X|X|||||||||||
||type()||natuurlijk_persoon|niet_natuurlijk_persoon|natuurlijk_persoon|natuurlijk_persoon|niet_natuurlijk_persoon|niet_natuurlijk_persoon|natuurlijk_persoon|natuurlijk_persoon|natuurlijk_persoon|vestiging||natuurlijk_persoon|natuurlijk_persoon|natuurlijk_persoon|natuurlijk_persoon|natuurlijk_persoon|
||vestigingsnummer|||||||||||X|||||||
|belanghebbendeGebruiker{}||||X||X|||||||||||||
||burgerservicenummer|||||X|||||||||||||
||geheimhoudingPersoonsgegevens(?)|||||True|||||||||||||
||kvkNummer||||||||||||||||||
||naam|||X||X|||||||||||||
||rsin|||X|||||||||||||||
||type()|||niet_natuurlijk_persoon||natuurlijk_persoon|||||||||||||
||vestigingsnummer||||||||||||||||||
|grondoppervlakte|||X|X|X|X|X|X||X|X|X|X|X|X|X|X|X|
|identificatie|||X|X|X|X|X|X|X|X|X|X|X|X|X|X|X|X|
|kadastraalOnroerendeZaakIdentificaties[]|||||||||||||||||||
|pandIdentificaties[]||||3|1|1|||10|||||1|1|1|1|1|
|verantwoordelijkeGemeente(*)|||Bedum|Test Gemeente 8000|Test Gemeente 8000|Bedum|Test Gemeente 8000|Test Gemeente 8000|Bedum|Test Gemeente 8000|Test Gemeente 8000|Test Gemeente 8000|Test Gemeente 8000|Test Gemeente 8000|Test Gemeente 8000|Test Gemeente 8000|Test Gemeente 8000|Test Gemeente 8000|
|waarden[{}]|||1|4||5|||1|4|5|6||4|4|4|2|2|
||beschikkingsStatussen[{}]||1|1||1|||1|1|1|1||1|1|1|2|1|
||ingangsdatum||X|X||X|||X|X|X|X||X|X|X|X|X|
||vastgesteldeWaarde||X|X||X|||X|X|X|X||X|X|X|X|X|
||waardepeildatum||X|X||X|||X|X|X|X||X|X|X|X|X|
|_links{}|||X|X|X|X|X|X|X|X|X|X|X|X|X|X|X|X|
||adres{}||X|X|X|X|X|X|X|X|X|X|X|X|X|X|X|X|
||adresseerbareObjecten[]||||||||||||||||||
||belanghebbendeEigenaar{}||X||X|X|||X|X|X|||X|X|X|X|X|
||belanghebbendeGebruiker{}|||||X|||||||||||||
||kadastraalOnroerendeZaken[]||1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|1|
||panden[]|||1|1|1|||1|||||1|1|1|1|1|
||self{}||X|X|X|X|X|X|X|X|X|X|X|X|X|X|X|X|
