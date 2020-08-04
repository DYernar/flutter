import 'package:equatable/equatable.dart';
import 'package:qaz_latin/feature/true_false_game/model/select_question_model.dart';

abstract class TrueFalseEvent extends Equatable {}

class TrueFalseGameStarted extends TrueFalseEvent {
  @override
  List<Object> get props => [];
}

class ShowGameInstructionEvent extends TrueFalseEvent {
  @override
  List<Object> get props => [];
}

class ShowQuestionEvent extends TrueFalseEvent {
  @override
  List<Object> get props => [];
}

class ChoiceMadeEvent extends TrueFalseEvent {
  final Question question;
  final int selectedIndex;

  ChoiceMadeEvent(this.selectedIndex, this.question);
  @override
  List<Object> get props => [];
}
