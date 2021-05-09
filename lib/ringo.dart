library ringo;

import 'package:ringo/src/lattice/lattice.dart';

import 'src/data/dictionary.dart';
import 'src/data/double_array.dart';
import 'src/data/tokenized_word.dart';
import 'src/search/longest_match.dart';

class Ringo {
  const Ringo(this._doubleArray, this._dictionary);
  final DoubleArray _doubleArray;
  final Dictionary _dictionary;

  static Future<Ringo> init() async {
    final doubleArray = await DoubleArray.init();
    final dictionary = await Dictionary.init();
    return Ringo(doubleArray, dictionary);
  }

  List<String> tokenize(String query) {
    final searchdResult = _doubleArray.searchCommonPrefix(query);
    final longestMatchResult = LongestMatch.simpleTokenize(searchdResult, query);

    return longestMatchResult;
  }

  void analyzeMorphologic(String query) {
    final words = _doubleArray.searchCommonPrefix(query);
    final allWords = _dictionary.allWordsFromTokenizedWords(words);
    print(words.first.dicWords);
    //print(allWords.length);
  }
}
