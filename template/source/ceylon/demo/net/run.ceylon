import ceylon.net.http.server.endpoints { serveStaticFile }
import ceylon.net.http.server { Server, newServer, AsynchronousEndpoint, startsWith, Endpoint, isRoot}
import ceylon.io { SocketAddress }
import ceylon.demo.net.todo { demo }
import ceylon.demo.net.todo.endpoints { redirect }
import ceylon.net.uri { Uri, Path, PathSegment }


by ("Matej Lazar")

String prop_server_bind_port = "server.bind.port";
String prop_server_bind_host = "server.bind.host";
String prop_server_files_lcation = "server.files.location";

"Run the module `ceylon.demo.net`."
shared void run() {

    if (exists files = process.propertyValue(prop_server_files_lcation)) {
        print("Static files location ``files``.");
        startServer(files);
    } else {
        print("To serve static files define VM argument server.files.location.");
    }
}

void startServer(String files) {
    value resourceEndpoint = AsynchronousEndpoint {
        path = startsWith("/css").or(startsWith("/img")).or(startsWith("/js")).or(startsWith("/index.html"));
        service => serveStaticFile(files);
    };
    
    value redirectToIndex = AsynchronousEndpoint {
        path = isRoot();
        service => redirect("/index.html");
    };
        
    value todo = Endpoint {
        path = startsWith("/todo");
        service => demo;
    };
    
    Server server = newServer {
        resourceEndpoint, todo, redirectToIndex
    };
    
    
    variable Integer port = 8080;
    if (exists portStr = process.propertyValue(prop_server_bind_port)) {
        if (exists p = parseInteger(portStr)) {
            port = p;
        }
    }
    
    variable String host = "127.0.0.1";
    if (exists h = process.propertyValue(prop_server_bind_host)) {
        host = h;
    }
    
    server.start(SocketAddress(host, port));

}
