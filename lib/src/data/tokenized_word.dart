import 'package:ringo/src/data/word.dart';

class TokenizedWord {
  TokenizedWord({
    required this.word,
    required this.start,
    required this.end,
    dicWords,
  });
  final String word;
  final int start;
  final int end;
  final List<Word> dicWords = <Word>[];
}
