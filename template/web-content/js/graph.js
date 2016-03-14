
require.config({
    baseUrl: "modules",
    waitSeconds: 15
});

require(['com/redhat/demo/graph/1.2.2/com.redhat.demo.graph-1.2.2'], function(graph) {
    graph.run();
});

