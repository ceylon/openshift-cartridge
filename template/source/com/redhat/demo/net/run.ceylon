import ceylon.net.http.server {
    newServer,
    AsynchronousEndpoint,
    startsWith,
    Endpoint,
    isRoot
}
import ceylon.net.http.server.endpoints {
    serveStaticFile,
    redirect,
    RepositoryEndpoint
}
import ceylon.io {
    SocketAddress
}
import ceylon.file {
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
    
    value modulesEndpoint 
            = RepositoryEndpoint {
        root = "/modules/";
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
