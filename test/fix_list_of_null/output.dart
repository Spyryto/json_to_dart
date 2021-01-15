class Response {
  String uid;
  Dati dati;

  Response({this.uid, this.dati});

  Response.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    dati = json['dati'] != null ? Dati.fromJson(json['dati']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uid'] = uid;
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
  Stato stato;
  String dataAttivazione;
  Null dataCessazione;
  String codiceFiscale;
  Null partitaIva;
  Null domiciliazioneBancaria;
  List<String> telefonoFisso;
  List<String> telefonoCellulare;
  List<String> fax;
  List<String> email;
  Null note;
  String ultimoAggiornamento;
  Residenza residenza;

  Dati(
      {this.label,
      this.codiceAzienda,
      this.codiceAnagrafico,
      this.stato,
      this.dataAttivazione,
      this.dataCessazione,
      this.codiceFiscale,
      this.partitaIva,
      this.domiciliazioneBancaria,
      this.telefonoFisso,
      this.telefonoCellulare,
      this.fax,
      this.email,
      this.note,
      this.ultimoAggiornamento,
      this.residenza});

  Dati.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    codiceAzienda = json['codice_azienda'];
    codiceAnagrafico = json['codice_anagrafico'];
    stato = json['stato'] != null ? Stato.fromJson(json['stato']) : null;
    dataAttivazione = json['data_attivazione'];
    dataCessazione = json['data_cessazione'];
    codiceFiscale = json['codice_fiscale'];
    partitaIva = json['partita_iva'];
    domiciliazioneBancaria = json['domiciliazione_bancaria'];
    telefonoFisso = json['telefono_fisso'].cast<String>();
    telefonoCellulare = json['telefono_cellulare'].cast<String>();
    fax = json['fax'].cast<String>();
    email = json['email'].cast<String>();
    note = json['note'];
    ultimoAggiornamento = json['ultimo_aggiornamento'];
    residenza = json['residenza'] != null
        ? Residenza.fromJson(json['residenza'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['label'] = label;
    data['codice_azienda'] = codiceAzienda;
    data['codice_anagrafico'] = codiceAnagrafico;
    if (stato != null) {
      data['stato'] = stato.toJson();
    }
    data['data_attivazione'] = dataAttivazione;
    data['data_cessazione'] = dataCessazione;
    data['codice_fiscale'] = codiceFiscale;
    data['partita_iva'] = partitaIva;
    data['domiciliazione_bancaria'] = domiciliazioneBancaria;
    data['telefono_fisso'] = telefonoFisso;
    data['telefono_cellulare'] = telefonoCellulare;
    data['fax'] = fax;
    data['email'] = email;
    data['note'] = note;
    data['ultimo_aggiornamento'] = ultimoAggiornamento;
    if (residenza != null) {
      data['residenza'] = residenza.toJson();
    }
    return data;
  }
}

class Stato {
  String codifica;
  String descrizione;

  Stato({this.codifica, this.descrizione});

  Stato.fromJson(Map<String, dynamic> json) {
    codifica = json['codifica'];
    descrizione = json['descrizione'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['codifica'] = codifica;
    data['descrizione'] = descrizione;
    return data;
  }
}

class Residenza {
  String nome;
  String cognome;
  Null ragioneSociale;
  String belfiore;
  String indirizzo;
  String civico;
  Null barrato;
  Null edificio;
  Null interno;
  Null piano;
  Null scala;
  String cap;
  String provincia;
  String comune;
  String nazione;
  Null note;
  String ultimoAggiornamento;

  Residenza(
      {this.nome,
      this.cognome,
      this.ragioneSociale,
      this.belfiore,
      this.indirizzo,
      this.civico,
      this.barrato,
      this.edificio,
      this.interno,
      this.piano,
      this.scala,
      this.cap,
      this.provincia,
      this.comune,
      this.nazione,
      this.note,
      this.ultimoAggiornamento});

  Residenza.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    cognome = json['cognome'];
    ragioneSociale = json['ragione_sociale'];
    belfiore = json['belfiore'];
    indirizzo = json['indirizzo'];
    civico = json['civico'];
    barrato = json['barrato'];
    edificio = json['edificio'];
    interno = json['interno'];
    piano = json['piano'];
    scala = json['scala'];
    cap = json['cap'];
    provincia = json['provincia'];
    comune = json['comune'];
    nazione = json['nazione'];
    note = json['note'];
    ultimoAggiornamento = json['ultimo_aggiornamento'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['nome'] = nome;
    data['cognome'] = cognome;
    data['ragione_sociale'] = ragioneSociale;
    data['belfiore'] = belfiore;
    data['indirizzo'] = indirizzo;
    data['civico'] = civico;
    data['barrato'] = barrato;
    data['edificio'] = edificio;
    data['interno'] = interno;
    data['piano'] = piano;
    data['scala'] = scala;
    data['cap'] = cap;
    data['provincia'] = provincia;
    data['comune'] = comune;
    data['nazione'] = nazione;
    data['note'] = note;
    data['ultimo_aggiornamento'] = ultimoAggiornamento;
    return data;
  }
}
