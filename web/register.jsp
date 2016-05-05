<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.PreparedStatement"%>
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
        <title>Register Sikolin</title>
        <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/css/materialize.min.css">
    </head>
    <body class="light-blue">
        <div class="container">
            <div class="row">
                <div class="col s6 offset-s3">
                    <div class="card-panel">
                        <div class="center-align row">
                            <h3>Register</h3>
                        </div>
                        <form class="row" method="POST" action="register.jsp">
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
                                <div class="input-field col s8 offset-s2">
                                    <i class="material-icons prefix">verified_user</i>
                                    <select name="role" required>
                                        <option value="" disabled selected>Choose your option</option>
                                        <option value="0">Buyer</option>
                                        <option value="1">Seller</option>
                                    </select>
                                    <label>Who are you?</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col s8 offset-s2 center-align">
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
        <script src="assets/js/style.js"></script>
        <%
            if ((request.getParameter("username") != null) && (request.getParameter("password") != null) && (request.getParameter("role") != null) && (request.getMethod().equalsIgnoreCase("POST"))) {
                String dbUsername = "root";
                String dbPassword = "root";
                String dbUrl = "jdbc:mysql://localhost/sikolin";
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String role = request.getParameter("role");
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection connection = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
                    String hash_pass = BCrypt.hashpw(password, BCrypt.gensalt(12));
                    String query = "INSERT INTO user(username, password, role) values(?, ?, ?)";
                    PreparedStatement ps = connection.prepareStatement(query);
                    ps.setString(1, username);
                    ps.setString(2, hash_pass);
                    ps.setString(3, role);
                    ps.executeUpdate();
                    ps.close();
                    response.sendRedirect("login.jsp");
                } catch (Exception e) {
        %>
        <script>
            $(document).ready(function () {
                Materialize.toast('Username Exist', 4000);
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