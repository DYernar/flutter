import 'dart:math';

import 'package:flutter/services.dart';
import 'package:qaz_latin/feature/news_page/bloc/c_l_conversion.dart';
import 'package:qaz_latin/feature/true_false_game/model/select_question_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class Game {
  String get title;
  String get instruction;
  Question getQuestion();
  Set<String> get getWordList => wordlist;

  Future<void> sendResults(int score);
  static Set<String> wordlist;

  static Future<void> generateWords() async {
    String fileText = await rootBundle.loadString('assets/words.txt');
    fileText = fileText.replaceAll('\n', "");
    fileText = fileText.replaceAll(',', "");
    fileText = fileText.replaceAll('.', "");
    fileText = fileText.replaceAll('!', "");
    fileText = fileText.replaceAll('?', "");
    fileText = fileText.replaceAll('-', "");
    fileText = fileText.replaceAll('»', "");
    fileText = fileText.replaceAll('«', "");
    fileText = fileText.replaceAll(':', "");
    fileText = fileText.replaceAll(';', "");
    fileText = fileText.toLowerCase();
    List<String> words = fileText.split(" ");

    words = words.where((element) => element.length > 6).toList();
    wordlist = new Set();

    for (String word in words) {
      wordlist.add(word);
    }
  }

  String wrongConversion(String word) {
    var rand = new Random();
    int replaceInd = rand.nextInt(word.length);

    word = word.replaceAll(word[replaceInd], wrong_alphabet[word[replaceInd]]);
    word = converToLatin(word);
    return word;
  }

  String converToLatin(String str) {
    String ret = "";
    for (int i = 0; i < str.length; i++) {
      if (alphabet[str[i]] != null) {
        ret = ret + alphabet[str[i]].toString();
      } else {
        ret = ret + str[i].toString();
      }
    }
    return ret;
  }

  List<String> shuffleArray(List<String> arr) {
    print(wordlist.length);
    var rand = new Random();
    for (int i = arr.length - 1; i > 0; i--) {
      var ind = rand.nextInt(i);
      var temp = arr[ind];

      arr[ind] = arr[i];
      arr[i] = temp;
    }

    return arr;
  }

  Future<String> getTokenPref() async {
    final prefs = await SharedPreferences.getInstance();

    final token = prefs.getString("token");
    return token;
  }
}

class TrueFalseGame extends Game {
  @override
  Question getQuestion() {
    var rand = new Random();
    int index = rand.nextInt(Game.wordlist.length);

    if (rand.nextInt(2) == 1) {
      var str = converToLatin(getWordList.elementAt(index));
      return Question(
          '${getWordList.elementAt(index)} = $str ? ', ['true', 'false'], 0);
    } else {
      var str = wrongConversion(getWordList.elementAt(index));
      return Question(
          '${getWordList.elementAt(index)} = $str ? ', ['true', 'false'], 1);
    }
  }

  @override
  String get instruction => 'Тұжырымның дұрыс немесе бұрыс екенін табыңыз';

  @override
  String get title => 'Шын-Жалған';

  @override
  Future<void> sendResults(int score) async {
    final response = await http.post(
      'https://evening-oasis-57787.herokuapp.com/saveScore?score=$score&game=1',
      headers: {
        'appToken': 'Qazaq latin app',
        'token': await getTokenPref(),
      },
    );
    print(response.statusCode);
  }
}

class SelectCorrectWordGame extends Game {
  @override
  Question getQuestion() {
    var rand = new Random();
    String word = getWordList.elementAt(rand.nextInt(getWordList.length));
    String c = word;
    word = converToLatin(word);

    List<String> answers = [];
    answers.add(word);

    while (answers.length != 4) {
      String n = wrongConversion(c);
      n = converToLatin(n);

      if (!answers.contains(n)) {
        answers.add(n);
      }
    }

    answers = shuffleArray(answers);

    var latin = converToLatin(c);
    int correctIndex = 0;

    for (var i = 0; i < 4; i++) {
      if (answers[i] == latin) {
        correctIndex = i;
        break;
      }
    }
    return Question(c, answers, correctIndex);
  }

  @override
  String get instruction => 'Сөздің дұрыс латынша аудармасын табыңыз';

  @override
  String get title => 'Дұрыс сөзді тап';

  @override
  Future<void> sendResults(int score) async {
    final response = await http.post(
      'https://evening-oasis-57787.herokuapp.com/saveScore?score=$score&game=2',
      headers: {
        'appToken': 'Qazaq latin app',
        'token': await getTokenPref(),
      },
    );
    print(response.statusCode);
  }
}
