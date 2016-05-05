<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<%
    if ((session.getAttribute("user_id") != null) && (session.getAttribute("role") != null)) {
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
    <body class="light-blue lighten-5">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.3/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/js/materialize.min.js"></script>
        <script src="assets/js/homepage.js"></script>
        <ul id="dropdown1" class="dropdown-content">
            <li><a href="#!">one</a></li>
            <li><a href="#!">two</a></li>
            <li class="divider"></li>
            <li><a href="logout.jsp">Logout</a></li>
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
        <div class="row">
            <div class="col s8 amber lighten-5">
                <div class="row">
                    <h3> Daftar Menu Kantin Fasilkom </h3>
                    <div class="col s12">
                        <ul class="tabs">
                            <li class="tab col s4"><a class="active" href="#makanan">Makanan</a></li>
                            <li class="tab col s4"><a href="#minuman">Minuman</a></li>
                            <li class="tab col s4"><a href="#snack">Snack</a></li>
                        </ul>
                    </div>
                </div>
                <div id="makanan">
                    <div class="row">
                        <%
                            String query = "SELECT * FROM menu WHERE jenis='0'";
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
                                out.print("<div class='col s6'>");
                                out.print("<div class='card'>");
                                out.print("<div class='card-content'>");
                                out.print("<div class='row'>");
                                out.print("<div class='col s3'>");
                                out.print("<img src='assets/img/pizza.png' width='100px' height='100px'>");
                                out.print("</div>");
                                out.print("<div class='col s6'>");
                                out.print("<h5>" + resultSet.getObject(2) + "</h5>");

                                //Modal for each detail
                                out.print("<a class='waves-effect waves-light btn modal-trigger' href='#modal" + resultSet.getObject(1) + "'>Detail</a>");
                                out.print("<div id='modal" + resultSet.getObject(1) + "' class='modal'>");
                                out.print("<div class='modal-content'>");
                                out.print("<h4>Modal Header</h4>");
                                out.print("<p>A bunch of text</p>");
                                out.print("</div>");
                                out.print("<div class='modal-footer'>");
                                out.print("<a href='#!' class=' modal-action modal-close waves-effect waves-green btn-flat'>Close</a>");
                                out.print("</div></div><br/>");
                                out.print("<button  class='waves-effect waves-light btn' onclick='addToCart(" + resultSet.getObject(1) + ",\"" + resultSet.getObject(2) + "\", \"" + Integer.parseInt(resultSet.getString(4)) + "\")'> Order <i class='material-icons right'>send</i> </button>");
                                out.print("<strong>Harga satuan: " + resultSet.getObject(4) + "</strong>");
                                out.print("</div>");
                                out.print("</div>");
                                out.print("</div>");
                                out.print("</div>");
                                out.print("</div>");
                            }
//                            connection.close();
//                            statement.close();
                        %>
                    </div>
                </div>
                <div id="minuman">
                    <div class="row">
                        <%
                            query = "SELECT * FROM menu WHERE jenis='1'";
                            resultSet = statement.executeQuery(query);

                            // process to show table
                            metaData = resultSet.getMetaData();

                            while (resultSet.next()) {
                                out.print("<div class='col s6'>");
                                out.print("<div class='card' onclick='addToCart(" + resultSet.getObject(1) + ",\"" + resultSet.getObject(2) + "\", \"" + Integer.parseInt(resultSet.getString(4)) + "\")'>");
                                out.print("<div class='card-content'>");
                                out.print("<div class='row'>");
                                out.print("<div class='col s3'>");
                                out.print("<img src='assets/img/pizza.png' width='100px' height='100px'>");
                                out.print("</div>");
                                out.print("<div class='col s9'>");
                                out.print("<h3>" + resultSet.getObject(2) + "</h3>");
                                out.print("Harga satuan: " + resultSet.getObject(4));
                                out.print("</div>");
                                out.print("</div>");
                                out.print("</div>");
                                out.print("</div>");
                                out.print("</div>");
                            }
//                            connection.close();
//                            statement.close();
                        %>
                    </div>
                </div>
                <div id="snack">
                    <div class="row">
                        <%
                            query = "SELECT * FROM menu WHERE jenis='2'";
                            resultSet = statement.executeQuery(query);

                            // process to show table
                            metaData = resultSet.getMetaData();

                            while (resultSet.next()) {
                                out.print("<div class='col s6'>");
                                out.print("<div class='card' onclick='addToCart(" + resultSet.getObject(1) + ",\"" + resultSet.getObject(2) + "\", \"" + Integer.parseInt(resultSet.getString(4)) + "\")'>");
                                out.print("<div class='card-content'>");
                                out.print("<div class='row'>");
                                out.print("<div class='col s3'>");
                                out.print("<img src='assets/img/pizza.png' width='100px' height='100px'>");
                                out.print("</div>");
                                out.print("<div class='col s9'>");
                                out.print("<h3>" + resultSet.getObject(2) + "</h3>");
                                out.print("Harga satuan: " + resultSet.getObject(4));
                                out.print("</div>");
                                out.print("</div>");
                                out.print("</div>");
                                out.print("</div>");
                                out.print("</div>");
                            }
                            connection.close();
                            statement.close();
                        %>
                    </div>
                </div>
            </div>
            <div class="col s3  amber lighten-5">
                <form action="SubmitOrder">
                    <div id="shopcart" style="overflow-y: scroll; height:65vh;"></div>
                    <div id="totalHarga">Total : Rp. 0</div>
                    <input type="hidden" name="itemCount" id="itemCount" value="0"></input>
                    <input type="hidden" name="userid" value="<%= session.getAttribute("user_id")%>"> 
                    <input type="submit">
                </form>
            </div>
        </div>
    </body>
</html>
<%
    } else {
        response.sendRedirect("login.jsp");
    }
%>