from django.shortcuts import render
from django.conf import settings
from redis import Redis

from .models import Food

redis = Redis(host=settings.REDIS_HOST, port=settings.REDIS_PORT)

# Create your views here.
def homepage(request):
    food = Food.objects.all()
    count = redis.incr('hits')
    context = {'count': count, 'food': food}
    return render(request, 'app/home.html', context)
    
