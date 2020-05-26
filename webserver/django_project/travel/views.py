from django.shortcuts import render

# Create your views here.


from django.http import HttpResponse

from django.template import Context, loader



def index(request):
    print('HTTP request is received')
    print('request.META')
    return render(request, 'index.html')
