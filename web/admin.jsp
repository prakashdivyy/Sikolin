<%-- 
    Document   : admin
    Created on : May 21, 2016, 7:10:22 PM
    Author     : Kevin
--%>

<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/css/materialize.min.css">
        <link type="text/css" rel="stylesheet" href="assets/css/animate.css" media="screen,projection"/>
        <link type="text/css" rel="stylesheet" href="assets/css/style.css"/>
        <title>Admin Page</title>
    </head>
    <body>
        <nav>
            <div class="nav-wrapper teal lighten-1 z-depth-2 ">
                <a href="index.jsp" class="brand-logo">
                    <img src="assets/img/logosikolin.png" height="64"/>
                    <img src="assets/img/textsikolin.png"  height="48"/>
                </a>
                <ul class="right hide-on-med-and-down">
                    <li><a href="logout.jsp">Logout</a></li>
                </ul>
            </div>
        </nav>
        <div class="row">
            <div class="col s8 offset-s2">
                <div class="card">
                    <div class="card-content">
                        <span class="card-title center-align"> <strong>List Buyer </strong></span>
                        <table class="table">
                            <thead>
                                <tr>
                                    <td>Nama</td>
                                    <td>Credits</td>
                                    <td>Add Credits</td>
                                    <td></td>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    String query = "SELECT id,username,credits FROM user where role = '0'";
                                    Class.forName("com.mysql.jdbc.Driver");
                                    String userName = "root";
                                    String password = "root";
                                    String url = "jdbc:mysql://localhost/sikolin";
                                    Connection connection = DriverManager.getConnection(url, userName, password);
                                    Statement statement = connection.createStatement();
                                    ResultSet resultSet = statement.executeQuery(query);
                                    while (resultSet.next()) {
                                %>
                            <form action="AddCredits">
                                <tr>
                                    <td>
                                        <h5><%= resultSet.getString("username")%></h5>
                                    </td>
                                    <td>
                                        <h5><%= resultSet.getString("credits")%></h5>
                                    </td>
                                    <td>
                                        <input id="credits" name="credits" type="number">    
                                    </td>
                                    <td>
                                        <input id="addCredits" class="waves-effect waves-light btn" type="submit">
                                    </td>
                                </tr>
                                <input type="hidden" name="usercredit" value="<%= resultSet.getString("credits")%>">
                                <input type="hidden" name="userid" value="<%= resultSet.getString("id")%>">
                            </form>
                            <%}%>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
