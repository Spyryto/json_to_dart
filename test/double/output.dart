class DoubleTest {
  int int1;
  double double2;
  double double3;
  double double4;
  double double5;
  double double6;
  double double7;
  double double8;
  double double9;
  double double10;
  double double11;
  double double12;
  double double13;
  double double14;
  double double15;
  double double16;

  DoubleTest(
      {this.int1,
      this.double2,
      this.double3,
      this.double4,
      this.double5,
      this.double6,
      this.double7,
      this.double8,
      this.double9,
      this.double10,
      this.double11,
      this.double12,
      this.double13,
      this.double14,
      this.double15,
      this.double16});

  DoubleTest.fromJson(Map<String, dynamic> json) {
    int1 = json['int1'];
    double2 = json['double2'];
    double3 = json['double3'];
    double4 = json['double4'];
    double5 = json['double5'];
    double6 = json['double6'];
    double7 = json['double7'];
    double8 = json['double8'];
    double9 = json['double9'];
    double10 = json['double10'];
    double11 = json['double11'];
    double12 = json['double12'];
    double13 = json['double13'];
    double14 = json['double14'];
    double15 = json['double15'];
    double16 = json['double16'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['int1'] = int1;
    data['double2'] = double2;
    data['double3'] = double3;
    data['double4'] = double4;
    data['double5'] = double5;
    data['double6'] = double6;
    data['double7'] = double7;
    data['double8'] = double8;
    data['double9'] = double9;
    data['double10'] = double10;
    data['double11'] = double11;
    data['double12'] = double12;
    data['double13'] = double13;
    data['double14'] = double14;
    data['double15'] = double15;
    data['double16'] = double16;
    return data;
  }
}
