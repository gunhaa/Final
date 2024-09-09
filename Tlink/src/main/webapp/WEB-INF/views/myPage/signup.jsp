<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myPage/myPage.css">
    <script src="https://kit.fontawesome.com/e245e5bbb1.js" crossorigin="anonymous"></script>
</head>

<body>

    <main class="container2">
${pageContext.request.contextPath}
        <div class="small-logo" onclick="location.href='/'"></div>
        <section>
            <form action="/signUp" method="POST">
                <div class="title">회원가입</div>
                <div class="card">
                    <div class="card-row">
                        <div class="row-title">이메일</div>
                        <div class="row-content">
                            <input type="text" name="userEmail" placeholder="이메일을 입력해주세요.">
                            <button type="button">전송</button>
                        </div>
                    </div>
                    <div class="card-row">
                        <div class="row-title">인증번호</div>
                        <div class="row-content">
                            <input type="text" name="authKey" placeholder="인증번호를 입력해주세요.">
                            <button type="button">인증</button>
                        </div>
                    </div>
                    <div class="card-row">
                        <div class="row-title">비밀번호</div>
                        <div class="row-content">
                            <input type="text" name="userPw" placeholder="비밀번호를 입력해주세요.">
                        </div>
                    </div>
                    <div class="card-row">
                        <div class="row-title">비밀번호 확인</div>
                        <div class="row-content">
                            <input type="text" id="pwCheck" placeholder="비밀번호를 확인해주세요.">
                        </div>
                    </div>
                </div>
                <!-- 하단 카드 -->
                <div class="card">
                    <div class="card-row">
                        <div class="row-title">이름</div>
                        <div class="row-content">
                            <input type="text" name="userName" placeholder="이름을 입력해주세요.">
                        </div>
                    </div>
                    <div class="card-row">
                        <div class="row-title">전화번호</div>
                        <div class="row-content">
                            <input type="text" name="userPhone" placeholder="전화번호를 입력해주세요.">
                        </div>
                    </div>

                    <div class="card-row">
                        <div class="row-title">우편번호</div>
                        <div class="row-content">
                            <input type="text" name="userAddr" id="sample6_postcode">
                            <button type="button" onclick="sample6_execDaumPostcode()">검색</button>
                        </div>
                    </div>
                    <div class="card-row">
                        <div class="row-title">주소</div>
                        <div class="row-content">
                            <input type="text" name="userAddr" id="sample6_address">
                        </div>
                    </div>
                    <div class="card-row">
                        <div class="row-title">상세주소</div>
                        <div class="row-content">
                            <input type="text" name="userAddr" placeholder="상세주소를 입력해주세요." id="sample6_detailAddress">
                        </div>
                    </div>
                </div>

                <div class="btn-area">
                    <button onclick="location.href='/'"  type="button" style="background-color: #ddd; color: grey;">취소</button>
                    <button>가입</button>
                </div>
            </form>
        </section>
    </main>

    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
        function sample6_execDaumPostcode() {
            new daum.Postcode({
                oncomplete: function (data) {
                    // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var addr = ''; // 주소 변수

                    //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                        addr = data.roadAddress;
                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
                        addr = data.jibunAddress;
                    }

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('sample6_postcode').value = data.zonecode;
                    document.getElementById("sample6_address").value = addr;
                    // 커서를 상세주소 필드로 이동한다.
                    document.getElementById("sample6_detailAddress").value = '';
                    document.getElementById("sample6_detailAddress").focus();
                }
            }).open();
        }
    </script>
</body>

</html>