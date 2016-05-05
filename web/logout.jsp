<%@page session="true"%>
<%
    if ((session.getAttribute("user_id") != null) && (session.getAttribute("role") != null)) {
        session.setAttribute("user_id", null);
        session.setAttribute("role", null);
        session.invalidate();
    }
    response.sendRedirect("login.jsp");
%>
