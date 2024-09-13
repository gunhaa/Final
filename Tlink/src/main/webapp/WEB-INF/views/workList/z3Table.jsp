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






</head>
<body>
    
    <main style="display: flex">
        <jsp:include page="/WEB-INF/views/common/side.jsp" />

        <div>
            <jsp:include page="/WEB-INF/views/workList/z0Box.jsp" />
        


              

            <section class="tbCon">
                <span class="tgBtn">▶</span>
                <span style="font-weight: bold;">개인 프로젝트</span>
                <div class="tbBox">
                    <table>
                        <thead>
                            <tr class="col">
                                <th>
                                   <span style="visibility:hidden;" class="material-symbols-outlined">draft</span>
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
                                    <span class="material-symbols-outlined">person</span>
                                    <span>담당자</span>
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
                                <td>
                                    <a href="/workSheet"><span class="material-symbols-outlined">draft</span></a>
                                </td>
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
                                <td contenteditable="true"></td>
                                
                                <td >
                                    <span class="material-symbols-outlined mis"> disabled_by_default</span>
                                </td>
                            </tr>
                        </tbody>

                        <tfoot>
                            <tr>
                                <td class="" colspan="5" >
                                    <span class="material-symbols-outlined pls" >add_circle</span>
                                </td>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </section>
        </div>
    </main>

</body>
</html>




<style>
    * {box-sizing: border-box;}
    body{margin: 0;}
    [contenteditable] {outline: none;}

    .tbCon {
        margin: 20px 0 0 10px;

    }

    .tbCon table{
        /* width: 1400px; */
    }


    .tbCon th, 
    .tbCon td {
        padding: 10px;
 
        color: black;
    }

    .tbCon th { border-bottom: 1px solid #ccc; }

    .tbBox{
        margin-top: 20px;
    }

    .tbBox table {
        background-color: transparent;
        color: black;
        border-radius: 10px;
        box-shadow: 3px 3px 5px black;
    }

    .tbBox td {
        text-align: center;
        border-bottom: 1px solid #eee;
    }

    .tbBox td:hover {
        background-color: rgba(255, 255, 255, 0.1);
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


<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.min.js" integrity="sha256-Fb0zP4jE3JHqu+IBB9YktLcSjI1Zc6J2b6gTjB0LpoM=" crossorigin="anonymous"></script>
<script src="/resources/js/work/udf.js"></script>
<script>







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






    $('.tgBtn').on("click", function () {
        $('.tbBox').slideToggle();
        $(`.tgBtn`).toggleTextRotate90();

    })
   



</script>
    
