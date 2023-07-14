class WindModel{
  final num speed;
  final num deg;

  WindModel({required this.deg, required this.speed});

  factory WindModel.fromJson(Map<String, dynamic> json){
    return WindModel(deg: json["deg"] as num? ?? 0, speed: json["speed"] as num? ?? 0);
  }
}