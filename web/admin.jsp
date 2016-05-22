<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<%
    if ((session.getAttribute("user_id") != null) && (session.getAttribute("role") != null) && (session.getAttribute("role").toString().equals("2"))) {
%>
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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.3/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/js/materialize.min.js"></script>
        <script src="assets/js/homepage.js"></script>
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
            <div class="col s12 amber lighten-4">
                <div class="row">
                    <br>
                    <div class="col s12">
                        <ul class="tabs">
                            <li class="tab col s4"><a class="active" href="#addcredit">Add Credits</a></li>
                            <li class="tab col s4"><a href="#manage">Manage User</a></li>
                            <li class="tab col s4"><a href="#viewpesanan">View Pesanan</a></li>
                        </ul>
                    </div>
                    <div id="addcredit">
                        <div class="row">
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
                                <div class="col s3">
                                    <div class="card">
                                        <div class="card-content">
                                            <div class="row">
                                                <div class="col s12">
                                                    <table class="table">
                                                        <tr>
                                                            <th>Username</th>
                                                            <th>:</th>
                                                            <td><%= resultSet.getString("username")%></td>
                                                        </tr>
                                                        <tr>
                                                            <th>Credits</th>
                                                            <th>:</th>
                                                            <td>Rp. <%= resultSet.getString("credits")%></td>
                                                        </tr>
                                                        <tr>
                                                            <th>Add Credits</th>
                                                            <th>:</th>
                                                            <td><input id="credits" name="credits" type="number" max="1000000" min="1000" step="100" value="1000"></td>
                                                        </tr>
                                                    </table>
                                                    <input id="addCredits" class="waves-effect waves-light btn teal lighten-2 right" type="submit" value="Add Credits">
                                                    <input type="hidden" name="usercredit" value="<%= resultSet.getString("credits")%>">
                                                    <input type="hidden" name="userid" value="<%= resultSet.getString("id")%>">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                            <%
                                }
                            %>
                        </div>
                    </div>
                    <div id="manage">
                        <div class="row">
                            AA
                        </div>    
                    </div>
                    <div id="viewpesanan">
                        <div class="row">
                            BB
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
<%
    } else {
        response.sendRedirect("login.jsp");
    }
%>
