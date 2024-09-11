<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myPage/sideMenu.css">
    <title>Document</title>
</head>
<body>

    <main>
        <section class="container">
            <div class="sidebar">
                <!-- 프로필 이미지 -->
                <div class="top">
                    <div class="profile-img">
                        <input type="file" style="display: none;" id="inputProfile">
                        <label for="inputProfile">
                            <img src="/resources/images/common/user.png" alt="">
                        </label>
                    </div>
                </div>
                <!-- 메뉴 -->
                <div class="mid">
                    <div class="menu" onclick="location.href='project'">프로젝트</div>
                    <div class="menu">공지사항</div>
                    <div class="menu" onclick="location.href='info'">내 정보</div>
                    <div class="menu" onclick="location.href='changePw'">비밀번호 변경</div>
                    <div class="menu" onclick="location.href='secession'">회원 탈퇴</div>
                </div>
                <div class="bot">
                    <div class="logout" onclick="location.href='/logout'">로그아웃</div>
                </div>
            </div>
        </section>
    </main>

    <c:if test="${!empty message}">

        <script>
            // EL/JSTL 구문이 먼저 해석되는데
            // 문자열의 경우 따옴표가 없는 상태이니 붙여줘야한다!!!
            alert('${message}');
        </script>

    </c:if>
    
</body>
</html>





    