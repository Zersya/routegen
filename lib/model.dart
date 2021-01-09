class Config {
  String appName;
  String packageName;
  String schoolName;
  String logoSchoolUrl;
  String baseUrl;
  String clientId;
  List<Modules> modules;

  Config(
      {this.appName,
      this.packageName,
      this.schoolName,
      this.logoSchoolUrl,
      this.baseUrl,
      this.clientId,
      this.modules});

  Config.fromJson(Map<String, dynamic> json) {
    appName = json['app_name'];
    packageName = json['package_name'];
    schoolName = json['school_name'];
    logoSchoolUrl = json['logo_school_url'];
    baseUrl = json['base_url'];
    clientId = json['client_id'];
    if (json['modules'] != null) {
      modules = new List<Modules>();
      json['modules'].forEach((v) {
        modules.add(new Modules.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app_name'] = this.appName;
    data['package_name'] = this.packageName;
    data['school_name'] = this.schoolName;
    data['logo_school_url'] = this.logoSchoolUrl;
    data['base_url'] = this.baseUrl;
    data['client_id'] = this.clientId;
    if (this.modules != null) {
      data['modules'] = this.modules.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Modules {
  String nameId;
  String nameEn;
  String route;
  String className;
  String iconUrl;

  Modules({this.nameId, this.nameEn, this.route, this.className, this.iconUrl});

  Modules.fromJson(Map<String, dynamic> json) {
    nameId = json['name_id'];
    nameEn = json['name_en'];
    route = json['route'];
    className = json['class_name'];
    iconUrl = json['icon_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name_id'] = this.nameId;
    data['name_en'] = this.nameEn;
    data['route'] = this.route;
    data['class_name'] = this.className;
    data['icon_url'] = this.iconUrl;
    return data;
  }
}

class Routes<T> {
  final String name;
  final String route;
  final T handler;

  Routes({this.name, this.handler, this.route}) : assert(name != null);
}
