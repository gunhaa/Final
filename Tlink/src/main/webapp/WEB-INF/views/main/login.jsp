<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main/main.css">
    <script src="${pageContext.request.contextPath}/resources/js/main/main.js" defer></script>
    <script src="https://kit.fontawesome.com/e245e5bbb1.js" crossorigin="anonymous"></script>
</head>
<body>
    
    <main>
        <section>
            <form action="/login" method="post">
                <div class="login-logo" onclick="location.href='/'"></div>
                <div class="input">
                    <i class="fa-solid fa-user"></i>
                    <input type="text" name="userEmail">
                </div>
                <div class="input">
                    <i class="fa-solid fa-key"></i>
                    <input type="password" name="userPw">
                </div>
                <button class="start-btn">시작하기</button>
                <span onclick="location.href='/findPw'">비밀번호가 기억나지 않으세요?</span>
            </form>
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
