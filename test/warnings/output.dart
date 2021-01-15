class Warnings {
	List<String> ambiguousArray;
	List<Ambiguous> ambiguous;
	List<String> emptyArr;

	Warnings({this.ambiguousArray, this.ambiguous, this.emptyArr});

	Warnings.fromJson(Map<String, dynamic> json) {
		ambiguousArray = json['ambiguousArray'].cast<String>();
		if (json['ambiguous'] != null) {
			ambiguous = <Ambiguous>[];
			json['ambiguous'].forEach((v) { ambiguous.add(Ambiguous.fromJson(v)); });
		}
		emptyArr = json['emptyArr'].cast<String>();
	}

	Map<String, dynamic> toJson() {
		final data = <String, dynamic>{};
		data['ambiguousArray'] = ambiguousArray;
		if (ambiguous != null) {
      data['ambiguous'] = ambiguous.map((v) => v.toJson()).toList();
    }
		data['emptyArr'] = emptyArr;
		return data;
	}
}

class Ambiguous {
	double shouldBeDouble;
	List<Arr> arr;

	Ambiguous({this.shouldBeDouble, this.arr});

	Ambiguous.fromJson(Map<String, dynamic> json) {
		shouldBeDouble = json['shouldBeDouble'];
		if (json['arr'] != null) {
			arr = <Arr>[];
			json['arr'].forEach((v) { arr.add(Arr.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final data = <String, dynamic>{};
		data['shouldBeDouble'] = shouldBeDouble;
		if (arr != null) {
      data['arr'] = arr.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class Arr {
	List<String> emptyArr;
	int amb;
	String str;

	Arr({this.emptyArr, this.amb, this.str});

	Arr.fromJson(Map<String, dynamic> json) {
		emptyArr = json['emptyArr'].cast<String>();
		amb = json['amb'];
		str = json['str'];
	}

	Map<String, dynamic> toJson() {
		final data = <String, dynamic>{};
		data['emptyArr'] = emptyArr;
		data['amb'] = amb;
		data['str'] = str;
		return data;
	}
}
