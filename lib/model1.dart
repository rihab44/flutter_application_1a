


class Produit {
 late String? nom;
 late double? prix;
 late double? code;
 late double? stock;
 late double? criteredemesure;

  Produit({
    this.nom,
    this.prix,
    this.code,
    this.stock,
    this.criteredemesure,
  });

  Produit.fromJson(Map<String, dynamic> json) {
    nom = json['nom'];
    prix = json['prix'];
    code = json['code'];
    stock = json['stock'];
    criteredemesure = json['criteredemesure'];
  }
}