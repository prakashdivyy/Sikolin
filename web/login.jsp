<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.mindrot.jbcrypt.BCrypt"%>
<%@page session="true"%>
<%
    if ((session.getAttribute("user_id") == null) && (session.getAttribute("role") == null)) {
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Sikolin</title>
        <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/css/materialize.min.css">
    </head>
    <body class="light-blue">
        <div class="container">
            <div class="row">
                <div class="col s6 offset-s3">
                    <br>
                    <div class="card-panel">
                        <div class="center-align row">
                            <img src="assets/img/logosikolin.png" width="200">
                            <br>
                            <img src="assets/img/textsikolin.png" width="200">
                        </div>
                        <form class="row" method="POST" action="login.jsp">
                            <div class="row">
                                <div class="input-field col s8 offset-s2">
                                    <i class="material-icons prefix">account_circle</i>
                                    <input id="username" type="text" class="validate" name="username" required>
                                    <label for="username">Username</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="input-field col s8 offset-s2">
                                    <i class="material-icons prefix">lock</i>
                                    <input id="password" type="password" class="validate" name="password" required>
                                    <label for="password">Password</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col s8 offset-s2 center-align">
                                    <a class="btn waves-effect red darken-4" href="register.jsp">Register</a>
                                    <button class="btn waves-effect yellow darken-4" type="submit" name="action">Submit</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.3/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/js/materialize.min.js"></script>
        <%
            if ((request.getParameter("username") != null) && (request.getParameter("password") != null) && (request.getMethod().equalsIgnoreCase("POST"))) {
                String dbUsername = "root";
                String dbPassword = "root";
                String dbUrl = "jdbc:mysql://localhost/sikolin";
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection connection = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
                    String query = "SELECT id, password, role FROM user WHERE username='" + username + "'";
                    Statement statement = connection.createStatement();
                    ResultSet resultSet = statement.executeQuery(query);
                    resultSet.next();
                    String hash = (String) resultSet.getObject(2);
                    if (BCrypt.checkpw(password, hash)) {
                        int user_id = Integer.parseInt(resultSet.getObject(1).toString());
                        int role = Integer.parseInt(resultSet.getObject(3).toString());
                        session.setAttribute("user_id", user_id);
                        session.setAttribute("role", role);
                        if (role == 0) {
                            response.sendRedirect("buyer.jsp");
                        } else {
                            response.sendRedirect("seller.jsp");
                        }
                    } else {
        %>
        <script>
            $(document).ready(function () {
                Materialize.toast('Invalid Username or Password', 4000);
            });
        </script>
        <%
            }
        } catch (Exception e) {
        %>
        <script>
            $(document).ready(function () {
                Materialize.toast('Invalid Username or Password', 4000);
            });
        </script>
        <%
                }
            }
        %>
    </body>
</html>
<%
    } else {
        int role = Integer.parseInt(session.getAttribute("role").toString());
        if (role == 0) {
            response.sendRedirect("buyer.jsp");
        } else {
            response.sendRedirect("seller.jsp");
        }
    }
%>
