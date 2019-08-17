import 'package:async_redux/async_redux.dart';
import 'todos/models/todo_state.dart';

var store = Store<AppState>(
  initialState: AppState.initialState(),
);

class AppState {
  final List<TodoState> todoList;
  final Event<TodoState> onAdd;

  AppState({this.todoList, this.onAdd});

  AppState copy({List<TodoState> todoList, Event<TodoState> onAdd}) =>
      AppState(todoList: todoList ?? this.todoList, onAdd: onAdd ?? this.onAdd);

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
