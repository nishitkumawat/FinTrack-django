from dotenv import load_dotenv
import mysql.connector as connector
import os
from argon2 import PasswordHasher, exceptions
from pycparser.c_ast import Return
from dashboard import views
import models

# Path to your HTML file


# Load the .env file (uncomment if using environment variables)
# load_dotenv()

# Database credentials (can also load from .env for security)
db_user = 'root'
db_password = ''
db_name = 'fintrack'


database = None
cursor = None
hasher = PasswordHasher()  # For password hashing

def create_connection():
    global database,cursor
    try:
        if database is None:
            database = connector.connect(
                host='localhost',
                user=db_user,
                password=db_password,
                database=db_name,
                charset="utf8mb4",  # Specify character set
                collation="utf8mb4_general_ci"
            )
            cursor = database.cursor()
            print("Database connection established.")
    except connector.Error as e:
        print(f"Error connecting to the database: {e}")
        database = None
        
def close_connection():
    global database,cursor
    """Close the database connection."""
    if cursor:
        cursor.close()
    if database:
        database.close()
        print("Database connection closed.")
        
def execute_query( query, params=None):
    global database,cursor
    try:
        if database is None or cursor is None:
            raise Exception("Database connection is not established.")
        cursor.execute(query, params or ())
        database.commit()
        print("Query executed successfully.")
        return cursor.fetchall()
    except Exception as e:
        print(f"Error executing query: {e}")
        return None
    
def login(username, password):
    global database,cursor
    cursor.execute("SELECT * FROM user_info WHERE username = %s AND password = %s", (username, password))
    result = cursor.fetchone()
    print(result)
    if result:
        print("Login successful!")
        user = []
        for value in result:
            user.append(value)
            print(value)
        currentUser = models.Company(user[0],user[1],user[2],user[4],user[5],user[6],user[7],user[3])
        return currentUser
    else:
        print("Invalid email or password.")
        return None
    
def register(username,email,password,phone,company_name,company_address,gst_no):
    global database,cursor
    try:
        cursor.execute("SELECT company_id FROM user_info ORDER BY company_id DESC LIMIT 1;")
        result = cursor.fetchone()
        company_id = 0
        if result:
            for i in result:
                company_id = int(i)+1
        cursor.execute("insert into user_info(company_id, username, email, password, phone, company_name, company_address, gst_no ) values(%s,%s,%s,%s,%s,%s,%s,%s)",(company_id,username,email,password,phone,company_name,company_address,gst_no))
        database.commit()
        
        currentUser =  models.Company(company_id,username,email,phone,company_name,company_address,gst_no,password)
        return currentUser
    except Exception as e:
        print(e)
        return None
    
def addToInventory (item_id,item_name,item_quantity,item_rate,rate_per):
    global database,cursor
    try:
        cursor.execute(
            "insert into inventory(company_id,item_id,item_name,item_quantity,item_rate,rate_per  ) values(%s,%s,%s,%s,%s,%s)",
            (views.currentUser.company_id,item_id,item_name,item_quantity,item_rate,rate_per))
        database.commit()
        return True
    except Exception as e:
        print(e)
        return False
    
def removeFromInventory(item_id):
    global database,cursor
    try:
        cursor.execute("DELETE FROM inventory WHERE item_id = %s",[item_id])
        database.commit()
        return True
    except Exception as e:
        print(e)
        return False
    
def editItemRate(item_id,new_rate):
    global database,cursor
    try:
        cursor.execute("UPDATE inventory SET item_rate = %s WHERE item_id = %s", [new_rate,item_id])
        database.commit()
        return True
    except Exception as e:
        print(e)
        return False
    
def editRatePer(item_id,new_rateper):
    global database,cursor
    try:
        cursor.execute("UPDATE inventory SET rate_per = %s WHERE item_id = %s", [new_rateper,item_id])
        database.commit()
        return True
    except Exception as e:
        print(e)
        return False
    
def editItemName(item_id,new_name):
    global database,cursor
    try:
        cursor.execute("UPDATE inventory SET item_name = %s WHERE item_id = %s", [new_name,item_id])
        database.commit()
        return True
    except Exception as e:
        print(e)
        return False
    
def editItemQuantity(item_id,new_quan):
    global database,cursor
    try:
        cursor.execute("UPDATE inventory SET item_quantity = %s WHERE item_id = %s", [new_quan,item_id])
        database.commit()
        return True
    except Exception as e:
        print(e)
        return False
    
def generateBill(bill_no, bill_date, receiver_name, receiver_company_name,
            receiver_company_gstno, receiver_company_phone, receiver_company_address, items, total_amount,
            bill_pdf):
    global database,cursor
    try:
        cursor.execute(
            "INSERT INTO bills(company_id, bill_no, bill_date, receiver_name, receiver_company_name, receiver_company_gstno, receiver_company_phone, receiver_company_address, items, total_amount, bill_pdf) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",
            (views.currentUser.company_id, bill_no, bill_date, receiver_name, receiver_company_name,
             receiver_company_gstno, receiver_company_phone, receiver_company_address, items, total_amount,
             bill_pdf)
        )
        database.commit()
        return True
    except Exception as e:
        print(e)
        return False
    
def getBill(bill_no):
    global database,cursor
    cursor.execute("SELECT bill_pdf FROM bills where bill_no = %s and company_id = %s",[bill_no,views.currentUser.company_id])
    result = cursor.fetchone()
    pdf_name = f"invoice-{views.currentUser.company_id}-{bill_no}"
    if result:
        pdf_data = result[0]
        if pdf_data[:4] == b"%PDF" and pdf_data[-5:] == b"%%EOF":
            print("Valid PDF data retrieved.")
        else:
            print("The retrieved data doesn't appear to be a valid PDF.")
        pdf_file_path = 'bil.jpg'
        with open(pdf_file_path, "wb") as pdf_file:
            pdf_file.write(pdf_data)
            print(f"The PDF has been saved as {pdf_file_path}")
            
def updateCompanyDetails(d):
    global database,cursor
    try:
        cursor.execute("UPDATE user_info SET email=%s,phone=%s,company_name=%s,company_address=%s,gst_no=%s WHERE username = %s",[d['email'],d['phone_no'],d['company_name'],d['company_address'],d['gst_no'],d['username']] )
        database.commit()
        return True
    except Exception as e:
        print(e)
        return False
    
                

def listOfUsername():
    global database,cursor
    cursor.execute("SELECT username FROM user_info")
    result = cursor.fetchall()
    r = []
    for i in result:
        r.append(i[0])
    return r
    
        
# if _name__ == "__main__":
# d = Database()
# d.create_connection()
# d.login("nk@gmail.com","1234567890")
# # d.register(2,"nsk","nsk","aaaaa","1234567890","ads","addas","dasd")
# print(views.currentUser)
# d.addToInventory(1,'Hair Oil',300,250,'bottle')
# d.removeFromInventory(1)
# d.editItemRate(1,350)
# with open('ab.pdf', "rb") as file:
#     billpdf = file.read()
# a = d.generateBill(4,'2023-02-02','asdas','sadsa','sadda','sdaas','sadsa','sad','1000',billpdf)
# print(a)
# d.getBill(4)
# html_file = r"D:\Projects\fintrack\pages\billTable.html"
#
# # Output PDF file
# pdf_file = 'output.pdf'
#
# # Convert HTML file to PDF
# pdfkit.from_file(html_file, pdf_file)
#
# print(f"PDF saved as {pdf_file}")