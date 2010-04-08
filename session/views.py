##################################################
# session/views.py
# SCAuthExample
#
# Created by Saikat Chakrabarti on April 7, 2010.
#
# See LICENSE file for license information.
##################################################

from django.http import HttpResponseNotAllowed, HttpResponseNotFound, HttpResponse, HttpResponseForbidden
from django.utils import simplejson
from SCAuthExample import settings

def session_request(request):
    request_method = request.META['REQUEST_METHOD'];
    if (request_method ==  'POST'):
        return login_user(request)
    if (request_method == 'DELETE'):
        return logout_user(request)
    elif (request_method == 'GET' or request_method == 'HEAD'):
        return is_logged_in(request)
    else:
        return HttpResponseNotAllowed(['POST', 'GET', 'DELETE'])

def logout_user(request):
    settings.CURRENT_SESSION = None
    return HttpResponse('', mimetype='application/json')

def login_user(request):
    jsonObj = simplejson.loads(request.raw_post_data)
    username = jsonObj['username']
    password = jsonObj['password']
    if username == 'demo' and password == 'demo':
        settings.CURRENT_SESSION = username
        print settings.CURRENT_SESSION
        return HttpResponse('', mimetype='application/json')
    return HttpResponseForbidden('', mimetype = 'application/json')

def is_logged_in(request):
    return HttpResponseNotFound('', mimetype = 'application/json')
