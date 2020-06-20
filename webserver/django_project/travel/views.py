from django.shortcuts import render

# Create your views here.


from django.http import HttpResponse

from django.template import Context, loader



def index(request):
    print('HTTP API travel')
    print('request.META')
    return render(request, 'index.html')

def healthcheck(request):
    print('HTTP API healthcheck')
    print('request.META')
    return HttpResponse("I am healthy!!!")
