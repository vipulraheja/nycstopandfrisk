defaultChartTest("test1", randomData(4,40));

function myData() {
	var series1 = [];
	for(var i =1; i < 100; i ++) {
		series1.push({
			x: i, y: 100 / i
		});
	}

	return [
		{
			key: "Series #1",
			values: series1,
			color: "#0000ff"
		}
	];
}

nv.addGraph(function() {
	var chart = nv.models.lineChart();

	chart.xAxis
		.axisLabel("X-axis Label");

	chart.yAxis
		.axisLabel("Y-axis Label")
		.tickFormat(d3.format("d"))
		;

	d3.select("svg")
		.datum(myData())
		.transition().duration(500).call(chart);

	nv.utils.windowResize(
			function() {
				chart.update();
			}
		);

	return chart;
});

function randomData(groups, points) { //# groups,# points per group
  var data = [],
      shapes = ['circle', 'cross', 'triangle-up', 'triangle-down', 'diamond', 'square'],
      random = d3.random.normal();

  for (i = 0; i < groups; i++) {
    data.push({
      key: 'Group ' + i,
      values: []
    });

    for (j = 0; j < points; j++) {
      data[i].values.push({
        x: random(), 
        y: random(), 
        size: Math.random(), 
        shape: shapes[j % 6]
      });
    }
  }
  return data;
}

function defaultChartTest(container, data, margin) {
  nv.addGraph(function() {
    var chart;
    chart = nv.models.scatterChart()
                  .showDistX(true).showDistY(true)
                  ;
    chart.xAxis.tickFormat(d3.format('.02f'));
    chart.yAxis.tickFormat(d3.format('.02f'));
    if (margin) {
      chart.margin(margin);
    }
    chart.tooltipContent(function(key) {
        return "<h3>" + key + "</h3>";
    });
    d3.select('#' + container + ' svg').datum(data).transition().duration(500).call(chart);
    nv.utils.windowResize(chart.update);
    return chart;
  });
}