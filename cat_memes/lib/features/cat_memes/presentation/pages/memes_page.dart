
import 'package:flutter/material.dart';
import '../bloc/memes_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemesPage extends StatelessWidget {
  const MemesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MemesBloc()..add(LoadMemesEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text("Cat Memes")),
        body: BlocBuilder<MemesBloc, MemesState>(
          builder: (context, state) {
            if (state is MemesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MemesLoaded) {
              return ListView.builder(
                itemCount: state.memes.length,
                itemBuilder: (context, index) {
                  final meme = state.memes[index];
                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Image.asset(meme.imagePath),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(meme.caption),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text("Something went wrong"));
            }
          },
        ),
      ),
    );
  }
}
