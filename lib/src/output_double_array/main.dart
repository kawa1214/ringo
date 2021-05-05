import 'dart:convert';
import 'dart:io';

import 'array_utils.dart';
import 'double_array.dart';
import 'trie.dart';

main() async {
  final current = '/lib/src/output_double_array/';
  final file = File(Directory.current.path + '/lib/src/dictionaly/dic.csv');
  final read = file.openRead();

  final lines =
      await read.transform(utf8.decoder).transform(LineSplitter()).toList();
  final wordDic = lines.map((e) {
    final parts = e.split(',');
    return parts.first;
  }).toList();
  String chars = '';
  wordDic.forEach((e) {
    for (var i = 0; i < e.length; i++) {
      final char = e[i];
      if (!chars.contains(char)) {
        chars += char;
      }
    }
  });

  final trie = TrieTree.newTrieTree(chars);
  for (var i = 0; i < wordDic.length; i++) {
    //if (i < 1000) {
    trie.add(wordDic[i]);
    //}
  }

  //final result = trie.getAllWordsWithPrefix('本領');
  //print(result);
  final doubleArray = DoubleArray.newDoubleArray(trie);
  ListUtils.saveList(
      doubleArray.base, Directory.current.path + current + 'outputs/base.csv');
  ListUtils.saveList(doubleArray.check,
      Directory.current.path + current + 'outputs/check.csv');
  print(doubleArray.base.length);
  print(doubleArray.check.length);
  //final daResult = doubleArray.search('本領');
  //print(daResult);
  final result = doubleArray.searchPrefix('はなしたら元気になった');
  print(result);
  /*
  final trie = TrieTree.newTrieTree('abcde');
  for (final word in wordDic) {
    //trie.add(word);
  }

  trie.add("ac");
  trie.add("ace");
  trie.add("ade");
  trie.add("adea");
  trie.add("bae");
  trie.add("bca");
  trie.add("dae");
  trie.add("eee");

  //final result = trie.getAllWordsWithPrefix('ace');
  //print(result);
  
  final doubleArray = DoubleArray.newDoubleArray(trie);
  //print(doubleArray.base);
  //print(doubleArray.check);
  
  final daResult = doubleArray.search('ac');
  print(daResult);
  */
}
