class Config {
  String? appName;
  String? packageName;
  String? schoolName;
  String? logoSchoolUrl;
  String? baseUrl;
  String? clientId;
  String? schoolId;
  List<Modules>? modules;

  Config(
      {this.appName,
      this.packageName,
      this.schoolName,
      this.logoSchoolUrl,
      this.baseUrl,
      this.clientId,
      this.schoolId,
      this.modules});

  Config.fromJson(Map<String, dynamic> json) {
    appName = json['app_name'];
    packageName = json['package_name'];
    schoolName = json['school_name'];
    logoSchoolUrl = json['logo_school_url'];
    baseUrl = json['base_url'];
    clientId = json['client_id'];
    schoolId = json['school_id'];
    if (json['modules'] != null) {
      modules =  [];
      json['modules'].forEach((v) {
        modules!.add(Modules.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['app_name'] = this.appName;
    data['package_name'] = this.packageName;
    data['school_name'] = this.schoolName;
    data['logo_school_url'] = this.logoSchoolUrl;
    data['base_url'] = this.baseUrl;
    data['client_id'] = this.clientId;
    data['school_id'] = this.schoolId;
    if (this.modules != null) {
      data['modules'] = this.modules!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Modules {
  String? nameId;
  String? nameEn;
  String? categoryId;
  String? categoryEn;
  String? descriptionId;
  String? descriptionEn;
  String? route;
  String? className;
  String? iconUrl;

  Modules({this.nameId, this.nameEn, this.categoryId, this.categoryEn, this.descriptionId, this.descriptionEn, this.route, this.className, this.iconUrl});

  Modules.fromJson(Map<String, dynamic> json) {
    nameId = json['name_id'];
    nameEn = json['name_en'];
    categoryId = json['category_id'];
    categoryEn = json['category_en'];
    descriptionId = json['description_id'];
    descriptionEn = json['description_en'];
    route = json['route'];
    className = json['class_name'];
    iconUrl = json['icon_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name_id'] = this.nameId;
    data['name_en'] = this.nameEn;
    data['category_id'] = this.categoryId;
    data['category_en'] = this.categoryEn;
    data['description_id'] = this.descriptionId;
    data['description_en'] = this.descriptionEn;
    data['route'] = this.route;
    data['class_name'] = this.className;
    data['icon_url'] = this.iconUrl;
    return data;
  }
}

class Routes<T> {
  final String name;
  final String? route;
  final T? handler;

  Routes({required this.name, this.handler, this.route}) : assert(name != null);
}
