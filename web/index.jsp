<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--Import Google Icon Font-->
        <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

        <!--Import materialize.css-->
        <link type="text/css" rel="stylesheet" href="assets/css/materialize.min.css"  media="screen,projection"/>
        <link type="text/css" rel="stylesheet" href="assets/css/animate.css"  media="screen,projection"/>

        <link type="text/css" rel="stylesheet" href="assets/css/style.css"/>
        <title>Homepage</title> 
    </head>
    <body class="light-blue lighten-5">
        <script>
            var count = 0;
            function addToCart(id, name) {
                $("#shopcart").append("<div id='order" + count + "' class='card animated bounceInUp'><div class='card-content black-text'><input type='text' value='" + name + "' disabled/><input type='number' value='1'/></div><div class='card-action'><a href='#' onclick='eraseCart(" + count + ")'>Remove</a></div></div>");
                count++;
            }
            function eraseCart(id) {
                $('#order' + id).remove()
            }
        </script>
        <!--Import jQuery before materialize.js-->
        <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
        <script type="text/javascript" src="assets/js/materialize.min.js"></script>
        <script>
            $(document).ready(function () {
                $(".dropdown-button").dropdown();
                $('.modal-trigger').leanModal();

            });
        </script>

        <!-- Dropdown Structure -->
        <ul id="dropdown1" class="dropdown-content">
            <li><a href="#!">one</a></li>
            <li><a href="#!">two</a></li>
            <li class="divider"></li>
            <li><a href="#!">three</a></li>
        </ul>
        <nav>
            <div class="nav-wrapper teal lighten-1 z-depth-2 ">
                <a href="index.jsp" class="brand-logo"><img src="assets/logosikolin.png" height="64"/><img src="assets/textsikolin.png"  height="48"/> </a>
                <ul class="right hide-on-med-and-down">
                    <!-- Modal Trigger -->
                    <li><a class="modal-trigger" href="#cart"><i class="material-icons">shopping_cart</i></a></li>
                    <!-- Dropdown Trigger -->
                    <li><a class="dropdown-button" href="#!" data-activates="dropdown1"><i class="material-icons right">menu</i></a></li>
                </ul>
            </div>
        </nav>
        <!--         Modal Structure 
                <div id="cart" class="modal modal-fixed-footer">
                    <div class="modal-content">
                        <h4>Shopping Cart</h4>
                        <table class="responsive-table highlight ">
                            <thead>
                                <tr>
                                    <th data-field="id">Name</th>
                                    <th data-field="name">Item Name</th>
                                    <th data-field="price">Item Price</th>
                                </tr>
                            </thead>
        
                            <tbody>
                                <tr>
                                    <td>Alvin</td>
                                    <td>Eclair</td>
                                    <td>$0.87</td>
                                </tr>
                                <tr>
                                    <td>Alan</td>
                                    <td>Jellybean</td>
                                    <td>$3.76</td>
                                </tr>
                                <tr>
                                    <td>Jonathan</td>
                                    <td>Lollipop</td>
                                    <td>$7.00</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="modal-footer">
                        <a href="#!" class="modal-action modal-close waves-effect waves-green btn-flat ">Agree</a>
                    </div>
                </div>-->
        <div class="row">
            <div class="col s9 amber lighten-4 columns">
                <%
                    String query = "SELECT * FROM menu";
                    Class.forName("com.mysql.jdbc.Driver");
                    String userName = "root";
                    String password = "";
                    String url = "jdbc:mysql://localhost/sikolin";
                    Connection connection = DriverManager.getConnection(url, userName, password);
                    Statement statement = connection.createStatement();
                    ResultSet resultSet = statement.executeQuery(query);

                    // process to show table
                    ResultSetMetaData metaData = resultSet.getMetaData();

                    out.print("<table class='striped'");
                    out.print("<tr>");
                    for (int i = 1; i <= 6; i++) {
                        out.print("<th>");
                        out.print(metaData.getColumnName(i));
                        out.print("</th>");
                    }
                    out.print("</tr>");

                    while (resultSet.next()) {
                        out.print("<tr>");
                        out.print("<td>" + resultSet.getObject(1) + "</td> ");
                        out.print("<td onclick='addToCart(" + resultSet.getObject(1) + ",\"" + resultSet.getObject(2) + "\")'>" + resultSet.getObject(2) + "</td> ");
                        out.print("<td>" + resultSet.getObject(3) + "</td> ");
                        out.print("<td>" + resultSet.getObject(4) + "</td> ");
                        out.print("<td>" + resultSet.getObject(5) + "</td> ");
                        out.print("<td>" + resultSet.getObject(6) + "</td> ");
                        out.print("</tr>");

                    }

                    out.print("</table>");
                    connection.close();
                    statement.close();

                    connection.close();
                    statement.close();

                %>
            </div>
            <div class="col s3 teal lighten-5 columns">
                <form action="PurchaseItem">
                    <div id="shopcart" style="overflow-y: scroll; height:65vh;">
                    </div>
                    <input type="submit">
                </form>
            </div>
        </div>
    </body>
</html>
