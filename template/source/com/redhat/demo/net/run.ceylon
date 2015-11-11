import ceylon.net.http.server {
    newServer,
    AsynchronousEndpoint,
    startsWith,
    Endpoint,
    isRoot,
    Request
}
import ceylon.net.http.server.endpoints {
    serveStaticFile,
    redirect
}
import ceylon.io {
    SocketAddress
}
import ceylon.file {
    File,
    parsePath
}

import com.redhat.demo.net.todo {
    demo
}

"Run the server."
by ("Matej Lazar")
shared void run() {

    value portString = 
            process.environmentVariableValue(
                    "OPENSHIFT_CEYLON_HTTP_PORT") 
                else "8080";
    assert (exists port = parseInteger(portString));
    
    value host = 
            process.environmentVariableValue(
                    "OPENSHIFT_CEYLON_IP") 
                else "127.0.0.1";
    
    value repoDir = 
            process.environmentVariableValue(
                    "OPENSHIFT_REPO_DIR");
    assert (exists repoDir);
    
    value resourceEndpoint 
            = AsynchronousEndpoint {
        path = startsWith("/css")
           .or(startsWith("/img"))
           .or(startsWith("/js"))
           .or(startsWith("/index.html"))
           .or(startsWith("/graph.html"));
        service => serveStaticFile(repoDir + "web-content/");
    };
    
    value ceylonDir = 
            process.environmentVariableValue(
                    "OPENSHIFT_CEYLON_DIR");
    assert (exists ceylonDir);
    
    value ceylonVersion =
            process.environmentVariableValue(
                    "OPENSHIFT_CEYLON_VERSION");
    assert (exists ceylonVersion);

    value ceylonRepoDir = "data/ceylon_repo/repo/";
    value ceylonCacheDir = "data/ceylon_repo/cache/";

    function fileExists(String path) {
        String subpath = path.replace("/modules/", ceylonRepoDir);
        if (is File r=parsePath(ceylonDir).childPath(subpath).resource) {
            return r.readable;
        } else {
            return false;
        }
    }

    value modulesEndpoint 
            = AsynchronousEndpoint {
        path = startsWith("/modules/");
        service => serveStaticFile {
            externalPath = ceylonDir;
            fileMapper(Request request)
                => request.path.replace("modules/",
                    if (request.path.contains("/ceylon.language-"))
                        then "usr/ceylon-" + ceylonVersion + "/repo/"
                        else if (fileExists(request.path))
                            then ceylonRepoDir
                            else ceylonCacheDir);
        };
    };
    
    value redirectToIndex 
            = AsynchronousEndpoint {
        path = isRoot();
        service => redirect("/index.html");
    };
    
    value todo 
            = Endpoint {
        path = startsWith("/todo");
        service => demo;
    };
    
    newServer { resourceEndpoint, modulesEndpoint, todo, redirectToIndex }
        .start(SocketAddress(host, port));

}
