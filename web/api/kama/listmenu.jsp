<%@page import="org.sikolin.Util"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%
    JSONObject json = new JSONObject();
    if (request.getMethod().equalsIgnoreCase("POST")) {
        try {
            String dbUsername = "root";
            String dbPassword = "root";
            String dbUrl = "jdbc:mysql://localhost/sikolin";
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
            json.put("status", true);
            JSONArray listMakanan = new JSONArray();
            String queryMenu = "SELECT * FROM menu";
            Statement statementMenu = connection.createStatement();
            ResultSet resultSetMenu = statementMenu.executeQuery(queryMenu);
            while (resultSetMenu.next()) {
                JSONObject mymenu = new JSONObject();
                int id_menu = resultSetMenu.getInt("id");
                String nama_menu = resultSetMenu.getString("nama");
                int harga_menu = resultSetMenu.getInt("harga");
                Blob image = resultSetMenu.getBlob("foto");
                byte[] imgData = image.getBytes(1, (int) image.length());
                String foto_menu = Util.encode(imgData);
                int id_seller = resultSetMenu.getInt("id_seller");
                float rating = resultSetMenu.getFloat("total_rating");
                Statement statementPenjual = connection.createStatement();
                String queryPenjual = "SELECT username FROM user WHERE id='" + id_seller + "'";
                ResultSet resultSetPenjual = statementPenjual.executeQuery(queryPenjual);
                resultSetPenjual.next();
                mymenu.put("id_menu", id_menu);
                mymenu.put("nama_menu", nama_menu);
                mymenu.put("harga_menu", harga_menu);
                mymenu.put("foto_menu", foto_menu);
                mymenu.put("rating", rating);
                listMakanan.add(mymenu);
            }
            json.put("menu", listMakanan);
        } catch (Exception e) {
            json.put("status", false);
        }
    } else {
        json.put("status", false);
    }
    out.print(json);
%>