class TodoState {
  final int id;
  final String title;
  final bool done;

  TodoState({this.id, this.title, this.done});

  factory TodoState.initial() => new TodoState(id: 0, title: '', done: false);

  TodoState copy({
    int id,
    String title,
    bool done,
  }) =>
      TodoState(
        id: id ?? this.id,
        title: title ?? this.title,
        done: done ?? this.done,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoState &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          done == other.done;

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ done.hashCode;
}
