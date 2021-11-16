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

||||800000051111|800000093455|800000200021|800000200022|800000014669|800000003118|800000823525|800012345678|
|--- |--- |--- |--- |--- |--- |--- |--- |--- |--- |--- |
|aanduiding{}|||X|X|X|X|X|X|X|X|
||huisletter||||||||||
||huisnummer||X|X|X|X|X|X|X|X|
||huisnummertoevoeging||||X|X|||||
||postcode||X|X|X|X|X|X|X|X|
||straat||X|X|X|X|X|X|X|X|
||woonplaats||X|X|X|X|X|X|X|X|
||locatieomschrijving||||||||||
||nummeraanduidingIdentificatie||X|X|X|X|X|X|X|X|
|adresseerbaarObjectIdentificaties[]|||1|1|||1|1|1|3|
|belanghebbendeEigenaar{}|||X|X|X|X|X|X|X||
||burgerservicenummer|||X|||X|X|||
||geheimhoudingPersoonsgegevens(?)||||||||||
||kvkNummer||||||||X||
||naam||X|X|X|X|X|X|X||
||rsin||X||X|X|||||
||type()||niet_natuurlijk_persoon|natuurlijk_persoon|niet_natuurlijk_persoon|niet_natuurlijk_persoon|natuurlijk_persoon|natuurlijk_persoon|vestiging||
||vestigingsnummer||||||||X||
|belanghebbendeGebruiker{}|||X||||||||
||burgerservicenummer||||||||||
||geheimhoudingPersoonsgegevens(?)||||||||||
||kvkNummer||||||||||
||naam||X||||||||
||rsin||X||||||||
||type()||niet_natuurlijk_persoon||||||||
||vestigingsnummer||||||||||
|grondoppervlakte|||X|X|X|X|X|X|X|X|
|identificatie|||X|X|X|X|X|X|X|X|
|kadastraalOnroerendeZaken[{}]|||3|1|1|1|1|1|1|1|
||aanduiding{}||X|X|X|X|X|X|X|X|
|||appartementsindex|||||||||
|||deelperceelnummer|||X|X|||||
|||gemeentecode|X|X|X|X|X|X|X|X|
|||perceelnummer|X|X|X|X|X|X|X|X|
|||sectie|X|X|X|X|X|X|X|X|
||aanduidingMetGemeentenaam||||||||||
||identificatie||X|X|X|X|X|X|X|X|
|pandIdentificaties[]|||3|1|||||||
|verantwoordelijkeGemeente(*)|||Test Gemeente 8000|Test Gemeente 8000|Test Gemeente 8000|Test Gemeente 8000|Test Gemeente 8000|Test Gemeente 8000|Test Gemeente 8000|Test Gemeente 8000|
|waarden[{}]|||4||||4|5|6||
||beschikkingsStatussen[{}]||1||||1|1|1||
||ingangsdatum||X||||X|X|X||
||vastgesteldeWaarde||X||||X|X|X||
||waardepeildatum||X||||X|X|X||
|_links{}|||X|X|X|X|X|X|X|X|
||adres{}||X|X|X|X|X|X|X|X|
||adresseerbareObjecten[]||1|1|||1|1|1|1|
||belanghebbendeEigenaar{}|||X|||X|X|||
||belanghebbendeGebruiker{}||||||||||
||kadastraalOnroerendeZaken[]||1|1|1|1|1|1|1|1|
||panden[]||1|1|||||||
||self{}||X|X|X|X|X|X|X|X|
