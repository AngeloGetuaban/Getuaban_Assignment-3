import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'sqlite_service.dart';
import 'Todo.dart';
import 'view_page.dart';

import 'form_page.dart';

class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TodoListState();
  }
}

class _TodoListState extends State {
  var databaseProvider = DatabaseProvider();
  List todos = [];
  int todoCount = 0;

  @override
  void initState() {
    // TODO: implement initState
    databaseProvider.getTodos();
    //super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Todo App",
          style: TextStyle(
              fontWeight: FontWeight.w900, fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: buildTodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          goToTodoAdd();
        },
        child: Icon(Icons.add),
        tooltip: "Yeni Urun Ekle",
      ),
    );
  }

  ListView buildTodoList() {
    return ListView.builder(
        itemCount: todoCount,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.blue,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black12,
                child: Text("O"),
              ),
              title: Text(
                this.todos[position].title,
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    color: Colors.white),
              ),
              subtitle: Text(
                this.todos[position].body,
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                    color: Colors.white),
              ),
              onTap: () {
                goToDetail(this.todos[position]);
              },
            ),
          );
        });
  }

  void goToTodoAdd() async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const TodoAdd()));
    if (result != null) {
      if (result) {
        getTodo();
      }
    }
  }

  void getTodo() async {
    var todosFuture = databaseProvider.getTodos();
    todosFuture.then((data) {
      setState(() {
        this.todos = data;
        todoCount = data.length;
      });
    });
  }

  void goToDetail(todo) async {
    bool result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => TodoDetail(todo)));
    if (result != null) {
      if (result) {
        getTodo();
      }
    }
  }
}