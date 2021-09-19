class TodoModel {
  String todo;

  TodoModel({required this.todo});

  Map<String, dynamic> toMap() {
    return {'todo': todo};
  }
}
