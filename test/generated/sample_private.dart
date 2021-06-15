// Sample: 1 ()
// PersonalInfo: 1 (Sample)
// Phones: 1 (PersonalInfo)
//
// ---------- output ----------
// Sample ()
// PersonalInfo (Sample)
// Phones (PersonalInfo)
// ==========

class Sample {
	String _username;
	int _favouriteInteger;
	double _favouriteDouble;
	String _url;
	String _htmlUrl;
	List<String> _tags;
	List<int> _randomIntegers;
	List<double> _randomDoubles;
	PersonalInfo _personalInfo;

	Sample({required String username, required int favouriteInteger, required double favouriteDouble, required String url, required String htmlUrl, required List<String> tags, required List<int> randomIntegers, required List<double> randomDoubles, required PersonalInfo personalInfo}) :
		_username = username,
		_favouriteInteger = favouriteInteger,
		_favouriteDouble = favouriteDouble,
		_url = url,
		_htmlUrl = htmlUrl,
		_tags = tags,
		_randomIntegers = randomIntegers,
		_randomDoubles = randomDoubles,
		_personalInfo = personalInfo;


	String get username => _username;
	set username(String username) => _username = username;
	int get favouriteInteger => _favouriteInteger;
	set favouriteInteger(int favouriteInteger) => _favouriteInteger = favouriteInteger;
	double get favouriteDouble => _favouriteDouble;
	set favouriteDouble(double favouriteDouble) => _favouriteDouble = favouriteDouble;
	String get url => _url;
	set url(String url) => _url = url;
	String get htmlUrl => _htmlUrl;
	set htmlUrl(String htmlUrl) => _htmlUrl = htmlUrl;
	List<String> get tags => _tags;
	set tags(List<String> tags) => _tags = tags;
	List<int> get randomIntegers => _randomIntegers;
	set randomIntegers(List<int> randomIntegers) => _randomIntegers = randomIntegers;
	List<double> get randomDoubles => _randomDoubles;
	set randomDoubles(List<double> randomDoubles) => _randomDoubles = randomDoubles;
	PersonalInfo get personalInfo => _personalInfo;
	set personalInfo(PersonalInfo personalInfo) => _personalInfo = personalInfo;

	Sample.fromJson(Map<String, dynamic> json) :
		_username = json['username'],
		_favouriteInteger = json['favouriteInteger'],
		_favouriteDouble = json['favouriteDouble'],
		_url = json['url'],
		_htmlUrl = json['html_url'],
		_tags = json['tags'].cast<String>(),
		_randomIntegers = json['randomIntegers'].cast<int>(),
		_randomDoubles = json['randomDoubles'].cast<double>(),
		_personalInfo = PersonalInfo.fromJson(json['personalInfo']);


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
	String _firstName;
	String _lastName;
	String _location;
	List<Phones> _phones;

	PersonalInfo({required String firstName, required String lastName, required String location, required List<Phones> phones}) :
		_firstName = firstName,
		_lastName = lastName,
		_location = location,
		_phones = phones;


	String get firstName => _firstName;
	set firstName(String firstName) => _firstName = firstName;
	String get lastName => _lastName;
	set lastName(String lastName) => _lastName = lastName;
	String get location => _location;
	set location(String location) => _location = location;
	List<Phones> get phones => _phones;
	set phones(List<Phones> phones) => _phones = phones;

	PersonalInfo.fromJson(Map<String, dynamic> json) :
		_firstName = json['firstName'],
		_lastName = json['lastName'],
		_location = json['location'],
		_phones = json['phones'] != null ?
			<Phones>[] :
			json['phones'].map((v) => Phones.fromJson(v));


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
	String _type;
	String _number;
	bool _shouldCall;

	Phones({required String type, required String number, required bool shouldCall}) :
		_type = type,
		_number = number,
		_shouldCall = shouldCall;


	String get type => _type;
	set type(String type) => _type = type;
	String get number => _number;
	set number(String number) => _number = number;
	bool get shouldCall => _shouldCall;
	set shouldCall(bool shouldCall) => _shouldCall = shouldCall;

	Phones.fromJson(Map<String, dynamic> json) :
		_type = json['type'],
		_number = json['number'],
		_shouldCall = json['shouldCall'];


	Map<String, dynamic> toJson() {
		final __data__ = <String, dynamic>{};
		__data__['type'] = _type;
		__data__['number'] = _number;
		__data__['shouldCall'] = _shouldCall;
		return __data__;
	}
}

