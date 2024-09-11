<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
            <script>
                const req = "<%=request.getContextPath()%>";
            </script>

            <head>
                <meta charset="UTF-8">
                <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <link rel="stylesheet" href="<%=request.getContextPath()%>/resources/css/videoConference/popup.css">
                <script src="https://kit.fontawesome.com/4bef400c33.js" crossorigin="anonymous"></script>
            </head>

            <body>
                <main>

                    <!-- <div id="main-container">
                        <div class="modal-background">
                            <div id="content-box">
                                <div id="content-box-wrapper">
                                    <div id="content-box-item1">주제 추가</div>
                                    <input id="content-box-item2" placeholder="이 화상회의의 주제는 무엇인가요?"></input>
                                    <button id="content-box-item3" class="btn">확인</button>
                                    <button id="content-box-item4" class="btn">취소</button>
                                </div>
                            </div>
                        </div> -->
                    <div id="title-container"><b>오늘 점심은 뭐먹을까</b></div>
                    <div id="middle-container">
                        <div id="video-container">
                        </div>
                        <div id="chat-container">
                            <div class="chat-itembox">
                                <span class="today">2024-09-09</span>
                                <div class="chat-item">
                                    <img src="<%=request.getContextPath()%>/resources/images/loofy1.jpg" class="chat-prof-img">
                                    <div class="chat-id">배지환</div>
                                    <div class="chat-content">내일올게요내일올게요내일올게요내일올게요내일올게요내일올게요내일올게요내일올게요내일올게요내일올게요내일올게요내일올게요내일올게68글자임</div>
                                </div>
                            </div>
                           <div class="chat-inputbox">
                                <div class="chat-background">
                                    <input class="chat-input">
                                </div>
                                <button class="chat-send">d</button>
                                <button class="chat-booked">d</button>
                           </div>
                        </div>
                    </div>
                    <div id="button-container">
                        <div id="btn-box">
                            <div class="btn btn1" id="video-btn">비</div>
                            <div class="btn btn1" id="mic-btn">마</div>
                            <!-- <div class="btn btn1" id="display-btn">화</div> -->
                            <div class="btn btn1" id="change-btn">전환</div>
                            <div class="btn btn1" id="changeTitle-btn">주제 변경</div>
                            <div class="optionBox none" id="option-window">
                                <div class="options1">카메라(사용중)</div>
                                <div class="options2">화면 공유</div>
                            </div>
                        </div>
                        <div class="btn btn3" id="exit-btn">
                            <b>나가기</b>
                        </div>
                    </div>

                    </div>
                    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.min.js"></script>
                    <script src="<%=request.getContextPath()%>/resources/js/videoConference/popup.js"
                        crossorigin="anonymous"></script>
                </main>

            </body>

            </html>