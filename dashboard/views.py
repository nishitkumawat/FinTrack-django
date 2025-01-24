from django.shortcuts import redirect, render
from userlogin import views as userLogin_views
from database import db_operations as db

currentUser = None


# Create your views here.
def dashboard(request):
    global currentUser
    db.create_connection()
    companyLogin()
    print(currentUser)
    return render(request,"dashboard.html", {
        'email':currentUser.email,
        'company_name': currentUser.company_name,
        'company_address': currentUser.company_address,
        'gst_no': currentUser.gst_no,
        'phone_no': currentUser.phone_no,
    })

def invoiceGenerate(request):

    global currentUser
    if request.method == "POST":
        
        form_type = request.POST.get('form_type')
        if form_type == 'invoice':
        
            consignee = request.POST.get("consignee")
            buyer = request.POST.get("buyer")
            invoiceNo = request.POST.get("invoiceNo")
            date = request.POST.get("date")
            deliveryNote = request.POST.get("deliveryNote")
            paymentMode = request.POST.get("paymentMode")
            dispatchDoc = request.POST.get("dispatchDoc")
            deliveryNoteDate = request.POST.get("deliveryNoteDate")
            dispatchedThrough = request.POST.get("dispatchedThrough")
            destination = request.POST.get("destination")

            print(consignee,buyer,invoiceNo,date,deliveryNote,paymentMode,dispatchDoc,deliveryNoteDate,dispatchedThrough,destination)

    return render(request,'invoicegenerate.html',{'a':12222,'b':'dww'})


def companyLogin():
    global currentUser
    username = userLogin_views.username
    password = userLogin_views.password
    email = userLogin_views.email
    
    listOfUsername = db.listOfUsername()
    if username in listOfUsername:
        currentUser = db.login(username=username,password=password)
    else:
        companyRegister(username,email,password)
    print(currentUser)
    
def companyRegister(username,email,password):
    global currentUser
    currentUser =  db.register(username,email,password,"","","","")

def companyDetails(request):
    global currentUser
    print('companyDetails')
    if request.method == 'POST':
        print('post')
        form_type = request.POST.get('form_type')
        if form_type == 'companyupdate':
            print('in')
            # username = request.POST.get("username")
            email = request.POST.get("email")
            company_name = request.POST.get("company_name")
            company_address = request.POST.get("company_address")
            phone_no = request.POST.get("phone_no")
            gst_no = request.POST.get("gst_no")
            
            print(email,company_address,company_name)
            
            currentUser.email = email
            currentUser.company_name = company_name
            currentUser.company_address = company_address
            currentUser.phone_no = phone_no
            currentUser.gst_no = gst_no
            
            d = {'username':currentUser.username,'email':email,'company_name':company_name,'company_address':company_address,'phone_no':phone_no,'gst_no':gst_no}
            
            db.updateCompanyDetails(d)
            return render(request,"dashboard.html", { 'email':email,'company_name':company_name,'company_address': company_address, 'gst_no': gst_no,'phone_no':phone_no,})    
    return render(request,"companyDetails.html")