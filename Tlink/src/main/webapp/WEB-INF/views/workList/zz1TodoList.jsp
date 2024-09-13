<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

    
</head>
<body>
    

    <main style="display: flex">
        <jsp:include page="/WEB-INF/views/common/side.jsp" />


        <div>



            <table class="table">
                <caption><h1>Todo List</h1></caption>
                <tbody>
                    <tr>
                        <th>작업 전</th>
                        <th>작업 중</th>
                        <th>작업 후</th>
                    </tr>
                    <tr>
                        <td>
                            <details>
                                <summary>
                                    <span class="title">프로젝트 제안서 작성1</span>
                                    <span class="material-symbols-outlined deleteBtn">event_busy</span>
                                </summary>
                                <span class="content">111</span> 
                            </details>

                            <details>
                                <summary>
                                    <span class="title">프로젝트 제안서 작성2</span> 
                                    <span class="material-symbols-outlined deleteBtn">event_busy</span>
                                </summary>
                                <span class="content">222</span>
                            </details>

                            <span class="plusBtn">+새로만들기</span>
                        </td>
                            
                        <td>
                            <details>
                                <summary>
                                    <span class="title">프로젝트 제안서 작성1</span>
                                    <span class="material-symbols-outlined deleteBtn">event_busy</span>
                                </summary>
                                <span class="content">111</span> 
                            </details>

                            <details>
                                <summary>
                                    <span class="title">프로젝트 제안서 작성2</span> 
                                    <span class="material-symbols-outlined deleteBtn">event_busy</span>
                                </summary>
                                <span class="content">222</span>
                            </details>

                            <span class="plusBtn">+새로만들기</span>
                        </td>

                        <td>
                            <details>
                                <summary>
                                    <span class="title">프로젝트 제안서 작성1</span>
                                    <span class="material-symbols-outlined deleteBtn">event_busy</span>
                                </summary>
                                <span class="content">111</span> 
                            </details>

                            <details>
                                <summary>
                                    <span class="title">프로젝트 제안서 작성2</span> 
                                    <span class="material-symbols-outlined deleteBtn">event_busy</span>
                                </summary>
                                <span class="content">222</span>
                            </details>

                            <span class="plusBtn">+새로만들기</span>
                        </td>
                    </tr>


                </tbody>
            </table>

        </div>
    </main>






</body>
</html>


<style>
    *{ box-sizing: border-box; }
    [contenteditable] { outline: none;}
    
    table{
        border-collapse: separate;
        border-spacing: 100px 10px;
    }

    td{
        vertical-align: top;
        width: 300px;
    }
    tr{
        border:1px solid black;
    }



    .deleteBtn{
        font-size: 15px;
    }



</style>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.min.js" integrity="sha256-Fb0zP4jE3JHqu+IBB9YktLcSjI1Zc6J2b6gTjB0LpoM=" crossorigin="anonymous"></script>
<script src="../udf.js"></script>
<script>
    $(document).on("mouseover",'.title', function(){ $('.title').contentEditable() } ) ;
    $(document).on("mouseover",'.content', function(){ $('.content').contentEditable() } ) ;

    $('.table td').sortable({
        connectWith: '.table td',

        cursor: "move",

        delay: 150,
        distance: 5,

        dropOnEmpty: true,
       

        start: function (event, ui) {
            console.log("drag : " + (ui.item.index()));
        },
        stop: function (event, ui) {
            console.log("drop : " + (ui.item.index()));
        }
    });



    for(let i=0; i<3; i++){
        $(`.plusBtn`).eq(i).on("click", function(e){
            $(this).before(
`<details>
    <summary>
        <span class="title">제목</span> 
        <span class="material-symbols-outlined deleteBtn">event_busy</span>
    </summary>
    <span class="content">내용</span>
</details>`);
        })
         //추후 -> 비동기 추가
    }

    $(document).on("click", `.deleteBtn` ,function(){
        if(confirm("삭제하시겠습니까??")
        ){
            $(this).parents('details').remove();
        }

        //추후 -> 비동기 추가
    })


    



</script>