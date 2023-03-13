class ProgressModel {
  int id;
  String name;

  ProgressModel({required this.id, required this.name});

  factory ProgressModel.fromJson(Map<String, dynamic> json) => ProgressModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };

  factory ProgressModel.empty() {
    return ProgressModel(
      id: 0,
      name: 'Pending',
    );
  }
}
