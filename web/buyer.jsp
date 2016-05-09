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
        <!--        <ul id="dropdown1" class="dropdown-content">
                    <li><a href="#!">one</a></li>
                    <li><a href="#!">two</a></li>
                    <li class="divider"></li>
                    <li><a href="logout.jsp">Logout</a></li>
                </ul>-->
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
            <div class="col s8 columns">
                <div class="card" style='height:65vh;'>
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
                        <div id="makanan">
                            <div class="row">
                                <%
                                    String query = "SELECT menu.id, nama, jenis, harga, foto, deskripsi, id_seller, username FROM menu INNER JOIN user ON menu.id_seller = user.id WHERE jenis='0'";
                                    Class.forName("com.mysql.jdbc.Driver");
                                    String userName = "root";
                                    String password = "root";
                                    String url = "jdbc:mysql://localhost/sikolin";
                                    Connection connection = DriverManager.getConnection(url, userName, password);
                                    Statement statement = connection.createStatement();
                                    ResultSet resultSet = statement.executeQuery(query);

                                    // process to show table
                                    ResultSetMetaData metaData = resultSet.getMetaData();

                                    while (resultSet.next()) {
                                        Blob image = resultSet.getBlob("foto");
                                        byte[] imgData = image.getBytes(1, (int) image.length());
                                        String foto_menu = Util.encode(imgData);
                                        out.print("<div class='col s6'>");
                                        out.print("<div class='card'>");
                                        out.print("<div class='card-content'>");
                                        out.print("<div class='row'>");
                                        out.print("<div class='col s3'>");

                                        String img = "data:image/jpeg;base64," + foto_menu;
                                        out.print("<img src='" + img + "' width='125' height='125'>");
                                        out.print("</div>");
                                        out.print("<div class='col s6'>");
                                        out.print("<h4>" + resultSet.getObject(2) + "</h4>");

                                        out.print("<h5>Harga: Rp. " + resultSet.getObject(4) + "</h5>");
                                        //Modal for each detail
                                        out.print("<a color='blue' class='modal-trigger' href='#modal" + resultSet.getObject(1) + "'>Detail</a>");
                                        out.print("<div id='modal" + resultSet.getObject(1) + "' class='modal'>");
                                        out.print("<div class='modal-content'>");

                                        out.print("<div class='row'>");
                                        out.print("<div class='col s3'>");
                                        out.print("<img src='" + img + "' width='200' height='200'>");
                                        out.print("</div>");
                                        out.print("<div class='col s8 offset-s1'>");
                                        out.print("<h4> " + resultSet.getObject(2) + " </h4>");
                                        out.print("<h5> Penjual: " + resultSet.getObject(8) + " </h5>");
                                        out.print("<h5> Rating: 9.8/10 </h5>");
                                        out.print("</div>");
                                        out.print("</div>");
                                        out.print("<p> "+resultSet.getObject(6)+" </p> ");

                                        out.print("</div>");
                                        out.print("<div class='modal-footer'>");
                                        out.print("<a href='#!' class=' modal-action modal-close waves-effect waves-green btn-flat'>Close</a>");
                                        out.print("</div></div><br/>");
                                        out.print("</div>");
                                        out.print("<div class='col s1'><br/><br/><br/>");

                                        out.print("<button  id='button" + resultSet.getObject(1) + "' class='waves-effect waves-light btn' onclick='addToCart(" + resultSet.getObject(1) + ",\"" + resultSet.getObject(2) + "\", \"" + Integer.parseInt(resultSet.getString(4)) + "\")'><i class='material-icons'>add_shopping_cart</i></button>");

                                        out.print("</div>");
                                        out.print("</div>");
                                        out.print("</div>");
                                        out.print("</div>");
                                        out.print("</div>");

                                    }

                                %>
                            </div>
                        </div>
                        <div id="minuman">
                            <div class="row">
                                <%                                    
                                    query = "SELECT menu.id, nama, jenis, harga, foto, deskripsi, id_seller, username FROM menu INNER JOIN user ON menu.id_seller = user.id  WHERE jenis='1'";
                                    resultSet = statement.executeQuery(query);

                                    // process to show table
                                    metaData = resultSet.getMetaData();

                                    while (resultSet.next()) {
                                        Blob image = resultSet.getBlob("foto");
                                        byte[] imgData = image.getBytes(1, (int) image.length());
                                        String foto_menu = Util.encode(imgData);
                                        out.print("<div class='col s6'>");
                                        out.print("<div class='card'>");
                                        out.print("<div class='card-content'>");
                                        out.print("<div class='row'>");
                                        out.print("<div class='col s3'>");

                                        String img = "data:image/jpeg;base64," + foto_menu;
                                        out.print("<img src='" + img + "' width='125' height='125'>");
                                        out.print("</div>");
                                        out.print("<div class='col s6'>");
                                        out.print("<h4>" + resultSet.getObject(2) + "</h4>");

                                        out.print("<h5>Harga: Rp. " + resultSet.getObject(4) + "</h5>");
                                        //Modal for each detail
                                        out.print("<a color='blue' class='modal-trigger' href='#modal" + resultSet.getObject(1) + "'>Detail</a>");
                                        out.print("<div id='modal" + resultSet.getObject(1) + "' class='modal'>");
                                        out.print("<div class='modal-content'>");

                                        out.print("<div class='row'>");
                                        out.print("<div class='col s3'>");
                                        out.print("<img src='" + img + "' width='200' height='200'>");
                                        out.print("</div>");
                                        out.print("<div class='col s8 offset-s1'>");
                                        out.print("<h4> " + resultSet.getObject(2) + " </h4>");
                                        out.print("<h5> Penjual: " + resultSet.getObject(8) + " </h5>");
                                        out.print("<h5> Rating: 9.8/10 </h5>");
                                        out.print("</div>");
                                        out.print("</div>");
                                        out.print("<p> "+resultSet.getObject(6)+" </p> ");

                                        out.print("</div>");
                                        out.print("<div class='modal-footer'>");
                                        out.print("<a href='#!' class=' modal-action modal-close waves-effect waves-green btn-flat'>Close</a>");
                                        out.print("</div></div><br/>");
                                        out.print("</div>");
                                        out.print("<div class='col s1'><br/><br/><br/>");

                                        out.print("<button  id='button" + resultSet.getObject(1) + "' class='waves-effect waves-light btn' onclick='addToCart(" + resultSet.getObject(1) + ",\"" + resultSet.getObject(2) + "\", \"" + Integer.parseInt(resultSet.getString(4)) + "\")'><i class='material-icons'>add_shopping_cart</i></button>");

                                        out.print("</div>");
                                        out.print("</div>");
                                        out.print("</div>");
                                        out.print("</div>");
                                        out.print("</div>");

                                    }

                                %>
                            </div>
                        </div>
                        <div id="snack">
                            <div class="row">
                                <%
                                    query = "SELECT menu.id, nama, jenis, harga, foto, deskripsi, id_seller, username FROM menu INNER JOIN user ON menu.id_seller = user.id  WHERE jenis='2'";
                                    resultSet = statement.executeQuery(query);

                                    // process to show table
                                    metaData = resultSet.getMetaData();

                                    while (resultSet.next()) {
                                        Blob image = resultSet.getBlob("foto");
                                        byte[] imgData = image.getBytes(1, (int) image.length());
                                        String foto_menu = Util.encode(imgData);
                                        out.print("<div class='col s6'>");
                                        out.print("<div class='card'>");
                                        out.print("<div class='card-content'>");
                                        out.print("<div class='row'>");
                                        out.print("<div class='col s3'>");

                                        String img = "data:image/jpeg;base64," + foto_menu;
                                        out.print("<img src='" + img + "' width='125' height='125'>");
                                        out.print("</div>");
                                        out.print("<div class='col s6'>");
                                        out.print("<h4>" + resultSet.getObject(2) + "</h4>");

                                        out.print("<h5>Harga: Rp. " + resultSet.getObject(4) + "</h5>");
                                        //Modal for each detail
                                        out.print("<a color='blue' class='modal-trigger' href='#modal" + resultSet.getObject(1) + "'>Detail</a>");
                                        out.print("<div id='modal" + resultSet.getObject(1) + "' class='modal'>");
                                        out.print("<div class='modal-content'>");

                                        out.print("<div class='row'>");
                                        out.print("<div class='col s3'>");
                                        out.print("<img src='" + img + "' width='200' height='200'>");
                                        out.print("</div>");
                                        out.print("<div class='col s8 offset-s1'>");
                                        out.print("<h4> " + resultSet.getObject(2) + " </h4>");
                                        out.print("<h5> Penjual: " + resultSet.getObject(8) + " </h5>");
                                        out.print("<h5> Rating: 9.8/10 </h5>");
                                        out.print("</div>");
                                        out.print("</div>");
                                        out.print("<p> "+resultSet.getObject(6)+" </p> ");

                                        out.print("</div>");
                                        out.print("<div class='modal-footer'>");
                                        out.print("<a href='#!' class=' modal-action modal-close waves-effect waves-green btn-flat'>Close</a>");
                                        out.print("</div></div><br/>");
                                        out.print("</div>");
                                        out.print("<div class='col s1'><br/><br/><br/>");

                                        out.print("<button  id='button" + resultSet.getObject(1) + "' class='waves-effect waves-light btn' onclick='addToCart(" + resultSet.getObject(1) + ",\"" + resultSet.getObject(2) + "\", \"" + Integer.parseInt(resultSet.getString(4)) + "\")'><i class='material-icons'>add_shopping_cart</i></button>");

                                        out.print("</div>");
                                        out.print("</div>");
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
            <div class="col s4 columns">
                <div class="card">
                    <div class="card-content">
                        <span class="card-title left-align"> Shopping Cart  <i class='material-icons'>shopping_cart</i></span>
                        <form action="SubmitOrder">

                            <div id="shopcart" style="overflow-y: scroll; height:65vh;"></div>
                            <div class="pull-right">
                                <table>
                                    <tr>
                                        <td> Credit   </td>
                                        <td> : Rp. </td>
                                        <td> <div id="userCredit" data-value="<%= credit%>"><%= credit%> </div></td>
                                    </tr>
                                    <tr>
                                        <td>Total </td>
                                        <td> : Rp. </td>
                                        <td><div id="totalHarga" data-value="0">0</div> </td>
                                    </tr>
                                    <hr>
                                    <tr>
                                        <td>Sisa :</td>
                                        <td> : Rp. </td>
                                        <td><input id="sisacredit" name="sisacredit" type="text" value="<%= credit%>" style='pointer-events: none;'></td>
                                    </tr>
                                </table>
                                <input type="hidden" name="itemCount" id="itemCount" value="0"></input>
                                <input type="hidden" name="userid" value="<%= session.getAttribute("user_id")%>"> 
                                <input id="submitOrder" type="submit">
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