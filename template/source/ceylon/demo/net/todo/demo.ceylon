import ceylon.net.http {
    contentType
}
import ceylon.net.http.server {
    Response,
    Request,
    Session
}
import ceylon.io.charset {
    utf8
}
import ceylon.html {
    Html
}
import ceylon.html.serializer {
    NodeSerializer
}

by ("Matej Lazar")
shared void demo(Request request, Response response) {
    
    response.addHeader(contentType {
        contentType = "text/html";
        charset = utf8;
    });

    value manager = TaskManager(request.session);
    
    if (exists message = request.parameter("message"), 
            !message.empty) {
        manager.addTask(Task(message));
    }

    if (exists markDone = request.parameter("markDone"), 
            !markDone.empty) {
        manager.taskDone(markDone, true);
    }

    if (exists markNotDone = request.parameter("markNotDone"), 
            !markNotDone.empty) {
        manager.taskDone(markNotDone, false);
    }

    if (exists remove = request.parameter("remove"), 
            !remove.empty) {
        manager.delete(remove);
    }

    Html html =
            let (q = request.parameter("q") else "") 
            wireFrame {
                path="";
                inputForm(q),
                taskList(manager.tasks(q), q)
            };
    
    NodeSerializer(response.writeString).serialize(html);
}
