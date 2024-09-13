<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>




<section>
    <ul class="chartList">
        <li><a href="/workList/gantChart">Gant chart</a></li>
        <li><a href="/workList/sankeyChart">Sankey chart</a></li>
        <li><a href="/workList/treeChart">Tree chart</a></li>
        
        <jsp:include page="/WEB-INF/views/workList/z1z0z3TreeList.jsp" />

    </ul>
</section>



<style>
  .chartList{
    list-style-type: none;
  }
  .chartList li{
    width: 150px;
    font-size: 18px;
    font-weight: bold;
  }
  .chartList li:has(span){
    padding: 10px;
  }
  
  .chartList a{
      text-decoration: none;
      color: black;
      font-size: 18px;
      font-weight: bold;
      padding: 10px;
      display: block;
      text-align: left;
      border-radius: 5px;

      transition-duration: 0.1s;
      height: 100%;
      width:100%;
  }
  
  .chartList a:hover {
      color: white;
      background-color: #3B5998;
  }


</style>
