liprug: simple status board
----------------------------

![liprug](http://i.imgur.com/kusLR6U.png)

The idea behind liprug is to give you a simple tool
to communicate your operational status to clients.

The main objectives behind liprug were:

* Simple deployment compatible with heroku and AWS
* All-in-one solution
* Simple administration

### Deployment

You can deploy to heroku or any host provider. It is advised to set up liprug to operate
behind SSL only.

### Configuration

Configuration is done through environment variables, here are the relevant ones:

* `REDIS_URL` or `REDISTOGO_URL`: url of redis host for storage
* `LIPRUG_BRAND_HEADER`: text you want shown on the header bar
* `LIPRUG_BRAND_CONTACT`: if present, a "report issue" button will show up in the bar, with this value as href
* `LIPRUG_CREDENTIALS`: colon separated user and password

### Usage

The main URL shows current service status, the `/admin` URL allows input and modifications

### Roadmap

* Additional authentication methods to admin interface
* Per-service history
* Typed service data to allow graphs

### Authors

liprug is a production of [exoscale](https://exoscale.ch)
