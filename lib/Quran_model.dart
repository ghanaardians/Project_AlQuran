class QuranModel {
  List<Quran>? data;
  QuranModel({this.data});
  QuranModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Quran>[];
      json['data'].forEach((v) {
        data!.add(new Quran.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Quran {
  String? arti;
  String? asma;
  int? ayat;
  String? nama;
  String? type;
  String? urut;
  String? audio;
  String? nomor;
  String? rukuk;
  String? keterangan;
  Quran({
    required this.arti,
    required this.asma,
    required this.ayat,
    required this.nama,
    required this.type,
    required this.urut,
    required this.audio,
    required this.nomor,
    required this.rukuk,
    required this.keterangan,
  });

  Quran.fromJson(Map<String, dynamic> data) {
    arti = data['arti'];
    asma = data['asma'];
    ayat = data['ayat'];
    nama = data['nama'];
    type = data['type'];
    urut = data['urut'];
    audio = data['audio'];
    nomor = data['nomor'];
    rukuk = data['rukuk'];
    keterangan = data['keterangan'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['arti'] = this.arti;
    data['asma'] = this.asma;
    data['ayat'] = this.ayat;
    data['nama'] = this.nama;
    data['type'] = this.type;
    data['urut'] = this.urut;
    data['audio'] = this.audio;
    data['nomor'] = this.nomor;
    data['rukuk'] = this.rukuk;
    data['keterangan'] = this.keterangan;
    return data;
  }
}
