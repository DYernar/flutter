import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qaz_latin/feature/true_false_game/model/game.dart';
import 'package:qaz_latin/feature/true_false_game/bloc/true_false_bloc.dart';
import 'package:qaz_latin/feature/true_false_game/bloc/true_false_event.dart';
import 'package:qaz_latin/feature/true_false_game/bloc/true_false_state.dart';
import 'package:qaz_latin/feature/true_false_game/ui/correct_answer_screen.dart';
import 'package:qaz_latin/feature/true_false_game/ui/instruction_screen.dart';
import 'package:qaz_latin/feature/true_false_game/ui/loading_screen.dart';
import 'package:qaz_latin/feature/true_false_game/ui/main_game_screen.dart';
import 'package:qaz_latin/feature/true_false_game/ui/result_screen.dart';

class TrueFalseGameMainScreen extends StatefulWidget {
  final Game game;
  TrueFalseGameMainScreen(this.game, {Key key}) : super(key: key);

  @override
  _TrueFalseGameState createState() => _TrueFalseGameState();
}

class _TrueFalseGameState extends State<TrueFalseGameMainScreen> {
  TrueFalseBloc _trueFalseBloc;

  @override
  void initState() {
    super.initState();
    _trueFalseBloc = TrueFalseBloc(widget.game);
    _trueFalseBloc.add(ShowGameInstructionEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _trueFalseBloc,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            BlocBuilder<TrueFalseBloc, TrueFalseState>(
              builder: (context, state) {
                if (state is LoadingQuestionState) {
                  return LoadingTrueFalseScreen();
                }
                if (state is ShowInstructionState) {
                  return InstructionPage(state.instruction);
                }
                if (state is ShowQuestionState) {
                  return TrueFalseGameScreen(state.question);
                }
                if (state is ShowAnswerState) {
                  return GestureDetector(
                      onTap: () {
                        _trueFalseBloc.add(ShowQuestionEvent());
                      },
                      child: CorrectAnswer(state.question));
                }

                if (state is ShowResultState) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: ResultScreen());
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
