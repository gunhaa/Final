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


    .listBox{
        width: 1200px;
    }

    details{ 
        padding: 3px; 
    }
    .title{ transition-duration: 1s; padding: 5px; transform: translateX(5px); }

    .dataBox{
        border-radius: 100%;
        color:black;
        font-weight: bold;
        margin-left: 3px;
        padding: 3px;

        display: none;
        
    }
    .dataBox>div{ display: flex; align-items: center; }
    .dataBox span{ font-size: 15px; padding: 3px; }



    summary{
        position: relative;
        font-size: 16px;
       
    }
    

    .workSheet{
        font-size: 20px;
    }
    
    .title{
        display: inline-block;
        min-width: 10px;
        min-height: 10px;
    }



</style>





</head>
<body>
    

    <main style="display: flex">
        <jsp:include page="/WEB-INF/views/common/side.jsp" />

        <div>
            <jsp:include page="/WEB-INF/views/workList/z0Box.jsp" />
        

            <div style="display:flex;">

    
                <section class="listBox">
                    <details>
                        <summary>
                                <span style="display: none;">작업번호</span>
                                <span class="title" >
                                    작업1
                                </span>
                        </summary>
                    
                        <details>
                            <summary>
                                <span class="title" >작업11</span>
                            </summary>
                    
                            <details>
                                <summary>
                                    <span class="title" >작업111</span>
                                </summary>
                
                                <details>
                                    <summary>
                                        <span class="title" >작업1111</span>
                                    </summary>
                                    <details>
                                        <summary>
                                            <span class="title" >작업11111</span>
                                        </summary>
                                    </details>

                                </details>
                            </details>

                        </details>

                    </details><hr>
                    
                
                    <details>
                        <summary>
                            <span class="title" >작업2</span>
                        </summary>
                        <details>
                            <summary>
                                <span class="title">작업22</span>
                            </summary>
                            <details>
                                <summary>
                                    <span class="title">작업222</span>
                                </summary>
                            </details>
                        </details>
                    </details><hr>

                </section>

                
                <jsp:include page="/WEB-INF/views/workList/z0z0BtnBox.jsp" />

            </div>

        </div>
    </main>

    


  
        











    
    <section class="dataBox"> 
        <div> <!-- flex부분 -->
            <span class="material-symbols-outlined workSheet">description</span><span>작업</span>
            <span class="material-symbols-outlined">chat</span><span>메세지</span>
        </div>
    </section>


<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.min.js"
    integrity="sha256-Fb0zP4jE3JHqu+IBB9YktLcSjI1Zc6J2b6gTjB0LpoM=" crossorigin="anonymous"></script>
    <script src="/resources/js/work/udf.js"></script>


<script>

    function update(ele){ $(ele).on("mousedown", function(){ $(this).attr("contenteditable", "true"); }).on("focusout", function(){ $(this).removeAttr("contenteditable"); })} //수정함수
    update($('.title'));

    
    $(`.workSheet`).on("click", function(){
        location="/workSheet";
    })



    childDetails='';
    const lmt=5;
    for(let i=1; i<=lmt; i++){
        const ii=238+ (0-238)/lmt*i;
        childDetails+='>details';
        $('details'+ childDetails).attr("style", "padding:10px;");
        $('details'+ childDetails+'>summary>span:nth-child(1)').attr("style"
        ,`border-bottm: 1px solid rgb(\${ii}, \${ii}, \${ii});`);
    }

    


    

 
    function rightPopup(ele){ 
        let top=$(ele).offset().top; 
        let left=$(ele).offset().left; 

        console.log(top);
        console.log(left);

        const width=ele.offsetWidth; 
        const height=ele.offsetHeight; 
        left+=width; 
        $(`.dataBox`).show("100").offset({ top: top, left: left  }); 

    }










</script>
    
</body>
</html>





