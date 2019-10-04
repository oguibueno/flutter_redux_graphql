import 'package:async_redux/async_redux.dart';
import 'todos/models/todo.dart';

var store = Store<AppState>(
  initialState: AppState.initialState(),
);

class AppState {
  final List<Todo> todoList;

  AppState({this.todoList});

  AppState copy({List<Todo> todoList}) =>
      AppState(todoList: todoList ?? this.todoList);

  static AppState initialState() => AppState(todoList: <Todo>[]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          todoList == other.todoList;

  @override
  int get hashCode => todoList.hashCode;
}
