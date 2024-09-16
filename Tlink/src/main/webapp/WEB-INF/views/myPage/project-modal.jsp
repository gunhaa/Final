<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common/modal.css">
    <title>Document</title>
</head>
<body>
<!--모달 팝업-->
<form action="/project/create" method="post">
    <div class="modal">
        <div class="modal_popup">
            <h3>프로젝트 생성</h3>
            <div class="modal-row">
                <span class="input-title">프로젝트명</span><input type="text" name="projectTitle">
            </div>
            <div class="modal-row">
                <span class="input-title">프로젝트 설명</span><input type="text" name="projectInfo">
            </div>
            <div class="btn-area">
                <button type="button" class="close-btn">닫기</button>
                <button class="submit-btn">생성</button>
            </div>
        </div>
    </div>
</form>


</body>
</html>