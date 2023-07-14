class CoordModel{
  final num lon;
  final num lat;
  CoordModel({required this.lat, required this.lon});

  factory CoordModel.fromJsom(Map<String,dynamic> json){
    return CoordModel(lat: json["lat"] as num? ?? 0, lon: json["lon"] as num? ?? 0);
  }
}