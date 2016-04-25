<%@page session="true"%>
<%
    if (session.getAttribute("user_id") != null) {
        session.setAttribute("user_id", null);
        session.invalidate();
        response.sendRedirect("login.jsp");
    } else {
        response.sendRedirect("login.jsp");
    }
%>
