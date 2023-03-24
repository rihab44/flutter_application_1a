


class produit {
  late String? nom;
  late double? prix;
  late double? code;
  late double? stock;
  late double? criteredemesure;

  produit({
    this.nom,
    this.prix,
    this.code,
    this.stock,
    this.criteredemesure,
  });
  factory produit.fromJson(Map<String, dynamic> json) {
    return produit(
      nom: json['nom'] as String?,
      prix: json['prix'] as double?,
      code: json['code'] as double?,
      stock: json['stock'] as double?,
      criteredemesure: json['criteredemesure'] as double?,
    );
  }

  Map<String, dynamic> tojson() {
    final _data = <String, dynamic>{};
    _data["nom"] = nom;
    _data["prix"] = prix;
    _data["code"] = code;
    _data["stock"] = stock;
    _data["criteredemesure"] = criteredemesure;

    return _data;
  }

}