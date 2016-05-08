<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.util.Date"%>
<%
    if ((session.getAttribute("user_id") != null) && (session.getAttribute("role") != null) && (session.getAttribute("role").toString().equals("1"))) {
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Menu Sikolin</title>
        <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/css/materialize.min.css">
    </head>
    <body class="light-blue">
        <div class="container">
            <div class="row">
                <div class="col s6 offset-s3">
                    <div class="card-panel">
                        <div class="center-align row">
                            <h3>Add Menu</h3>
                        </div>
                        <form class="row" method="POST" action="addmenu.jsp" enctype="multipart/form-data">
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
        <script src="assets/js/style.js"></script>
        <%
            if (request.getMethod().equalsIgnoreCase("POST")) {
                File file;
                int maxFileSize = 5000 * 1024;
                int maxMemSize = 5000 * 1024;
                String filePath = "C:\\Users\\Kevin\\Desktop";
                String contentType = request.getContentType();
                if ((contentType.indexOf("multipart/form-data") >= 0)) {
                    DiskFileItemFactory factory = new DiskFileItemFactory();
                    factory.setSizeThreshold(maxMemSize);
                    factory.setRepository(new File("C:\\Users\\Kevin\\Desktop"));
                    ServletFileUpload upload = new ServletFileUpload(factory);
                    upload.setSizeMax(maxFileSize);
                    try {
                        String dbUsername = "root";
                        String dbPassword = "root";
                        String dbUrl = "jdbc:mysql://localhost/sikolin";
                        String name = "";
                        int price = 0;
                        int foodtype = 0;
                        int id_seller = Integer.parseInt(session.getAttribute("role").toString());
                        FileInputStream photo = null;
                        String dir_foto = "";
                        List fileItems = upload.parseRequest(request);
                        Iterator i = fileItems.iterator();
                        while (i.hasNext()) {
                            FileItem fi = (FileItem) i.next();
                            if (!fi.isFormField()) {
                                String fileName = fi.getName();
                                String[] tmp = fileName.split("\\.");
                                String ext = tmp[tmp.length - 1];
                                if (ext.equalsIgnoreCase("jpeg") || ext.equalsIgnoreCase("jpg")) {
                                    Date date = new Date();
                                    long milsec = date.getTime();
                                    dir_foto = filePath + "_sikolin_" + milsec + "_" + fileName;
                                    file = new File(dir_foto);
                                    fi.write(file);
                                    photo = new FileInputStream(file);
                                } else {
                                    throw new Exception("File Not Supported");
                                }
                            } else {
                                String fname = fi.getFieldName();
                                String fvalue = fi.getString();
                                if (fname.equals("name")) {
                                    name = fvalue;
                                } else if (fname.equals("price")) {
                                    price = Integer.parseInt(fvalue);
                                } else if (fname.equals("foodtype")) {
                                    foodtype = Integer.parseInt(fvalue);
                                }
                            }
                        }
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection connection = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
                        String query = "INSERT INTO menu(nama, jenis, harga, foto, id_seller) values(?, ?, ?, ?, ?)";
                        PreparedStatement ps = connection.prepareStatement(query);
                        ps.setString(1, name);
                        ps.setInt(2, foodtype);
                        ps.setInt(3, price);
                        ps.setBlob(4, photo);
                        ps.setInt(5, id_seller);
                        ps.executeUpdate();
                        ps.close();
                        response.sendRedirect("index.jsp");
                    } catch (Exception e) {
        %>
        <script>
            $(document).ready(function () {
                Materialize.toast('<% out.print(e.getMessage()); %>', 4000);
            });
        </script>
        <%
                    }
                }
            }
        %>
    </body>
</html>
<%
    } else {
        response.sendRedirect("login.jsp");
    }
%>