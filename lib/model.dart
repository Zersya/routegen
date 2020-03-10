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
}


class Routes<T> {
  final String name;
  final T handler;

  Routes({this.name, this.handler}) : assert(name != null);
}
