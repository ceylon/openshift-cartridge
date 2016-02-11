
require.config({
    baseUrl: "modules",
    waitSeconds: 15
});

require(['com/redhat/demo/graph/1.2.1/com.redhat.demo.graph-1.2.1'], function(graph) {
    graph.run();
});

