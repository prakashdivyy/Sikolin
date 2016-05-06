<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%
    if ((session.getAttribute("user_id") != null) && (session.getAttribute("role") != null)) {
%>
<!DOCTYPE html>
<html>
    <head>
        <!--        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                Import Google Icon Font
                <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        
                Import materialize.css
                <link type="text/css" rel="stylesheet" href="assets/css/materialize.min.css"  media="screen,projection"/>
                <link type="text/css" rel="stylesheet" href="assets/css/animate.css"  media="screen,projection"/>
        
                <link type="text/css" rel="stylesheet" href="assets/css/style.css"/>
                <title>Cek status</title> -->
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/css/materialize.min.css">
        <link type="text/css" rel="stylesheet" href="assets/css/animate.css" media="screen,projection"/>
        <link type="text/css" rel="stylesheet" href="assets/css/style.css"/>
        <title>Sikolin Cek Pesanan</title>
    </head>
    <body class="light-blue lighten-5">
        <!--Import jQuery before materialize.js-->
        <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
        <script type="text/javascript" src="assets/js/materialize.min.js"></script>
        <!-- Dropdown Structure -->
        <ul id="dropdown1" class="dropdown-content">
            <li><a href="#!">one</a></li>
            <li><a href="#!">two</a></li>
            <li class="divider"></li>
            <li><a href="#!">three</a></li>
        </ul>
        <nav>
            <div class="nav-wrapper teal lighten-1 z-depth-2 ">
                <a href="index.jsp" class="brand-logo">
                    <img src="assets/img/logosikolin.png" height="64"/>
                    <img src="assets/img/textsikolin.png"  height="48"/>
                </a>
                <ul class="right hide-on-med-and-down">
                    <li>
                        <a class="dropdown-button" href="#!" data-activates="dropdown1">
                            <i class="material-icons right">menu</i>
                        </a>
                    </li>
                </ul>
            </div>
        </nav>

        <%
            String userid = "" + session.getAttribute("user_id");
            String query = "SELECT * FROM pesanan as P, form as F WHERE F.id_user = '" + userid + "' AND F.id = P.id_form";
            Class.forName("com.mysql.jdbc.Driver");
            String userName = "root";
            String password = "root";
            String url = "jdbc:mysql://localhost/sikolin";
            Connection connection = DriverManager.getConnection(url, userName, password);
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);
            ResultSetMetaData metaData = resultSet.getMetaData();
        %>
        <div class="row">
            <div class="col s8 offset-s2">
                <div class="card">
                    <div class="card-content">
                        <%
                            out.print("<table class='table'");
                            out.print("<tr>");
                            for (int i = 1; i <= 6; i++) {
                                out.print("<th>");
                                out.print(metaData.getColumnName(i));
                                out.print("</th>");
                            }
                            out.print("</tr>");
                            int count = 1;
                            while (resultSet.next()) {

                                out.print("<tr>");
                                out.print("<td>" + resultSet.getObject(1) + "</td>");
                                out.print("<td>" + resultSet.getObject(2) + "</td>");
                                out.print("<td>" + resultSet.getObject(3) + "</td> ");
                                out.print("<td>" + resultSet.getObject(4) + "</td> ");
                                out.print("<td>" + resultSet.getObject(5) + "</td>");
                                out.print("<td>" + resultSet.getObject(6) + "</td>");
                                out.print("</tr>");
                                count++;
                            }
                            out.print("</table>");
                        %>
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