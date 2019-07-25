from django.shortcuts import render
from django.conf import settings
from redis import Redis

redis = Redis(host=settings.REDIS_HOST, port=settings.REDIS_PORT)

# Create your views here.
def homepage(request):
    count = redis.incr('hits')
    context = {'count': count}
    return render(request, 'app/home.html', context)
    
