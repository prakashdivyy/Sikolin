<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page session="true"%>
<%
    if (session.getAttribute("user_id") != null) {
%>
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
        <!--Import jQuery before materialize.js-->
        <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
        <script type="text/javascript" src="assets/js/materialize.min.js"></script>
        <script>
            $(document).ready(function () {
                $(".dropdown-button").dropdown();
                $('.modal-trigger').leanModal();
                $('ul.tabs').tabs();
            });

            var count = 0;
            var total = 0;

            function addToCart(id, name, price) {
                $("#shopcart").append("<div id='order" + count + "' class='card animated bounceInUp'><div class='card-content black-text'><input type='text' value='" + name + "' disabled/><div class='row'><div class='input-field'><select id='jumlah" + count + "'><option value='1' selected>1</option><option value='2'>2</option><option value='3'>3</option><option value='4'>4</option><option value='5'>5</option></select></div></div></div><div class='card-action'><a class='right-align' href='#' onclick='eraseCart(" + count + ", " + price + ")'>Remove</a></div></div>");
                total += parseInt(price, 10);
                increaseCount();
                updateTotal();
                $('select').material_select();
            }

            function increaseCount() {
                count++;
                document.getElementById("itemCount").value = count;


            }
            function decreaseCount() {
                count--;
                document.getElementById("itemCount").value = count;

            }
            function eraseCart(id, price) {
                $('#order' + id).remove()
                total -= parseInt(price, 10);
                decreaseCount();
                updateTotal();
            }
            function updateTotal() {
                $("#totalHarga").html("Total : Rp. " + total);

            }
            $("[id^=jumlah]").change(function () {
                $(this).val();
            })
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

                    <li><a class="dropdown-button" href="#!" data-activates="dropdown1"><i class="material-icons right">menu</i></a></li>
                </ul>
            </div>
        </nav>
        <div class="row">
            <div class="col s9 amber lighten-4 columns">
                <h3> Daftar Menu Kantin Fasilkom </h3>
                <div class="row">
                    <div class="col s12">
                        <ul class="tabs">
                            <li class="tab col s4"><a class="active" href="#makanan">Makanan</a></li>
                            <li class="tab col s4"><a href="#minuman">Minuman</a></li>
                            <li class="tab col s4"><a href="#snack">Snack</a></li>

                        </ul>
                    </div>
                    <div id="makanan" class="col s12">
                        <div class="row">
                            <%
                                String query = "SELECT * FROM menu WHERE jenis='0'";
                                Class.forName("com.mysql.jdbc.Driver");
                                String userName = "root";
                                String password = "";
                                String url = "jdbc:mysql://localhost/sikolin";
                                Connection connection = DriverManager.getConnection(url, userName, password);
                                Statement statement = connection.createStatement();
                                ResultSet resultSet = statement.executeQuery(query);

                                // process to show table
                                ResultSetMetaData metaData = resultSet.getMetaData();

                                while (resultSet.next()) {
                                    out.print("<div class='col s6'>");
                                    out.print("<div class='card' onclick='addToCart(" + resultSet.getObject(1) + ",\"" + resultSet.getObject(2) + "\", \"" + Integer.parseInt(resultSet.getString(4)) + "\")'>");
                                    out.print("<div class='card-content'>");
                                    out.print("<div class='row'>");
                                    out.print("<div class='col s3'>");
                                    out.print("<i class='material-icons'>filter_hdr</i> ");
                                    out.print("</div>");
                                    out.print("<div class='col s9'>");
                                    out.println(resultSet.getObject(2));
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
                    <div id="minuman" class="col s12">
                        <div class="row">
                            <%
                                query = "SELECT * FROM menu WHERE jenis='1'";
                                Class.forName("com.mysql.jdbc.Driver");
                                userName = "root";
                                password = "";
                                url = "jdbc:mysql://localhost/sikolin";
                                connection = DriverManager.getConnection(url, userName, password);
                                statement = connection.createStatement();
                                resultSet = statement.executeQuery(query);

                                // process to show table
                                metaData = resultSet.getMetaData();

                                while (resultSet.next()) {
                                    out.print("<div class='col s6'>");
                                    out.print("<div class='card' onclick='addToCart(" + resultSet.getObject(1) + ",\"" + resultSet.getObject(2) + "\", \"" + Integer.parseInt(resultSet.getString(4)) + "\")'>");
                                    out.print("<div class='card-content'>");
                                    out.print("<div class='row'>");
                                    out.print("<div class='col s3'>");
                                    out.print("<i class='material-icons'>filter_hdr</i> ");
                                    out.print("</div>");
                                    out.print("<div class='col s9'>");
                                    out.println(resultSet.getObject(2));
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
                    <div id="snack" class="col s12">
                        <div class="row">
                            <%
                                query = "SELECT * FROM menu WHERE jenis='2'";
                                Class.forName("com.mysql.jdbc.Driver");
                                userName = "root";
                                password = "";
                                url = "jdbc:mysql://localhost/sikolin";
                                connection = DriverManager.getConnection(url, userName, password);
                                statement = connection.createStatement();
                                resultSet = statement.executeQuery(query);

                                // process to show table
                                metaData = resultSet.getMetaData();

                                while (resultSet.next()) {
                                    out.print("<div class='col s6'>");
                                    out.print("<div class='card' onclick='addToCart(" + resultSet.getObject(1) + ",\"" + resultSet.getObject(2) + "\", \"" + Integer.parseInt(resultSet.getString(4)) + "\")'>");
                                    out.print("<div class='card-content'>");
                                    out.print("<div class='row'>");
                                    out.print("<div class='col s3'>");
                                    out.print("<i class='material-icons'>filter_hdr</i> ");
                                    out.print("</div>");
                                    out.print("<div class='col s9'>");
                                    out.println(resultSet.getObject(2));
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
            </div>

            <div class="col s3 teal lighten-5 columns">
                <form action="SubmitOrder">
                    <input type="hidden" name="itemCount" id="itemCount" value="0"></input>

                    <div id="shopcart" style="overflow-y: scroll; height:65vh;">


                    </div>
                    <div id="totalHarga">Total : Rp. 0</div>
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
