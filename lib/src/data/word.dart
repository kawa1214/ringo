class Word {
  const Word({
    required this.word,
    required this.leftContextId,
    required this.rightContextId,
    required this.occurrenceCost,
  });
  final String word;
  final int leftContextId;
  final int rightContextId;
  final int occurrenceCost;
}
