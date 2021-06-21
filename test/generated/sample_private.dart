//@dart=2.12

class Sample {
  final String _username;
  final int _favouriteInteger;
  final double _favouriteDouble;
  final String _url;
  final String _htmlUrl;
  final List<String> _tags;
  final List<int> _randomIntegers;
  final List<double> _randomDoubles;
  final PersonalInfo _personalInfo;

  Sample(
      {required String username,
      required int favouriteInteger,
      required double favouriteDouble,
      required String url,
      required String htmlUrl,
      required List<String> tags,
      required List<int> randomIntegers,
      required List<double> randomDoubles,
      required PersonalInfo personalInfo})
      : _username = username,
        _favouriteInteger = favouriteInteger,
        _favouriteDouble = favouriteDouble,
        _url = url,
        _htmlUrl = htmlUrl,
        _tags = tags,
        _randomIntegers = randomIntegers,
        _randomDoubles = randomDoubles,
        _personalInfo = personalInfo;

  String get username => _username;
  int get favouriteInteger => _favouriteInteger;
  double get favouriteDouble => _favouriteDouble;
  String get url => _url;
  String get htmlUrl => _htmlUrl;
  List<String> get tags => _tags;
  List<int> get randomIntegers => _randomIntegers;
  List<double> get randomDoubles => _randomDoubles;
  PersonalInfo get personalInfo => _personalInfo;

  factory Sample.fromJson(Map<String, dynamic> json) {
    return Sample(
      username: json['username'],
      favouriteInteger: json['favouriteInteger'],
      favouriteDouble: json['favouriteDouble'],
      url: json['url'],
      htmlUrl: json['html_url'],
      tags: json['tags'].cast<String>(),
      randomIntegers: json['randomIntegers'].cast<int>(),
      randomDoubles: json['randomDoubles'].cast<double>(),
      personalInfo: PersonalInfo.fromJson(json['personalInfo']),
    );
  }

  Map<String, dynamic> toJson() {
    final __data__ = <String, dynamic>{};
    __data__['username'] = _username;
    __data__['favouriteInteger'] = _favouriteInteger;
    __data__['favouriteDouble'] = _favouriteDouble;
    __data__['url'] = _url;
    __data__['html_url'] = _htmlUrl;
    __data__['tags'] = _tags;
    __data__['randomIntegers'] = _randomIntegers;
    __data__['randomDoubles'] = _randomDoubles;
    __data__['personalInfo'] = _personalInfo.toJson();
    return __data__;
  }
}

class PersonalInfo {
  final String _firstName;
  final String _lastName;
  final String _location;
  final List<Phones> _phones;

  PersonalInfo(
      {required String firstName,
      required String lastName,
      required String location,
      required List<Phones> phones})
      : _firstName = firstName,
        _lastName = lastName,
        _location = location,
        _phones = phones;

  String get firstName => _firstName;
  String get lastName => _lastName;
  String get location => _location;
  List<Phones> get phones => _phones;

  factory PersonalInfo.fromJson(Map<String, dynamic> json) {
    return PersonalInfo(
      firstName: json['firstName'],
      lastName: json['lastName'],
      location: json['location'],
      phones: List<Phones>.from(json['phones'].map((x) => Phones.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    final __data__ = <String, dynamic>{};
    __data__['firstName'] = _firstName;
    __data__['lastName'] = _lastName;
    __data__['location'] = _location;
    __data__['phones'] = _phones.map((v) => v.toJson()).toList();
    return __data__;
  }
}

class Phones {
  final String _type;
  final String _number;
  final bool _shouldCall;

  Phones(
      {required String type, required String number, required bool shouldCall})
      : _type = type,
        _number = number,
        _shouldCall = shouldCall;

  String get type => _type;
  String get number => _number;
  bool get shouldCall => _shouldCall;

  factory Phones.fromJson(Map<String, dynamic> json) {
    return Phones(
      type: json['type'],
      number: json['number'],
      shouldCall: json['shouldCall'],
    );
  }

  Map<String, dynamic> toJson() {
    final __data__ = <String, dynamic>{};
    __data__['type'] = _type;
    __data__['number'] = _number;
    __data__['shouldCall'] = _shouldCall;
    return __data__;
  }
}
