from django.shortcuts import render,redirect
from django.contrib.auth.models import User

def homepage(request):
  # if request.user.is_anonymous:
  #   return redirect("login.html")
  return render(request,'home.html')