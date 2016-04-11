<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.mindrot.jbcrypt.BCrypt"%>
<%@page contentType="application/json" pageEncoding="UTF-8"%>
<%
    JSONObject json = new JSONObject();
    if ((request.getParameter("username") != null) && (request.getParameter("password") != null) && (request.getMethod().equalsIgnoreCase("POST"))) {
        String dbUsername = "root";
        String dbPassword = "root";
        String dbUrl = "jdbc:mysql://localhost/sikolin";
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
            String query = "SELECT password FROM user WHERE username='" + username + "'";
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);
            resultSet.next();
            String hash = (String) resultSet.getObject(1);
            if (BCrypt.checkpw(password, hash)) {
                json.put("auth", 1);
            } else {
                json.put("auth", 0);
            }
        } catch (Exception e) {
            json.put("auth", 0);
        }
    } else {
        json.put("auth", 0);
    }
    out.print(json);
%>