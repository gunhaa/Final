<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <link rel="stylesheet" href="/resources/css/work/common.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
    <link rel="shortcut icon" href="#">
    <style>

        .tbBox table{
            width: 100%;
        }
        .tbBox select,.tbBox input{
            width: 100%;
            border: none;
            background-color: transparent;
            text-align: center;
        }
        .tbBox td{
            text-align: center;
            width:150px;
        }




        .title {
            display: inline-block;
            min-width: 10px;
            min-height: 10px;
        }



        .bntBox {
            width: 120px;
            padding: 10px;
            display: flex;

        }

        .bntBox button {
            width: 50px;
            height: 50px;
            border-radius: 100%;
            display: flex;
            justify-content: center;
            align-items: center;

            border: none;

            color: black;
            background-color: transparent;
        }



        .sectionBox{
            width: 1200px;
        }

        .sectionBox section{
            width: 750px;
        }
        

        .sectionBox section nav {
            display: flex;
            align-items: center;
            justify-content: space-between;
            font-weight: bold;
            padding: 3px;
            border: 1px solid #ddd;
        }

        .sectionBox section article {
            background-color: #eee;
        }

        .sectionBox section button {
            border: none;
            background-color: transparent;
            font-weight: bold;
        }

        .sectionBox section button .material-symbols-outlined {
            font-weight: bold;
        }
    </style>

    <style>
        .btnBox{ min-width: 120px; 
            padding: 10px;
            display: flex; 
            flex-direction: column;
        }
        .btnBox button{ min-width: 50px; height: 50px; border-radius: 5px; display: flex; justify-content: center; align-items: center;
            border: none;
            background-color: white;
            color:black;
            font-weight: bold;
        }
        .btnBox button:hover{
            filter: invert(100%);
        }
    </style>





</head>
<body>
    


    <main style="display: flex">
        <jsp:include page="/WEB-INF/views/common/side.jsp" />

        <div>
            <jsp:include page="/WEB-INF/views/workList/z0Box.jsp" />
        
          

            <div style="display:flex;">
                <div class="sectionBox">

                    <section>
                        <nav>
                            <span class="title">프로젝트1</span>
                            <button><span class="material-symbols-outlined">add</span></button>
                        </nav>
                        <article class="tbBox">
                            <table>
                                <tbody>
                                    <tr>
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
                                    </tr>
            
                                    <tr>
                                        <td class="workName"></td>
                                        <td><span><input class="dueDate" type="date" value="2018-12-31"></span></td>
                                        <td>
                                            <select class="workState" name="" id="">
                                                <option value="0">시작 전</option>
                                                <option value="1">진행 중</option>
                                                <option value="2">완료 후</option>
                                            </select>
                                        </td>
                                        <td>
                                            <select class="workPriority" name="" id="">
                                                <option value="0">낮음</option>
                                                <option value="1">중간</option>
                                                <option value="2">높음</option>
                                            </select>
                                        </td>
                                        <td class="workManager">
                                            <select name="" id="">
                                                <option value="">김길동</option>
                                                <option value="">이길동</option>
                                                <option value="">박길동</option>
                                            </select>
                                        </td>
                                    </tr>
                                </tbody>
            
                            </table>
            
                        </article>
                    </section>
            
        
        
                    <section>
                        <nav>
                            <span class="title">프로젝트1</span>
                            <button><span class="material-symbols-outlined">add</span></button>
                        </nav>
                        <article class="tbBox">
                            <table>
                                <tbody>
                                    <tr>
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
                                    </tr>
            
                                    <tr>
                                        <td class="workName"></td>
                                        <td><span><input class="dueDate" type="date" value="2018-12-31"></span></td>
                                        <td>
                                            <select class="workState" name="" id="">
                                                <option value="0">시작 전</option>
                                                <option value="1">진행 중</option>
                                                <option value="2">완료 후</option>
                                            </select>
                                        </td>
                                        <td>
                                            <select class="workPriority" name="" id="">
                                                <option value="0">낮음</option>
                                                <option value="1">중간</option>
                                                <option value="2">높음</option>
                                            </select>
                                        </td>
                                        <td class="workManager">
                                            <select name="" id="">
                                                <option value="">김길동</option>
                                                <option value="">이길동</option>
                                                <option value="">박길동</option>
                                            </select>
                                        </td>
                                    </tr>
                                </tbody>
            
                            </table>
            
                        </article>
                    </section>
                    
                </div>



                <section class="btnBox">
                    <button class="removeEffect"><span class="material-symbols-outlined">disabled_by_default</span><span>효과제거</span></button>
                    <button class="spreadEffect"><span class="material-symbols-outlined">add_circle</span><span>펼침효과</span></button>

                    <button class="allFold"><span class="material-symbols-outlined">menu</span><span>모두접기</span></button>
                    <button class="allSpread"><span class="material-symbols-outlined" style="transform: rotateY(180deg);">sort</span><span>모두펴기</span></button>
                    <button class="draagable"><span class="material-symbols-outlined">arrow_selector_tool</span><span>Drag이동</span></button>
                    <button class="draagableDestroy"><span class="material-symbols-outlined">mouse_lock_off</span><span>Drag고정</span></button>
                    <button class="originMovement"><span class="material-symbols-outlined">adjust</span><span>원점이동</span></button>
                    <button class="translateX"><span class="material-symbols-outlined">arrow_right_alt</span><span>우측이동</span></button>
                    <button class="translateY"><span class="material-symbols-outlined">arrow_left_alt</span><span>좌측이동</span></button>
                </section>



            </div>


        </div>
    </main>






   



    <section class="bntBox">
        <button class="dis"><span class="material-symbols-outlined">disabled_by_default</span></button>
        <button class="ena"><span class="material-symbols-outlined">add_circle</span></button>
    </section>


    
</body>
</html>





<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.min.js"
    integrity="sha256-Fb0zP4jE3JHqu+IBB9YktLcSjI1Zc6J2b6gTjB0LpoM=" crossorigin="anonymous"></script>
<script src="/resources/js/work/udf.js"></script>

<script>
    $('.title').contentEditable();
    $('td').contentEditable();


    $(`.sectionBox section button span`).on("click", function () {
        $(this).toggleStyle(`transition-duration: 1s; transform: rotate(180deg);`,`transition-duration: 1s;`);
        $(this).toggleText(`remove`,`add`);
        $(this).parents("nav").next().slideToggle();
    })










</script>







<script>
    function spread(ele){ $(ele).parents("details").attr("open","open"); }
    function fold(ele){ $(ele).parents("details").removeAttr("open"); }
    $(`.title`).on("mouseover", function(e){ 
        spread(this); 
        rightPopup(this);
    });

    $('.removeEffect').on("click", function(){ $(`.title`).off("mouseover"); })
    $('.spreadEffect').on("click", function(){ $(`.title`).on("mouseover", 
    function(){
        $(this).parents("nav").next().slideToggle(); 
    }); })
    $(`.allFold`)     .on("click", function(){ $(`details`).removeAttr("open"); $(`.dataBox`).css("display", "none"); })
    $(`.allSpread`)   .on("click", function(){ $(`details`).attr("open","open") })
    $(`.draagable`)   .on("click", function(){ $('.btnBox').draggable(); })
    $(`.draagableDestroy`)   .on("click", function(){   $('.btnBox').draggable("destroy"); })
    $(`.originMovement`)   .on("click", function(){ $('.btnBox').attr("style",`transition-duration: 1s; transform: translateX(0px);`);  })

    let x=0;
    $(`.translateX`).on("click", function(){ 
        x+=300;
        $('.btnBox').attr("style",
        `transition-duration: 1s; transform: translateX(\${x}px);`); 

    })
    $(`.translateY`).on("click", function(){ 
        x-=300;
        $('.btnBox').attr("style",
        `transition-duration: 1s; transform: translateX(\${x}px);`); 
    })
    

</script>