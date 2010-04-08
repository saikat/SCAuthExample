##################################################
# urls.py
# SCAuthExample
#
# Created by Saikat Chakrabarti on April 7, 2010.
#
# See LICENSE file for license information.
##################################################

from django.conf.urls.defaults import *

# Uncomment the next two lines to enable the admin:
# from django.contrib import admin
# admin.autodiscover()

urlpatterns = patterns('',
                       (r'^user/', include('SCAuthExample.user.urls')),
                       (r'^session/', include('SCAuthExample.session.urls')),
                       (r'^(?P<path>.*)$', 'django.views.static.serve', {'document_root': 'frontend/'}),
                       )
