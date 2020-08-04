import 'package:equatable/equatable.dart';
import 'package:qaz_latin/feature/true_false_game/model/select_question_model.dart';

abstract class TrueFalseState extends Equatable {}

class ShowInstructionState extends TrueFalseState {
  final String instruction;

  ShowInstructionState(this.instruction);
  @override
  List<Object> get props => [instruction];
}

class LoadingQuestionState extends TrueFalseState {
  @override
  List<Object> get props => [];
}

class ShowQuestionState extends TrueFalseState {
  final Question question;
  final int score;
  final int lives;

  ShowQuestionState(this.question, this.score, this.lives);
  @override
  List<Object> get props => [
        question,
      ];
}

class ShowAnswerState extends TrueFalseState {
  final Question question;

  final int score;
  final int lives;

  ShowAnswerState(this.question, this.score, this.lives);
  @override
  List<Object> get props => [question];
}

class ShowResultState extends TrueFalseState {
  final int score;

  ShowResultState(this.score);

  @override
  List<Object> get props => [score];
}
