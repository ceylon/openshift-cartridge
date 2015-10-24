import ceylon.html { ... }

by("Matej Lazar")

//class ElementI(String onClick, CssClass classNames)
//        extends BaseElement("", classNames)
//        satisfies TextNode & InlineElement & ParentNode<InlineElement> {
//    
//    shared actual Tag tag = Tag("i");
//    
//    attributes = ["onclick"->onClick];
//    shared actual {<InlineElement|{InlineElement*}|Snippet<InlineElement>|Null>*} children = nothing;
//    shared actual String text = nothing;
//}

Html wireFrame(String path, {BlockOrInline+} innerElements) 
    => Html { 
        html5;
        Head {
            title = "Ceylon Demo"; 
            id = "head";
            headChildren = {
                CharsetMeta(),
                Link {
                    rel = stylesheet;
                    type = css; 
                    href = "``path``/css/bootstrap.min.css";
                    id = "bootstrap";
                },
                Link {
                    rel = stylesheet;
                    type = css; 
                    href = "``path``/css/style.css";
                    id = "bootstrap";
                },
                Script {
                    src = "``path``/js/bootstrap.min.js";
                    javascript;
                }
            };
        };
        Body {
            Div {
                classNames = "container";
                children => {
                    H1("Ceylon In Session ToDo List"),
                    *innerElements 
                };
            }
        };
    };

Form inputForm(String q) 
    => Form { 
        action = "";
        method = "GET";
        children = {
            Div("New Task"),
            Div {
                classNames = "input-append";
                children = {
                    Input {
                        type = text;
                        name = "message";
                        placeholder = "Enter new task ...";
                    },
                    Button {
                        type = submit;
                        classNames = "btn";
                        text = "Add";
                    }
                };
            },
            Div {
                classNames = "input-append";
                children = {
                    Input {
                        type = text;
                        name = "q";
                        valueOf = q;
                    },
                    Button {
                        type = submit;
                        classNames = "btn";
                        text = "Apply";
                    },
                    Button {
                        type = submit;
                        classNames = "btn";
                        text = "Remove";
                        nonstandardAttributes = ["onclick"->"this.form.q.value='';this.form.sumit();"];
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
                            type = checkbox;
                            checked = task.done;
                            nonstandardAttributes = ["onclick" -> onClickDone];
                        },
                        Span {
                            classNames = task.done then "taskDone" else "taskNotDone";
                            text = task.message;
                        }
                    };
                }
            };
        };
    }

    Td column2(Task task) {
        String onClickRemove="document.location='?q=" + q + "&remove=" + task.id + "'";
        
        return Td {
            nonstandardAttributes = ["width"->"20px"];
            children = {
                Div {
                    children = {
                        Span { 
                            classNames = "icon icon-remove";
                            nonstandardAttributes = ["onclick" -> onClickRemove];
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
        classNames = "table table-hover";
        rows = rows;
    };
}
