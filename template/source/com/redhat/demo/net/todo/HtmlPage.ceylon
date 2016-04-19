import ceylon.html { ... }

by("Matej Lazar")


Html wireFrame(String path, {Content<FlowCategory>*} innerElements) 
    => Html { 
        Head {
            id = "head";
            Title {"Ceylon Demo"},
            Meta { charset="utf-8"; },
            Link {
                rel = "stylesheet";
                type = MimeType.textCss; 
                href = "``path``/css/bootstrap.min.css";
                id = "bootstrap";
            },
            Link {
                rel = "stylesheet";
                type = MimeType.textCss; 
                href = "``path``/css/style.css";
                id = "bootstrap";
            },
            Script {
                src = "``path``/js/bootstrap.min.js";
                type = MimeType.textJavascript;
            }
        },
        Body {
            Div {
                clazz = "container";
                children => {
                    H1("Ceylon In Session ToDo List"),
                    *innerElements 
                };
            }
        }
    };

Form inputForm(String q) 
    => Form { 
        action = "";
        method = "GET";
        children = {
            Div("New Task"),
            Div {
                clazz = "input-append";
                children = {
                    Input {
                        type = InputType.text;
                        name = "message";
                        placeholder = "Enter new task ...";
                    },
                    Button {
                        type = ButtonType.submit;
                        clazz = "btn";
                        "Add"
                    }
                };
            },
            Div {
                clazz = "input-append";
                children = {
                    Input {
                        type = InputType.text;
                        name = "q";
                        val = q;
                    },
                    Button {
                        type = ButtonType.submit;
                        clazz = "btn";
                        "Apply"
                    },
                    Button {
                        type = ButtonType.submit;
                        clazz = "btn";
                        attributes = ["onclick"->"this.form.q.value='';this.form.sumit();"];
                        "Remove"
                    }
                };
            }
        };
    };

Table taskList(Collection<Task> tasks, String q) {
    
    Td column1(Task task) {
        String onClickDone="document.location='?q=" + q + "&" + (task.done then "markNotDone" else "markDone") + "=" + task.id + "'";
        return Td {
            children = {
                Div {
                    children = {
                        Input {
                            type = InputType.checkbox;
                            checked = task.done;
                            attributes = ["onclick" -> onClickDone];
                        },
                        Span {
                            clazz = task.done then "taskDone" else "taskNotDone";
                            task.message
                        }
                    };
                }
            };
        };
    }

    Td column2(Task task) {
        String onClickRemove="document.location='?q=" + q + "&remove=" + task.id + "'";
        
        return Td {
            attributes = ["width"->"20px"];
            children = {
                Div {
                    children = {
                        Span { 
                            clazz = "icon icon-remove";
                            attributes = ["onclick" -> onClickRemove];
                        }
                    };
                }
            };
        };
        
    }

    value rows = [
        for (Task task in tasks)
            Tr {
                column1(task),
                column2(task)
            }
    ];
       
    return Table {
        clazz = "table table-hover";
        rows
    };
}
