<%--
  Created by IntelliJ IDEA.
  User: fixer
  Date: 2022-11-06
  Time: 오전 12:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Content</title>
</head>
<body>
<button type="button" onclick="location.href='/' ">홈으로</button>
<div>
    <p id="paragraph"><h2>${name}</h2></p>
</div>
<div>
    <video controls width="720">
        <source src="${link}" type="video/mp4">
        브라우저에서 지원되는 포맷이 아닙니다.
    </video>
</div>
</body>
</html>
