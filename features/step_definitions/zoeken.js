const { World } = require('./world');
const { Given, When, Then, setWorldConstructor } = require('@cucumber/cucumber');
const axios = require('axios');
const should = require('chai').should();

setWorldConstructor(World);

Given('de LV WOZ kent een WOZ-object met objectnummer {string}', function (string) {
});

Given('in de LV WOZ is dit WOZ-object verbonden met adresseerbare objecten {string}, {string} en {string}', function (string, string2, string3) {
});

Given('de aanduiding WOZ-object heeft postcode {string} en huisnummer {int} en huisletter {string} en huisnummertoevoeging {string}', function (string, int, string2, string3) {
});

Given('de aanduiding WOZ-object heeft nummeraanduidingIdentificatie {string}', function (string) {
});

Given('de LV WOZ kent GEEN WOZ-object verbonden met een adresseerbaar object met identificatie {string}', function (string) {
});

Given('de LV WOZ kent GEEN WOZ-object met aanduiding met postcode {string} en huisnummer {int}', function (string, int) {
});

Given('de LV WOZ kent GEEN WOZ-object met belanghebbendeEigenaar.rsin {string}', function (string) {
});

When('ik een WOZ-object zoek met {string}', async function (path) {
    const config = {
        method: 'get',
        url: `${this.context["baseurl"]}${path}`,
        headers: { 
          'X-API-KEY': this.context["apikey"]
        }
    };

    try {
        this.context["response"] = await axios(config);
    }
    catch(e) {
        this.context["exception"] = e;
    }
});

Then('bevat het antwoord het WOZ-object met identificatie {string}', function (expected) {
    const data = this.context["response"].data;
    const wozObject = data._embedded.wozObjecten[0];

    wozObject.identificatie.should.equal(expected, JSON.stringify(wozObject, null, "\t"));
});

Then('heeft het antwoord http-statuscode {string}', function (expected) {
    const response = this.context["response"];

    response.status.should.equal(Number(expected), response);
});

Then('bevat het antwoord header {string} met waarde {string}', function (key, value) {
    const response = this.context["response"];

    response.headers[key].should.equal(value, response.headers);
});

Then('is de _embedded property van het antwoord leeg', function () {
    const data = this.context["response"].data;

    JSON.stringify(data._embedded).should.equal("{}", JSON.stringify(data, null, "\t"));
});

Then('is de _links.self property gelijk aan {string}', function (expected) {
    const data = this.context["response"].data;

    data._links.self.href.should.equal(expected, data._links.self);
});

Then('is het antwoord gelijk aan:', function (docString) {
    const data = this.context["response"].data;

    JSON.stringify(data, null, 2).should.equal(docString);
});
