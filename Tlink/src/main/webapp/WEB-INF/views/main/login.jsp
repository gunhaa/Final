<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main/main.css">
    <script src="https://kit.fontawesome.com/e245e5bbb1.js" crossorigin="anonymous"></script>
</head>
<body>
    
    <main>
        <section>
            <form action="">
                <div class="login-logo" onclick="location.href='/'"></div>
                <div class="input">
                    <i class="fa-solid fa-user"></i>
                    <input type="text">
                </div>
                <div class="input">
                    <i class="fa-solid fa-key"></i>
                    <input type="password">
                </div>
                <button class="start-btn" onclick="location.href='/myPage/project'">시작하기</button>
                <span onclick="location.href='/findPw'">비밀번호가 기억나지 않으세요?</span>
            </form>
        </section>
    </main>
</body>
</html>
