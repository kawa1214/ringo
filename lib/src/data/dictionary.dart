import 'package:ringo/src/utils/list_utils.dart';
import 'tokenized_word.dart';
import 'word.dart';

class Dictionary {
  const Dictionary(this.words);
  final List<Word> words;
  
  static Future<Dictionary> init() async {
    final words = await ListUtils.loadWords();
    return Dictionary(words);
  }

  List<TokenizedWord>  allWordsFromTokenizedWords(List<TokenizedWord> tokenizedWords) {
    for(final tokenizedWord in tokenizedWords) {
      final allWords = words.where((e) => e.word==tokenizedWord.word).toList();
      if (allWords.isNotEmpty){
        tokenizedWord.dicWords.addAll(allWords);
      }
    }
    return tokenizedWords;
  }
}