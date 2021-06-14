class Empresa {
  String codEmpresa;
  String nomeEmpresa;
  String cnpjEmpresa;
  String loginEmpresa;
  String senhaEmpresa;

  Empresa({this.codEmpresa, this.nomeEmpresa, this.cnpjEmpresa});

  static List<Empresa> fromJsonList(List list) {
    if (list == null) return null;
    return list.map<Empresa>((item) => Empresa.fromJson(item)).toList();
  }

  Empresa.fromJson(Map<String, dynamic> json) {
    json['codigo'] != null ? codEmpresa = json['codigo'] : codEmpresa = "";
    json['email'] != null ? nomeEmpresa = json['email'] : nomeEmpresa = "";
    json['senha'] != null ? cnpjEmpresa = json['senha'] : cnpjEmpresa = "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codigo'] = this.codEmpresa ?? "";
    data['email'] = this.nomeEmpresa ?? "";
    data['senha'] = this.cnpjEmpresa ?? "";
    return data;
  }
}
