<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<%
    if ((session.getAttribute("user_id") != null) && (session.getAttribute("role") != null) && (session.getAttribute("role").toString().equals("1"))) {
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
    <%
        if ((request.getParameter("menu_id") != null) && (request.getParameter("form_id") != null) && (request.getParameter("progress") != null) && (request.getMethod().equalsIgnoreCase("POST"))) {
            String dbUsername = "root";
            String dbPassword = "root";
            String dbUrl = "jdbc:mysql://localhost/sikolin";
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
            String menu_id = request.getParameter("menu_id");
            String form_id = request.getParameter("form_id");
            String progress = request.getParameter("progress");
            // TODO LATER
            //String updateTableSQL = "UPDATE pesanan SET USERNAME = ? WHERE USER_ID = ?";
            //PreparedStatement preparedStatement = connection.prepareStatement(updateTableSQL);
            //preparedStatement.setString(1, "mkyong_new_value");
            //preparedStatement.setInt(2, 1001);
            out.print(menu_id + " " + form_id + " " + progress);
        }
    %>
    <body class="light-blue lighten-5">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.3/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/js/materialize.min.js"></script>
        <script src="assets/js/homepage.js"></script>
        <nav>
            <div class="nav-wrapper teal lighten-1 z-depth-2 ">
                <a href="index.jsp" class="brand-logo">
                    <img src="assets/img/logosikolin.png" height="64"/>
                    <img src="assets/img/textsikolin.png"  height="48"/>
                </a>
                <ul id="nav-mobile" class="right hide-on-med-and-down">
                    <li><a href="addmenu.jsp">Tambah Menu</a></li>
                    <li><a href="logout.jsp">Logout</a></li>
                </ul>
            </div>
        </nav>
        <%
            String userid = session.getAttribute("user_id").toString();
            String dbUsername = "root";
            String dbPassword = "root";
            String dbUrl = "jdbc:mysql://localhost/sikolin";
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
        %>
        <div class="row">
            <div class="col s12 amber lighten-4">
                <div class="row">
                    <br>
                    <div class="col s12">
                        <ul class="tabs">
                            <li class="tab col s4"><a class="active" href="#neworder">New Order</a></li>
                            <li class="tab col s4"><a href="#inprogress">In Progress</a></li>
                            <li class="tab col s4"><a href="#completed">Completed</a></li>
                        </ul>
                    </div>
                </div>
                <div id="neworder">
                    <%
                        String query = "SELECT * FROM pesanan INNER JOIN menu on pesanan.id_menu=menu.id WHERE id_seller='" + userid + "' AND status=0";
                        Statement statement = connection.createStatement();
                        ResultSet resultSet = statement.executeQuery(query);
                        while (resultSet.next()) {
                    %>
                    <div class="row">
                        <form action="seller.jsp" method="POST">
                            <div class="col s12">
                                <div class="card">
                                    <div class="card-content">
                                        <div class="row">
                                            <div class='col s2'>
                                                <% out.print(resultSet.getString("nama")); %>
                                            </div>
                                            <div class='col s9 offset-s1'>
                                                <input type="hidden" name="menu_id" value="<% out.print(resultSet.getInt("id_menu")); %>">
                                                <input type="hidden" name="form_id" value="<% out.print(resultSet.getInt("id_form")); %>">
                                                <input type="hidden" name="progress" value="0">
                                                <h5><% out.print(resultSet.getString("nama")); %></h5>
                                                <h6>Jumlah : <% out.print(resultSet.getInt("jumlah")); %></h6>
                                                <h6>Id Pesanan : <% out.print(resultSet.getInt("id_form")); %></h6>
                                                <h6>Pesan:</h6>
                                                <% if (resultSet.getString("keterangan") != null) { %>
                                                <p><% out.print(resultSet.getString("keterangan")); %></p>
                                                <% } else { %>
                                                <p>-</p>
                                                <% } %>
                                                <input type="submit" value="DONE">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <%
                        }
                    %>
                </div>
                <div id="inprogress">
                    <%
                        query = "SELECT * FROM pesanan INNER JOIN menu on pesanan.id_menu=menu.id WHERE id_seller='" + userid + "' AND status=1";
                        Statement statement2 = connection.createStatement();
                        ResultSet resultSet2 = statement2.executeQuery(query);
                        while (resultSet2.next()) {
                    %>
                    <div class="row">
                        <form action="seller.jsp" method="POST">
                            <div class="col s12">
                                <div class="card">
                                    <div class="card-content">
                                        <div class="row">
                                            <div class='col s2'>
                                                <% out.print(resultSet2.getString("nama")); %>
                                            </div>
                                            <div class='col s9 offset-s1'>
                                                <input type="hidden" name="menu_id" value="<% out.print(resultSet2.getInt("id_menu")); %>">
                                                <input type="hidden" name="form_id" value="<% out.print(resultSet2.getInt("id_form")); %>">
                                                <input type="hidden" name="progress" value="1">
                                                <h5><% out.print(resultSet2.getString("nama")); %></h5>
                                                <h6>Jumlah : <% out.print(resultSet2.getInt("jumlah")); %></h6>
                                                <h6>Id Pesanan : <% out.print(resultSet2.getInt("id_form")); %></h6>
                                                <h6>Pesan:</h6>
                                                <% if (resultSet2.getString("keterangan") != null) { %>
                                                <p><% out.print(resultSet2.getString("keterangan")); %></p>
                                                <% } else { %>
                                                <p>-</p>
                                                <% } %>
                                                <input type="submit" value="DONE">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                    <%
                        }
                    %>
                </div>
                <div id="completed">
                    <%
                        query = "SELECT * FROM pesanan INNER JOIN menu on pesanan.id_menu=menu.id WHERE id_seller='" + userid + "' AND status=2";
                        Statement statement3 = connection.createStatement();
                        ResultSet resultSet3 = statement3.executeQuery(query);
                        while (resultSet3.next()) {
                    %>
                    <div class="row">
                        <div class="col s12">
                            <div class="card">
                                <div class="card-content">
                                    <div class="row">
                                        <div class='col s2'>
                                            <% out.print(resultSet3.getString("nama")); %>
                                        </div>
                                        <div class='col s9 offset-s1'>
                                            <h5><% out.print(resultSet3.getString("nama")); %></h5>
                                            <h6>Jumlah : <% out.print(resultSet3.getInt("jumlah")); %></h6>
                                            <h6>Id Pesanan : <% out.print(resultSet3.getInt("id_form")); %></h6>
                                            <h6>Pesan:</h6>
                                            <% if (resultSet3.getString("keterangan") != null) { %>
                                            <p><% out.print(resultSet3.getString("keterangan")); %></p>
                                            <% } else { %>
                                            <p>-</p>
                                            <% } %>
                                        </div>
                                    </div>
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
    </body>
</html>
<%
    } else {
        response.sendRedirect("login.jsp");
    }
%>
