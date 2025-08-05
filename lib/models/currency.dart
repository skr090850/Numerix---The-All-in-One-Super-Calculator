// Yeh class currency conversion API se mile data ko represent karti hai.
class Currency {
  final String code; // e.g., "USD", "INR"
  final String name; // e.g., "United States Dollar"
  final double rate; // Base currency ke sapeksh rate

  Currency({
    required this.code,
    required this.name,
    required this.rate,
  });

  // API se mile JSON (Map) ko Currency object mein convert karne ke liye.
  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      code: json['code'],
      name: json['name'],
      rate: json['rate'].toDouble(),
    );
  }
}
