<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>

<div id="commentArea">
    <!-- 댓글 목록 -->
    <div class="comment-list-area">
        <ul id="commentList">
            
            <c:forEach items="${notice.commentList}" var="comment">
                <%-- 댓글 삭제 여부 확인 --%>
                <c:if test="${comment.commentDeleteFlag == 'Y'}">
                    <li class="comment-row">삭제된 댓글입니다.</li>
                </c:if>

                <c:if test="${comment.commentDeleteFlag == 'N'}">
                    <!-- 부모 댓글 / 자식 댓글 여부 확인 -->
                    <li class="comment-row <c:if test='${comment.parentNo != 0}'>child-comment</c:if>">
                        <div class="comment-writer">
                            <c:if test="${empty loginUser.profileImg}">
                                <img src="/resources/images/common/user.png" id="image">
                            </c:if>
                            <c:if test="${!empty loginUser.profileImg}">
                                <img src="${loginUser.profileImg}" id="image">
                            </c:if>
                            <div class="comment-text-area">
                                <!-- 닉네임 -->
                                <span>${comment.userName}</span>
                                </br>
                                <!-- 작성일 -->
                                <span class="comment-date">${comment.commentCreateDate}</span>
                            </div>
                        </div>
                    
                        <!-- 댓글 내용 -->
                        <p class="comment-content">${comment.commentContent}</p>

                        <!-- 버튼 영역 -->
                        <div class="comment-btn-area">
                            <c:if test="${!empty loginUser}">
                                <button onclick="showInsertComment(${comment.commentNo}, this)">답글</button>   
                            </c:if>
    
                            <!-- 로그인 회원과 댓글 작성자가 같은 경우 -->
                            <c:if test="${loginUser.userNo == comment.userNo}">
                                <button onclick="showUpdateComment(${comment.commentNo}, this)">수정</button>     
                                <button onclick="deleteComment(${comment.commentNo})">삭제</button>
                            </c:if>
                        </div>
                    </li>
                </c:if>

            </c:forEach>

        </ul>
    </div>
    

    <!-- 댓글 작성 부분 -->
    <div class="comment-write-area">
        <textarea id="commentContent"></textarea>
        <button id="addComment">
            댓글<br>
            등록
        </button>
 
    </div>

</div>