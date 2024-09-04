<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main/main.css">
    <title>TLink</title>
</head>
<body>
    <main>
        <section>
            <div class="main-logo"></div>
            <div class="btn-area">
                <button class="login-btn" onclick="location.href='/login'">로그인</button>
                <button class="signUp-btn" onclick="location.href='/signup'">회원가입</button>
            </div>
        </section>
    </main>
    
</body>
</html>