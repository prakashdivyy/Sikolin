<%@page import="java.io.InputStream"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page  session="true"%>
<%
    if ((session.getAttribute("user_id") == null) && (session.getAttribute("role") == null)) {
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Menu Sikolin</title>
        <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/css/materialize.min.css">
    </head>
    <%
            if ((request.getParameter("name") != null) && (request.getParameter("price") != null) && (request.getParameter("description") != null) && (request.getParameter("foodtype") != null) && (request.getPart("photo") != null) && (request.getMethod().equalsIgnoreCase("POST"))) {
                out.print("haha");
                String dbUsername = "root";
                String dbPassword = "root";
                String dbUrl = "jdbc:mysql://localhost/sikolin";
                String name = request.getParameter("name");
                int price = Integer.parseInt(request.getParameter("price"));
                String description = request.getParameter("description");
                String foodtype = request.getParameter("foodtype");
                int id_seller = Integer.parseInt(session.getAttribute("user_id").toString());
                InputStream inputStream = null; // input stream of the upload file
                Part photo = request.getPart("photo");
                if (photo != null) {
                    // prints out some information for debugging
                    out.print(photo.getName());
                    out.print(photo.getSize());
                    out.print(photo.getContentType());
                    // obtains input stream of the upload file
                    inputStream = photo.getInputStream();
                }
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection connection = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
                    String query = "INSERT INTO menu(nama, jenis, harga, foto, id_seller, deskripsi) values(?, ?, ?, ?, ?, ?)";
                    PreparedStatement ps = connection.prepareStatement(query);
                    ps.setString(1, name);
                    ps.setString(2, foodtype);
                    ps.setInt(3, price);
                    ps.setBlob(4, inputStream);
                    ps.setInt(5, id_seller);
                    ps.setString(6, description);
                    ps.executeUpdate();
                    ps.close();
                    response.sendRedirect("index.jsp");
                } catch (Exception e) {
                    e.getMessage();
                }
            }
        }
    %>
    <body class="light-blue">
        <div class="container">
            <div class="row">
                <div class="col s6 offset-s3">
                    <div class="card-panel">
                        <div class="center-align row">
                            <h3>Add Menu</h3>
                        </div>
                        <form class="row" method="POST" action="seller.jsp" enctype="multipart/form-data">
                            <div class="row">
                                <div class="input-field col s8 offset-s2">
                                    <i class="material-icons prefix">restaurant_menu</i>
                                    <input id="name" type="text" class="validate" name="name" required>
                                    <label for="name">Nama</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="input-field col s8 offset-s2">
                                    <i class="material-icons prefix">attach_money</i>
                                    <input id="price" type="number" class="validate" name="price" required>
                                    <label for="price">Harga</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="input-field col s8 offset-s2">
                                    <i class="material-icons prefix">menu</i>
                                    <select name="foodtype" required>
                                        <option value="" disabled selected>Choose your option</option>
                                        <option value="0">Makanan</option>
                                        <option value="1">Minuman</option>
                                        <option value="2">Snack</option>
                                    </select>
                                    <label>Jenis Item?</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="input-field col s8 offset-s2">
                                    <i class="material-icons prefix">description</i>
                                    <input id="description" type="text" class="validate" name="description" required>
                                    <label for="description">Deskripsi</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="input-field col s8 offset-s2">
                                    <i class="material-icons prefix">add_a_photo</i>
                                    <input id="photo" type="file" class="validate" name="photo" required>

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
        <script>   $(document).ready(function () {
                $('select').material_select();
            });
        </script>

    </body>
</html>
