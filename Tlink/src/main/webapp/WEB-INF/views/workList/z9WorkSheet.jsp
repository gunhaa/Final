<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="user" value="${loginUser}"/>
${work}


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <link rel="stylesheet" href="/resources/css/work/common.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

</head>

<body>


    <main style="display: flex; justify-content: space-between;">
        <jsp:include page="/WEB-INF/views/common/side.jsp" />

        <article class="workBox">

                <div>
                    <table style="border-collapse: collapse;">
                        <caption>
                            <span class="workNo" hidden>${work.workNo}</span>
                            <h1 class="workTitle" contenteditable="true">${work.workTitle}</h1>
                        </caption>
                    </table>
                </div>

                <div>
                    <table class="sheetTb" style="border-collapse: collapse;">
                        <thead>
                            <tr>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="material-symbols-outlined">person</span>
                                    <span>담당자</span>
                                </td>
                                <td>
                                    <select name="" id="" class="putBox workMnNo workManager">
                                            <c:forEach var="user" items="${mList}">
                                                <option value="${user.userNo}" <c:if test="${work.workManager==user.userNo}">selected</c:if> >${user.userName}</option>
                                            </c:forEach>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="material-symbols-outlined">trending_up</span>
                                    <span>상태</span>
                                </td>
                                <td>
                                    <select class="putBox workPrSt workState">
                                        <option value="0" <c:if test="${work.workState==0}">selected</c:if> >시작 전</option>
                                        <option value="1" <c:if test="${work.workState==1}">selected</c:if> >진행 중</option>
                                        <option value="2" <c:if test="${work.workState==2}">selected</c:if> >완료 후</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="material-symbols-outlined">calendar_today</span>
                                    <span>마감일</span>
                                </td>
                                <td>
                                    <input class="putBox dueDt dueDate" type="date" value="${work.dueDate}">
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span class="material-symbols-outlined">cake</span>
                                    <span>우선순위</span>
                                </td>
                                <td>
                                    <select class="putBox workPr workPriority">
                                        <option value="0" checked>낮음</option>
                                        <option value="1">중간</option>
                                        <option value="2">높음</option>
                                    </select>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <span class="material-symbols-outlined">radio_button_checked</span>
                                    <span>프로젝트</span>
                                </td>
                                <td>
                                    <select class="putBox projectNo">
                                        <option value="${work.projectNo}">${work.projectName}</option>
                                    </select>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <span class="material-symbols-outlined">arrow_outward</span>
                                    <span>상위작업</span>
                                </td>
                                <td>
                                    <select class="putBox parentNo">
                                        <option value=""                     <c:if test="${work.parentNo==0}">selected</c:if> >없음</option>
                                        <c:forEach var="parentWork" items="${pList}">
                                            <c:if test="${parentWork.workNo!=work.workNo}">
                                                <option value="${parentWork.workNo}" <c:if test="${work.parentNo==parentWork.workNo}">selected</c:if> >${parentWork.workTitle}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </td>
                            </tr>

                        </thead>
                    </table>
                </div>

                <div>
                    <table style="border-collapse: collapse;">
                        <tbody>
                            <tr>
                                <td></td>
                                <td></td>
                            </tr>


                            <tr>
                                <td colspan="2">
                                    <span class="material-symbols-outlined">person_pin_circle</span>
                                    <span hidden>memberNo</span>
                                    <span>김길동</span>
                                    <h6>지나가는 길입니다.</h6>
                                </td>

                            </tr>


                            <tr>
                                <td   colspan="2" >
                                    <section style="display: flex; justify-content: space-between;" >
                                        <span   class="commentWork" contenteditable="true" placeholder='댓글을 입력해주세요.'></span>
                                        <button class="commentWork" contenteditable="false" style="border:none; background-color: transparent;"><span class="material-symbols-outlined">arrow_upward</span>댓글등록</button>
                                    </section>
                                </td>
                            </tr>



                        </tbody>

                    </table>
                </div>

                <div>
                    <table style="border-collapse: collapse;">
                        <tfoot>
                            <tr>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td class="putText workContent" colspan="2" contenteditable="true">
                                    ${work.workContent}
                                </td>
                            </tr>
                        </tfoot>
                    </table>
                </div>

        </article>



        <aside class="btnBox">
            
            <table style="font-weight: bold;">
                <tbod>
                    <tr>
                        <td><button><span class="material-symbols-outlined tgB">description</span>상단접기</button></td>
                        <td><sub>Alt+Q</sub></td>
                    </tr>
                    <tr>
                        <td><button><span class="material-symbols-outlined tgB">description</span>중단접기</td></button>
                        <td><small>Alt+A</small></td>
                    </tr>
                    <tr>
                        <td><button><span class="material-symbols-outlined tgB">description</span>하단접기</button></td>
                        <td><small>Alt+Z</small></td>
                    </tr>
                    <tr>
                        <td><button class="saveBtn"><span class="material-symbols-outlined">save</span>저장하기</button></td>
                        <td><small>Alt+Shift+S</small></td>
                    </tr>
                    <tr>
                        <td><button class="deleteBtn"><span class="material-symbols-outlined">scan_delete</span>삭제하기</button></td>
                        <td><small>Alt+Shift+D</small></td>
                    </tr>
                </tbod>
            </table>

            
            
        </aside>


    </main>



    

    







</body>

</html>

<style>

    [contenteditable="true"]:empty:before {
        content: attr(placeholder);
        color: #ddd;
    }

    .sheetTb {
        border-collapse: collapse;
    }

    .workBox caption {
        width: 500px;
    }

    .workBox  caption span {
        transition-duration: 400ms;
    }

    .workBox td {
        width: 250px;
        padding: 10px;
    }

    .workBox  thead,
    .workBox  tbody,
    .workBox tfoot {
        transition-duration: 1s;
        
    }

    .workBox thead,
    .workBox tbody {
        border-bottom: 1px solid #ddd;
    }


    .putBox {
        border: none;
        outline: none;
    }

    .btnBox{
        display:flex;
        flex-direction:column;
    }
    .btnBox button{
        background-color:transparent; 
        border:none;
        font-weight: bold;
    }



</style>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.min.js" integrity="sha256-Fb0zP4jE3JHqu+IBB9YktLcSjI1Zc6J2b6gTjB0LpoM=" crossorigin="anonymous"></script>
<script src="/resources/js/work/udf.js"></script>

<script>
  

    $(`.dueDt`).val(new Date().toISOString().substring(0, 10));

    const obj={arrStyle:[`transition-duration: 100ms; transform: rotateY(360deg);`,`transition-duration: 100ms; transform: rotateY(0deg);`], arr:[`thead`, `tbody`, `tfoot`]}
    for (let i = 0; i < 3; i++){ $($('.tgB')[i]).on(`click`, function () { $(this).toggleText(`folder`,`description`).toggleStyle(obj.arrStyle[0], obj.arrStyle[1]); $(`\${obj.arr[i]}`).parents("div").toggle("100");}) } //토글버튼
    $(document).keyup( function(e){ 
        if(e.altKey &&               (e.key=='q' || e.key=='Q')){ $(`\${obj.arr[0]}`).parents("div").toggle("100");}
        if(e.altKey &&               (e.key=='a' || e.key=='A')){ $(`\${obj.arr[1]}`).parents("div").toggle("100");}
        if(e.altKey &&               (e.key=='z' || e.key=='Z')){ $(`\${obj.arr[2]}`).parents("div").toggle("100");}
        if(e.altKey && e.shiftKey && (e.key=='S' || e.key=='s')){ updateWork();}
        if(e.altKey && e.shiftKey && (e.key=='D' || e.key=='d')){ deleteWork();}
    })

    
    
    




</script>
<script>
    //삽입*수정*삭제 
    function alertResult(res){ res==1 ?  alert("성공하였습니다.") : alert("실패하였습니다.") }

    function updateWork(){
        const data={
            "workNo"      : $(`.workNo`).text(), 
            "workTitle"   : $(`.workTitle`).text(),
            "workMnNo"    : $(`.workMnNo`).val(),
            "workPrSt"    : $(`.workPrSt`).val(),
            "dueDt"       : $(`.dueDt`).val(),
            "workPr"      : $(`.workPr`).val(),
            "projectNo"   : $(`.projectNo`).val(),
            "parentNo"    : $(`.parentNo`).val(),
            "workContent" : $(`.workContent`).html().trim(),
        };
        console.log(
            data.workNo
        );

        fetch("/workSheet/detail", {
                method: "PUT",
                headers: {"Content-Type" : "application/json"},
                body: JSON.stringify(data)
            }
        )
        .then (rep => rep.text())
        .then (res => {alertResult(res); })
        .catch(err => console.log(err))
    }


    function deleteWork(){
        if(confirm("삭제하시겠습니까??")){
            const data={
                "workNo"      : $(`.workNo`).text(), 
            };
        
            fetch("/workSheet/detail", {
                    method: "DELETE",
                    headers: {"Content-Type" : "application/json"},
                    body: JSON.stringify(data)
                }
            )
            .then (rep => rep.text())
            .then (res => {
                alertResult(res); 

                const url = new URL(window.location.href);
                const params = new URLSearchParams(url.search);
                const workNo = params.get('workNo');
                const projectNo = params.get('projectNo');

                location="/workList/table?projectNo="+projectNo;
            })
            .catch(err => console.log(err))
        }
        return;
        
    }


    $(`.saveBtn`)  .on("click", function(e){ updateWork(); })
    $(`.deleteBtn`).on("click", function(e){ deleteWork(); })


    

    $(`.commentWork`).on("click", function(){
      alert(1);  
    })
</script>

