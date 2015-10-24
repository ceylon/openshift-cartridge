import ceylon.net.http.server {
    Session
}
import ceylon.collection {
    MutableMap,
    HashMap
}

by ("Matej Lazar")
shared class TaskManager(Session session) {

    value taskMap {
        if (is MutableMap<String,Task> tasks 
                = session.get("tasks")) {
            return tasks;
        } else {
            value tasks = HashMap<String,Task>();
            session.put("tasks", tasks);
            return tasks;
        }
    }
    
    function taskById(String id) {
        if (exists task = taskMap.get(id)) {
            return task;
        } else {
            throw Exception("Invalid id");
        }
    }
    
    function queryTasks(String q) 
            => taskMap.filter((elem) => q in elem.item.message);
    
    shared void addTask(Task task) 
            => taskMap.put(task.id, task);

    shared Collection<Task> tasks(String q = "") 
            => if (q.empty) then taskMap.items 
               else queryTasks(q).collect(Entry.item);

    shared void taskDone(String id, Boolean done) 
            => taskById(id).done = done;

    shared void delete(String id) => taskMap.remove(id);
        
}
