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
        
            <div style="display: flex; justify-content: space-between;">


              <section class="workChartBox">
             
                <div style="display: flex; justify-content: space-evenly;">
                  <div id="chart"></div>
                  <div id="chart1"></div>
                </div>
                <div style="display: flex; justify-content: space-evenly;">
                  <div id="chart2"></div>
                </div>

              </section>


              <jsp:include page="/WEB-INF/views/workList/z2z0List.jsp" />
             

            </div>
            
        </div>
    </main>


 





</body>

</html>

<style>
  *{box-sizing: border-box;}
  .chartList{
    list-style-type: none;
  }
  .chartList li{
    width: 150px;
    text-align: center;
  }

  
  .chartList a {
      text-decoration: none;
      color: black;
      font-size: 18px;
      font-weight: bold;
      padding: 11px 0;
      display: block;
      text-align: center;
      border-radius: 5px;

      transition-duration: 0.1s;
      height: 100%;
  }
  
  .chartList a:hover {
      color: white;
      background-color: #3B5998;
  }

  .workChartBox{
     width: 1200px;
  }


</style>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://code.jquery.com/ui/1.14.0/jquery-ui.min.js" integrity="sha256-Fb0zP4jE3JHqu+IBB9YktLcSjI1Zc6J2b6gTjB0LpoM=" crossorigin="anonymous"></script>
<script src="../udf.js"></script>

<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>

<script>
  var options = {
          series: [{
          name: 'Points',
          type: 'scatter',
        
          //2.14, 2.15, 3.61, 4.93, 2.4, 2.7, 4.2, 5.4, 6.1, 8.3
          data: [{
            x: 1,
            y: 2.14
          }, {
            x: 1.2,
            y: 2.19
          }, {
            x: 1.8,
            y: 2.43
          }, {
            x: 2.3,
            y: 3.8
          }, {
            x: 2.6,
            y: 4.14
          }, {
            x: 2.9,
            y: 5.4
          }, {
            x: 3.2,
            y: 5.8
          }, {
            x: 3.8,
            y: 6.04
          }, {
            x: 4.55,
            y: 6.77
          }, {
            x: 4.9,
            y: 8.1
          }, {
            x: 5.1,
            y: 9.4
          }, {
            x: 7.1,
            y: 7.14
          },{
            x: 9.18,
            y: 8.4
          }]
        }, {
          name: 'Line',
          type: 'line',
          data: [{
            x: 1,
            y: 2
          }, {
            x: 2,
            y: 3
          }, {
            x: 3,
            y: 4
          }, {
            x: 4,
            y: 5
          }, {
            x: 5,
            y: 6
          }, {
            x: 6,
            y: 7
          }, {
            x: 7,
            y: 8
          }, {
            x: 8,
            y: 9
          }, {
            x: 9,
            y: 10
          }, {
            x: 10,
            y: 11
          }]
        }],
          chart: {
          width: 500,
          height: 400,
          type: 'line',
        },
        fill: {
          type:'solid',
        },
        markers: {
          size: [6, 0]
        },
        tooltip: {
          shared: false,
          intersect: true,
        },
        legend: {
          show: false
        },
        xaxis: {
          type: 'numeric',
          min: 0,
          max: 12,
          tickAmount: 12
        }
        };

        var chart = new ApexCharts(document.querySelector("#chart"), options);
        chart.render();















var options = {
          series: [{
          name: "SAMPLE A",
          data: [
          [16.4, 5.4], [21.7, 2], [25.4, 3], [19, 2], [10.9, 1], [13.6, 3.2], [10.9, 7.4], [10.9, 0], [10.9, 8.2], [16.4, 0], [16.4, 1.8], [13.6, 0.3], [13.6, 0], [29.9, 0], [27.1, 2.3], [16.4, 0], [13.6, 3.7], [10.9, 5.2], [16.4, 6.5], [10.9, 0], [24.5, 7.1], [10.9, 0], [8.1, 4.7], [19, 0], [21.7, 1.8], [27.1, 0], [24.5, 0], [27.1, 0], [29.9, 1.5], [27.1, 0.8], [22.1, 2]]
        },{
          name: "SAMPLE B",
          data: [
          [36.4, 13.4], [1.7, 11], [5.4, 8], [9, 17], [1.9, 4], [3.6, 12.2], [1.9, 14.4], [1.9, 9], [1.9, 13.2], [1.4, 7], [6.4, 8.8], [3.6, 4.3], [1.6, 10], [9.9, 2], [7.1, 15], [1.4, 0], [3.6, 13.7], [1.9, 15.2], [6.4, 16.5], [0.9, 10], [4.5, 17.1], [10.9, 10], [0.1, 14.7], [9, 10], [12.7, 11.8], [2.1, 10], [2.5, 10], [27.1, 10], [2.9, 11.5], [7.1, 10.8], [2.1, 12]]
        },{
          name: "SAMPLE C",
          data: [
          [21.7, 3], [23.6, 3.5], [24.6, 3], [29.9, 3], [21.7, 20], [23, 2], [10.9, 3], [28, 4], [27.1, 0.3], [16.4, 4], [13.6, 0], [19, 5], [22.4, 3], [24.5, 3], [32.6, 3], [27.1, 4], [29.6, 6], [31.6, 8], [21.6, 5], [20.9, 4], [22.4, 0], [32.6, 10.3], [29.7, 20.8], [24.5, 0.8], [21.4, 0], [21.7, 6.9], [28.6, 7.7], [15.4, 0], [18.1, 0], [33.4, 0], [16.4, 0]]
        }],
          chart: {
          width: 500,
          height: 400,
          type: 'scatter',
          zoom: {
            enabled: true,
            type: 'xy'
          }
        },
        xaxis: {
          tickAmount: 10,
          labels: {
            formatter: function(val) {
              return parseFloat(val).toFixed(1)
            }
          }
        },
        yaxis: {
          tickAmount: 7
        }
        };

        var chart = new ApexCharts(document.querySelector("#chart1"), options);
        chart.render();


        var options = {
          series: [{
          name: 'Network',
          data: [{
              x: 'Dec 23 2017',
              y: null
            },
            {
              x: 'Dec 24 2017',
              y: 44
            },
            {
              x: 'Dec 25 2017',
              y: 31
            },
            {
              x: 'Dec 26 2017',
              y: 38
            },
            {
              x: 'Dec 27 2017',
              y: null
            },
            {
              x: 'Dec 28 2017',
              y: 32
            },
            {
              x: 'Dec 29 2017',
              y: 55
            },
            {
              x: 'Dec 30 2017',
              y: 51
            },
            {
              x: 'Dec 31 2017',
              y: 67
            },
            {
              x: 'Jan 01 2018',
              y: 22
            },
            {
              x: 'Jan 02 2018',
              y: 34
            },
            {
              x: 'Jan 03 2018',
              y: null
            },
            {
              x: 'Jan 04 2018',
              y: null
            },
            {
              x: 'Jan 05 2018',
              y: 11
            },
            {
              x: 'Jan 06 2018',
              y: 4
            },
            {
              x: 'Jan 07 2018',
              y: 15,
            },
            {
              x: 'Jan 08 2018',
              y: null
            },
            {
              x: 'Jan 09 2018',
              y: 9
            },
            {
              x: 'Jan 10 2018',
              y: 34
            },
            {
              x: 'Jan 11 2018',
              y: null
            },
            {
              x: 'Jan 12 2018',
              y: null
            },
            {
              x: 'Jan 13 2018',
              y: 13
            },
            {
              x: 'Jan 14 2018',
              y: null
            }
          ],
        }],
          chart: {
          width: 1000,
          type: 'area',
          height: 400,
          animations: {
            enabled: false
          },
          zoom: {
            enabled: false
          },
        },
        dataLabels: {
          enabled: false
        },
        stroke: {
          curve: 'straight'
        },
        fill: {
          opacity: 0.8,
          type: 'pattern',
          pattern: {
            style: ['verticalLines', 'horizontalLines'],
            width: 5,
            height: 6
          },
        },
        markers: {
          size: 5,
          hover: {
            size: 9
          }
        },
        title: {
          text: 'Network Monitoring',
        },
        tooltip: {
          intersect: true,
          shared: false
        },
        theme: {
          palette: 'palette1'
        },
        xaxis: {
          type: 'datetime',
        },
        yaxis: {
          title: {
            text: 'Bytes Received'
          }
        }
        };

        var chart = new ApexCharts(document.querySelector("#chart2"), options);
        chart.render();
</script>