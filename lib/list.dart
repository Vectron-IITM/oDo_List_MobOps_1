import 'package:flutter/material.dart';
import './todo.dart';

class TodoList extends StatefulWidget {
  @override
  TodoListState createState() => TodoListState();
}

class TodoListState extends State<TodoList> {
  List<Todo> todos = [];
  TextEditingController controller = new TextEditingController();

  toggleTodo(Todo todo, bool isChecked) {
    setState(() {
      todo.isDone = isChecked;
    });
  }

  Widget buildItems(BuildContext context, int index) {
    Todo todo = todos[index];

    return CheckboxListTile(
      secondary: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          setState(() {
            todos.removeAt(index);
          });
        },
      ),
      controlAffinity: ListTileControlAffinity.leading,
      value: todo.isDone,
      title: Text(todo.title),
      onChanged: (bool isChecked) {
        toggleTodo(todo, isChecked);
      },
    );
  }

  addTodo() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Today\'s Tasks'),
            content: TextField(
              controller: controller,
              autofocus: true,
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              FlatButton(
                onPressed: () {
                  setState(() {
                    final todo = new Todo(title: controller.value.text);
                    todos.add(todo);
                    controller.clear();
                    Navigator.of(context).pop();
                  });
                },
                child: Text('Add'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Today'),
        backgroundColor: Colors.red[400],
      ),
      body: empty(todos.length),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.red[400],
        onPressed: addTodo,
      ),
    );
  }

  void removeItemFromList(item) {
    setState(() {
      deleteItem(item);
    });
  }

  void deleteItem(item) {
    todos.remove(item);
  }

  Widget empty(items) {
    if (items > 0) {
      return ListView.builder(
        itemBuilder: buildItems,
        itemCount: todos.length,
      );
    } else {
      return Center(
          child: Text(
        'You\'re all done for today! \n #TodoListZero',
        style: TextStyle(fontSize: 20),
      ));
    }
  }
}
