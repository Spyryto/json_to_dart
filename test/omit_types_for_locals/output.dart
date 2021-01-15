class Response {
  Dati dati;

  Response({this.dati});

  Response.fromJson(Map<String, dynamic> json) {
    dati = json['dati'] != null ? Dati.fromJson(json['dati']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (dati != null) {
      data['dati'] = dati.toJson();
    }
    return data;
  }
}

class Dati {
  Null label;
  String codiceAzienda;
  String codiceAnagrafico;
  String codiceServizio;

  Dati(
      {this.label,
      this.codiceAzienda,
      this.codiceAnagrafico,
      this.codiceServizio});

  Dati.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    codiceAzienda = json['codice_azienda'];
    codiceAnagrafico = json['codice_anagrafico'];
    codiceServizio = json['codice_servizio'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['label'] = label;
    data['codice_azienda'] = codiceAzienda;
    data['codice_anagrafico'] = codiceAnagrafico;
    data['codice_servizio'] = codiceServizio;
    return data;
  }
}
