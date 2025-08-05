import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
// TODO: HistoryItem model ko import karna hai.
// import 'package:numerix/models/history_item.dart';

// Yeh class local SQLite database ko manage karti hai.
class DatabaseHelper {
  // Singleton pattern: Is class ka sirf ek hi instance banega.
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  // Database ka instance get karta hai. Agar nahi hai to banata hai.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  // Database ko initialize karta hai.
  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'numerix.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Jab database pehli baar banta hai, to table create karta hai.
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        expression TEXT NOT NULL,
        result TEXT NOT NULL,
        timestamp TEXT NOT NULL
      )
    ''');
  }

  // History mein naya item insert karta hai.
  Future<void> insertHistory(Map<String, dynamic> historyItem) async {
    final db = await database;
    await db.insert('history', historyItem, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Database se saari history get karta hai.
  Future<List<Map<String, dynamic>>> getHistory() async {
    final db = await database;
    // Sabse naye item ko sabse upar rakhne ke liye ORDER BY ka istemal.
    return await db.query('history', orderBy: 'id DESC');
  }

  // Poori history ko clear karta hai.
  Future<void> clearHistory() async {
    final db = await database;
    await db.delete('history');
  }
}
