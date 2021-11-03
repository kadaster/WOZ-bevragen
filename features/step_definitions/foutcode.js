const { World } = require('./world')
const { Given, When, Then, setWorldConstructor } = require('@cucumber/cucumber');
const axios = require('axios');
const should = require('chai').should();

setWorldConstructor(World);

When('{string} zonder X-API-Key header wordt aangeroepen', async function (path) {       
    const config = {
        method: 'get',
        url: `${this.context["baseurl"]}${path}`
    };

    try {
        this.context["response"] = await axios(config);
    }
    catch(e) {
        this.context["exception"] = e;
    }
});

When('{string} met lege X-API-Key header wordt aangeroepen', async function (path) {       
    const config = {
        method: 'get',
        url: `${this.context["baseurl"]}${path}`,
        headers: { 
          'X-API-KEY': ''
        }
    };

    try {
        this.context["response"] = await axios(config);
    }
    catch(e) {
        this.context["exception"] = e;
    }
});
