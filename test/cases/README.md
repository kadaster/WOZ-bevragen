# Testgevallen

Hier staan per operatie de beschikbare testgevallen waarbij per property is aangegeven of het testgeval hierop een waarde heeft.

De bovenste rij van elke tabel bevat de identificaties van de test-resources.
De linker kolom(men) bevatten de namen van properties van de resource.

Bij een testgeval betekent
- "X" dat dit testgeval een waarde heeft voor het betreffende gegeven.
- Een getal dat het aantal items van het gegeven in het testgeval bevat.
- Tekst dat dit de enumeratiewaarde is van het gegeven bij dit testgeval.

**Operaties:**

- [raadpleegActueelWozobject](#raadpleegActueelWozobject)

## raadpleegActueelWozobject

||||000500055044|800000051111|800000093455|
|--- |--- |--- |--- |--- |--- |
|aanduiding{}|||X|X|X|
||huisletter|||X||
||huisnummer||X|X|X|
||huisnummertoevoeging|||X||
||postcode||X|X|X|
||straat||X|X|X|
||woonplaats||X|X|X|
||locatieomschrijving|||||
||nummeraanduidingIdentificatie||X|X|X|
|adresseerbaarObjectIdentificaties[]|||1|1|1|
|belanghebbendeEigenaar{}|||X|X|X|
||burgerservicenummer||X||X|
||geheimhoudingPersoonsgegevens(?)||False|False|False|
||kvkNummer|||||
||naam||X|X|X|
||rsin|||X||
||type()||natuurlijk_persoon|niet_natuurlijk_persoon|natuurlijk_persoon|
||vestigingsnummer|||||
|belanghebbendeGebruiker{}||||X||
||burgerservicenummer|||||
||geheimhoudingPersoonsgegevens(?)|||False||
||kvkNummer|||||
||naam|||X||
||rsin|||X||
||type()|||niet_natuurlijk_persoon||
||vestigingsnummer|||||
|grondoppervlakte|||X|X|X|
|identificatie|||X|X|X|
|kadastraalOnroerendeZaakIdentificaties[]|||0|3|1|
|pandIdentificaties[]|||0|3|1|
|verantwoordelijkeGemeente{}|||X|X|X|
|waarden[{}]||||||
||beschikkingsStatussen[{}]|||||
||ingangsdatum|||||
||vastgesteldeWaarde|||||
||waardepeildatum|||||
|_links{}|||X|X|X|
||adres{}|||||
||adresseerbaarObjecten[]|||||
||belanghebbendeEigenaar{}|||||
||belanghebbendeGebruiker{}|||||
||panden[]|||||
||self{}||X|X|X|
