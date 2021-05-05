import 'dart:convert';
import 'dart:typed_data';

Uint8List stringToUint8List(String string) {
  final encoder = Utf8Encoder();
  return encoder.convert(string);
}

String uint8ListToString(List<int> bytes) {
  return Utf8Decoder().convert(bytes);
}

class Vocabulary {
  Vocabulary({required this.word, required this.offset, required this.stopIndex});
  String word;
  int offset;
  int stopIndex;

  factory Vocabulary.newVocabulary(String voc) {
    //print(charToUnit8(voc[0]));
    //print(voc);
    //print(stringToUint8List(voc[0]));
    //print(voc);
    //print(stringToUint8List(voc[voc.length-1]));
    final codes = stringToUint8List(voc);
    //codes.sort((a, b) => b.compareTo(a));
    final offset = codes.first;
    //print(offset);
    return Vocabulary(
      word: voc,
      offset: codes.first,
      stopIndex: codes.last - offset + 1,
    );
  }

  List<int> codes(String word) {
    final codes = <int>[];
    final uint8List = stringToUint8List(word);
    for (final uint8 in uint8List) {
      codes.add(uint8);
    }
    //codes.add(stopIndex);
    //print(codes);
    return codes;
  }
}

class TrieNode {
  late int code;
  List<TrieNode> children = [];

  void traverse(int i, List<int> codes) {
    if (i == codes.length) {
      return;
    }
    for (final child in children) {
      if (child.code == codes[i]) {
        child.traverse(i + 1, codes);
        return;
      }
    }
    final next = TrieNode();
    next.code = codes[i];
    children.add(next);
    next.traverse(i + 1, codes);
  }
}

class TrieTree {
  TrieTree({required this.vocabulary, required this.root});
  Vocabulary vocabulary;
  TrieNode root;

  factory TrieTree.newTrieTree(String voc) {
    return TrieTree(
      vocabulary: Vocabulary.newVocabulary(voc),
      root: TrieNode(),
    );
  }

  void add(String word) {
    final codes = vocabulary.codes(word);
    root.traverse(0, codes);
  }

  bool searchResult = false;
  bool getAllWordsWithPrefix(String prefix) {
    List<int> searched = [];
    //final codes = vocabulary.codes(prefix);
    final codes = stringToUint8List(prefix);
    _getAllWordsWithPrefixHelper(codes, root, searched);
    return searchResult;
  }

  void _getAllWordsWithPrefixHelper(
      List<int>codes, TrieNode node, List<int> searched) {
    if (codes.isEmpty) {
      searchResult = true;
      return;
    }

    for (final child in node.children) {
      if (child.code == codes.first) {
        searched.add(child.code);
        return _getAllWordsWithPrefixHelper(codes.sublist(1), child, searched);
      }
    }
    return;
  }
}
