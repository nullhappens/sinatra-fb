Sinatra facebook skeleton app, roughly based off of Heroku's starter
facebook app.  Using Omniauth (https://github.com/intridea/omniauth) to
handle authorization using OAuth and Koala (https://github.com/arsduo/koala)
for facebook Graph API communication.

The app has been set up to use pow (http://pow.cx/) to test locally
although you can also start up the application using foreman using thin.


Usage:

1. Create an app on facebook 
2. Paste Secret Key and app id in .env in application root
3. Start up application using foreman or pow

