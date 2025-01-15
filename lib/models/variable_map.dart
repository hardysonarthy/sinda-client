class VariableMap {
  final bool isEnabled;
  final String? tableKey;
  final dynamic tableValue;
  final String? tableDescription;

  VariableMap(
      {this.tableValue,
      this.tableKey,
      this.tableDescription,
      this.isEnabled = true});
}
