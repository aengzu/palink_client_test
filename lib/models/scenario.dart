class Scenario {
  final int scenarioId;
  final int categoryId;
  final String scenarioName;
  final String scenarioDescription;
  final DateTime creationDate;

  Scenario({required this.scenarioId, required this.categoryId, required this.scenarioName, required this.scenarioDescription,  required this.creationDate});

  factory Scenario.fromJson(Map<String, dynamic> json) {
    return Scenario(
      scenarioId: json['scenario_id'],
      categoryId: json['category_id'],
      scenarioName: json['scenario_name'],
      scenarioDescription: json['scenario_description'],
      creationDate: json['creation_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'scenario_id' : scenarioId,
      'category_id' : categoryId,
      'scenario_name': scenarioName,
      'scenario_description': scenarioDescription,
      'creation_date' : creationDate
    };
  }
}
