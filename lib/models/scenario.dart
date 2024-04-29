class Scenario {
  final int id;
  final String scenarioName;
  final String description;
  final DateTime createdAt;

  Scenario({required this.id, required this.scenarioName, required this.description, required this.createdAt});

  factory Scenario.fromJson(Map<String, dynamic> json) {
    return Scenario(
      id: json['id'],
      scenarioName: json['scenario_name'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'scenario_name': scenarioName,
      'description': description,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
