<%--
  Created by IntelliJ IDEA.
  User: fixer
  Date: 2022-11-05
  Time: 오후 8:07
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <title>File List</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

    <link rel="stylesheet" href="<c:url value="/resources/css/style.css"/>">
</head>
<body>
<button type="button" onclick="location.href='/' ">홈으로</button>
<section class="ftco-section">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6 text-center mb-5">
                <h2 class="heading-section">영상 또는 디렉토리 목록</h2>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="table-wrap">
                    <table class="table">
                        <thead class="thead-dark">
                        <tr>
                            <th>ID no.</th>
                            <th>바로가기링크</th>
                            <th>디렉토리표시</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="fileList" items="${fileList}" varStatus="status">
                            <tr class="alert" role="alert">
                                <th scope="row">${status.count}</th>
                                <c:if test="${fileList.isdir eq 'true'}">
                                    <td>
                                        <form action="/list" method="post" id="${fileList.name}">
                                            <input type="hidden" name="api" value="SYNO.FileStation.List">
                                            <input type="hidden" name="version" value="2">
                                            <input type="hidden" name="method" value="list">
                                            <input type="hidden" name="sort_by" value="crtime">
                                            <input type="hidden" name="folder_path" value="${fileList.path}">
                                            <input type="hidden" name="_sid" value=<%= cookieValue %>>
                                            <a href="javascript:;" onclick="document.getElementById('${fileList.name}').submit();">${fileList.name}</a>
                                        </form>
                                    </td>
                                    <td>${fileList.isdir}</td>
                                </c:if>
                                <c:if test="${fileList.isdir eq 'false'}">
                                    <td>
                                        <form action="/content" method="post" id="${fileList.name}">
                                            <input type="hidden" name="name" value="${fileList.name}">
                                            <input type="hidden" name="path" value="${fileList.path}">
                                            <a href="javascript:;" onclick="document.getElementById('${fileList.name}').submit();">${fileList.name}</a>
                                        </form>
                                    </td>
                                    <td>${fileList.isdir}</td>
                                </c:if>
                            </tr>
                        </c:forEach>

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</section>
<script src='<c:url value="/resources/js/jquery.min.js"/>'></script>
<script src='<c:url value="/resources/js/popper.js"/>'></script>
<script src='<c:url value="/resources/js/bootstrap.min.js"/>'></script>
<script src='<c:url value="/resources/js/main.js"/>'></script>
</body>
</html>
