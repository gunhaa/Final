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

    
</head>
<body>
    

    <main style="display: flex">
        <jsp:include page="/WEB-INF/views/common/side.jsp" />


        <div>



            <table class="table">
                <caption><h1>Todo List</h1></caption>
                <thead>
                    <tr>
                        <th>작업 전</th>
                        <th>작업 중</th>
                        <th>작업 후</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <span class="todoStateNavigator" hidden>0</span>
                            <section></section>
                            <span class="plusBtn">+새로만들기</span>
                        </td>
                            
                        <td>
                            <span class="todoStateNavigator" hidden>1</span>
                            <section></section>
                            <span class="plusBtn">+새로만들기</span>
                        </td>

                        <td>
                            <span class="todoStateNavigator" hidden>2</span>
                            <section></section>
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
<script src="/resources/js/work/udf.js"></script>
<script>

    const projectNo_=${projectNo};
    const userNo_   =${loginUser.userNo};


    function selectTodo(){
        
        console.log( userNo_ );
        const data={ 
            "userNo"      : userNo_, 
            "projectNo"   : projectNo_, 
        };
        fetch("/todo/tList", {
                method: "POST",
                headers: {"Content-Type" : "application/json"},
                body: JSON.stringify(data)
            }
        )
        .then (rep => rep.json())
        .then (res => { 
            const arr=res;

            for(let todo of arr){
                console.log(todo);
            
                $(`.table section`).eq(0).append(
                    `<details>
                        <summary>
                            <span class="todoNo" hidden   >\${todo.todoNo}</span>
                            <span class="title"           >\${todo.todoTitle}</span>
                            <span class="todoState" hidden>\${todo.todoState}</span>
                            <span class="material-symbols-outlined deleteBtn">event_busy</span>
                        </summary>
                        <span class="content">\${todo.todoContent}</span> 
                    </details>`
                );


            }

        })
        .catch(err => console.log(err))

    }
    selectTodo();



</script>


<script>

//     $(document).on("mouseover",'.title', function(){ $('.title').contentEditable() } ) ;
//     $(document).on("mouseover",'.content', function(){ $('.content').contentEditable() } ) ;


    $('.table td').sortable({
        connectWith: '.table td',
        cursor: "move",
        delay: 150,
        distance: 5,
        dropOnEmpty: true,
        cancel: '[contenteditable]',

        start:  function(event, ui){ console.log("drag : " + (ui.item.index())); updateOn()},
        change: function(event, ui){ $(this).attr("style",`background-color: #eee; font-weight: bold;`); },
        stop:   function(event, ui){ console.log("drop : " + (ui.item.index()));  $(`.table ul`).removeAttr("style"); 

            const todoNo=$(ui.item).find(`.todoNo`).text();
            const todoState=$(ui.item).parents(`td`).find(`.todoStateNavigator`).text();
            const data={
                "todoNo"         : todoNo, 
                "todoState"      : todoState, 
                "projectNo"      : projectNo, 
            };


            fetch("/todoList/update/todoState", { method: "PUT", headers: {"Content-Type" : "application/json"}, body: JSON.stringify(data)}).then (rep => rep.text())
            .then(res => { res!=0 ?  updateDone()  : alert("수정실패") ; }).catch(err => console.log(err))



        }, 

    });



//     for(let i=0; i<3; i++){
//         $(`.plusBtn`).eq(i).on("click", function(e){
//             $(this).before(
// `<details>
//     <summary>
//         <span class="title">제목</span> 
//         <span class="material-symbols-outlined deleteBtn">event_busy</span>
//     </summary>
//     <span class="content">내용</span>
// </details>`);
//         })
//          //추후 -> 비동기 추가
//     }

//     $(document).on("click", `.deleteBtn` ,function(){
//         if(confirm("삭제하시겠습니까??")
//         ){
//             $(this).parents('details').remove();
//         }

//         //추후 -> 비동기 추가
//     })


    



</script>