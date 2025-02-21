import json
from django.http import HttpResponse, JsonResponse
from django.shortcuts import  render
from dataStructure.ds import BST, HashMap
from userlogin import views as userLogin_views
from database import db_operations as db
from django.views.decorators.csrf import csrf_exempt
import os
from django.template.loader import render_to_string
import weasyprint
from num2words import num2words
from datetime import date,timedelta,datetime
from collections import defaultdict


currentUser = None
d = None
dashboardDict = dict()
renderInvoice = ''
# Create your views here.
def dashboard(request):
    global currentUser,dashboardDict
    db.create_connection()
    companyLogin()
    portfolio()
    inventory = db.inventory(currentUser.company_id)
    dashboardDict.update({
        'email':currentUser.email,
        'company_name': currentUser.company_name,
        'company_address': currentUser.company_address,
        'gst_no': currentUser.gst_no,
        'phone_no': currentUser.phone_no,
        'inventory':inventory,
        'invoice_no' : db.newInvoiceNo(currentUser.company_id),
        'sellTable' : db.sellTable(currentUser.company_id)})
    
    print(dashboardDict)
    return render(request,"dashboard.html",dashboardDict )

def portfolio():
    global dashboardDict
    turnover = db.calculateTurnOver(currentUser.company_id) 
    inventory = db.calculateInventory(currentUser.company_id)
    profit = turnover - db.totalPurchase(currentUser.company_id)
    data = db.sells(currentUser.company_id)
    
    today = datetime.today().date()
    one_year_ago = today - timedelta(days=365)

    month_names = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", 
                "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

    months = []
    year, month = one_year_ago.year, one_year_ago.month
    for _ in range(11): 
        label = f"{month_names[month-1]}-{year}"
        months.append(label)
        month += 1
        if month > 12:
            month = 1
            year += 1

    present_month_label = f"{month_names[today.month-1]}-{today.year}"
    months.append(present_month_label)

    monthly_totals = {label: 0 for label in months}

    for date_str, amount in data.items():
        date_obj = datetime.strptime(date_str, "%Y-%m-%d").date()
        
        if one_year_ago <= date_obj <= today:
            label = f"{month_names[date_obj.month-1]}-{date_obj.year}"
            if label in monthly_totals:
                monthly_totals[label] += amount

    print(monthly_totals)
    graph_json = json.dumps(monthly_totals)
    
    dashboardDict['sales_graph'] = graph_json
    dashboardDict['turnover'] = turnover
    dashboardDict['inventoryTotal'] = inventory
    dashboardDict['profit'] = profit
    if turnover!=0:
        dashboardDict['profitPerct'] = (profit/turnover)*100
    else:
        dashboardDict['profitPerct'] = 0

    quantity = db.quantity(currentUser.company_id)
    if quantity:
        # sorted_dict = dict(sorted(quantity.items(), key=lambda item: item[1], reverse=True)[:3])
        bst = BST()
        for key, value in quantity.items():
            bst.insert(key, value)
        sorted_dict = bst.get_top_n(3)
        dashboardDict['topQuantity'] = sorted_dict
    else:
        dashboardDict['topQuantity'] = {}

def mainPage(request):
    mainPageDict = {}
    return render(request,"mainPage.html",mainPageDict)

def invoiceGenerate(request):
    global currentUser,d,renderInvoice
    if request.method == "POST":
        
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

        # d1 = {'email':currentUser.email,'company_name': currentUser.company_name,'company_address': currentUser.company_address,'gst_no': currentUser.gst_no,
        #     'phone_no': currentUser.phone_no,'billerName':billerName,'billerAddress':billerAddress,
        #     'billerPhoneNo':billerPhoneNo,'invoiceNo':invoiceNo,'date':date,'paymentMode':paymentMode,'grandTotalInWords':grandTotalInWords,'selectedItems':itemsList,'tax':tax,'total':totalPrice,'grandTotal':grandTotal}
        
        # d2 = {'email':currentUser.email,'company_name': currentUser.company_name,'company_address': currentUser.company_address,'gst_no': currentUser.gst_no,
        #     'phone_no': currentUser.phone_no,'billerName':billerName,'billerAddress':billerAddress,
        #     'billerPhoneNo':billerPhoneNo,'invoiceNo':invoiceNo,'date':date,'paymentMode':paymentMode,
        #     'billerGstNo':billerGstNo,'buyerOrderNo':buyerOrderNo,'eWayBillNumber':eWayBillNumber,'eWayBillDate':eWayBillDate,
        #     'billOfLading':billOfLading,'motorVechileNumber':motorVechileNumber,'refNo':refNo,'otherRef':otherRef,'grandTotalInWords':grandTotalInWords,'selectedItems':itemsList}  


        invoice_map1 = HashMap()
        invoice_map1.put('email', currentUser.email)
        invoice_map1.put('company_name', currentUser.company_name)
        invoice_map1.put('company_address', currentUser.company_address)
        invoice_map1.put('gst_no', currentUser.gst_no)
        invoice_map1.put('phone_no', currentUser.phone_no)
        invoice_map1.put('billerName', billerName)
        invoice_map1.put('billerAddress', billerAddress)
        invoice_map1.put('billerPhoneNo', billerPhoneNo)
        invoice_map1.put('invoiceNo', invoiceNo)
        invoice_map1.put('date', date)
        invoice_map1.put('paymentMode', paymentMode)
        invoice_map1.put('grandTotalInWords', grandTotalInWords)
        invoice_map1.put('selectedItems', itemsList)
        invoice_map1.put('tax', tax)
        invoice_map1.put('total', totalPrice)
        invoice_map1.put('grandTotal', grandTotal)
        d1 = invoice_map1.get_all()
        
        invoice_map2 = HashMap()
        invoice_map2.put('email', currentUser.email)
        invoice_map2.put('company_name', currentUser.company_name)
        invoice_map2.put('company_address', currentUser.company_address)
        invoice_map2.put('gst_no', currentUser.gst_no)
        invoice_map2.put('phone_no', currentUser.phone_no)
        invoice_map2.put('billerName', billerName)
        invoice_map2.put('billerAddress', billerAddress)
        invoice_map2.put('billerPhoneNo', billerPhoneNo)
        invoice_map2.put('invoiceNo', invoiceNo)
        invoice_map2.put('date', date)
        invoice_map2.put('paymentMode', paymentMode)
        invoice_map2.put('billerGstNo', billerGstNo)
        invoice_map2.put('buyerOrderNo', buyerOrderNo)
        invoice_map2.put('eWayBillNumber', eWayBillNumber)
        invoice_map2.put('eWayBillDate', eWayBillDate)
        invoice_map2.put('billOfLading', billOfLading)
        invoice_map2.put('motorVechileNumber', motorVechileNumber)
        invoice_map2.put('refNo', refNo)
        invoice_map2.put('otherRef', otherRef)
        invoice_map2.put('grandTotalInWords', grandTotalInWords)
        invoice_map2.put('selectedItems', itemsList)

        d2 = invoice_map2.get_all()

        salesEntry(currentUser.company_id,invoiceNo,billerName,billerPhoneNo,billerGstNo,date,itemsList)

        if binvoice == "yes":
            d = d2
            db.addInvoiceDetailed(d)
            renderInvoice = 'invoicegenerate.html'
            save_pdf()
            return render(request,'invoicegenerate.html',d2)
        
        else:
            d = d1
            db.addInvoice(d)
            renderInvoice = 'invoicegenerate2.html'
            save_pdf()
            return render(request,'invoicegenerate2.html',d1)

def salesEntry(company_id,invoiceNo,billerName,billerPhoneNo,billerGstNo,date,selectedItems):
    
    for i in selectedItems:
        purchase_price = db.getPurchasePrice(currentUser.company_id,i['id'])
        db.addToSales(company_id,invoiceNo,billerName,billerPhoneNo,billerGstNo,date,i['name'],purchase_price,i['rate'],i['quantity'],i['totalPrice'])
    
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
    db.addToInventory(currentUser.company_id,data[0],data[1],data[2],data[3])
    
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
            print(dashboardDict)
            dashboardDict['company_name'] = company_name
            dashboardDict['company_address'] = company_address
            dashboardDict['gst_no'] = gst_no
            dashboardDict['phone_no'] = phone_no
            db.updateCompanyDetails(d)
            return render(request,"dashboard.html",dashboardDict)    
    return render(request,"companyDetails.html")


def save_pdf():
    global d,renderInvoice
    
    html_content = render_to_string(renderInvoice,d)
    name = f"{currentUser.company_id}_{dashboardDict['invoice_no']}"
    pdf_file_path = f'savedinvoice/{name}_invoice.pdf'
    weasyprint.HTML(string=html_content).write_pdf(pdf_file_path)
    return HttpResponse(f"PDF saved at: {os.path.abspath(pdf_file_path)}")