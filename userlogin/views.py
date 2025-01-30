from django.shortcuts import render,redirect
from django.contrib.auth import logout,authenticate,login
from django.contrib.auth.models import User
from django.contrib import messages

username = ''
password = ''
email = ''
# Create your views here.
def loginUser(request):
    global username,password
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        user = authenticate(request, username=username, password=password)
        print(user)
        if user is not None:
            print(username)
            login(request, user)
            return redirect('dashboard')
        else:
            messages.error(request, 'Invalid username or password.')
    return render(request, 'login.html')

        

def signupUser(request):
    global username,password,email
    if request.method == "POST":
        email = request.POST.get('signup-email')
        name = request.POST.get('signup-fullname')
        password = request.POST.get('signup-password')
        confirm_password = request.POST.get('signup-confirm-password')
        
        if password != confirm_password:
            messages.error(request, "Passwords do not match.")
            return render(request, 'signup.html')

        # Check if username or email already exists
        if User.objects.filter(username=name).exists():
            messages.error(request, "Username already taken.")
            return render(request, 'signup.html')
        
        if User.objects.filter(email=email).exists():
            messages.error(request, "Email already in use.")
            return render(request, 'signup.html')

        # Create new user
        try:
            user = User.objects.create_user(username=name, email=email, password=password)
            user.save()
            messages.success(request, "Signup successful! Please log in.")
            print('sign up')
            return redirect(request,'login.html')  # Redirect to the login page
        except Exception as e:
            messages.error(request, f"An error occurred: {str(e)}")
            return redirect('login')
    
    return render(request, 'signup.html')

        
def logoutUser(request):
    logout(request)
    return redirect(request,"login.html")