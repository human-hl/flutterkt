import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'memes_event.dart';
part 'memes_state.dart';

class MemesBloc extends Bloc<MemesEvent, MemesState> {
  MemesBloc() : super(MemesLoading()) {
    on<LoadMemesEvent>((event, emit) async {
      await Future.delayed(const Duration(seconds: 1));
      emit(MemesLoaded(memes: [
        Meme(
            imagePath: 'assets/images/cat1.png',
            caption:
                'Когда забыл покормить кота, и он начал строить тебе гроб глазами'),
        Meme(
            imagePath: 'assets/images/cat2.png',
            caption:
                'Утро понедельника: я — тюлень, душа — вне зоны действия сети'),
        Meme(
            imagePath: 'assets/images/cat3.png',
            caption:
                'Кот смотрит в пустоту... возможно, туда ушли все твои надежды'),
        Meme(
            imagePath: 'assets/images/cat4.png',
            caption: 'Ты хотел поспать? ХА. Я — кот. Я — закон'),
        Meme(
            imagePath: 'assets/images/cat5.png',
            caption:
                'Когда услышал, как открыли банку. Даже если спал в другой галактике'),
      ]));
    });
  }
}

class Meme {
  final String imagePath;
  final String caption;

  Meme({required this.imagePath, required this.caption});
}
