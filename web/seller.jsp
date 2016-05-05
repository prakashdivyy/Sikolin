<%@page import="org.sikolin.ImageUtil"%>
<%@page import="java.io.File"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
            File imageFile = new File("/tmp/images.jpeg");
            String img = ImageUtil.imageToBase64String(imageFile);
        %>
        <img src="data:image/jpeg;base64,<% out.print(img);%>">
    </body>
</html>
