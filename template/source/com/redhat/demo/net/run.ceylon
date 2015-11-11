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
    
    value homeDir =
            process.environmentVariableValue(
        "OPENSHIFT_HOMEDIR")
    else parsePath("").absolutePath.string;
    
    value repoDir =
            process.environmentVariableValue(
                    "OPENSHIFT_REPO_DIR")
                else homeDir;
    
    value resourceEndpoint 
            = AsynchronousEndpoint {
        path = startsWith("/css")
           .or(startsWith("/img"))
           .or(startsWith("/js"))
           .or(startsWith("/index.html"))
           .or(startsWith("/graph.html"));
        service => serveStaticFile(repoDir + "/web-content/");
    };
    
    value modulesDir = repoDir + "/modules";
    
    value userCacheDir =
            (process.propertyValue("user.home") else "")
                + "/.ceylon/cache";
    value cacheDir = process.propertyValue("ceylon.cache.repo")
            else parsePath(userCacheDir).absolutePath.string;
    
    value systemRepoDir =
            process.propertyValue("ceylon.system.repo");
    assert (exists systemRepoDir);
    
    function fileExists(String path) {
        String abspath = modulesDir + path[8...];
        if (is File r=parsePath(abspath).resource) {
            return r.readable;
        } else {
            return false;
        }
    }

    value modulesEndpoint 
            = AsynchronousEndpoint {
        path = startsWith("/modules/");
        service => serveStaticFile {
            externalPath = "/";
            fileMapper(Request request)
                => (if (request.path.contains("/ceylon.language-"))
                        then systemRepoDir
                        else if (fileExists(request.path))
                            then modulesDir
                            else cacheDir)
                    + request.path[8...];
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
