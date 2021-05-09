import 'package:ringo/src/data/tokenized_word.dart';

class LongestMatch {
  static List<String> simpleTokenize(List<TokenizedWord> words, String query) {
    // TODO: ロジックを綺麗に書き直す
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
}