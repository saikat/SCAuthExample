Introduction
============

SCAuthExample is an example of the SCAuth library for Cappuccino.  Go to [http://github.com/saikat/SCAuth](http://github.com/saikat/SCAuth) to learn about SCAuth.

Running the example
===================

You will need to first install [Django](http://www.djangoproject.com) on your machine.  Then, copy over your built Cappuccino frameworks and SCAuth into SCAuthExample/Frameworks.  Once you do this, cd to SCAuthExample in a terminal and run `python manage.py runserver`.  The example will be accessible at http://localhost:8000/index.html.

The example is fairly contrived (there isn't an actual database with actual users running on the backend).  Clicking the Login button displays the login panel.  Trying to register will always return a 409, and entering any username/password combination other than demo/demo will return a 403.  Additionally, it isn't actually using browser sessions.  Once you log in, you will remain "logged in" until you log out using the button in the app or restart the backend (Ctrl-C in the terminal, then run `python manage.py runserver` again).  Clicking the button that says "Do something that requires authentication" makes a request to the backend that returns a 401 if you are not logged in, prompting a login dialog to occur.
