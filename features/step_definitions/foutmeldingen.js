const { World } = require('./world')
const { Given, When, Then, setWorldConstructor } = require('@cucumber/cucumber');
const axios = require('axios');
const should = require('chai').should();

setWorldConstructor(World);

When('{string} wordt aangeroepen', async function (path) {
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

Then('bevat de response de volgende kenmerken', function (dataTable) {
    let data = this.context["exception"].response.data;

    dataTable.rawTable.forEach(function(value, index) {
        if(index > 0) {
            const actual = '' + data[value[0]];
            const expected = value[1];

            actual.should.equal(expected, JSON.stringify(data, null, "\t"));
        }
    });
});

Then('bevat de response geen invalidParams', function () {
    let data = this.context["exception"].response.data;
    let invalidParams = data.invalidParams;

    should.not.exist(invalidParams, JSON.stringify(data, null, "\t"));
});

Then('bevat de response de volgende invalidParams', function (dataTable) {
    let data = this.context["exception"].response.data;
    let invalidParams = data.invalidParams;

    should.exist(invalidParams, JSON.stringify(data, null, "\t"));

    dataTable.rawTable.forEach(function(value, index) {
        if(index > 0) {
            const expected = value;
            let actual = invalidParams.find(function(value) {
                return value["name"] = expected[0];
            });
            actual.should.not.be.null;
            actual.reason.should.equal(expected[1], JSON.stringify(data, null, "\t"));
        }
    });
});
