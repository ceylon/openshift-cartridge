
var ceylonVersion = "1.3.1";

var langMod = 'ceylon/language/' + ceylonVersion + '/ceylon.language-' + ceylonVersion;

require.config({
    baseUrl: "modules",
    waitSeconds: 15,
    map: {
        '*': {
            'ceylon/language/1.2.0/ceylon.language-1.2.0': langMod,
            'ceylon/language/1.2.1/ceylon.language-1.2.1': langMod,
            'ceylon/language/1.2.2/ceylon.language-1.2.2': langMod,
            'ceylon/language/1.3.0/ceylon.language-1.3.0': langMod
			/* Don't put the latest version here, only previous versions */
        }
    }
});

require(['com/redhat/demo/graph/1.3.1/com.redhat.demo.graph-1.3.1'], function(graph) {
    graph.run();
});

