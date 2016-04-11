<%@page import="java.io.BufferedReader"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="org.mindrot.jbcrypt.BCrypt"%>
<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%
    JSONObject json = new JSONObject();
    if (request.getMethod().equalsIgnoreCase("POST")) {
        JSONParser parser = new JSONParser();
        String dbUsername = "root";
        String dbPassword = "root";
        String dbUrl = "jdbc:mysql://localhost/sikolin";
        BufferedReader reader = request.getReader();
        try {
            Object obj = parser.parse(reader);
            JSONObject jsonObject = (JSONObject) obj;
            String username = (String) jsonObject.get("username");
            String password = (String) jsonObject.get("password");
            String role = (String) jsonObject.get("role");
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection connection = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
                String hash_pass = BCrypt.hashpw(password, BCrypt.gensalt(12));
                String query = "INSERT INTO user(username, password, role) values(?, ?, ?)";
                PreparedStatement ps = connection.prepareStatement(query);
                ps.setString(1, username);
                ps.setString(2, hash_pass);
                ps.setString(3, role);
                ps.executeUpdate();
                ps.close();
                json.put("status", true);
                json.put("message", "Thank you for register");
            } finally {

            }
        } catch (Exception e) {
            json.put("status", false);
            json.put("message", "Username Exist");
        }
    } else {
        json.put("status", false);
        json.put("message", "Not Authorized");
    }
    out.print(json);
%>