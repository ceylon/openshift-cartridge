by ("Matej Lazar")

shared class Task(message, done = false) {
    shared String id = system.nanoseconds.string;
    shared String message;
    shared variable Boolean done;
}
