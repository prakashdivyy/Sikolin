<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--Import Google Icon Font-->
        <link href="http://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

        <!--Import materialize.css-->
        <link type="text/css" rel="stylesheet" href="assets/css/materialize.min.css"  media="screen,projection"/>
        
        <link type="text/css" rel="stylesheet" href="assets/css/style.css"/>
        <title>Homepage</title>
    </head>
    <body class="light-blue lighten-5">
        <!-- Dropdown Structure -->
        <ul id="dropdown1" class="dropdown-content">
            <li><a href="#!">one</a></li>
            <li><a href="#!">two</a></li>
            <li class="divider"></li>
            <li><a href="#!">three</a></li>
        </ul>
        <nav>
            <div class="nav-wrapper teal lighten-1">
                <a href="index.jsp" class="brand-logo"><img src="assets/logosikolin.png" height="64px"/><img src="assets/textsikolin.png"  height="48px"/> </a>
                <ul class="right hide-on-med-and-down">
                    
                    <!-- Dropdown Trigger -->
                    <li><a class="dropdown-button" href="#!" data-activates="dropdown1"><i class="material-icons right">menu</i></a></li>
                </ul>
            </div>
        </nav>
        <!--Import jQuery before materialize.js-->
        <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
        <script type="text/javascript" src="assets/js/materialize.min.js"></script>
        <script>
            $(document).ready(function () {
                $(".dropdown-button").dropdown();
            });
        </script>
    </body>
</html>
