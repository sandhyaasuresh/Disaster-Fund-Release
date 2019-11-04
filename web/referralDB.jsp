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
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Thank You</title>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel= "stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
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
    a {
        color: #ffffff;
    }
    a:visited {
    color:#fff;
    }
    a:hover {
    color:#fff;
  }
    .container{
      padding-top : 15px;
      margin-left: 20px;
      margin-right:20px;
      margin-bottom: 10px;
    }
    .container1{
      margin:5px;
      font-size: 15px;
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
    a {
        text-decoration: 'none';
    }
     </style>
    
    </head>
    <body>
        <div class="container2 navbar row">
              <div class="header1 col-md-9" style='font-size: 32px' >
                  <B>Disaster Fund Release</B>
              </div>
            <div class="col-lg-1"> <a href="index.html"> Employee</a></div>
            <div class="col-lg-1"> <a href="#">Existing Customer </a></div>
            <div class="col-lg-1"> <a href="referral.html">New User</a></div>
        </div>
        <header>
              <div class="container1" align="center" style="margin-top: 42px">
                  <h1>Thanks for registering!</h1>
                  <br>
              </div>
        </header>
        <%
        try
           {
           String url = "jdbc:sqlserver://localhost:1433;databaseName=hackOhio;integratedSecurity=true";
           Connection con = null;
           Statement stmt = null;
           Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
           con = DriverManager.getConnection(url);
           
           
           String firstName = request.getParameter("firstName");
           String lastName = request.getParameter("lastName");
           String address = request.getParameter("address");
           long number = Long.parseLong(request.getParameter("number"));
           long salary = Long.parseLong(request.getParameter("salary"));
           int propertyAssets = Integer.parseInt(request.getParameter("propertyAssets"));
           String comments = request.getParameter("comments");
         
           
           String sqlall = "select * from referrals";
           stmt = con.createStatement();
           ResultSet rs = stmt.executeQuery(sqlall);
           int ID = 1;
           while(rs.next()){
               ID++;
           }
           stmt = con.createStatement();
           String sql_insert = "insert into referrals values ("+ID+", '"+firstName+"', '"+lastName+"', '"+address+"', "+number+", "+salary+", "+propertyAssets+", "+ request.getAttribute("max_roi") +", '"+comments +"');";
           stmt.executeUpdate(sql_insert);
           con.commit();
           }
           catch (Exception e)
           {
               System.out.println(e.getMessage());   
           }
        %>
    <center><h6>You are eligible to avail a loan with a rate of interest. The loan amount and rate of interest will be communicated to you soon. </h6>
        
            <br>
            <h6>To reduce your ROI by <b>1.50%</b>, please create a bank account with us!</h6>
    
        <div class="form-ele" style="font-family: 'Times New Roman', Georgia, serif;">
            <center><input type="submit" class="button" value="Click here to create an account" /></center>
        </div>
    </body>
</html>
