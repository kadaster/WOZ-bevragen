class World {
    constructor({ attach, log, parameters }) {
        this.context = {
            "baseurl": "https://api.kadaster.nl/lvwoz-eto-apikey/api/v1",
            "apikey": "woz-api-key"
        };
    }
}

module.exports = {World}