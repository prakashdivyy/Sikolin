<%@page import="org.sikolin.Util"%>
<%@page import="java.sql.Blob"%>
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
        <script>
            setTimeout(function () {
                window.location.reload(1);
            }, 10000);
        </script>

        <nav>
            <div class="nav-wrapper teal lighten-1 z-depth-2 ">
                <a href="index.jsp" class="brand-logo">
                    <img src="assets/img/logosikolin.png" height="64"/>
                    <img src="assets/img/textsikolin.png"  height="48"/>
                </a>
                <ul class="right hide-on-med-and-down">
                    <li><a href="buyer.jsp">Order Food</a></li>
                    <li><a href="logout.jsp">Logout</a></li>
                </ul>
            </div>
        </nav>

        <div class="row">
            <div class="col s8 offset-s2">
                <div class="card">
                    <div class="card-content">
                        <span class="card-title center-align"> <strong>Status Pesanan </strong></span>

                        <%            String userid = session.getAttribute("user_id").toString();
                            String query = "SELECT P.id_form, P.jumlah, P.keterangan, P.status, M.nama, M.foto, U.username from pesanan P inner join menu M on P.id_menu = M.id inner join user U on M.id_seller = U.id, form F where P.id_form = F.id and F.id_user=" + userid + " ORDER BY P.status ASC";
                            Class.forName("com.mysql.jdbc.Driver");
                            String userName = "root";
                            String password = "root";
                            String url = "jdbc:mysql://localhost/sikolin";
                            Connection connection = DriverManager.getConnection(url, userName, password);
                            Statement statement = connection.createStatement();
                            ResultSet resultSet = statement.executeQuery(query);

                            while (resultSet.next()) {
                                Blob image = resultSet.getBlob("foto");
                                byte[] imgData = image.getBytes(1, (int) image.length());
                                String foto_menu = Util.encode(imgData);
                                String img = "data:image/jpeg;base64," + foto_menu;

                        %>

                        <div class="card">
                            <div class="card-content">
                                <div class="row">
                                    <div class="col s2">
                                        <img src="<%= img%>" width="200px" height="200px">
                                    </div>
                                    <div class="col s8 offset-s1">
                                        <h5> <%= resultSet.getString("nama")%> </h5>
                                        <table class="responsive-table highlight">
                                            <thead>
                                                <tr>
                                                    <th>Penjual</th>
                                                    <th>Jumlah</th>
                                                    <th>Keterangan</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td><%= resultSet.getString("username")%></td>
                                                    <td><%= resultSet.getInt("jumlah")%></td>
                                                    <td><%= resultSet.getString("keterangan")%></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="col s1">
                                        <h5> Status </h5>
                                        <%

                                            switch (resultSet.getInt("status")) {
                                                case 0:
                                        %>
                                        <br>
                                        <i class="large material-icons">input</i>
                                        <%
                                                    break;
                                                case 1:
                                        %>
                                        <br>
                                        <i class="large material-icons">rowingt</i>
                                        <%
                                                    break;
                                                case 2:
                                        %>
                                        <br>
                                        <i class="large material-icons">done</i>
                                        <%
                                                    break;
                                            }
                                        %>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%
                            }
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