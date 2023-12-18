<%--
  Created by IntelliJ IDEA.
  User: fixer
  Date: 2022-11-05
  Time: 오전 1:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
  request.setCharacterEncoding("utf-8");
  Cookie[] cookies = request.getCookies();
  String cookieName = "";
  String cookieValue = "";

  if (cookies != null) {
    for (int i = 0; i < cookies.length ; i++) {
      if(cookies[i].getName().equals("id")) {
        cookieName = cookies[i].getName();
        cookieValue = cookies[i].getValue();
      }
    }
  }
%>
<html>
  <head>
    <title>Main page</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!--===============================================================================================-->
    <link rel="icon" type="image/png" href="<c:url value="/resources/images/icons/favicon.ico"/>"/>
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/vendor/bootstrap/css/bootstrap.min.css"/>">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/fonts/font-awesome-4.7.0/css/font-awesome.min.css"/>">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/vendor/animate/animate.css"/>">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/vendor/css-hamburgers/hamburgers.min.css"/>">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/vendor/animsition/css/animsition.min.css"/>">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/vendor/select2/select2.min.css"/>">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/vendor/daterangepicker/daterangepicker.css"/>">
    <!--===============================================================================================-->
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/util.css"/>">
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/main.css"/>">
    <!--===============================================================================================-->
  </head>
  <body>
  <div class="limiter">
    <div class="container-login100">
      <div class="wrap-login100">
        <%
          if (cookieName.equals("")) {
        %>
        <form action="/login" method="post" class="login100-form validate-form p-l-55 p-r-55 p-t-178">
          <input type="hidden" name="api" value="SYNO.API.Auth">
          <input type="hidden" name="version" value="3">
          <input type="hidden" name="method" value="login">
          <input type="hidden" name="session" value="FileStation">
          <input type="hidden" name="format" value="cookie">
					<span class="login100-form-title">
						Log In (id : selab / pw : Sepass1!)
					</span>

          <div class="wrap-input100 validate-input m-b-16" data-validate="Please enter username">
            <input class="input100" type="text" name="account" placeholder="Username">
            <span class="focus-input100"></span>
          </div>

          <div class="wrap-input100 validate-input" data-validate = "Please enter password">
            <input class="input100" type="password" name="passwd" placeholder="Password">
            <span class="focus-input100"></span>
          </div>

          <div class="text-right p-t-13 p-b-23">
          </div>

          <div class="container-login100-form-btn">
            <input class="login100-form-btn" type="submit" value="로그인"><br/>
          </div>

          <div class="flex-col-c p-t-170 p-b-40">
          </div>
        </form>
        <%
        } else {
        %>
        <div class="login100-form validate-form p-l-55 p-r-55 p-t-178">
          <span class="login100-form-title">
            로그인 성공!!
          </span>
          <div class="flex-col-c p-t-170 p-b-40">
            <span class="txt3">
              SiHyeon's WebStation
            </span>
            <span class="txt1 p-b-9">
              에 오신걸 환영합니다!!
            </span>
          </div>
          <div class="container-login100-form-btn">
            <form action="/logout" method="post" >
              <input type="hidden" name="api" value="SYNO.API.Auth">
              <input type="hidden" name="version" value="1">
              <input type="hidden" name="method" value="logout">
              <input type="hidden" name="session" value="FileStation">
              <input type="hidden" name="_sid" value=<%= cookieValue %>>
              <input class="login100-form-btn" type="submit" value="로그아웃"><br/>
            </form>
          </div>
          <div class="container-login100-form-btn">
            <form action="/list" method="post">
              <input type="hidden" name="api" value="SYNO.FileStation.List">
              <input type="hidden" name="version" value="2">
              <input type="hidden" name="method" value="list">
              <input type="hidden" name="sort_by" value="crtime">
              <input type="hidden" name="folder_path" value="/web/web_video">
              <input type="hidden" name="_sid" value=<%= cookieValue %>>
              <input class="login100-form-btn" type="submit" value="영상 목록 보기"><br/>
            </form>
          </div>
          <%
            }
          %>
      </div>
    </div>
  </div>

    <!--===============================================================================================-->
    <script src='<c:url value="/resources/vendor/jquery/jquery-3.2.1.min.js"/>'></script>
    <!--===============================================================================================-->
    <script src='<c:url value="/resources/vendor/animsition/js/animsition.min.js"/>'></script>
    <!--===============================================================================================-->
    <script src='<c:url value="/resources/vendor/bootstrap/js/popper.js"/>'></script>
    <script src='<c:url value="/resources/vendor/bootstrap/js/bootstrap.min.js"/>'></script>
    <!--===============================================================================================-->
    <script src='<c:url value="/resources/vendor/select2/select2.min.js"/>'></script>
    <!--===============================================================================================-->
    <script src='<c:url value="/resources/vendor/daterangepicker/moment.min.js"/>'></script>
    <script src='<c:url value="/resources/vendor/daterangepicker/daterangepicker.js"/>'></script>
    <!--===============================================================================================-->
    <script src='<c:url value="/resources/vendor/countdowntime/countdowntime.js"/>'></script>
    <!--===============================================================================================-->
    <script src='<c:url value="/resources/js/login.js"/>'></script>
  </body>
</html>
