Sinatra facebook skeleton app
=============================

Roughly based off of Heroku's starter facebook app for Sinatra.  Using Omniauth: [https://github.com/intridea]/omniauth to handle authorization using OAuth and Koala: [https://github.com/arsduo/koala] for facebook Graph API communication.

The app has been set up to use pow: [http://pow.cx/] to test locally although you can also start up the application using foreman.

Version
-
1.0-beta

Usage:
-
1. Create an app on facebook.
2. Paste Secret Key and app id in .env in application root.
3. Run bundler install from app root to get dependencies.
3. Start up application using foreman or pow.
4. Navigate to /login
5. Nom Nom Nom

Extra: 
-
This app is running on Heroku, visit [http://rocky-lowlands-9965.herokuapp.com/login]

Follow me at @nullhappens: [https://twitter.com/nullhappens]
