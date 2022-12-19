import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'sqlite_service.dart';
import 'Todo.dart';
import 'package:sqflite/sqflite.dart';
class TodoDetail extends StatefulWidget {
  Todo todo;
  TodoDetail(this.todo);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TodoDetailState(todo);
  }
}

enum Options { delete, update }

class _TodoDetailState extends State {
  final Todo todo;
  _TodoDetailState(this.todo);
  var databaseProvider = DatabaseProvider();
  var title = TextEditingController();
  var body = TextEditingController();
  var _currentIndex = 0;
  @override
  void initState() {
    title.text = todo.title.toString();
    body.text = todo.body.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Todo Task ${todo.id}",
          style: TextStyle(
              fontWeight: FontWeight.w900, fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: buildProductDetail(),
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                enableFeedback: false,
                onPressed: () async {
                      await databaseProvider.update(Todo.withId(
                          id: todo.id,
                          title: title.text,
                          body: body.text,
                          ));
                      Navigator.pop(context, true);
                      },
                icon: const Icon(
                Icons.edit,
                color: Colors.white,
                size: 35,
              ),
      ),
        IconButton(
          enableFeedback: false,
          onPressed: () async {
            await databaseProvider.delete(todo.id);
            Navigator.pop(context, true);
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.white,
            size: 35,
          ),
        ),
    ],
              ),
      ),
    );
  }
  Widget buildProductDetail() {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          buildTitle(),
          buildBody(),
        ],
      ),
    );
  }

  Widget buildTitle() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Title: ",
      ),
      controller: title,
    );
  }

  Widget buildBody() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Description : ",
      ),
      controller: body,
    );
  }
}