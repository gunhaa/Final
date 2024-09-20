<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thread</title>

    <link rel="stylesheet" href="/resources/css/chat/threadUtil-style.css">
    <link rel="stylesheet" href="/resources/css/chat/thread-style.css">

</head>
<body>
   <section class="chatView">
        <div class="viewHeader">
            <span><%--  --%></span>
            <div>
                <div class="memberList"></div>
                <button></button>
            </div>
       
        </div> 

        <div class="saperator"></div>

        <div class="viewMain">
            
        </div>

    </section>

    <section class="chatInput">
        <!-- <form action="/chat/insert" method="post" enctype="multipart/form-data"> -->
            <div id="inputBox" contenteditable="true"></div>
            
            <input type="hidden" name="message" id="message">
            
            <input type="file" name="files" id="inputFile" multiple>
            
            <button type="button" id="send">send</button>
        <!-- </form> -->
    </section>

    <script src="/resources/js/chat/thread.js"></script>
</body>
</html>