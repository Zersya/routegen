

class Config {
  String name;
  String route;
  String classDt;
  String iconUrl;

  Config({this.name, this.classDt, this.route, this.iconUrl});

  Config.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    route = json['route'];
    classDt = json['class'];
    iconUrl = json['icon_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['route'] = this.route;
    data['class'] = this.classDt;
    data['icon_url'] = this.iconUrl;
    return data;
  }
}


class Routes<T> {
  final String name;
  final T handler;

  const Routes({this.name, this.handler}) : assert(name != null);
}
