class ProgressModel {
  int id;
  String status;

  ProgressModel({required this.id, required this.status});

  factory ProgressModel.fromJson(Map<String, dynamic> json) => ProgressModel(
    id: json["id"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
  };

  factory ProgressModel.empty() {
    return ProgressModel(
      id: 0,
      status: 'pending',
    );
  }
}