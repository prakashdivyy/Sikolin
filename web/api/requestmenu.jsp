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
    if ((request.getMethod().equalsIgnoreCase("POST")) && (request.getParameter("username") != null) && (request.getParameter("authkey") != null) && (request.getParameter("id_menu") != null) && (request.getParameter("keterangan") != null) && (request.getParameter("jumlah") != null)) {
        try {
            String dbUsername = "root";
            String dbPassword = "root";
            String dbUrl = "jdbc:mysql://localhost/sikolin";
            String username = request.getParameter("username");
            String authkey = request.getParameter("authkey");
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
            String query = "SELECT id, role, credits FROM user WHERE username='" + username + "'";
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);
            resultSet.next();
            int id = Integer.parseInt(resultSet.getObject(1).toString());
            int role = Integer.parseInt(resultSet.getObject(2).toString());
            String compare = Util.md5(username + role + id);
            if (compare.equals(authkey)) {
                Statement statement2 = connection.createStatement();
                ResultSet result2 = statement2.executeQuery("SELECT * from form");
                int new_id;
                if (!result2.isBeforeFirst()) {
                    new_id = 1;
                } else {
                    result2.last();
                    new_id = Integer.parseInt(result2.getString(1)) + 1;
                }
                String jumlah = request.getParameter("jumlah");
                String id_menu = request.getParameter("id_menu");
                String keterangan = request.getParameter("keterangan");
                Statement statement3 = connection.createStatement();
                ResultSet result3 = statement3.executeQuery("SELECT harga from menu where id = '" + id_menu + "'");
                result3.next();
                int harga = result3.getInt("harga");
                int credit = resultSet.getInt("credits") - (Integer.parseInt(jumlah) * harga);
                if (credit > 0) {
                    String query2 = "INSERT INTO form  values (" + new_id + "," + id + ", NOW())";
                    statement2.addBatch(query2);
                    String tempQuery = "INSERT INTO pesanan values (0," + id + "," + new_id + "," + jumlah + ",'" + keterangan + "',0)";
                    statement2.addBatch(tempQuery);
                    statement2.executeBatch();
                    query = "UPDATE user SET credits='" + credit + "' where id='" + id + "'";
                    statement.executeUpdate(query);
                    json.put("status", true);
                } else {
                    json.put("status", false);
                    json.put("error_msg", "Insufficient Credit");
                }
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