// Yeh class calculation history ke ek single item ko represent karti hai.
class HistoryItem {
  final int? id; // Database mein id nullable ho sakti hai (auto-increment)
  final String expression;
  final String result;
  final DateTime timestamp;

  HistoryItem({
    this.id,
    required this.expression,
    required this.result,
    required this.timestamp,
  });

  // Database mein insert karne ke liye object ko Map mein convert karta hai.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'expression': expression,
      'result': result,
      'timestamp': timestamp.toIso8601String(), // DateTime ko string mein save karte hain
    };
  }

  // Database se mile Map ko HistoryItem object mein convert karta hai.
  factory HistoryItem.fromMap(Map<String, dynamic> map) {
    return HistoryItem(
      id: map['id'],
      expression: map['expression'],
      result: map['result'],
      timestamp: DateTime.parse(map['timestamp']), // String ko wapas DateTime mein convert karte hain
    );
  }
}
