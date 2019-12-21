from django.shortcuts import render

# Create your views here.

from django.http import HttpResponse
from django.template import loader,Context


def index(request):
    print('index')
    t = loader.get_template("index.html")
    return HttpResponse(t.render())

def commands(request):
    print('commands')