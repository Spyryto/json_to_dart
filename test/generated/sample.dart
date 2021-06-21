//@dart=2.12

class Sample {
  final String username;
  final int favouriteInteger;
  final double favouriteDouble;
  final String url;
  final String htmlUrl;
  final List<String> tags;
  final List<int> randomIntegers;
  final List<double> randomDoubles;
  final PersonalInfo personalInfo;

  Sample(
      {required this.username,
      required this.favouriteInteger,
      required this.favouriteDouble,
      required this.url,
      required this.htmlUrl,
      required this.tags,
      required this.randomIntegers,
      required this.randomDoubles,
      required this.personalInfo});

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
    __data__['username'] = username;
    __data__['favouriteInteger'] = favouriteInteger;
    __data__['favouriteDouble'] = favouriteDouble;
    __data__['url'] = url;
    __data__['html_url'] = htmlUrl;
    __data__['tags'] = tags;
    __data__['randomIntegers'] = randomIntegers;
    __data__['randomDoubles'] = randomDoubles;
    __data__['personalInfo'] = personalInfo.toJson();
    return __data__;
  }
}

class PersonalInfo {
  final String firstName;
  final String lastName;
  final String location;
  final List<Phones> phones;

  PersonalInfo(
      {required this.firstName,
      required this.lastName,
      required this.location,
      required this.phones});

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
    __data__['firstName'] = firstName;
    __data__['lastName'] = lastName;
    __data__['location'] = location;
    __data__['phones'] = phones.map((v) => v.toJson()).toList();
    return __data__;
  }
}

class Phones {
  final String type;
  final String number;
  final bool shouldCall;

  Phones({required this.type, required this.number, required this.shouldCall});

  factory Phones.fromJson(Map<String, dynamic> json) {
    return Phones(
      type: json['type'],
      number: json['number'],
      shouldCall: json['shouldCall'],
    );
  }

  Map<String, dynamic> toJson() {
    final __data__ = <String, dynamic>{};
    __data__['type'] = type;
    __data__['number'] = number;
    __data__['shouldCall'] = shouldCall;
    return __data__;
  }
}
