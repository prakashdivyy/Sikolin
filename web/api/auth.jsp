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
    if ((request.getMethod().equalsIgnoreCase("POST")) && (request.getParameter("username") != null) && (request.getParameter("password") != null)) {
        try {
            String dbUsername = "root";
            String dbPassword = "root";
            String dbUrl = "jdbc:mysql://localhost/sikolin";
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            Class.forName("com.mysql.jdbc.Driver");
            Connection connection = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
            String query = "SELECT * FROM user WHERE username='" + username + "'";
            Statement statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(query);
            resultSet.next();
            String hash = (String) resultSet.getObject(3);
            if (BCrypt.checkpw(password, hash)) {
                json.put("status", true);
                json.put("username", username);
                int credits = Integer.parseInt(resultSet.getObject(4).toString());
                int role = Integer.parseInt(resultSet.getObject(5).toString());
                json.put("credits", credits);
                json.put("role", role);
            } else {
                json.put("status", false);
                json.put("error_msg", "Invalid Username or Password");
            }
        } catch (Exception e) {
            json.put("status", false);
            json.put("error_msg", "Invalid Username or Password");
        }
    } else {
        json.put("status", false);
        json.put("error_msg", "Not Authorized");
    }
    out.print(json);
%>