
import 'package:flutter/material.dart';
import 'package:untitled10/sqlite_service.dart';
import 'Todo.dart';


class TodoAdd extends StatefulWidget {
  const TodoAdd({super.key});

  @override
  State<StatefulWidget> createState() {
    return TodoAddState();
  }
}
class TodoAddState extends State {
  var body = TextEditingController();
  var title = TextEditingController();
  var databaseProvider = DatabaseProvider();
  Todo? todo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Todo",
          style: TextStyle(
              fontWeight: FontWeight.w900, fontSize: 20, color: Colors.white),
        ),
        centerTitle: true,
      ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              buildTitleField(),
              buildBodyField(),
              buildSavebutton(),
            ],
          ),
        ));
  }

  Widget buildTitleField() {
    return TextField(
      decoration: const InputDecoration(
        labelText: "Title",
      ),
      controller: title,
    );
  }

  Widget buildBodyField() {
    return TextField(
      decoration: const InputDecoration(
        labelText: "Description",
      ),
      controller: body,
    );
  }

  Widget buildSavebutton() {
    return ElevatedButton(
      child: const Text(
        "Save",
        style: TextStyle(
            fontWeight: FontWeight.w900, fontSize: 20, color: Colors.white),
      ),
      onPressed: () {
        addProduct();
      },
    );
  }

  void addProduct() async {
    var result = await databaseProvider.insert(Todo.withId(
        title: title.text,
        body: body.text,
    ));
    Navigator.pop(context, true);
  }
}
