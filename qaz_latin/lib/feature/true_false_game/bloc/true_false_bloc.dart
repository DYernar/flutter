import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qaz_latin/feature/true_false_game/model/game.dart';
import 'package:qaz_latin/feature/true_false_game/model/select_question_model.dart';
import 'package:qaz_latin/feature/true_false_game/bloc/true_false_event.dart';
import 'package:qaz_latin/feature/true_false_game/bloc/true_false_state.dart';

class TrueFalseBloc extends Bloc<TrueFalseEvent, TrueFalseState> {
  final Game _game;
  int score = 0;
  int lives = 3;

  TrueFalseBloc(this._game) : super(null);

  @override
  Stream<TrueFalseState> mapEventToState(TrueFalseEvent event) async* {
    if (event is ShowGameInstructionEvent) {
      yield ShowInstructionState(_game.instruction);
    }

    if (event is ShowQuestionEvent) {
      if (lives < 1) {
        yield LoadingQuestionState();
        lives = 3;
        int finalScore = score;
        await _game.sendResults(finalScore);
        yield ShowResultState(finalScore);
      } else {
        Question currentQuestion = _game.getQuestion();
        yield ShowQuestionState(currentQuestion, score, lives);
      }
    }

    if (event is ChoiceMadeEvent) {
      if (event.selectedIndex == event.question.correctIndex) {
        score++;
      } else {
        lives--;
      }
      yield ShowAnswerState(event.question, score, lives);
    }
  }
}
