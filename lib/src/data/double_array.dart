import '../utils/string_utils.dart';
import '../utils/list_utils.dart';
import '../utils/path.dart';
import 'tokenized_word.dart';

class DoubleArray {
  const DoubleArray({
    required this.base,
    required this.check,
  });
  final List<int> base;
  final List<int> check;

  static Future<DoubleArray> init() async {
    final base = await ListUtils.loadList(Path.base);
    final check = await ListUtils.loadList(Path.check);
    return DoubleArray(base: base, check: check);
  }

  List<TokenizedWord> searchCommonPrefix(String word) {
    final searchResult = <TokenizedWord>[];
    for (var start = 0; start < word.length; start++) {
      for (var end = 1; end < word.length + 1; end++) {
        final result = _searchCommonPrefixHelper(word, start, end);
        if (result != null) {
          searchResult.add(result);
        }
      }
    }
    return searchResult;
  }

  TokenizedWord? _searchCommonPrefixHelper(String word, int start, int end) {
    if (start == end || start > end) {
      return null;
    }
    final query = word.substring(start, end);
    if (_search(query)) {
      final word = TokenizedWord(word: query, start: start, end: end);
      return word;
    }
    return null;
  }

  bool _search(String word) {
    int current = 0;
    final codes = StringUtils.stringToUint8List(word);
    for (var i = 0; i < codes.length; i++) {
      final code = codes[i];
      final next = base[current] + code;
      final checkData = check[next] - 1;
      if (current != checkData) {
        return false;
      }
      current = next;
    }
    return true;
  }
}
