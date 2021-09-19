import 'package:flutter/material.dart';
import 'package:sql_database/model/todo_model.dart';
import 'package:sql_database/provider/db_helper.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo SQLite App'),
        bottom: PreferredSize(
            child: Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                controller: _controller,
                onEditingComplete: () async {
                  if (_controller.text.isNotEmpty) {
                    final text = _controller.text.trim();
                    final todo = TodoModel(todo: text);
                    await addTodo(todo: todo).then((value) {
                      setState(() {
                        _controller.clear();
                      });
                    });
                  }
                },
              ),
            ),
            preferredSize: const Size.fromHeight(80)),
      ),
      body: FutureBuilder(
        future: readTodo(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: (snapshot.data as dynamic).length,
                itemBuilder: (context, index) {
                  final data = (snapshot.data as dynamic)[index];
                  print(data);
                  return ListTile(
                    title: Text(data['todo'].toString()),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        deleteTodo(id: [data['id']]).then((value) {
                          setState(() {});
                        });
                      },
                    ),
                  );
                });
          } else {
            return const Center(
              child: Text('Please add todo'),
            );
          }
        },
      ),
    );
  }
}
