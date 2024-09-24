<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="comment-area">
    <!-- 댓글 목록 -->
    <div class="comment-list-area">
        <ul id="commentList">
            <!-- commentDeleteFlag == 3인 댓글이 있는지 확인 -->
            <c:set var="hasFixedComment" value="false" />
            <c:forEach items="${notice.commentList}" var="comment">
                <c:if test="${comment.commentDeleteFlag == 3}">
                    <c:set var="hasFixedComment" value="true" />
                </c:if>
            </c:forEach>

            <!-- 고정된 댓글 출력 -->
            <c:forEach items="${notice.commentList}" var="comment">
                <c:if test="${comment.commentDeleteFlag == 3}">
                    <li class="comment-row topComment">
                        <div class="comment-writer">
                            <c:if test="${empty comment.profileImage}">
                                <img src="/resources/images/common/user.png" id="image">
                            </c:if>
                            <c:if test="${!empty comment.profileImage}">
                                <img src="${comment.profileImage}" id="image">
                            </c:if>
                            <div class="comment-text-area">
                                <!-- 닉네임 -->
                                <span>${comment.userName}</span>
                                <!-- 작성일 -->
                                <span class="comment-date">(${comment.commentCreateDate})</span>

                                <!-- 로그인 유저가 일반 유저가 아닐 때만 고정/고정 해제 버튼 처리 -->
                                <c:if test="${loginUser.role != 'U'}">
                                    <c:choose>
                                        <c:when test="${hasFixedComment}">
                                            <c:if test="${comment.commentDeleteFlag == 3}">
                                                <button onclick="commentFixDisabled(${comment.commentNo}, this)" class="fixBtn">
                                                    <i class="fa-solid fa-thumbtack-slash" id="commentFixDisable"></i>
                                                </button>
                                            </c:if>
                                        </c:when>
                                        <c:otherwise>
                                            <button onclick="commentFixd(${comment.commentNo}, this)" class="fixBtn">
                                                <i class="fa-solid fa-thumbtack" id="commentFix"></i>
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>

                            </div>
                            <div class="likeArea">
                                <button class="likeBtn">aaa</button>
                                <span class="likeCount">123</span>
                            </div>
                        </div>

                        <!-- 댓글 내용 -->
                        <p class="comment-content">${comment.commentContent}</p>

                        <!-- 버튼 영역 -->
                        <div class="comment-btn-area">
                            <!-- 로그인 회원과 댓글 작성자가 같은 경우 -->
                            <c:if test="${loginUser.userNo == comment.userNo}">
                                <button onclick="showInsertComment(${comment.commentNo}, this)">답글</button>   
                                <button onclick="showUpdateComment(${comment.commentNo}, this)">수정</button>     
                                <button onclick="deleteComment(${comment.commentNo})">삭제</button>
                            </c:if>
                            <c:if test="${loginUser.userNo != comment.userNo}">
                                <button onclick="showInsertComment(${comment.commentNo}, this)">답글</button>   
                                <c:if test="${loginUser.role != 'U'}">
                                    <button onclick="deleteComment(${comment.commentNo})">삭제</button>
                                </c:if>
                            </c:if>
                        </div>
                    </li>
                </c:if>
            </c:forEach>

            <!-- 일반 댓글 출력 -->
            <c:forEach items="${notice.commentList}" var="comment">
                <c:if test="${comment.commentDeleteFlag == 1}">
                    <li class="comment-row <c:if test='${comment.parentNo != 0}'>child-comment</c:if>">
                        <div class="comment-writer">
                            <c:if test="${empty comment.profileImage}">
                                <img src="/resources/images/common/user.png" id="image">
                            </c:if>
                            <c:if test="${!empty comment.profileImage}">
                                <img src="${comment.profileImage}" id="image">
                            </c:if>
                            <div class="comment-text-area">
                                <!-- 닉네임 -->
                                <span>${comment.userName}</span>
                                <!-- 작성일 -->
                                <span class="comment-date">(${comment.commentCreateDate})</span>

                                <!-- 로그인 유저가 일반 유저가 아닐 때만 고정/고정 해제 버튼 처리 -->
                                <c:if test="${loginUser.role != 'U'}">
                                    <c:choose>
                                        <c:when test="${hasFixedComment}">
                                            <c:if test="${comment.commentDeleteFlag == 3}">
                                                <button onclick="commentFixDisabled(${comment.commentNo}, this)" class="fixBtn">
                                                    <i class="fa-solid fa-thumbtack-slash" id="commentFixDisable"></i>
                                                </button>
                                            </c:if>
                                        </c:when>
                                        <c:otherwise>
                                            <button onclick="commentFixd(${comment.commentNo}, this)" class="fixBtn">
                                                <i class="fa-solid fa-thumbtack" id="commentFix"></i>
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </c:if>

                            </div>
                            <div class="likeArea">
                                <button  class="likeBtn">aaa</button>
                                <span class="likeCount">123</span>
                            </div>
                        </div>

                        <!-- 댓글 내용 -->
                        <p class="comment-content">${comment.commentContent}</p>

                        <!-- 버튼 영역 -->
                        <div class="comment-btn-area">
                            <!-- 로그인 회원과 댓글 작성자가 같은 경우 -->
                            <c:if test="${loginUser.userNo == comment.userNo}">
                                <button onclick="showInsertComment(${comment.commentNo}, this)">답글</button>   
                                <button onclick="showUpdateComment(${comment.commentNo}, this)">수정</button>     
                                <button onclick="deleteComment(${comment.commentNo})">삭제</button>
                            </c:if>
                            <c:if test="${loginUser.userNo != comment.userNo}">
                                <c:if test="${loginUser.role != 'U'}">
                                    <button onclick="deleteComment(${comment.commentNo})">삭제</button>
                                </c:if>
                                <button onclick="showInsertComment(${comment.commentNo}, this)">답글</button>   
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
        <button id="addComment">댓글<br>등록</button>
    </div>
</div>
