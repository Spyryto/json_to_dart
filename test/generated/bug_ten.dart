class BugTen {
  Glossary? glossary;

  BugTen({this.glossary});

  BugTen.fromJson(Map<String, dynamic> json) {
    glossary =
        json['glossary'] != null ? Glossary.fromJson(json['glossary']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      if (glossary != null) 'glossary': glossary?.toJson(),
    };

    return data;
  }
}

class Glossary {
  String title;
  GlossDiv? glossDiv;

  Glossary({required this.title, this.glossDiv});

  Glossary.fromJson(Map<String, dynamic> json) : title = json['title'] {
    glossDiv =
        json['GlossDiv'] != null ? GlossDiv.fromJson(json['GlossDiv']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'title': title,
      if (glossDiv != null) 'GlossDiv': glossDiv?.toJson(),
    };
    return data;
  }
}

class GlossDiv {
  String title;
  GlossList? glossList;

  GlossDiv({required this.title, this.glossList});

  GlossDiv.fromJson(Map<String, dynamic> json) : title = json['title'] {
    glossList = json['GlossList'] != null
        ? GlossList.fromJson(json['GlossList'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'title': title,
      if (glossList != null) 'GlossList': glossList?.toJson(),
    };
    return data;
  }
}

class GlossList {
  GlossEntry? glossEntry;

  GlossList({required this.glossEntry});

  GlossList.fromJson(Map<String, dynamic> json) {
    glossEntry = json['GlossEntry'] != null
        ? GlossEntry.fromJson(json['GlossEntry'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      if (glossEntry != null) 'GlossEntry': glossEntry?.toJson(),
    };
    return data;
  }
}

class GlossEntry {
  String iD;
  String sortAs;
  String glossTerm;
  String acronym;
  String abbrev;
  GlossDef? glossDef;
  String glossSee;

  GlossEntry(
      {required this.iD,
      required this.sortAs,
      required this.glossTerm,
      required this.acronym,
      required this.abbrev,
      this.glossDef,
      required this.glossSee});

  GlossEntry.fromJson(Map<String, dynamic> json)
      : iD = json['ID'],
        sortAs = json['SortAs'],
        glossTerm = json['GlossTerm'],
        acronym = json['Acronym'],
        abbrev = json['Abbrev'],
        glossDef = json['GlossDef'] != null
            ? GlossDef.fromJson(json['GlossDef'])
            : null,
        glossSee = json['GlossSee'];

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{
      'ID': iD,
      'SortAs': sortAs,
      'GlossTerm': glossTerm,
      'Acronym': acronym,
      'Abbrev': abbrev,
      if (glossDef != null) 'GlossDef': glossDef?.toJson(),
      'GlossSee': glossSee,
    };
    return data;
  }
}

class GlossDef {
  String para;
  List<String> glossSeeAlso;

  GlossDef({required this.para, required this.glossSeeAlso});

  GlossDef.fromJson(Map<String, dynamic> json)
      : para = json['para'],
        glossSeeAlso = json['GlossSeeAlso'].cast<String>();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['para'] = para;
    data['GlossSeeAlso'] = glossSeeAlso;
    return data;
  }
}
