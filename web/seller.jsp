<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<%
    if ((session.getAttribute("user_id") != null) && (session.getAttribute("role") != null) && (session.getAttribute("role").toString().equals("1"))) {
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/css/materialize.min.css">
        <link type="text/css" rel="stylesheet" href="assets/css/animate.css" media="screen,projection"/>
        <link type="text/css" rel="stylesheet" href="assets/css/style.css"/>
        <title>Sikolin Home Page</title>
    </head>
    <body class="light-blue lighten-5">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.3/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/js/materialize.min.js"></script>
        <script src="assets/js/homepage.js"></script>
        <nav>
            <div class="nav-wrapper teal lighten-1 z-depth-2 ">
                <a href="index.jsp" class="brand-logo">
                    <img src="assets/img/logosikolin.png" height="64"/>
                    <img src="assets/img/textsikolin.png"  height="48"/>
                </a>
                <ul id="nav-mobile" class="right hide-on-med-and-down">
                    <li><a href="addmenu.jsp">Tambah Menu</a></li>
                    <li><a href="logout.jsp">Logout</a></li>
                </ul>
            </div>
        </nav>
        <div class="row">
            <div class="col s12 amber lighten-4">
                <div class="row">
                    <h3> Daftar Menu Kantin Fasilkom </h3>
                    <div class="col s12">
                        <ul class="tabs">
                            <li class="tab col s6"><a class="active" href="#inprogress">In Progress</a></li>
                            <li class="tab col s6"><a href="#completed">Completed</a></li>
                        </ul>
                    </div>
                </div>
                <div id="inprogress">
                    <div class="row">
                        <div class="col s12">
                            <div class="card">
                                <div class="card-content">
                                    <div class="row">
                                        <div class='col s2'>
                                            LALALA
                                        </div>
                                        <div class='col s9 offset-s1'>
                                            <h5>Nasi Padang</h5>
                                            <h6>Quantity : 6</h6>
                                            <p>JANGAN PEDES MAS!!!</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="completed">
                    <div class="row">
                        <div class="col s12">
                            <div class="card">
                                <div class="card-content">
                                    <div class="row">
                                        <div class='col s2'>
                                            LALALA
                                        </div>
                                        <div class='col s9 offset-s1'>
                                            <h5>Nasi Padang</h5>
                                            <h6>Quantity : 6</h6>
                                            <p>JANGAN PEDES MAS!!!</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col s12">
                            <div class="card">
                                <div class="card-content">
                                    <div class="row">
                                        <div class='col s2'>
                                            LALALA
                                        </div>
                                        <div class='col s9 offset-s1'>
                                            <h5>Nasi Padang</h5>
                                            <h6>Quantity : 6</h6>
                                            <p>JANGAN PEDES MAS!!!</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col s12">
                            <div class="card">
                                <div class="card-content">
                                    <div class="row">
                                        <div class='col s2'>
                                            LALALA
                                        </div>
                                        <div class='col s9 offset-s1'>
                                            <h5>Nasi Padang</h5>
                                            <h6>Quantity : 6</h6>
                                            <p>JANGAN PEDES MAS!!!</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col s12">
                            <div class="card">
                                <div class="card-content">
                                    <div class="row">
                                        <div class='col s2'>
                                            LALALA
                                        </div>
                                        <div class='col s9 offset-s1'>
                                            <h5>Nasi Padang</h5>
                                            <h6>Quantity : 6</h6>
                                            <p>JANGAN PEDES MAS!!!</p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
<%
    } else {
        response.sendRedirect("login.jsp");
    }
%>