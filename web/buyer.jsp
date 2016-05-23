<%@page import="org.sikolin.Util"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<%
    if ((session.getAttribute("user_id") != null) && (session.getAttribute("role") != null) && (session.getAttribute("role").toString().equals("0"))) {
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/css/materialize.min.css">
        <link type="text/css" rel="stylesheet" href="assets/css/animate.css" media="screen,projection"/>
        <link type="text/css" rel="stylesheet" href="assets/css/style.css"/>

        <title>Sikolin Home Page</title>
    </head>
    <body class="light-blue lighten-5  black-text">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.3/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/js/materialize.min.js"></script>
        <script src="assets/js/homepage.js"></script>
        <nav>
            <div class="nav-wrapper light-blue lighten-1 z-depth-2 ">
                <a href="index.jsp" class="brand-logo">
                    <img src="assets/img/logosikolin.png" height="64"/>
                    <img src="assets/img/textsikolin.png"  height="48"/>
                </a>
                <ul class="right hide-on-med-and-down">
                    <li><a href="statuspesanan.jsp"> Cek pesanan </a></li>
                    <li><a href="logout.jsp">Logout</a></li>
                </ul>
            </div>
        </nav>
        <div class="row">
            <div class="col s8">
                <div class="card columns">
                    <div class="card-content">
                        <span class="card-title"> Daftar Menu Kantin Fasilkom </span>
                        <div id='tabchooser' class="row">
                            <div class="col s12">
                                <div class="indicator orange" style="z-index:1">
                                    <ul class="tabs">
                                        <li class="tab col s4"><a class="active" href="#makanan" style="color: #00c5c8;">Makanan</a></li>
                                        <li class="tab col s4"><a href="#minuman"style="color: #00c5c8;">Minuman</a></li>
                                        <li class="tab col s4"><a href="#snack" style="color: #00c5c8;">Snack</a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div id="makanan" style="overflow-y: scroll; height:70vh;">
                            <div class="row">
                                <%
                                    String query = "SELECT  menu.id, nama, jenis, harga, foto, deskripsi, id_seller, username, menu.total_rating FROM menu INNER JOIN user ON menu.id_seller = user.id WHERE jenis='0'";
                                    Class.forName("com.mysql.jdbc.Driver");
                                    String userName = "root";
                                    String password = "root";
                                    String url = "jdbc:mysql://localhost/sikolin";
                                    Connection connection = DriverManager.getConnection(url, userName, password);
                                    Statement statement = connection.createStatement();
                                    ResultSet resultSet = statement.executeQuery(query);
                                    ResultSetMetaData metaData = resultSet.getMetaData();

                                    while (resultSet.next()) {
                                        Blob image = resultSet.getBlob("foto");
                                        byte[] imgData = image.getBytes(1, (int) image.length());
                                        String foto_menu = Util.encode(imgData);
                                        String img = "data:image/jpeg;base64," + foto_menu;
                                        out.print("<div class='col s6'>");
                                        out.print("<div class='card'>");
                                        out.print("<div class='card-image'>");
                                        out.print("<img src='" + img + "' class='activator' width='250px' height='250px'>");
                                        out.print("<span class='card-title activator'>" + resultSet.getObject(2) + "</span>");
                                        out.print("</div>");
                                        out.print("<div class='card-content'>");
                                        out.print("<h6>Harga : Rp. " + resultSet.getObject(4) + "</h6>");
                                        out.print("</div>");
                                        out.print("<div class='card-action'>");
                                        out.print("<button id='button" + resultSet.getObject(1) + "' class='waves-effect waves-light btn light-blue lighten-1' onclick='addToCart(" + resultSet.getObject(1) + ", \"" + resultSet.getObject(2) + "\", \"" + Integer.parseInt(resultSet.getString(4)) + "\")'><i class='material-icons'>add_shopping_cart</i></button>");
                                        out.print("</div>");
                                        out.print("<div class='card-reveal'>");
                                        out.print("<span class='card-title grey-text text-darken-4'>" + resultSet.getObject(2) + "<i class='material-icons right'>close</i></span>");
                                        out.print("<table>");
                                        out.print("<tr>");
                                        out.print("<th>Penjual</th>");
                                        out.print("<td>" + resultSet.getObject(8) + "</td>");
                                        out.print("</tr>");
                                        out.print("<tr>");
                                        out.print("<th>Rating</th>");
                                        out.print("<td>" + resultSet.getFloat("total_rating") + "/10</td>");
                                        out.print("</tr>");
                                        out.print("<tr>");
                                        out.print("<th>Deskripsi</th>");
                                        out.print("<td></td>");
                                        out.print("</tr>");
                                        out.print("<tr>");
                                        out.print("<td><p>" + resultSet.getObject(6) + "</p></td>");
                                        out.print("<td></td>");
                                        out.print("</tr>");
                                        out.print("</table>");
                                        out.print("</div>");
                                        out.print("</div>");
                                        out.print("</div>");
                                    }
                                %>
                            </div>
                        </div>
                        <div id="minuman" style="overflow-y: scroll; height:70vh;">
                            <div class="row">
                                <%  
                                    query = "SELECT menu.id, nama, jenis, harga, foto, deskripsi, id_seller, username, menu.total_rating FROM menu INNER JOIN user ON menu.id_seller = user.id  WHERE jenis='1'";
                                    resultSet = statement.executeQuery(query);
                                    metaData = resultSet.getMetaData();

                                    while (resultSet.next()) {
                                        Blob image = resultSet.getBlob("foto");
                                        byte[] imgData = image.getBytes(1, (int) image.length());
                                        String foto_menu = Util.encode(imgData);
                                        String img = "data:image/jpeg;base64," + foto_menu;
                                        out.print("<div class='col s6'>");
                                        out.print("<div class='card'>");
                                        out.print("<div class='card-image'>");
                                        out.print("<img src='" + img + "' class='activator' width='250px' height='250px'>");
                                        out.print("<span class='card-title activator'>" + resultSet.getObject(2) + "</span>");
                                        out.print("</div>");
                                        out.print("<div class='card-content'>");
                                        out.print("<h6>Harga : Rp. " + resultSet.getObject(4) + "</h6>");
                                        out.print("</div>");
                                        out.print("<div class='card-action'>");
                                        out.print("<button id='button" + resultSet.getObject(1) + "' class='waves-effect waves-light btn light-blue lighten-1' onclick='addToCart(" + resultSet.getObject(1) + ", \"" + resultSet.getObject(2) + "\", \"" + Integer.parseInt(resultSet.getString(4)) + "\")'><i class='material-icons'>add_shopping_cart</i></button>");
                                        out.print("</div>");
                                        out.print("<div class='card-reveal'>");
                                        out.print("<span class='card-title grey-text text-darken-4'>" + resultSet.getObject(2) + "<i class='material-icons right'>close</i></span>");
                                        out.print("<table>");
                                        out.print("<tr>");
                                        out.print("<th>Penjual</th>");
                                        out.print("<td>" + resultSet.getObject(8) + "</td>");
                                        out.print("</tr>");
                                        out.print("<tr>");
                                        out.print("<th>Rating</th>");
                                        out.print("<td>" + resultSet.getFloat("total_rating") + "/10</td>");
                                        out.print("</tr>");
                                        out.print("<tr>");
                                        out.print("<th>Deskripsi</th>");
                                        out.print("<td></td>");
                                        out.print("</tr>");
                                        out.print("<tr>");
                                        out.print("<td><p>" + resultSet.getObject(6) + "</p></td>");
                                        out.print("<td></td>");
                                        out.print("</tr>");
                                        out.print("</table>");
                                        out.print("</div>");
                                        out.print("</div>");
                                        out.print("</div>");
                                    }
                                %>
                            </div>
                        </div>
                        <div id="snack" style="overflow-y: scroll; height:70vh;">
                            <div class="row">
                                <%
                                    query = "SELECT menu.id, nama, jenis, harga, foto, deskripsi, id_seller, username, menu.total_rating FROM menu INNER JOIN user ON menu.id_seller = user.id  WHERE jenis='2'";
                                    resultSet = statement.executeQuery(query);
                                    metaData = resultSet.getMetaData();

                                    while (resultSet.next()) {
                                        Blob image = resultSet.getBlob("foto");
                                        byte[] imgData = image.getBytes(1, (int) image.length());
                                        String foto_menu = Util.encode(imgData);
                                        String img = "data:image/jpeg;base64," + foto_menu;
                                        out.print("<div class='col s6'>");
                                        out.print("<div class='card'>");
                                        out.print("<div class='card-image'>");
                                        out.print("<img src='" + img + "' class='activator' width='250px' height='250px'>");
                                        out.print("<span class='card-title activator'>" + resultSet.getObject(2) + "</span>");
                                        out.print("</div>");
                                        out.print("<div class='card-content'>");
                                        out.print("<h6>Harga : Rp. " + resultSet.getObject(4) + "</h6>");
                                        out.print("</div>");
                                        out.print("<div class='card-action'>");
                                        out.print("<button id='button" + resultSet.getObject(1) + "' class='waves-effect waves-light btn light-blue lighten-1' onclick='addToCart(" + resultSet.getObject(1) + ", \"" + resultSet.getObject(2) + "\", \"" + Integer.parseInt(resultSet.getString(4)) + "\")'><i class='material-icons'>add_shopping_cart</i></button>");
                                        out.print("</div>");
                                        out.print("<div class='card-reveal'>");
                                        out.print("<span class='card-title grey-text text-darken-4'>" + resultSet.getObject(2) + "<i class='material-icons right'>close</i></span>");
                                        out.print("<table>");
                                        out.print("<tr>");
                                        out.print("<th>Penjual</th>");
                                        out.print("<td>" + resultSet.getObject(8) + "</td>");
                                        out.print("</tr>");
                                        out.print("<tr>");
                                        out.print("<th>Rating</th>");
                                        out.print("<td>" + resultSet.getFloat("total_rating") + "/10</td>");
                                        out.print("</tr>");
                                        out.print("<tr>");
                                        out.print("<th>Deskripsi</th>");
                                        out.print("<td></td>");
                                        out.print("</tr>");
                                        out.print("<tr>");
                                        out.print("<td><p>" + resultSet.getObject(6) + "</p></td>");
                                        out.print("<td></td>");
                                        out.print("</tr>");
                                        out.print("</table>");
                                        out.print("</div>");
                                        out.print("</div>");
                                        out.print("</div>");
                                    }
                                    query = "SELECT credits FROM user where id='" + session.getAttribute("user_id") + "'";
                                    resultSet = statement.executeQuery(query);
                                    resultSet.next();
                                    int credit = Integer.parseInt(resultSet.getObject(1).toString());
                                %>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col s4">
                <div class="card columns">
                    <div class="card-content">
                        <span class="card-title left-align"> Shopping Cart  <i class='material-icons'>shopping_cart</i></span>
                        <form action="SubmitOrder">
                            <div id="shopcart" style="overflow-y: scroll; height:50vh;"></div>
                            <div class="pull-right">
                                <table>
                                    <tr>
                                        <td> <b>Credit</b>   </td>
                                        <td> : Rp. </td>
                                        <td> <div id="userCredit" data-value="<%= credit%>"><%= credit%> </div></td>
                                    </tr>
                                    <tr>
                                        <td> <b>Total </b> </td>
                                        <td> : Rp. </td>
                                        <td><div id="totalHarga" data-value="0">0</div> </td>
                                    </tr>
                                    <hr>
                                    <tr>
                                        <td><b>Sisa </b></td>
                                        <td> : Rp. </td>
                                        <td><input id="sisacredit" name="sisacredit" type="text" value="<%= credit%>" style='pointer-events: none;'></td>
                                    </tr>
                                </table>
                                <input type="hidden" name="itemCount" id="itemCount" value="0"></input>
                                <input type="hidden" name="userid" value="<%= session.getAttribute("user_id")%>"> 
                                <div class="right-align">
                                    <input id="submitOrder" class="btn btn-primary light-blue lighten-1" type="submit">
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
<%
        connection.close();
        statement.close();
    } else {
        response.sendRedirect("login.jsp");
    }
%>