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

||||000500055044|800000051111|800000093455|000500055046|000500030828|000500030843|800000200021|800000200022|000500000001|
|--- |--- |--- |--- |--- |--- |--- |--- |--- |--- |--- |--- |
|aanduiding{}|||X|X|X|X|X|X|X|X|X|
||huisletter|||X|||X|X|||X|
||huisnummer||X|X|X|X|X|X|X|X|X|
||huisnummertoevoeging|||X|||X|X|X|X|X|
||postcode||X|X|X|X|X|X|X|X|X|
||straat||X|X|X|X|X|X|X|X|X|
||woonplaats||X|X|X|X|X|X|X|X|X|
||locatieomschrijving||||||X|X||||
||nummeraanduidingIdentificatie||X|X|X|X|X|X|X|X|X|
|adresseerbaarObjectIdentificaties[]|||1|1|1|1|1|1|||1|
|belanghebbendeEigenaar{}|||X|X|X|X|X|X|X|X|X|
||burgerservicenummer||X||X|X|||||X|
||geheimhoudingPersoonsgegevens(?)||True||False|True|||||True|
||kvkNummer||||||X|X||||
||naam||X|X|X|X|X|X|X|X|X|
||rsin|||X|||X||X|X||
||type()||natuurlijk_persoon|niet_natuurlijk_persoon|natuurlijk_persoon|natuurlijk_persoon|niet_natuurlijk_persoon|vestiging|niet_natuurlijk_persoon|niet_natuurlijk_persoon|natuurlijk_persoon|
||vestigingsnummer|||||||X||||
|belanghebbendeGebruiker{}||||X||X|X|X||||
||burgerservicenummer|||||X|X|X||||
||geheimhoudingPersoonsgegevens(?)|||||True|True|True||||
||kvkNummer|||||||||||
||naam|||X||X|X|X||||
||rsin|||X||||||||
||type()|||niet_natuurlijk_persoon||natuurlijk_persoon|natuurlijk_persoon|natuurlijk_persoon||||
||vestigingsnummer|||||||||||
|grondoppervlakte|||X|X|X|X|X|X|X|X||
|identificatie|||X|X|X|X|X|X|X|X|X|
|kadastraalOnroerendeZaakIdentificaties[]||||3|1|1|1|1|1|1|12|
|pandIdentificaties[]||||3|1|1|1|1|||11|
|verantwoordelijkeGemeente{}|||X|X|X|X|X|X|X|X|X|
|waarden[{}]|||1|||5|3|2|||1|
||beschikkingsStatussen[{}]||1|||1|1|1|||1|
||ingangsdatum||X|||X|X|X|||X|
||vastgesteldeWaarde||X|||X|X|X|||X|
||waardepeildatum||X|||X|X|X|||X|
|_links{}|||X|X|X|X|X|X|X|X|X|
||adres{}|||||||||||
||adresseerbaarObjecten[]|||||||||||
||belanghebbendeEigenaar{}|||||||||||
||belanghebbendeGebruiker{}|||||||||||
||panden[]|||||||||||
||self{}||X|X|X|X|X|X|X|X|X|
