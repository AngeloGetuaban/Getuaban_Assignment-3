class Todo {
  var id;
  String? title;
  String? body;

  Todo({this.title, this.body});
  Todo.withId({this.id,this.title, this.body});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['title'] = title;
    map['body'] = body;
    if (id != null) {
      map["id"] = id;
    }

    return map;
    }

    Todo.fromObject(dynamic object) {
    this.id = int.tryParse(object["id"].toString());
    this.title = object['title'];
    this.body = object['body'];
  }
  }
