<%--
  Created by IntelliJ IDEA.
  User: fixer
  Date: 2022-11-05
  Time: 오전 10:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Trinity Helper</title>
    <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/trinity.css"/>">
    <!-- include libraries -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.14.0/css/all.min.css" integrity="sha512-1PKOgIY59xJ8Co8+NE6FZ+LOAZKjy+KY8iq0G4B3CyeY6wYHN3yt9PW0XpSriVlkMXe40PTKnXrLnZ9+fkDaog==" crossorigin="anonymous" />
    <style>
        body{
            background-color: #212529;
        }
        .wrapper{
            max-width: 576px;
            margin: 0 auto;
            color: white;
            font-family: 'Noto Sans KR', sans-serif;
            padding: 15px;
        }
        .noto-thin { font-weight: 100; }
        .noto-regular { font-weight: 400; }
        .noto-bold { font-weight: 700; }
        .noto-extra { font-weight: 900; }
        .my-card {
            min-height: 100px;
            background-color: white;
            border-radius: 10px;
            margin: 20px 0;
            padding: 15px;
        }
        .my-title{
            color: #212529;
            font-size: 16px;
        }
        .my-text{
            color: #212529;
            font-size: 12px;
        }
        .main-notice{
            color: gold;
            font-size: 12px;
            text-align: center;
        }
        .my-block{
            display: block;
            height: 50px;
            border: 1px solid #00AAFF;
            border-radius: 4px;
            margin-bottom: 5px;
            line-height: 50px;
            text-align: center;
        }

    </style>
</head>
<body>
<div class="wrapper">
    <h1 class="noto-extra" style="margin-top: 30px">수강신청 헬퍼</h1>
    <h5 class="noto-regular" style="margin-top: 40px; line-height: 30px; margin-bottom: 20px">수강신청 헬퍼는 수강 제한 인원을 미리 확인할 수 있습니다(자기 학년 기준). 그리고 현재 수강 신청 인원이 몇명인지 확인할 수 있습니다.</h5>
    <div class="login" style="margin: 80px 0 40px 0">
        <form action="/search" method="post">
            <!--<p class="main-notice">변경된 운영규칙을 반드시 확인하시기 바랍니다. (하단 공지사항 참조)</p>-->
            <p class="main-notice">수강 제한 인원을 확인하세요!</p>
            <!--<p class="main-notice">문자전송 서비스 운영 시간이 아닙니다. (하단 공지사항 참조)</p>-->
            <div class="row">
                <div class="col-1"></div>
                <div class="col-10">
                    <input type="text" class="form-control form-control-lg" name="subjNo" placeholder="과목 코드 입력" style="font-size:16px; text-align:center" pattern="[0-9]+" required>
                </div>
            </div>
            <div class="row">
                <div class="col-1"></div>
                <div class="col-10">
                    <input type="text" class="form-control form-control-lg" name="no" placeholder="분반 입력" style="font-size:16px; text-align:center" pattern="[0-9]+" required>
                </div>
            </div>
            <div class="row">
                <div class="col-1"></div>
                <div class="col-10">
                    <input type="text" class="form-control form-control-lg" name="userId" placeholder="트리니티 id 입력" style="font-size:16px; text-align:center" required>
                </div>
            </div>
            <div class="row">
                <div class="col-1"></div>
                <div class="col-10">
                    <input type="password" class="form-control form-control-lg" name="userPw" placeholder="트리니티 pw 입력" style="font-size:16px; text-align:center" required>
                </div>
            </div>
            <div class="row">
                <div class="col-1"></div>
                <div class="col-10">
                    <input type="text" class="form-control form-control-lg" name="year" placeholder="년도 입력" style="font-size:16px; text-align:center" pattern="[0-9]+" required>
                </div>
            </div>
            <div class="row">
                <div class="col-1"></div>
                <div class="col-10">
                    <input type="text" class="form-control form-control-lg" name="semester" placeholder="학기 입력" style="font-size:16px; text-align:center" pattern="[0-9]+" required>
                </div>
            </div>
            <div class="row">
                <div class="col-4"></div>
                <input type="submit" class="col-4 btn btn-info" value="로그인" style="margin: 20px 0">
            </div>
        </form>
        <p style="font-size: 12px">트리니티 아이디 비밀번호는 수집되지 않습니다. 또한 서버에 어떠한 기록도 남기지 않습니다!! 개인정보와 관련된 문의는 1876070677@shbox.kr로 문의해주세요.</p>
        <p style="font-size: 12px">본 사이트는 cuk.haenu.com 사이트의 트리니티 헬퍼의 레이아웃을 참조하였으며, https://github.com/dokdo2013/haenu-api의 파이썬 코드를 fastapi로 구현하였습니다.</p>
    </div>
    <hr style="margin: 10px 0; color: white; background-color: white">
    <c:if test="${totalNum ne null}">
        <div class="my-card support">
            <p class="my-title">조회 결과</p>
            <div class="accordion" id="noticeaccordion">
                <p class="my-text">강의명 : ${className}</p>
                <p class="my-text">수강 제한 인원 : ${totalNum}</p>
                <p class="my-text">현재 수강신청 인원 : ${nowNum}</p>
            </div>
        </div>
    </c:if>
</div>
</body>
</html>
