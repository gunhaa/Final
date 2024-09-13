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
                  <div id="chart2"></div>
                  <div id="chart3"></div>
                  <div id="chart4"></div>
                </div>

                <div style="display: flex; justify-content: space-evenly;">
                  <div id="chart5"></div>
                  <div id="chart6"></div>
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

<!-- <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script> -->
<script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
<script>

        var options = {
          series: [44, 55, 13, 43, 22],
          chart: {
          width: 400,
          height: 400,
          type: 'pie',
        },
        labels: ['Team A', 'Team B', 'Team C', 'Team D', 'Team E'],
        responsive: [{
          breakpoint: 480,
          options: {
            chart: {
              width: 400,
              height: 400,
            },
            legend: {
              position: 'bottom'
            }
          }
        }]
        };
        var chart = new ApexCharts(document.querySelector("#chart2"), options);
        chart.render();




        var options = {
          series: [76, 67, 61, 90],
          chart: {
          width: 400,
          height: 400,
          type: 'radialBar',
        },
        plotOptions: {
          radialBar: {
            offsetY: 0,
            startAngle: 0,
            endAngle: 270,
            hollow: {
              margin: 5,
              size: '30%',
              background: 'transparent',
              image: undefined,
            },
            dataLabels: {
              name: {
                show: false,
              },
              value: {
                show: false,
              }
            },
            barLabels: {
              enabled: true,
              useSeriesColors: true,
              offsetX: -8,
              fontSize: '16px',
              formatter: function(seriesName, opts) {
                return seriesName + ":  " + opts.w.globals.series[opts.seriesIndex]
              },
            },
          }
        },
        colors: ['#1ab7ea', '#0084ff', '#39539E', '#0077B5'],
        labels: ['Vimeo', 'Messenger', 'Facebook', 'LinkedIn'],
        responsive: [{
          breakpoint: 480,
          options: {
            legend: {
                show: false
            }
          }
        }]
        };

        var chart = new ApexCharts(document.querySelector("#chart3"), options);
        chart.render();



        var options = {
          series: [75],
          chart: {
          width: 400,
          height: 400,
          type: 'radialBar',
          toolbar: {
            show: true
          }
        },
        plotOptions: {
          radialBar: {
            startAngle: -135,
            endAngle: 225,
             hollow: {
              margin: 0,
              size: '70%',
              background: '#fff',
              image: undefined,
              imageOffsetX: 0,
              imageOffsetY: 0,
              position: 'front',
              dropShadow: {
                enabled: true,
                top: 3,
                left: 0,
                blur: 4,
                opacity: 0.24
              }
            },
            track: {
              background: '#fff',
              strokeWidth: '67%',
              margin: 0, // margin is in pixels
              dropShadow: {
                enabled: true,
                top: -3,
                left: 0,
                blur: 4,
                opacity: 0.35
              }
            },
        
            dataLabels: {
              show: true,
              name: {
                offsetY: -10,
                show: true,
                color: '#888',
                fontSize: '17px'
              },
              value: {
                formatter: function(val) {
                  return parseInt(val);
                },
                color: '#111',
                fontSize: '36px',
                show: true,
              }
            }
          }
        },
        fill: {
          type: 'gradient',
          gradient: {
            shade: 'dark',
            type: 'horizontal',
            shadeIntensity: 0.5,
            gradientToColors: ['#ABE5A1'],
            inverseColors: true,
            opacityFrom: 1,
            opacityTo: 1,
            stops: [0, 100]
          }
        },
        stroke: {
          lineCap: 'round'
        },
        labels: ['Percent'],
        };

        var chart = new ApexCharts(document.querySelector("#chart4"), options);
        chart.render();









      
        var options = {
          series: [
          {
            data: [
              {
                x: 'New Delhi',
                y: 218
              },
              {
                x: 'Kolkata',
                y: 149
              },
              {
                x: 'Mumbai',
                y: 184
              },
              {
                x: 'Ahmedabad',
                y: 55
              },
              {
                x: 'Bangaluru',
                y: 84
              },
              {
                x: 'Pune',
                y: 31
              },
              {
                x: 'Chennai',
                y: 70
              },
              {
                x: 'Jaipur',
                y: 30
              },
              {
                x: 'Surat',
                y: 44
              },
              {
                x: 'Hyderabad',
                y: 68
              },
              {
                x: 'Lucknow',
                y: 28
              },
              {
                x: 'Indore',
                y: 19
              },
              {
                x: 'Kanpur',
                y: 29
              }
            ]
          }
        ],
          legend: {
          show: false
        },
        chart: {
          width: 600,
          height: 400,
          type: 'treemap'
        },
        title: {
          text: 'Distibuted Treemap (different color for each cell)',
          align: 'center'
        },
        colors: [
          '#3B93A5',
          '#F7B844',
          '#ADD8C7',
          '#EC3C65',
          '#CDD7B6',
          '#C1F666',
          '#D43F97',
          '#1E5D8C',
          '#421243',
          '#7F94B0',
          '#EF6537',
          '#C0ADDB'
        ],
        plotOptions: {
          treemap: {
            distributed: true,
            enableShades: false
          }
        }
        };

        var chart = new ApexCharts(document.querySelector("#chart5"), options);
        chart.render();


        
        var options = {
          series: [{
          name: 'Series 1',
          data: [20, 100, 40, 30, 50, 80, 33],
        }],
          chart: {
          width: 600,
          height: 400,
          type: 'radar',
        },
        dataLabels: {
          enabled: true
        },
        plotOptions: {
          radar: {
            size: 140,
            polygons: {
              strokeColors: '#e9e9e9',
              fill: {
                colors: ['#f8f8f8', '#fff']
              }
            }
          }
        },
        title: {
          text: 'Radar with Polygon Fill'
        },
        colors: ['#FF4560'],
        markers: {
          size: 4,
          colors: ['#fff'],
          strokeColor: '#FF4560',
          strokeWidth: 2,
        },
        tooltip: {
          y: {
            formatter: function(val) {
              return val
            }
          }
        },
        xaxis: {
          categories: ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
        },
        yaxis: {
          labels: {
            formatter: function(val, i) {
              if (i % 2 === 0) {
                return val
              } else {
                return ''
              }
            }
          }
        }
        };

        var chart = new ApexCharts(document.querySelector("#chart6"), options);
        chart.render();


</script>