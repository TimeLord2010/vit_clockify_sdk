/// Represents an hourly rate for billing or calculation purposes.
class HourlyRate {
  /// The hourly rate amount.
  final num amount;

  /// Creates a new [HourlyRate] instance.
  HourlyRate({required this.amount});

  /// Creates a [HourlyRate] instance from JSON data.
  ///
  /// Expects a map with an 'amount' key. If missing, defaults to 0.
  factory HourlyRate.fromJson(Map<String, dynamic> json) {
    return HourlyRate(amount: json['amount'] ?? 0);
  }

  /// Converts this [HourlyRate] to JSON format.
  Map<String, dynamic> toJson() => {'amount': amount};

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HourlyRate &&
          runtimeType == other.runtimeType &&
          amount == other.amount;

  @override
  int get hashCode => amount.hashCode;

  @override
  String toString() => 'HourlyRate(amount: $amount)';
}
