
class Company:
    def __init__(self,company_id,username,email,phone_no,company_name,company_address,gst_no,password):
        self.company_id = company_id
        self.company_name = company_name
        self.username = username
        self.email = email
        self.phone_no = phone_no
        self.gst_no = gst_no
        self.company_address = company_address
        self.total_sales = 0
        self.total_purchases = 0
        self.password = password
        self.total_profit = self.total_sales- self.total_purchases
        self.turnover = self.total_sales

    def __str__(self):
        return f"Company ID : {self.company_id},Company Name : {self.company_name},Username : {self.username},Email : {self.email},Phone No : {self.phone_no},GST No : {self.gst_no},Company Address  : {self.company_address},Password : {self.password}"