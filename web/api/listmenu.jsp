<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.sikolin.HashKey"%>
<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%
    JSONObject json = new JSONObject();
    if ((request.getMethod().equalsIgnoreCase("POST")) && (request.getParameter("username") != null) && (request.getParameter("authkey") != null)) {
        try {
            String dbUsername = "root";
            String dbPassword = "root";
            String dbUrl = "jdbc:mysql://localhost/sikolin";
            String username = request.getParameter("username");
            String authkey = request.getParameter("authkey");
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
            String query = "SELECT id, role FROM user WHERE username='" + username + "'";
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);
            resultSet.next();
            int id = Integer.parseInt(resultSet.getObject(1).toString());
            int role = Integer.parseInt(resultSet.getObject(2).toString());
            String compare = HashKey.md5(username + role + id);
            if (compare.equals(authkey)) {
                json.put("status", true);
                JSONArray listMakanan = new JSONArray();
                String queryMenu = "SELECT * FROM menu";
                Statement statementMenu = connection.createStatement();
                ResultSet resultSetMenu = statementMenu.executeQuery(queryMenu);
                while (resultSetMenu.next()) {
                    JSONObject mymenu = new JSONObject();
                    int id_menu = Integer.parseInt(resultSetMenu.getObject(1).toString());
                    String nama_menu = resultSetMenu.getObject(2).toString();
                    int jenis_menu = Integer.parseInt(resultSetMenu.getObject(3).toString());
                    int harga_menu = Integer.parseInt(resultSetMenu.getObject(4).toString());
                    String foto_menu = resultSetMenu.getObject(5).toString();
                    int id_seller = Integer.parseInt(resultSetMenu.getObject(6).toString());
                    Statement statementPenjual = connection.createStatement();
                    String queryPenjual = "SELECT username FROM user WHERE id='" + id_seller + "'";
                    ResultSet resultSetPenjual = statementPenjual.executeQuery(queryPenjual);
                    resultSetPenjual.next();
                    String nama_penjual = resultSetPenjual.getObject(1).toString();
                    mymenu.put("id_menu", id_menu);
                    mymenu.put("nama_menu", nama_menu);
                    mymenu.put("jenis_menu", jenis_menu);
                    mymenu.put("harga_menu", harga_menu);
                    mymenu.put("foto_menu", foto_menu);
                    mymenu.put("nama_penjual", nama_penjual);
                    listMakanan.add(mymenu);
                }
                json.put("menu", listMakanan);
            } else {
                json.put("status", false);
                json.put("error_msg", "Invalid Token");
            }
        } catch (Exception e) {
            json.put("status", false);
            json.put("error_msg", e.toString());
        }
    } else {
        json.put("status", false);
        json.put("error_msg", "Not Authorized");
    }
    out.print(json);
%>