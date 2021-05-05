import 'trie.dart';

class DoubleArray {
  DoubleArray(
      {required this.base, required this.check, required this.vocabulary});
  List<int> base;
  List<int> check;
  Vocabulary vocabulary;

  factory DoubleArray.newDoubleArray(TrieTree t) {
    final doubleArray = DoubleArray(
      vocabulary: t.vocabulary,
      base: List.filled(500, 0),
      check: List.filled(500, 0),
    );
    doubleArray.build(0, t.root);
    return doubleArray;
  }

  void build(int current, TrieNode n) {
    int offset = 1;

    while (!acceptable(n.children, offset)) {
      offset++;
      //print('offset call');
    }

    base[current] = offset;

    for (final child in n.children) {
      final next = offset + child.code;
      check[next] = current + 1;
    }

    for (final child in n.children) {
      final next = offset + child.code;
      build(next, child);
    }

    //print('current: $current');
    //print('base: $base');
    //print('base: $check');
  }

  bool acceptable(List<TrieNode> nodes, int offset) {
    for (final child in nodes) {
      final next = offset + child.code;
      //print('offset: $offset, code: ${child.code}');
      if (check.length <= next) {
        extendArray();
      }
      if (check[next] != 0) {
        return false;
      }
    }
    return true;
  }

  void extendArray() {
    final extendList = List.filled(base.length, 0);
    base = [...base, ...extendList];
    check = [...check, ...extendList];
  }

  /*
  List<String> searchPrefix(String word) {
    final result = <String>[];
    int current = 0;
    final codes = vocabulary.codes(word);
    for (final code in codes) {
      final next = base[current] + code;
      if(next >= check.length || current != check[next]-1) {
        return result;
      }
      current = next;
    }
    dfs(current, codes, result);
    return result;
  }

  void dfs(int i, List<int> str, List<String> result) {
    final next = base[i] + vocabulary.stopIndex;
    if (next < check.length && i == check[next]-1) {
      result.add(str.toString());
    }

    for (var c=0; c < vocabulary.stopIndex; c++) {
      final next = base[i] + c;
      if (next>= check.length || i != check[next]-1) {
        continue;
      }

      dfs(next, [...str, c], result);
    }
  }
  */

  final searchResult = <String>[];
  List<String> searchPrefix(String word) {
    for (var start = 0; start < word.length; start++) {
      for (var end = 1; end < word.length + 1; end++) {
        searchHelper(word, start, end);
      }
    }
    return searchResult;
  }

  void searchHelper(String word, int start, int end) {
    //print('$start, $end');
    if (start == end || start > end) {
      return;
    }
    final query = word.substring(start, end);
    if (search(query)) {
      searchResult.add(query);
    }
  }

  bool search(String word) {
    int current = 0;
    final codes = vocabulary.codes(word);
    //print(codes);
    for (var i = 0; i < codes.length; i++) {
      final code = codes[i];
      //print(code);
      final next = base[current] + code;
      final checkData = check[next] - 1;
      //print('debug i: $i, char: code: $code, current: $current, next: $next, checkData: $checkData,');
      if (current != checkData) {
        return false;
        //return false;
      }
      current = next;
    }
    return true;
  }
}
