# ringo

ringo is separating words in Japanese.

## Usage
```
final ringo = await Ringo.init();
final tokenized = ringo.tokenize('吾輩はRingoである');
print('tokenized: $tokenized');
```

`tokenized: [吾輩, は, Ringo, である]`

## ⚡️ Features

- [x] Simple Separating words(only Japanese)
- [x] Unknown word processing
- [x] Use own dictionary(Create DoubleArray from TrieTree)
- [x] Fast dictionary search(DoubleArray algorithm)

## Upcoming Features

- [ ] Lattice Algorithm
- [ ] MorphologicalAnalysis

## Contributing

---

ringoは日本語の分かち書きをします．(今後，形態素解析もサポートする予定です)
