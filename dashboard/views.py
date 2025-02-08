import json
from django.http import HttpResponse, JsonResponse
from django.shortcuts import redirect, render
from userlogin import views as userLogin_views
from database import db_operations as db
from django.views.decorators.csrf import csrf_exempt
import os
from django.template.loader import render_to_string
import weasyprint
from num2words import num2words

currentUser = None
d = None
dashboardDict = None

# Create your views here.
def dashboard(request):
    global currentUser,dashboardDict
    db.create_connection()
    companyLogin()
    inventory = db.inventory(currentUser.company_id)
    dashboardDict = {
        'email':currentUser.email,
        'company_name': currentUser.company_name,
        'company_address': currentUser.company_address,
        'gst_no': currentUser.gst_no,
        'phone_no': currentUser.phone_no,
        'inventory':inventory,
        'invoice_no' : db.newInvoiceNo(currentUser.company_id),
        
    }
    
    currentUser.turnover = db.calculateTurnOver(currentUser.company_id)
    print(currentUser.turnover)
    inv = db.calculateInventory(currentUser.company_id)
    print(inv)
    return render(request,"dashboard.html",dashboardDict )

def invoiceGenerate(request):
    global currentUser,d
    if request.method == "POST":
        # form_type = request.POST.get('form_type')
        # if form_type == 'invoice':
            
            billerName = request.POST.get("billerName")
            billerAddress= request.POST.get("billerAddress")
            billerPhoneNo= request.POST.get("billerPhone")
            
            invoiceNo =  db.newInvoiceNo(currentUser.company_id)
            date = request.POST.get("date")
            paymentMode = request.POST.get("paymentMode")
            
            
            billerGstNo= request.POST.get("billerGst")
            buyerOrderNo = request.POST.get("buyerOrderNo")
            eWayBillNumber = request.POST.get("eWayBillNumber")
            eWayBillDate = request.POST.get("eWayBillDate")
            billOfLading = request.POST.get("billOfLading")
            motorVechileNumber = request.POST.get("motorVechileNumber")
            refNo = request.POST.get("refNo")
            otherRef = request.POST.get("otherRef")
            
            
            
            binvoice = request.POST.get("binvoices")
            
            selected_items = request.POST.get("selectedItems")
            itemsList = eval(f"{selected_items}")
           
            tax_input1 = request.POST.get("taxInput")
            tax_input = eval(f"{tax_input1}")
            
            sgst = tax_input[0]
            cgst = tax_input[1]
            igst = tax_input[2]
            totalPrice = 0
            
            
            print("invoice handled")
            print(selected_items)  
            print(tax_input)
            print(sgst,cgst,igst)
            decQuantity(eval(f'{selected_items}'))
            
            for i in itemsList:
                totalPrice += float(i['totalPrice'])
                
            totalPrice = round(totalPrice,2)
                
            tax = [sgst*totalPrice/100,cgst*totalPrice/100,igst*totalPrice/100]
                
            grandTotal = totalPrice + (totalPrice*sgst/100) + (totalPrice*cgst/100) + (totalPrice*igst/100)
            grandTotalInWords = num2words(grandTotal)
            print(grandTotalInWords)

            d1 = {'email':currentUser.email,'company_name': currentUser.company_name,'company_address': currentUser.company_address,'gst_no': currentUser.gst_no,
             'phone_no': currentUser.phone_no,'billerName':billerName,'billerAddress':billerAddress,
             'billerPhoneNo':billerPhoneNo,'invoiceNo':invoiceNo,'date':date,'paymentMode':paymentMode,'grandTotalInWords':grandTotalInWords,'selectedItems':itemsList,'tax':tax,'total':totalPrice,'grandTotal':grandTotal}
            
            d2 = {'email':currentUser.email,'company_name': currentUser.company_name,'company_address': currentUser.company_address,'gst_no': currentUser.gst_no,
             'phone_no': currentUser.phone_no,'billerName':billerName,'billerAddress':billerAddress,
             'billerPhoneNo':billerPhoneNo,'invoiceNo':invoiceNo,'date':date,'paymentMode':paymentMode,
             'billerGstNo':billerGstNo,'buyerOrderNo':buyerOrderNo,'eWayBillNumber':eWayBillNumber,'eWayBillDate':eWayBillDate,
             'billOfLading':billOfLading,'motorVechileNumber':motorVechileNumber,'refNo':refNo,'otherRef':otherRef,'grandTotalInWords':grandTotalInWords,'selectedItems':itemsList}  

            salesEntry(currentUser.company_id,invoiceNo,billerName,billerPhoneNo,billerGstNo,date,itemsList)

            if binvoice == "yes":
                d = d2
                db.addInvoiceDetailed(d)
                return render(request,'invoicegenerate.html',d2)
            
            else:
                d = d1
                db.addInvoice(d)
                return render(request,'invoicegenerate.html',d1)

def salesEntry(company_id,invoiceNo,billerName,billerPhoneNo,billerGstNo,date,selectedItems):
    for i in selectedItems:
        db.addToSales(company_id,invoiceNo,billerName,billerPhoneNo,billerGstNo,date,i['name'],i['rate'],i['quantity'],i['totalPrice'])
    
def decQuantity(items):
    dbInventory = db.fetchInventory(currentUser.company_id)
    for i in items:
        id = int(i["id"])
        quantity = int(i["quantity"])
        for j in dbInventory:
            if j[1] == id:
                quantity = j[3] - quantity
                db.decQuantity(currentUser.company_id,id,quantity)
   

@csrf_exempt
def handle_action(request):
    if request.method == "POST":
        data = json.loads(request.body.decode('utf-8'))
        action = data.get("action")
        if action == "updateInventory":
            table_data = data.get("data")
            updateInventory(eval(f'{table_data}'))    
            return JsonResponse({"message": "Inventory updated!"})
        elif action == "addInventory":
            data = data.get('data')
            addInventory(eval(f'{data}')) 
            return JsonResponse({"message": "Added to Inventory"})
        elif action == "deleteInventory":
            data = data.get('data')
            deleteInventory(eval(f'{data}'))
            return JsonResponse({"message": "Deleted from Inventory"})
    
    return JsonResponse({"message": "Invalid request!"})

def updateInventory(data):
    dbInventory = db.fetchInventory(currentUser.company_id)
    for i in data:
        afterSplit = i.split("|")
        for j in dbInventory:
            if afterSplit[0] == j[1] and afterSplit[1] == j[2] and afterSplit[2] == j[3] and afterSplit[3] == j[4] :
                pass
            else:
                db.editInventory(afterSplit[0],afterSplit[1],afterSplit[3])
                return
            

def addInventory(data):
    db.addToInventory(data[0],data[1],data[2],data[3])
    
def deleteInventory(id):
    db.removeFromInventory(currentUser.company_id,id)

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
    
def portfolioCalculation(id):
    pass
    
def companyRegister(username,email,password):
    global currentUser
    currentUser =  db.register(username,email,password,"","","","")

def companyDetails(request):
    global currentUser,dashboardDict
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
            return render(request,"dashboard.html",dashboardDict)    
    return render(request,"companyDetails.html")


def save_pdf(request):
    global d
    html_content = render_to_string('invoicegenerate.html',d)
    pdf_file_path = 'output.pdf'
    weasyprint.HTML(string=html_content).write_pdf(pdf_file_path)
    return HttpResponse(f"PDF saved at: {os.path.abspath(pdf_file_path)}")