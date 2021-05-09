import 'package:ringo/src/data/tokenized_word.dart';
import 'package:ringo/src/data/word.dart';
import 'package:ringo/src/output_double_array/array_utils.dart';
import 'package:ringo/src/output_double_array/trie.dart';
import 'package:ringo/src/utils/path.dart';

class Node {
  Node(this.word);
  final TokenizedWord word;
  final List<Node> nodes= [];
}

class Lattice {
  Lattice(this.node);
  final Node node;

  static Lattice setWords(List<TokenizedWord> words) {
    final node = bosNode();

    

    return Lattice(node);
  }

  static Node bosNode() {
    return Node(
      TokenizedWord(end: 0, start: 0, word: 'BOS'),
    );
  }
}

/*
class Word {
  const Word(
      {required this.word,
      required this.leftContextId,
      required this.rightContextId,
      required this.occurrenceCost});
  final String word;
  final int leftContextId;
  final int rightContextId;
  final int occurrenceCost;
}

class SearchDoubleArray {
  const SearchDoubleArray({required this.base, required this.check});
  final List<int> base;
  final List<int> check;
}

class LatticeWord {
  const LatticeWord(
      {required this.word, required this.start, required this.end});
  final int start;
  final int end;
  final Word word;
}

class Lattice {
  Lattice({required this.doubleArray, required this.dic});
  final SearchDoubleArray doubleArray;
  final List<Word> dic;
  final searchResult = <LatticeWord>[];

  List<Word> searchWordsFromDic(String word) {
    return dic.where((w) => w.word == word).toList();
  }

  List<LatticeWord> searchPrefix(String word) {
    for (var start = 0; start < word.length; start++) {
      for (var end = 1; end < word.length + 1; end++) {
        searchHelper(word, start, end);
      }
    }
    return searchResult;
  }

  void searchHelper(String word, int start, int end) {
    if (start == end || start > end) {
      return;
    }
    final query = word.substring(start, end);
    if (search(query)) {
      final words = searchWordsFromDic(query);
      final results =
          words.map((e) => LatticeWord(start: start, end: end, word: e));
      searchResult.addAll(results);
    }
  }

  bool search(String word) {
    int current = 0;
    final codes = stringToUint8List(word);
    for (var i = 0; i < codes.length; i++) {
      final code = codes[i];
      final next = doubleArray.base[current] + code;
      final checkData = doubleArray.check[next] - 1;
      if (current != checkData) {
        return false;
      }
      current = next;
    }
    return true;
  }
}
*/