class Config {
	String appName;
	String packageName;
	String schoolName;
	String logoSchoolUrl;
	String baseUrl;
	List<Modules> modules;

	Config({this.appName, this.packageName, this.schoolName, this.logoSchoolUrl, this.baseUrl, this.modules});

	Config.fromJson(Map<String, dynamic> json) {
		appName = json['app_name'];
		packageName = json['package_name'];
		schoolName = json['school_name'];
		logoSchoolUrl = json['logo_school_url'];
		baseUrl = json['base_url'];
		if (json['modules'] != null) {
			modules = new List<Modules>();
			json['modules'].forEach((v) { modules.add(new Modules.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['app_name'] = this.appName;
		data['package_name'] = this.packageName;
		data['school_name'] = this.schoolName;
		data['logo_school_url'] = this.logoSchoolUrl;
		data['base_url'] = this.baseUrl;
		if (this.modules != null) {
      data['modules'] = this.modules.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class Modules {
	String name;
	String route;
	String className;
	String iconUrl;

	Modules({this.name, this.route, this.className, this.iconUrl});

	Modules.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		route = json['route'];
		className = json['class_name'];
		iconUrl = json['icon_url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['route'] = this.route;
		data['class_name'] = this.className;
		data['icon_url'] = this.iconUrl;
		return data;
	}
}

class Routes<T> {
  final String name;
  final T handler;

  Routes({this.name, this.handler}) : assert(name != null);
}
