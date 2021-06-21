# JSON to Dart

[![Build Status](https://travis-ci.org/javiercbk/json_to_dart.svg?branch=master)](https://travis-ci.org/javiercbk/json_to_dart)

Given a JSON string, this library will generate all the necessary Dart classes to parse and generate JSON.

This library is designed to generate Flutter friendly model classes following the [flutter's doc recommendation](https://flutter.io/json/#serializing-json-manually-using-dartconvert).

## Caveats

🗹	 `Null` typedefs default to `String?` now. This makes the generated code at least usable.

🗹 Equal structures are detected. Equal classes are prefixed with name of parent class.

🗹 Maps can be used to rename classes on a general basis.

🗹 Hints can be used to rename classes matching a specified path selector.

☐ Properties named with funky names (like "!breaks", "|breaks", etc) or keyword (like "this", "break", "class", etc) are not handled. They will produce syntax errors.

☐ Array of arrays are not supported:

```json
[[{ "isThisSupported": false }]]
```

```json
[{ "thisSupported": [{ "cool": true }] }]
```
