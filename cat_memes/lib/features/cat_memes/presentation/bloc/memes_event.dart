
part of 'memes_bloc.dart';

abstract class MemesEvent extends Equatable {
  const MemesEvent();

  @override
  List<Object> get props => [];
}

class LoadMemesEvent extends MemesEvent {}
