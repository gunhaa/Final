<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <link rel="shortcut icon" href="#">
<style>
    * {box-sizing: border-box;}
    body{margin: 0;}
    [contenteditable] {outline: none;}


    .tbCon th, 
    .tbCon td {
        padding: 10px;
        width: 150px;
        color: black;
    }

    .tbCon th { border-bottom: 1px solid #ccc; }

    .tbBox table {
        background-color: transparent;
        color: black;

        border-collapse: separate;
        border-spacing: 0px;
    }

    .tbBox td {
        text-align: center;
    }

    .tbBox thead td
    ,.tbBox thead th:nth-child(1)
    {
       
        background-color: #D295BF;

        border:none;

        color:white;
    }


    .tbBox td:hover {

    }


    .tbBox select,
    .tbBox input {
        border: none;
        border-left: 1px solid rgba(255, 255, 255, 0.1);
        width: 100%;
        height: 100%;
        color: black;
        background-color: transparent;
        outline: none;
        padding: 10px;
    }

    .tbBox option {
        background-color: black;
        color: white;
        font-weight: bold;
    }


    .pls, .mis{
    color: rgba(0, 0, 0, 0.05);

    }

</style>





</head>
<body>

    <main style="display: flex">
        <jsp:include page="/WEB-INF/views/common/side.jsp" />

        <div>
            <jsp:include page="/WEB-INF/views/workList/z0Box.jsp" />
        


              

        
    <section class="tbCon">
        <div class="tbBox">
            <table>
                <thead>
                    <tr>
                        <td>&#8203;</td>
                        <td>&#8203;</td>
                        <td>&#8203;</td>
                        <td>&#8203;</td>
                        <td>&#8203;</td>
                        <td>&#8203;</td>
                        <td>&#8203;</td>
                        <td>&#8203;</td>
                    </tr>
                    <tr class="col">
                                 <th>
                            <span class="material-symbols-outlined">person</span>
                            <span>담당자</span>
                        </th>
                        <th>
                            <span class="material-symbols-outlined">description</span>
                            <span>작업이름</span>
                        </th>
                        <th>
                            <span class="material-symbols-outlined">calendar_today</span>
                            <span>마감일</span>
                        </th>
                        <th>
                            <span class="material-symbols-outlined">trending_up</span>
                            <span>상태</span>
                        </th>
                        <th>
                            <span class="material-symbols-outlined">cake</span>
                            <span>우선순위</span>
                        </th>
           
                        <th>
                            <span class="material-symbols-outlined">radio_button_checked</span>
                            <span>프로젝트</span>
                        </th>
                        <th>
                            <span class="material-symbols-outlined">arrow_outward</span>
                            <span>상위작업</span>
                        </th>
                        <th>
                            <span class="material-symbols-outlined">close_small</span>
                        </th>
                    </tr>
                </thead>


                <tbody class="row">
                    <tr>
                        <td contenteditable="true"></td>
                        <td><span><input type="date"></span></td>
                        <td>
                            <select name="" id="">
                                <option value="0">시작 전</option>
                                <option value="1">진행 중</option>
                                <option value="2">완료 후</option>
                            </select>
                        </td>
                        <td>
                            <select name="" id="">
                                <option value="">낮음</option>
                                <option value="">중간</option>
                                <option value="">높음</option>
                            </select>
                        </td>
                        <td></td>
                        <td></td>
                        <td></td>
                        
                        <td >
                            <span class="material-symbols-outlined mis"> disabled_by_default</span>
                        </td>
                    </tr>
                </tbody>

                <tfoot>
                    <tr>
                        <td class="" colspan="8" >
                            <span class="material-symbols-outlined pls" >add_circle</span>
                        </td>
                    </tr>
                </tfoot>
                
            </table>
        </div>
    </section>
        </div>
    </main>




<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.min.js" integrity="sha256-Fb0zP4jE3JHqu+IBB9YktLcSjI1Zc6J2b6gTjB0LpoM=" crossorigin="anonymous"></script>
<script src="/resources/js/work/udf.js"></script>
        

<script>

    //재정렬함수
    function serial() { for (let i = 0; i < $(`.index`).length; i++) { $(`.index`).eq(i).text(i + 1); } }

    $(function () {
        serial();
        // $(".col").sortable();
        // $(".row").sortable(); 


    });











    function plsRw(i) {
        $(`.row`).append(`
                                                <tr>
                        <td contenteditable="true"></td>
                        <td><span><input type="date"></span></td>
                        <td>
                            <select name="" id="">
                                <option value="0">시작 전</option>
                                <option value="1">진행 중</option>
                                <option value="2">완료 후</option>
                            </select>
                        </td>
                        <td>
                            <select name="" id="">
                                <option value="">낮음</option>
                                <option value="">중간</option>
                                <option value="">높음</option>
                            </select>
                        </td>
                        <td contenteditable="true"></td>
                        <td contenteditable="true"></td>
                        <td class="mis">
                            <span class="material-symbols-outlined"> disabled_by_default</span>
                        </td>
                    </tr>
            
            </tr>`);
    }

    $(`.pls`).on("click", function () {


        


        // plsRw(7);
        // serial();


    })






    // $(".row").sortable({
    //     start: function (event, ui) {
    //         console.log("drag : " + (ui.item.index()));
    //     },
    //     stop: function (event, ui) {
    //         console.log("drop : " + (ui.item.index()));
    //         console.log( $(ui.item));

    //         serial();
    //         // +추후 비동기 날리기.!!!
    //     },
    // });




    //삭제버튼
    $(document).on(`click`, ".mis", function (e) {
        $(e.target).parents(`tr`).remove();
        serial();
    })






    //토글버튼
    $('.tgBtn').on("click", function () {

        if ($(this).siblings(".tbBox").css("display") != "none") {
            $(this).text("play_circle");
            $(this).attr("style", `
      
        transition-duration: 1s;
        transform: rotate(810deg) scale(1.3);
   
        border-radius: 10px;
        margin-right: 50px;
        `);
            $(this).parent().attr("style", `
            
        `);
        } else {
            $(this).text("arrow_right");
            $(this).attr("style", `
        transition-duration: 1s;
        transform: rotate(0deg) scale(1);
        color: black;

        `)
        }


        $('.tbBox').slideToggle();

    })



</script>
    
</body>
</html>





