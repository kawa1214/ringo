library ringo;

import 'src/utils/path.dart';
import 'src/utils/string_utils.dart';
import 'src/utils/list_utils.dart';

/*
main() async {
  final ringo = await Ringo.init();
  final tokenized = ringo.tokenize('吾輩はRingoである');
  print('tokenized: $tokenized');
}
*/

class Ringo {
  const Ringo(this._doubleArray);
  final DoubleArray _doubleArray;

  static Future<Ringo> init() async {
    final base = await ListUtils.loadList(Path.base);
    final check = await ListUtils.loadList(Path.check);
    final doubleArray = DoubleArray(base: base, check: check);
    return Ringo(doubleArray);
  }

  List<String> tokenize(String query) {
    final searchdResult = _searchPrefix(query);
    final longestMatchResult = _longestMatch(searchdResult, query);

    return longestMatchResult;
  }

  List<String> _longestMatch(List<SearchedWord> words, String query) {
    final result = <String>[];
    int current = 0;
    words.sort((a, b) => b.end.compareTo(a.end));
    final unknownWordBuffer = StringBuffer();
    //print('query.length: ${query.length}');
    for (var i = 0; i < query.length && current < query.length; i++) {
      //print(current);
      final startWords = words.where((e) => e.start == current).toList();
      if (startWords.isNotEmpty) {
        /// 未知語を追加
        if (unknownWordBuffer.toString() != '') {
          result.add(unknownWordBuffer.toString());
          unknownWordBuffer.clear();
        }

        /// 辞書にある単語を追加
        final word = startWords.first;
        current = word.end;
        result.add(word.word);
      } else {
        /// 未知語は一つにまとめるため，StringWordBufferに保存
        unknownWordBuffer.write(query[current]);
        current++;
      }
    }

    /// 最後に未知後があったケースの処理
    if (unknownWordBuffer.toString() != '') {
      result.add(unknownWordBuffer.toString());
      unknownWordBuffer.clear();
    }
    return result;
  }

  List<SearchedWord> _searchPrefix(String word) {
    final searchResult = <SearchedWord>[];
    for (var start = 0; start < word.length; start++) {
      for (var end = 1; end < word.length + 1; end++) {
        final result = _searchPrefixHelper(word, start, end);
        if (result != null) {
          searchResult.add(result);
        }
      }
    }
    return searchResult;
  }

  SearchedWord? _searchPrefixHelper(String word, int start, int end) {
    if (start == end || start > end) {
      return null;
    }
    final query = word.substring(start, end);
    if (_search(query)) {
      final word = SearchedWord(word: query, start: start, end: end);
      return word;
    }
    return null;
  }

  bool _search(String word) {
    int current = 0;
    final codes = StringUtils.stringToUint8List(word);
    for (var i = 0; i < codes.length; i++) {
      final code = codes[i];
      final next = _doubleArray.base[current] + code;
      final checkData = _doubleArray.check[next] - 1;
      if (current != checkData) {
        return false;
      }
      current = next;
    }
    return true;
  }
}

class DoubleArray {
  const DoubleArray({
    required this.base,
    required this.check,
  });
  final List<int> base;
  final List<int> check;
}

class SearchedWord {
  const SearchedWord({
    required this.word,
    required this.start,
    required this.end,
  });
  final String word;
  final int start;
  final int end;
}
