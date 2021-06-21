//@dart=2.12

class BugTen {
  final Glossary glossary;

  BugTen({required this.glossary});

  factory BugTen.fromJson(Map<String, dynamic> json) {
    return BugTen(
      glossary: Glossary.fromJson(json['glossary']),
    );
  }

  Map<String, dynamic> toJson() {
    final __data__ = <String, dynamic>{};
    __data__['glossary'] = glossary.toJson();
    return __data__;
  }
}

class Glossary {
  final String title;
  final GlossDiv glossDiv;

  Glossary({required this.title, required this.glossDiv});

  factory Glossary.fromJson(Map<String, dynamic> json) {
    return Glossary(
      title: json['title'],
      glossDiv: GlossDiv.fromJson(json['GlossDiv']),
    );
  }

  Map<String, dynamic> toJson() {
    final __data__ = <String, dynamic>{};
    __data__['title'] = title;
    __data__['GlossDiv'] = glossDiv.toJson();
    return __data__;
  }
}

class GlossDiv {
  final String title;
  final GlossList glossList;

  GlossDiv({required this.title, required this.glossList});

  factory GlossDiv.fromJson(Map<String, dynamic> json) {
    return GlossDiv(
      title: json['title'],
      glossList: GlossList.fromJson(json['GlossList']),
    );
  }

  Map<String, dynamic> toJson() {
    final __data__ = <String, dynamic>{};
    __data__['title'] = title;
    __data__['GlossList'] = glossList.toJson();
    return __data__;
  }
}

class GlossList {
  final GlossEntry glossEntry;

  GlossList({required this.glossEntry});

  factory GlossList.fromJson(Map<String, dynamic> json) {
    return GlossList(
      glossEntry: GlossEntry.fromJson(json['GlossEntry']),
    );
  }

  Map<String, dynamic> toJson() {
    final __data__ = <String, dynamic>{};
    __data__['GlossEntry'] = glossEntry.toJson();
    return __data__;
  }
}

class GlossEntry {
  final String iD;
  final String sortAs;
  final String glossTerm;
  final String acronym;
  final String abbrev;
  final GlossDef glossDef;
  final String glossSee;

  GlossEntry(
      {required this.iD,
      required this.sortAs,
      required this.glossTerm,
      required this.acronym,
      required this.abbrev,
      required this.glossDef,
      required this.glossSee});

  factory GlossEntry.fromJson(Map<String, dynamic> json) {
    return GlossEntry(
      iD: json['ID'],
      sortAs: json['SortAs'],
      glossTerm: json['GlossTerm'],
      acronym: json['Acronym'],
      abbrev: json['Abbrev'],
      glossDef: GlossDef.fromJson(json['GlossDef']),
      glossSee: json['GlossSee'],
    );
  }

  Map<String, dynamic> toJson() {
    final __data__ = <String, dynamic>{};
    __data__['ID'] = iD;
    __data__['SortAs'] = sortAs;
    __data__['GlossTerm'] = glossTerm;
    __data__['Acronym'] = acronym;
    __data__['Abbrev'] = abbrev;
    __data__['GlossDef'] = glossDef.toJson();
    __data__['GlossSee'] = glossSee;
    return __data__;
  }
}

class GlossDef {
  final String para;
  final List<String> glossSeeAlso;

  GlossDef({required this.para, required this.glossSeeAlso});

  factory GlossDef.fromJson(Map<String, dynamic> json) {
    return GlossDef(
      para: json['para'],
      glossSeeAlso: json['GlossSeeAlso'].cast<String>(),
    );
  }

  Map<String, dynamic> toJson() {
    final __data__ = <String, dynamic>{};
    __data__['para'] = para;
    __data__['GlossSeeAlso'] = glossSeeAlso;
    return __data__;
  }
}
