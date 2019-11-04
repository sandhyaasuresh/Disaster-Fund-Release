<%--<%@page import="jdk.nashorn.internal.objects.NativeMath.round(Object, Object)"%>--%>
<%@page import="java.lang.Math"%>
<%@page import="java.lang.Integer"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.sql.*;" %>
<%@page import="java.io.*;" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Disaster Fund Release</title>
            <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Disaster Management</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link href= "vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <link href= "https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href= "https://fonts.googleapis.com/css?family=Kaushan+Script" rel='stylesheet' type='text/css'>
    <link href= "https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic" rel='stylesheet' type='text/css'>
    <link href= "https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700" rel='stylesheet' type='text/css'>

    <style>
    .jumbotron {
      border-radius: 6px;
      margin-right: 25%;
      margin-left: 25%;
      background: rgba(255,255,255,0.5);
      z-index: 2;
      box-shadow: 0 8px 16px -6px black
    };
    .container2 {
      padding-top : 15px;
      margin-bottom: 10px;
    
    }
    .button
    {
        z-index : 3;
        box-shadow: 0 8px 8px -6px black;
    }
    .container{
      padding-top : 15px;
      margin-left: 20px;
      margin-right:20px;
      margin-bottom: 10px;
    }
    .container1{
      margin:15px;
    }
    .form-ele {
      padding-top: 20px;
      font-size : 28;
    }
    .iptext {

    }
    div {
      font-family: 'Times New Roman', Georgia, serif;
    }
    a {
        color: #ffffff;
    }
    a:visited {
    color:#fff;
    }
    a:hover {
    color:#fff;
  }
    .header1 {
      margin-top: 10px;
      margin-bottom: 10px;
      
      font-family: 'Times New Roman', Georgia, serif;
    }
    .navbar {
      background-color: #333;
      color: #FFFFFF
    }
    body {
        background-color : #AAA;
    }
     </style>
    </head>
    <body>
        <div>
          <div class="container2 navbar row">
              <div class="header1 col-md-9" style='font-size: 32px' >
                  <B>Disaster Fund Release</B>
              </div>
            <div class="col-lg-1"> <a href="index.html"> Employee</a></div>
            <div class="col-lg-1"> <a href="#">Existing Customer </a></div>
            <div class="col-lg-1"> <a href="referral.html">New User</a></div>
        </div>
          <header>
              <div class="container1" align="center" style="font-family: 'Times New Roman', Georgia, serif;margin-top: 35px">
                  <h1>Project Name</h1>
                  <br>
              </div>
          </header>
          <div>
              <div class ="jumbotron" style="padding-left: 20px; padding-top: 10px; padding-bottom: 20px">
              <div class="header2" style="color:black;font-size:28; margin-bottom: 20px;text-align:center;font-family: 'Times New Roman', Georgia, serif;">
                  <h3>List of Affected Users</h3>
                <br>
              </div>
              
        <%
           Map<Integer, Integer> records = new HashMap<Integer, Integer>();
           try
           {
           String url = "jdbc:sqlserver://localhost:1433;databaseName=hackOhio;integratedSecurity=true";
           Connection con = null;
           Statement stmt = null;
           String sql = "select * from customers where region IN (";
           String regionsAffected[] = request.getParameterValues("regionsAffected");
           for(int i = 0; i<regionsAffected.length ; i++){
               if(i != regionsAffected.length-1)
                sql += "'" + regionsAffected[i] + "',";
               else
                sql = sql + "'" + regionsAffected[i] + "' ";
                       }
           double maxAmount = Double.parseDouble(request.getParameter("maxAmount"));
           double maxExisting = 0.7*maxAmount;
           sql = sql + ");";
           Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
           con = DriverManager.getConnection(url);
           stmt = con.createStatement();
           ResultSet rs = stmt.executeQuery(sql);
           while(rs.next())
           { 
           int balance = rs.getInt(9);
           int hasSaving = rs.getInt(10);
           int hasChecking = rs.getInt(11);
           int hasCreditCard = rs.getInt(12);
           int loan = rs.getInt(13);
           float duration = rs.getInt(14);
           int creditScore = rs.getInt(15);
           int sum = 0;
           
           
           //balance
           if(balance>=0 && balance<=500)
                sum-=1;
           else if(balance>500 && balance<=1000)
                sum-=2;
           else if(balance>1000 && balance<=1500)
                sum-=3;
           else if(balance>1500 && balance<=2000)
                sum-=4;
           else if(balance>2000 && balance<=2500)
                sum-=5;
           else if(balance>2500 && balance<=3000)
                sum-=6;
           else if(balance>3000 && balance<=3500)
                sum-=7;
           else if(balance>3500 && balance<=4000)
                sum-=8;
           else if(balance>4000 && balance<=4500)
                sum-=9;
           else
                sum-=10;
           
           //hasSaving
           if(hasSaving == 1)
                sum+=1;
           
           //hasChecking
           if(hasChecking == 1)
                sum+=1;
           
           //hasCreditCard
           if(hasCreditCard == 1)
                sum+=1;
           
           
           //loan
           if(loan == 0)
                sum+=0;
           else if(loan>0 && loan<=1000)
                sum-=1;
           else if(loan>1000 && loan<=2000)
                sum-=2;
           else if(loan>2000 && loan<=3000)
                sum-=3;
           else if(loan>3000 && loan<=4000)
                sum-=4;
           else if(loan>4000 && loan<=5000)
                sum-=5;
           else if(loan>5000 && loan<=6000)
                sum-=6;
           else if(loan>6000 && loan<=7000)
                sum-=7;
           else if(loan>7000 && loan<=8000)
                sum-=8;
           else if(loan>8000 && loan<=9000)
                sum-=9;
           else
                sum-=10;
           

           //duration
           if(duration>=0 && duration<=5)
                sum+=1;
           else if(duration>5 && duration<=10)
                sum+=2;
           else if(duration>10 && duration<=15)
                sum+=3;
           else if(duration>15 && duration<=20)
                sum+=4;
           else if(duration>20 && duration<=25)
                sum+=5;
           else if(duration>25 && duration<=30)
                sum+=6;
           else if(duration>30 && duration<=35)
                sum+=7;
           else if(duration>35 && duration<=40)
                sum+=8;
           else if(duration>40 && duration<=50)
                sum+=9;
           else
                sum+=10;
           
           
           //creditScore
           if(creditScore>=0 && creditScore<=10)
                sum+=1;
           else if(creditScore>=10 && creditScore<=20)
                sum+=2;
           else if(creditScore>=20 && creditScore<=30)
                sum+=3;
           else if(creditScore>=30 && creditScore<=40)
                sum+=4;
           else if(creditScore>=40 && creditScore<=50)
                sum+=5;
           else if(creditScore>=50 && creditScore<=60)
                sum+=6;
           else if(creditScore>=60 && creditScore<=70)
                sum+=7;
           else if(creditScore>=70 && creditScore<=80)
                sum+=8;
           else if(creditScore>=80 && creditScore<=90)
                sum+=9;
           else
                sum+=10;
           
            records.put(rs.getInt(1),sum);
           }
           int min = 100;
           
           //Finding negative values in sum for normalization
           for (Map.Entry<Integer, Integer> entry : records.entrySet()) {
               if(entry.getValue()< min)
                   min = entry.getValue();
           }
          
           //Normalizing
           float sumForRatio = 0;
           if (min<=0){
               int requirement = 1 - min;
               for(Map.Entry<Integer, Integer> entry : records.entrySet()){
                   int oldValue = records.replace(entry.getKey(), entry.getValue() + requirement);
                   sumForRatio = sumForRatio + entry.getValue();
               }
           }

            for (Map.Entry<Integer, Integer> entry : records.entrySet()) {
                float ratioVals = Math.round((entry.getValue()/sumForRatio)*1000);
                String sqlUpdateRatio = "Update customers SET ratio = ";
                String sqlUpdateRoi = "Update customers SET roi = ";
                String sqlUpdateAmountOffered = "Update customers SET amountOffered = ";
                sqlUpdateRatio += (float)(ratioVals/1000) + " where CustomerID = " + entry.getKey() + ";";
                sqlUpdateRoi += (float)(ratioVals/100) + " where CustomerID = " + entry.getKey() + ";";
                sqlUpdateAmountOffered += (float)(((ratioVals)*maxExisting)/1000) + " where CustomerID = " + entry.getKey() + ";";
                
                stmt.executeUpdate(sqlUpdateRatio);
                stmt.executeUpdate(sqlUpdateRoi);
                stmt.executeUpdate(sqlUpdateAmountOffered);

           }
            
            String sql_roi = "Select * from customers;";
            ResultSet rs_roi = stmt.executeQuery(sql_roi);
            float max_roi = 0;
            
            while(rs_roi.next()){
                float received_roi = rs_roi.getFloat(17);
                if(received_roi> max_roi)
                    max_roi = received_roi;
            }
            max_roi += 2.0;

            %><div align="center">
                    <table border="1" cellpadding="5">
                        <tr>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Region</th>
                            <th>Rate of Interest</th>
                            <th>Amount Offered</th>
                        </tr><%
            ResultSet rs_sql = stmt.executeQuery(sql);
            while(rs_sql.next()) {%>
                        <tr>
                            <td><%=rs_sql.getString(2)%></td>
                            <td><%=rs_sql.getString(3)%></td>
                            <td><%=rs_sql.getString(7)%></td>
                            <td><%=rs_sql.getString(17)%></td>
                            <td><%=rs_sql.getString(18)%></td>
                       </tr>
           <%}%> </table></div><%
           
           
           }
           catch(Exception e)
            {
                System.out.println(e.getMessage());
            }
           
         %>
         <Form action="index.html" method="get">
         <div class="form-ele" style="font-family: 'Times New Roman', Georgia, serif;">
            <center><input type="button"value="Send Notification"></center>
        </div>
         </Form>
       </div>
       </div>
       </div>
    </body>
</html>
