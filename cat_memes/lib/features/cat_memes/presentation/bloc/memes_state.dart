
part of 'memes_bloc.dart';

abstract class MemesState extends Equatable {
  const MemesState();

  @override
  List<Object> get props => [];
}

class MemesLoading extends MemesState {}

class MemesLoaded extends MemesState {
  final List<Meme> memes;
  const MemesLoaded({required this.memes});

  @override
  List<Object> get props => [memes];
}
