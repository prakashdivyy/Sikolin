<%@page import="org.sikolin.Util"%>
<%@page import="java.sql.Blob"%>
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
        <title>Dashboard Seller</title>
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
            String updateTableSQL = "UPDATE pesanan SET status = ? WHERE id_menu = ? AND id_form = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(updateTableSQL);
            if (progress.equals("0")) {
                preparedStatement.setInt(1, 1);
                preparedStatement.setInt(2, Integer.parseInt(menu_id));
                preparedStatement.setInt(3, Integer.parseInt(form_id));
                preparedStatement.executeUpdate();
                preparedStatement.close();
            } else if (progress.equals("1")) {
                preparedStatement.setInt(1, 2);
                preparedStatement.setInt(2, Integer.parseInt(menu_id));
                preparedStatement.setInt(3, Integer.parseInt(form_id));
                preparedStatement.executeUpdate();
                preparedStatement.close();
                String query = "SELECT jumlah, harga, id_seller FROM pesanan INNER JOIN menu on pesanan.id_menu=menu.id WHERE id_form='" + form_id + "'";
                Statement statement = connection.createStatement();
                ResultSet resultSet = statement.executeQuery(query);
                resultSet.next();
                int jumlah = resultSet.getInt("jumlah");
                int harga = resultSet.getInt("harga");
                int id_seller = resultSet.getInt("id_seller");
                int addMoney = jumlah * harga;
                String query2 = "SELECT credits FROM user WHERE id='" + id_seller + "'";
                Statement statement2 = connection.createStatement();
                ResultSet resultSet2 = statement2.executeQuery(query2);
                resultSet2.next();
                int credits = resultSet2.getInt("credits") + addMoney;
                String updateTableSQL2 = "UPDATE user SET credits = ? WHERE id = ?";
                PreparedStatement preparedStatement2 = connection.prepareStatement(updateTableSQL2);
                preparedStatement2.setInt(1, credits);
                preparedStatement2.setInt(2, id_seller);
                preparedStatement2.executeUpdate();
                preparedStatement2.close();
            }
        }
    %>

    <%
        String userid = session.getAttribute("user_id").toString();
        String dbUsername = "root";
        String dbPassword = "root";
        String dbUrl = "jdbc:mysql://localhost/sikolin";
        Class.forName("com.mysql.jdbc.Driver");
        Connection connection = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
        String qu = "SELECT credits FROM user WHERE id='" + userid + "'";
        Statement st = connection.createStatement();
        ResultSet re = st.executeQuery(qu);
        re.next();
        int credits = re.getInt("credits");
    %>
    <body class="light-blue lighten-5">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.3/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/js/materialize.min.js"></script>
        <script src="assets/js/homepage.js"></script>
        <nav>
            <div class="nav-wrapper light-blue lighten-1 z-depth-2 ">
                <a href="index.jsp" class="brand-logo">
                    <img src="assets/img/logosikolin.png" height="64"/>
                    <img src="assets/img/textsikolin.png"  height="48"/>
                </a>
                <ul id="nav-mobile" class="right hide-on-med-and-down">
                    <li>Credits : Rp. <% out.print(credits); %></li>
                    <li><a href="addmenu.jsp">Tambah Menu</a></li>
                    <li><a href="logout.jsp">Logout</a></li>
                </ul>
            </div>
        </nav>
        <div class="row">
            <div class="col s12">
                <div class="card">
                    <div class="card-content">
                        <div class="row">
                            <br>
                            <div class="col s12">
                                <ul class="tabs">
                                    <li class="tab col s4"><a class="active" href="#neworder" style="color: #00c5c8;">New Order</a></li>
                                    <li class="tab col s4"><a href="#inprogress" style="color: #00c5c8;">In Progress</a></li>
                                    <li></li>
                                    <li class="tab col s4"><a href="#completed" style="color: #00c5c8;">Completed</a></li>
                                </ul>
                            </div>
                        </div>
                        <div id="neworder">
                            <div class="row">
                                <%
                                    String query = "SELECT * FROM pesanan INNER JOIN menu on pesanan.id_menu=menu.id WHERE id_seller='" + userid + "' AND status=0";
                                    Statement statement = connection.createStatement();
                                    ResultSet resultSet = statement.executeQuery(query);
                                    while (resultSet.next()) {
                                        Blob image = resultSet.getBlob("foto");
                                        byte[] imgData = image.getBytes(1, (int) image.length());
                                        String foto_menu = Util.encode(imgData);
                                        String img = "data:image/jpeg;base64," + foto_menu;
                                        int form_id = resultSet.getInt("id_form");
                                        String uname1 = "SELECT username FROM form INNER JOIN user on form.id_user=user.id WHERE form.id='" + form_id + "'";
                                        Statement q1 = connection.createStatement();
                                        ResultSet r1 = q1.executeQuery(uname1);
                                        r1.next();
                                        String username = r1.getString("username");
                                %>
                                <form action="seller.jsp" method="POST">
                                    <div class="col s3">
                                        <div class="card">
                                            <div class="card-image">
                                                <img src="<% out.print(img); %>" width="250px" height="250px">
                                                <span class="card-title"><% out.print(resultSet.getString("nama")); %></span>
                                            </div>
                                            <div class="card-content">
                                                <input type="hidden" name="menu_id" value="<% out.print(resultSet.getInt("id_menu")); %>">
                                                <input type="hidden" name="form_id" value="<% out.print(resultSet.getInt("id_form")); %>">
                                                <input type="hidden" name="progress" value="0">
                                                <p>
                                                    <b>Id Pesanan :</b> 
                                                    <% out.print(resultSet.getInt("id_form")); %>
                                                </p>
                                                <p>
                                                    <b>Pemesan :</b> 
                                                    <% out.print(username); %>
                                                </p>
                                                <p>
                                                    <b>Jumlah :</b> 
                                                    <% out.print(resultSet.getInt("jumlah")); %>
                                                </p>
                                                <p>
                                                    <b>Pesan :</b>
                                                </p>
                                                <p>
                                                    <% if (resultSet.getString("keterangan") != null) { %>
                                                    <% out.print(resultSet.getString("keterangan")); %>
                                                    <% } else { %>
                                                    -
                                                    <% } %>
                                                </p>
                                            </div>
                                            <div class="card-action">
                                                <input class="waves-effect waves-light btn light-blue lighten-1" type="submit" value="Mulai Masak">
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                        <div id="inprogress">
                            <div class="row">
                                <%
                                    query = "SELECT * FROM pesanan INNER JOIN menu on pesanan.id_menu=menu.id WHERE id_seller='" + userid + "' AND status=1";
                                    Statement statement2 = connection.createStatement();
                                    ResultSet resultSet2 = statement2.executeQuery(query);
                                    while (resultSet2.next()) {
                                        Blob image = resultSet2.getBlob("foto");
                                        byte[] imgData = image.getBytes(1, (int) image.length());
                                        String foto_menu = Util.encode(imgData);
                                        String img = "data:image/jpeg;base64," + foto_menu;
                                        int form_id = resultSet2.getInt("id_form");
                                        String uname2 = "SELECT username FROM form INNER JOIN user on form.id_user=user.id WHERE form.id='" + form_id + "'";
                                        Statement q2 = connection.createStatement();
                                        ResultSet r2 = q2.executeQuery(uname2);
                                        r2.next();
                                        String username = r2.getString("username");
                                %>
                                <form action="seller.jsp" method="POST">
                                    <div class="col s3">
                                        <div class="card">
                                            <div class="card-image">
                                                <img src="<% out.print(img); %>" width="250px" height="250px">
                                                <span class="card-title"><% out.print(resultSet2.getString("nama")); %></span>
                                            </div>
                                            <div class="card-content">
                                                <input type="hidden" name="menu_id" value="<% out.print(resultSet2.getInt("id_menu")); %>">
                                                <input type="hidden" name="form_id" value="<% out.print(resultSet2.getInt("id_form")); %>">
                                                <input type="hidden" name="progress" value="1">
                                                <p>
                                                    <b>Id Pesanan :</b> 
                                                    <% out.print(resultSet2.getInt("id_form")); %>
                                                </p>
                                                <p>
                                                    <b>Jumlah :</b> 
                                                    <% out.print(resultSet2.getInt("jumlah")); %>
                                                </p>
                                                <p>
                                                    <b>Pesan :</b>
                                                </p>
                                                <p>
                                                    <% if (resultSet2.getString("keterangan") != null) { %>
                                                    <% out.print(resultSet2.getString("keterangan")); %>
                                                    <% } else { %>
                                                    -
                                                    <% } %>
                                                </p>
                                            </div>
                                            <div class="card-action">
                                                <input class="waves-effect waves-light btn light-blue lighten-1" type="submit" value="Selesai Masak">
                                            </div>
                                        </div>
                                    </div>
                                </form>
                                <%
                                    }
                                %>
                            </div>
                        </div>
                        <div id="completed">
                            <div class="row">
                                <%
                                    query = "SELECT * FROM pesanan INNER JOIN menu on pesanan.id_menu=menu.id WHERE id_seller='" + userid + "' AND status between 2 and 3";
                                    Statement statement3 = connection.createStatement();
                                    ResultSet resultSet3 = statement3.executeQuery(query);
                                    while (resultSet3.next()) {
                                        Blob image = resultSet3.getBlob("foto");
                                        byte[] imgData = image.getBytes(1, (int) image.length());
                                        String foto_menu = Util.encode(imgData);
                                        String img = "data:image/jpeg;base64," + foto_menu;
                                        int form_id = resultSet3.getInt("id_form");
                                        String uname3 = "SELECT username FROM form INNER JOIN user on form.id_user=user.id WHERE form.id='" + form_id + "'";
                                        Statement q3 = connection.createStatement();
                                        ResultSet r3 = q3.executeQuery(uname3);
                                        r3.next();
                                        String username = r3.getString("username");
                                %>
                                <div class="col s3">
                                    <div class="card">
                                        <div class="card-image">
                                            <img src="<% out.print(img); %>" width="250px" height="250px">
                                            <span class="card-title"><% out.print(resultSet3.getString("nama")); %></span>
                                        </div>
                                        <div class="card-content">
                                            <p>
                                                <b>Id Pesanan :</b> 
                                                <% out.print(resultSet3.getInt("id_form")); %>
                                            </p>
                                            <p>
                                                <b>Jumlah :</b> 
                                                <% out.print(resultSet3.getInt("jumlah")); %>
                                            </p>
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
            </div>
        </div>
    </body>
</html>
<%
    } else {
        response.sendRedirect("login.jsp");
    }
%>
