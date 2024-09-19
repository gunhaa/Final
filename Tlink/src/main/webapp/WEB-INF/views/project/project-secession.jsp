<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프로젝트 탈퇴</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myPage/myPage.css">
    <script src="${pageContext.request.contextPath}/resources/js/myPage/secession.js" defer></script>
</head>

<body>

    <main>

        <section class="container" style="display: flex;">
            <jsp:include page="/WEB-INF/views/common/side.jsp" />
            <!-- 우측 -->
            <div class="content">
                <div class="title">프로젝트 탈퇴</div>

                <!-- 상단 카드 -->
                <form action="/myPage/secession" method="post" id="secessionFrm">


                    <div class="card">
                        <div class="terms">
                            <span>프로젝트 탈퇴에 관한 약관</span>
                            <span>1. 프로젝트 내 정보가 소실됩니다.</span>
                            <span>2. 초대를 받아야 재가입 할 수 있습니다.</span>
                            <span>3. 내가 작업한 내용은 유지됩니다.</span>
                            <span>4. 프로젝트 매니저라면 직위를 위임하여야 합니다.</span>
                        </div>
                    </div>

                    <div class="card">
                        <div class="card-row">
                            <div class="agree">
                                위의 약관을 확인했습니다.
                            </div>
                            <div>
                                <input type="checkbox" id="agree">
                            </div>
                        </div>
                    </div>

                    <div class="btn-area">
                        <button type="submit">탈퇴</button>
                    </div>
                </form>
            </div>
        </section>
    </main>

</body>

</html>
