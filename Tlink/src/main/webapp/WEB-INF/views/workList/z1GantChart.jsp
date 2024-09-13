<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>




<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>    <link rel="stylesheet"
    href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

</head>

<body>



    <main style="display: flex">
        <jsp:include page="/WEB-INF/views/common/side.jsp" />


        <div>
          <jsp:include page="/WEB-INF/views/workList/z0Box.jsp" />
        
          <div style="display: flex;">
            <section style="width:1200px;">
              
              <div id="chart_div"></div>

              <section class="updateChart">
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
                              <span class="material-symbols-outlined">arrow_outward</span>
                              <span>상위작업</span>
                            </th>
                        </tr>
  
                        <tr>
                            <td class="workName"></td>
                            <td><span><input class="dueDate" type="date" value="2018-12-31"></span></td>
  
                            <td class="workManager">
                                <select name="" id="">
                                    <option value="">작업1</option>
                                    <option value="">작업2</option>
                                    <option value="">작업3</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                          <td colspan="5">&#8203;</td>
                        </tr>
                        <tr>
                          <td colspan="5">
                            <button>수정</button>
                            <button>취소</button>
                          </td>
                        </tr>
                    </tbody>
                </table>
  
              </section>
            </section>




            <jsp:include page="/WEB-INF/views/workList/z1z0List.jsp" />


          </div>

        </div>
    </main>





 





</body>

</html>

<style>
  *{box-sizing: border-box;}
  [contenteditable] { outline: none; }

  .updateChart{
    display: none;
    width: 320px;
    background-color: rgba(255, 255, 255, 0.9);
    border-left:10px solid #ccc;
    text-align: center;
  }
  .updateChart th{
    border-bottom: 3px solid #ccc;
  }

  .updateChart select, .updateChart input{
    border:none;
    background-color: transparent;
  }

  .updateChart button{
    border: none;
    font-weight: bold;
    background-color: white;
    padding: 5px;
  }
  .updateChart button:hover{
    filter: invert(10%);
  }

  

</style>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.min.js" integrity="sha256-Fb0zP4jE3JHqu+IBB9YktLcSjI1Zc6J2b6gTjB0LpoM=" crossorigin="anonymous"></script>
<script src="/resources/js/work/udf.js"></script>

<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script type="text/javascript">
google.charts.load('current', {'packages':['gantt']});
google.charts.setOnLoadCallback(drawChart);


function casting(date){ return `'`+date+`'` } //변환함수
function percent(createDt,dueDt){
  const createDate=new Date(casting(createDt));
  const dueDate=new Date(casting(dueDt));
  const sysDate=new Date();
  return (sysDate-createDate)/(dueDate-createDate)*100;
}
function castingChart(){

}


function drawChart() {

  var data = new google.visualization.DataTable();
  data.addColumn('string', 'Task ID');
  data.addColumn('string', 'Task Name');
  data.addColumn('string', 'Resource');
  data.addColumn('date', 'Start Date');
  data.addColumn('date', 'End Date');
  data.addColumn('number', 'Duration');
  data.addColumn('number', 'Percent Complete');
  data.addColumn('string', 'Dependencies');


  let length=15; //변수넣기 List받아다가 던질것.!!!


  // let workNo='1';
  // let workTitle="작업1";
  // let topParentNo="1"
  // let createDt="2024-09-10";
  // let dueDt="2024-09-11";
  // let parentNo='10';


  data.addRows([
    //[for문 예시]
    // [workNo,  workTitle, topParentNo,  
    // new Date(casting(createDt)),  new Date(casting(dueDt)),
    // null, percent(createDt, dueDt)  ,  parentNo],




    ['1',  'No1. 작업1', '1',  new Date(2024,10,10),    new Date(2024,10,12),  null, 100, null],
    
    // ['2',  'No2. 작업2', '1',  new Date(2015, 1, 4),  new Date(2015, 1, 6),  null, 100, '1'],
    // ['3',  '작업3', '1',  new Date(2015, 1, 6),  new Date(2015, 1, 7),  null, 25, '2'],
    // ['4',  '작업4', '1',  new Date(2015, 1, 6),  new Date(2015, 1, 9),  null, 20, '1'],
    // ['5',  '작업5', '1',  new Date(2015, 1, 7),  new Date(2015, 1, 10), null, 0, '3'],      
    // ['6',  '작업6', '2',  new Date(2015, 1, 3),  new Date(2015, 1, 4),  null, 0, null],      
    // ['7',  '작업7', '3',  new Date(2015, 1, 4),  new Date(2015, 1, 5),  null, 0, null],      
    // ['8',  '작업8', '3',  new Date(2015, 1, 5),  new Date(2015, 1, 9),  null, 0, null],     
    // ['9',  '작업9', '4',  new Date(2015, 1, 6),  new Date(2015, 1, 7),  null, 0, null],      
    // ['10', '작업10', '5', new Date(2015, 1, 7),  new Date(2015, 1, 9),  null, 0, null],      
    // ['11', '작업11', '4', new Date(2015, 1, 8),  new Date(2015, 1, 9),  null, 0, '9'],      
    // ['12', '작업12', '7', new Date(2015, 1, 9),  new Date(2015, 1, 10), null, 0, null],      
    // ['13', '작업13', '6', new Date(2015, 1, 10), new Date(2015, 1, 11), null, 0, '8'],      
    // ['14', '작업14', '7', new Date(2015, 1, 11), new Date(2015, 1, 12), null, 0, '12'],      
    // ['15', '작업15', '7', new Date(2015, 1, 12), new Date(2015, 1, 13), null, 0, '14'],      


  ]);


  var options = {height: (length+1)*42, };
  var chart = new google.visualization.Gantt(document.getElementById('chart_div'));
  chart.draw(data, options);

}








$(`.workName`).contentEditable();


$(document).on("dblclick", `rect, path`, function (e) {
  console.log(
    `\${e.pageY}`
  );


  $(`.updateChart`).attr("style", `position: absolute; top: \${e.pageY}px; left:\${e.pageX}px;`)
  // $(`.updateChart`).attr("style", `position: absolute; top: 10px; left:10px;`)
  $(`.updateChart`).toggle("slide");

});

$(`.updateChart button`).eq(1).on("click", function(){
  $(`.updateChart`).css("display", "none");
})







</script>

