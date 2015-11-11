
require.config({
    baseUrl: "modules",
    waitSeconds: 15
});

require(['com/redhat/demo/graph/1.2.0/com.redhat.demo.graph-1.2.0'], function(graph) {
    graph.run();
});

