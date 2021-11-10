## **Versie 1.0.0:**

### known issues:

Deze API is in productie genomen met een aantal bekende (non-breaking) issues die op de backlog van het ontwikkelteam zijn geplaatst :
  - Paginering: Eerste pagina zou geen `first` link moeten hebben & Laatste pagina zou geen `last` link moeten hebben
  - Foutmeldingen: `unsupportedCombi` bij geen parameters meegegeven zou `paramsRequired` moeten zijn
  - HAL Links: KadastraalOnroerendeZaken link niet tonen als er geen kadastraal onroerende zaken met een identificatie in de source zitten & geen templated: true
  Deze zullen we in beheerfase oplossen zodra adaptieve wijzigingen kunnen worden opgepakt
