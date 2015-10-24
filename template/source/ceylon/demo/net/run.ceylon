import ceylon.net.http.server.endpoints { serveStaticFile }
import ceylon.net.http.server { Server, newServer, AsynchronousEndpoint, startsWith, Endpoint, isRoot }
import ceylon.io { SocketAddress }
import ceylon.demo.net.todo { demo }
import ceylon.demo.net.todo.endpoints { redirect }
import ceylon.net.uri { Uri, Path, PathSegment }


"Run the module `ceylon.demo.net`."
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
    
    value resourceEndpoint = AsynchronousEndpoint {
        path = startsWith("/css")
           .or(startsWith("/img"))
           .or(startsWith("/js"))
           .or(startsWith("/index.html"));
        service => serveStaticFile(repoDir + "web-content/");
    };
    
    value redirectToIndex = AsynchronousEndpoint {
        path = isRoot();
        service => redirect("/index.html");
    };
        
    value todo = Endpoint {
        path = startsWith("/todo");
        service => demo;
    };
    
    newServer { resourceEndpoint, todo, redirectToIndex }
        .start(SocketAddress(host, port));

}
