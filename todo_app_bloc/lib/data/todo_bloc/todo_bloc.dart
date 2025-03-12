import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:todo_app_bloc/data/todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends HydratedBloc<TodoEvent,TodoState> {
  TodoBloc() : super(const TodoState()){
    on<AddTodo>(_onAddTodo);
    on<RemoveTodo>(_onRemoveTodo);
    on<AlterTodo>(_onAlterTodo);
  }

  void _onStarted(
    TodoStarted event,
    Emitter<TodoState> emit,
  )
}
