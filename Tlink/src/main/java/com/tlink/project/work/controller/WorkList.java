package com.tlink.project.work.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class WorkList {

	@GetMapping("/workList") public String workList() { 
			System.out.println("****************************");
			
		
		return "workList/workList"; 
		
		}
	

	@GetMapping("/workList/gantChart")     	    public String gantChart()      { return "workList/z1GantChart"; }
		@GetMapping("/workList/sankeyChart")    public String sankeyChart()    { return "workList/z1z2SankeyChart"; }
		@GetMapping("/workList/treeChart")      public String treeChart()      { return "workList/z1z3TreeChart"; }
	@GetMapping("/workList/workChart")          public String workChart()      { return "workList/z2WorkChart"; }
		@GetMapping("/workList/pieChart")       public String pieChart()       { return "workList/z2z2PieChart"; }
		@GetMapping("/workList/lineChart")      public String lineChart()      { return "workList/z2z3LineChart"; }
	@GetMapping("/workList/table")              public String table()          { return "workList/z3Table"; }
	@GetMapping("/workList/mywork")             public String mywork()         { return "workList/z4Mywork"; }
	@GetMapping("/workList/list")               public String list()           { return "workList/z5List"; }
	@GetMapping("/workList/managerBy")          public String managerBy()      { return "workList/z6ManagerBy"; }
	@GetMapping("/workList/projectBy")          public String projectBy()      { return "workList/z7ProjectBy"; }
	@GetMapping("/workList/stateBy")            public String stateBy()        { return "workList/z8StateBy"; }
	@GetMapping("/workSheet")                   public String workSheet()      { return "workList/z9WorkSheet"; }
	
	@GetMapping("/todoList")          	        public String todoList()       { return "workList/zz1TodoList"; }
	
}




