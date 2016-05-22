<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if ((request.getMethod().equalsIgnoreCase("POST")) && (request.getParameter("email") != null) && (request.getParameter("user_id") != null) && (session.getAttribute("user_id") != null)) {
        try {
            int kama_user_id = Integer.parseInt(request.getParameter("user_id"));
            int sikolin_user_id = Integer.parseInt(session.getAttribute("user_id").toString());
            if (kama_user_id != sikolin_user_id) {
                response.sendRedirect("../../buyer.jsp");
            } else {
                String dbUsername = "root";
                String dbPassword = "root";
                String dbUrl = "jdbc:mysql://localhost/sikolin";
                String email = request.getParameter("email");
                Class.forName("com.mysql.jdbc.Driver");
                Connection connection = DriverManager.getConnection(dbUrl, dbUsername, dbPassword);
                String updateTableSQL = "UPDATE user SET kama = ? WHERE id = ?";
                PreparedStatement preparedStatement = connection.prepareStatement(updateTableSQL);
                preparedStatement.setString(1, email);
                preparedStatement.setInt(2, kama_user_id);
                preparedStatement.executeUpdate();
                preparedStatement.close();
                response.sendRedirect("../../buyer.jsp");
            }
        } catch (Exception e) {
            response.sendRedirect("../../buyer.jsp");
        }
    } else {
        response.sendRedirect("../../login.jsp");
    }
%>