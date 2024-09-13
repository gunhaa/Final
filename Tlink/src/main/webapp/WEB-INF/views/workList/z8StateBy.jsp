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
            <jsp:include page="/WEB-INF/views/workList/z0Box.jsp" />
        
          


            <table class="table">
                <tbody>
                    <tr>
                        <th><span class="material-symbols-outlined">
                            pending
                            </span>시작 전</th>
                        <th><span class="material-symbols-outlined">
                            arrow_circle_right
                            </span>진행 중</th>
                        <th><span class="material-symbols-outlined">
                            pause_circle
                            </span>완료 후</th>
                    </tr>
                    <tr>
                        <td>
                            <ul>
                                <li>프로젝트 제안서 작성<span class="material-symbols-outlined dTd">close</span></li>
                            </ul>
                            <span class="pTd">+새로만들기</span>
                        </td>
                            
                        <td>
                            <ul>
                                <li>킥오프 회의 일정 잡기<span class="material-symbols-outlined dTd">close</span></li>
                            </ul>
                            <span class="pTd">+새로만들기</span>
                        </td>

                        <td>
                            <ul>
                                <li>유스케이스<span class="material-symbols-outlined dTd">close</span></li>
                            </ul>
                            <span class="pTd">+새로만들기</span>
                        </td>
                    </tr>


                </tbody>
            </table>


        </div>
    </main>





</body>
</html>


<style>
    *{
        box-sizing: border-box;
    }

    .table{
        /* border-collapse: collapse; */
        border-collapse: separate;
        border-spacing: 10px 10px;
    }

    .table th span{
        vertical-align: bottom;
        margin: 0 3px 0 0;

        height: 23px;
    }

    .table td{
        vertical-align: top;
        
    }
    .table tr{
        border:1px solid black;
    }

    .table ul{
        padding-left: 0px;
        list-style-type: none;
        display: flex;
        align-items: flex-start;
        flex-direction: column;


        width: 320px;
        min-height: 1px;
    }
    .table li{
        padding: 5px;
        /* border:1px solid black; */
        border-radius: 3px;
        height: 35px;
        width: 300px;

        box-shadow: 1px 1px 1.5px #ddd;

        position: relative;
    }





    .dTd{
        position:absolute;
        top: 3px;
        right:3px;
        font-size: 15px;

        color:#eee;
    }


</style>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.min.js" integrity="sha256-Fb0zP4jE3JHqu+IBB9YktLcSjI1Zc6J2b6gTjB0LpoM=" crossorigin="anonymous"></script>

<script>

    // $('.table ul').sortable();
    $('.table ul').sortable({
        connectWith: '.table ul',

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
        $(`.pTd`).eq(i).on("click", function(e){
            $(this).prev().append(`
            <li>
                <span class="material-symbols-outlined dTd">close</span>
            </li>
            `);
        })
         //추후 -> 비동기 추가
    }

    $(document).on("click", `.dTd` ,function(){
        $(this).parents('li').remove();

        //추후 -> 비동기 추가
    })


    



</script>