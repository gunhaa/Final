<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thread</title>

    <link rel="stylesheet" href="/resources/css/thread/threadUtil-style.css">
    <link rel="stylesheet" href="/resources/css/thread/thread-style.css">

</head>
<body>
    <main style="display: flex; margin:0px;">
        <jsp:include page="/WEB-INF/views/common/side.jsp"/>

        <container style="display: flex; flex-direction: column; width: 1200px; margin: 0px;">
            <section class="chatView" style="height: 700px">
                <div class="viewHeader">
                    <span>#파이널 프로젝트</span>
                    <div>
                        <div class="memberList"></div>
                        <button>Settings</button>
                    </div>
                </div> 
        
                <div class="saperator"></div>
        
                <div class="viewMain">
                    <ul>
                        <c:forEach var="chat" items="${chatList}">
                            <c:if test="${chat.chatType == normal}">
                                <li class="chatNormal">
                                    <div class="profile">
                                        <c:if test="${ empty chat.memberProfile }">
                                            <img src="/resources/images/common/user.png">
                                        </c:if>
                                        <c:if test="${ !empty chat.memberProfile }">
                                            <img src="${contextPath}${chat.memberProfile}">
                                        </c:if>
                                    </div>
                                    <div>
                                        <div class="infoLine">
                                            <span>
                            
                                            </span>
                                            <span class="createDate">
                                                오후 2:39
                                            </span>
                                        </div>
                                        <div>
                                            채팅 컨텐츠 파일이 있으면 파일을 만들어야하는데 어떻게 알지 시불???
                                        </div>
                                    </div>
                                </li>
        
                            </c:if>
                        </c:forEach>
                        <li class="chatSystem">
                            <div class="chatSystem2">
                                <span>
                                    # 황건하님이 파이널 프로젝트에 참여했습니다.
                                </span>
                                <span class="createDate">
                                    오후 2:39
                                </span>
                            </div>
                        </li>
    
                        <li class="chatNormal">
                            <div class="profile">
                                <img src="/resources/images/common/user.png">
                            </div>
                            <div>
                                <div class="infoLine">
                                    <span>
                                        황건하이름이박건하였다면?
                                    </span>
                                    <span class="createDate">
                                        오후 2:39
                                    </span>
                                </div>
                                <div>
                                    채팅 컨텐츠 파일이 있으면 파일을 만들어야하는데 어떻게 알지 시불???
                                </div>
                            </div>
                        </li>

                        <li class="chatSystem">
                            <div class="chatSystem2">
                                <span>
                                    # 황건하님이 파이널 프로젝트에 참여했습니다.
                                </span>
                                <span class="createDate">
                                    오후 2:39
                                </span>
                            </div>
                        </li>

                    </ul>
                </div>
        
            </section>
     
            <section class="threadInput">
                    
                    <div id="inputBox" contenteditable="true"></div>
                    
                    <div class="inputBtnArea">
                        <input type="file" name="files" id="inputFile" multiple>
                        <button type="button" class="btn" id="send">send</button>
                    </div>
    
                    <!--  -->
                    <input type="hidden" name="message" id="message">
            </section>
        </container>
        

        <!-- 모달 파트 -->
        <section id="modalContainer" class="hidden">
            <div class="modalContent">
                <div class="modalHeader">
                    <p>#새로운 스레드 시작하기</p>
                    <button id="closeBtn">close</button>
                </div>
                <div class="saperator"></div>
    
                <form action="/thread/createThread" method="post" onsubmit="return invalid()">
                    <div class="modalBody">
                        <p>스레드 이름</p>
                        <input type="text" name="threadTitle" id="threadTitle" >
                        <p>채널에서는 특정 주제에 대한 대화가 이루어집니다. 찾고 이해하기 쉬운 이름을 사용하세요.</p>
                        <p>멤버 검색</p>
                        <input type="search" name="query" id="query" placeholder="아이디 또는 이름을 입력해주세요." autocomplete="off" value="${param.query}">
        
                        <ul id="queryResult"></ul>
        
                        <div id="listArea" class="memberArea">
                            <div class="memberItem">
                                <div class="memberProfile">
                                    <img src="/resources/images/common/user.png">
                                    <span>${loginUser.userName}</span>
                                    <span class="email">hanggh@gmail.com</span>
                                </div>
                                <div>
                                    <c:if test="${loginUser.userNo != user.userNo}"> 
                                        <button id="removeMember"></button>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>

                    
                    <div class="modalBtnArea">
                        <input type="submit" id="createThreadBtn" value="스레드 생성하기"></input>
                    </div>
                    <!-- input -->
                    <input type="hidden" name="userList" value="${loginUser.userNo}" >
                    <input type="hidden" name="projectNo" value="${param.projectNo}">
                </form>
            </div>
        </section>
    
        <script src="/resources/js/thread/thread.js"></script>
        <script src="/resources/js/thread/newThread-modal.js"></script>

    </main>
	
</body>
</html>