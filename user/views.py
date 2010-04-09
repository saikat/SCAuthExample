##################################################
# user/views.py
# SCAuthExample
#
# Created by Saikat Chakrabarti on April 7, 2010.
#
# See LICENSE file for license information.
##################################################

from django.http import HttpResponseNotAllowed, HttpResponseBadRequest, HttpResponseNotFound, HttpResponse, HttpResponseForbidden
from SCAuthExample import settings

def user_request(request, username):
    request_method = request.META['REQUEST_METHOD'];
    if (request_method ==  'POST'):
        return register_user(request);
    elif (request_method == 'GET' or request_method == 'HEAD'):
        return get_user(username);
    elif(request_method == 'PUT'):
        return update_user(request)
    return HttpResponseNotAllowed(['POST', 'GET', 'PUT'])

def register_user(request):
    return HttpResponseBadRequest('', mimetype = 'application/json', status = 409)

def get_user(username):
    if username == 'demo':
        return HttpResponse('', mimetype='application/json')
    return HttpResponseNotFound('', mimetype = 'application/json')

def update_user(username):
    if settings.CURRENT_SESSION:
        return HttpResponse('', mimetype='application/json')
    return HttpResponseBadRequest('', mimetype = 'application/json', status = 401)
