# ringo
![ringo](https://github.com/kawa1214/ringo/blob/main/example/ringo.gif "ringo")

ringo is japanese word separation.

## Usage
```
final ringo = await Ringo.init();
final tokenized = ringo.tokenize('吾輩はRingoである');
print('tokenized: $tokenized');
```

`tokenized: [吾輩, は, Ringo, である]`

## ⚡️ Features

- [x] Simple word separation(Japanese)
- [x] Unknown word processing
- [x] Build own dictionary(Create DoubleArray from TrieTree)
- [x] Fast dictionary search(DoubleArray Algorithm)

## Upcoming Features

- [ ] MorphologicalAnalysis(Lattice Algorithm)

## Contributing

---

ringoは日本語の分かち書きをします．(今後，形態素解析もサポートする予定です)
