##################################################
# user/urls.py
# SCAuthExample
#
# Created by Saikat Chakrabarti on April 7, 2010.
#
# See LICENSE file for license information.
##################################################

from django.conf.urls.defaults import *

urlpatterns = patterns('SCAuthExample.user.views',
                       (r'^(?P<username>.*)$', 'user_request'),
		       )		       
