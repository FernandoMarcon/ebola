function plotVolcano(graphs) {
  var myPlot = Plotly.plot("volcano-plot", graphs, { displaylogo: false });
}

function plotGeneExpression(gene_name) {
  const div_name = "gene-boxplot-plot";
  fetch("genes/boxplot/" + gene_name)
    .then((response) => response.json())
    .then((data) => {
      Plotly.plot(div_name, data, {});
    });
}

function plotGeneNetwork(gene_name) {
  const div_name = "gene-corr-plot";
  // const cohort = "Geneva"

  // fetch(`/corr/${cohort}/${gene_name}`)
  fetch("/genes/corr/" + gene_name)
    .then((response) => response.json())
    .then((data) => {
      var chart = anychart.graph(data);
      chart.container(div_name);

      var nodes = chart.nodes();

      // set the size of nodes
      nodes.normal().height(10);
      nodes.hovered().height(15);
      nodes.selected().height(15);

      // set the fill of nodes
      // nodes.normal().fill("blue");
      nodes.hovered().fill("grey");
      nodes.selected().fill("black");

      // set the stroke of nodes
      nodes.normal().stroke(null);
      nodes.hovered().stroke("#333333", 3);
      nodes.selected().stroke("#333333", 3);

      // allow scrolling the chart with the mouse wheel
      chart.interactivity().scrollOnMouseWheel(true);
      chart.credits(false);
      chart.fit().draw();
    });
}
