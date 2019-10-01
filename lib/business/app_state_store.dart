import 'package:async_redux/async_redux.dart';
import 'todos/models/todo_state.dart';

var store = Store<AppState>(
  initialState: AppState.initialState(),
);

class AppState {
  final List<TodoState> todoList;

  AppState({this.todoList});

  AppState copy({List<TodoState> todoList}) =>
      AppState(todoList: todoList ?? this.todoList);

  static AppState initialState() => AppState(todoList: <TodoState>[]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppState &&
          runtimeType == other.runtimeType &&
          todoList == other.todoList;

  @override
  int get hashCode => todoList.hashCode;
}
