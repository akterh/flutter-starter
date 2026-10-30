// hive_database_service.dart
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
@injectable
class HiveDatabaseService {
  // Store opened boxes in memory
  final Map<String, Box> _boxes = {};


  // Store registered type IDs to prevent duplicate registration
  final Set<int> _registeredTypeIds = {};

  // Initialize Hive (call once in main)
  Future<void> init() async {
    await Hive.initFlutter();
  }

  // Register TypeAdapter for a model
  void registerAdapter<T>(TypeAdapter<T> adapter, int typeId) {
    if (!_registeredTypeIds.contains(typeId) && !Hive.isAdapterRegistered(typeId)) {
      Hive.registerAdapter(adapter);
      _registeredTypeIds.add(typeId);
    }
  }

  // Get or open a typed box
  Future<Box<T>> getTypedBox<T>(String userId, String tableName) async {
    final boxName = '${userId}_$tableName';

    if (_boxes.containsKey(boxName) && _boxes[boxName]!.isOpen) {
      return _boxes[boxName]! as Box<T>;
    }

    final box = await Hive.openBox<T>(boxName);
    _boxes[boxName] = box;
    return box;
  }

  // ==================== CREATE Operations ====================

  // Add single item with custom key
  Future<void> add<T>({required String userId, required String tableName, required String key, required T item}) async {
    final box = await getTypedBox<T>(userId, tableName);
    await box.put(key, item);
  }

  // Add single item with auto-generated key
  Future<int> addAuto<T>(String userId, String tableName, T item) async {
    final box = await getTypedBox<T>(userId, tableName);
    return await box.add(item);
  }

  // Add multiple items
  Future<void> addAll<T>(String userId, String tableName, Map<String, T> items) async {
    final box = await getTypedBox<T>(userId, tableName);

    await box.putAll(items);
  }

  // ==================== READ Operations ====================

  // Get single item by key
  Future<T?> get<T>(String userId, String tableName, String key) async {
    final box = await getTypedBox<T>(userId, tableName);
    return box.get(key);
  }

  // Get item with default value
  Future<T> getWithDefault<T>(String userId, String tableName, String key, T defaultValue) async {
    final box = await getTypedBox<T>(userId, tableName);
    return box.get(key, defaultValue: defaultValue) ?? defaultValue;
  }

  // Get all items as List
  Future<List<T>> getAll<T>(String userId, String tableName) async {
    final box = await getTypedBox<T>(userId, tableName);
    return box.values.toList();
  }

  // Get all items as Map
  Future<Map<String, T>> getAllAsMap<T>(String userId, String tableName) async {
    final box = await getTypedBox<T>(userId, tableName);
    return box.toMap().cast<String, T>();
  }

  // Get item at index
  Future<T?> getAt<T>(String userId, String tableName, int index) async {
    final box = await getTypedBox<T>(userId, tableName);
    return box.getAt(index);
  }

  // Get all keys
  Future<List<String>> getKeys<T>(String userId, String tableName) async {
    final box = await getTypedBox<T>(userId, tableName);
    return box.keys.cast<String>().toList();
  }

  // Get filtered items
  Future<List<T>> getWhere<T>(
      String userId,
      String tableName,
      bool Function(T item) test,
      ) async {
    final box = await getTypedBox<T>(userId, tableName);
    return box.values.where(test).toList();
  }

  // ==================== UPDATE Operations ====================

  // Update single item
  Future<void> update<T>(String userId, String tableName, String key, T item) async {
    final box = await getTypedBox<T>(userId, tableName);
    if (box.containsKey(key)) {
      await box.put(key, item);
    } else {
      throw Exception('Key "$key" does not exist in table "$tableName"');
    }
  }

  // Update item at index
  Future<void> updateAt<T>(String userId, String tableName, int index, T item) async {
    final box = await getTypedBox<T>(userId, tableName);
    await box.putAt(index, item);
  }

  // Update multiple items
  Future<void> updateAll<T>(String userId, String tableName, Map<String, T> items) async {
    final box = await getTypedBox<T>(userId, tableName);
    await box.putAll(items);
  }

  // ==================== DELETE Operations ====================

  // Delete single item
  Future<void> delete<T>(String userId, String tableName, String key) async {
    final box = await getTypedBox<T>(userId, tableName);
    await box.delete(key);
  }

  // Delete item at index
  Future<void> deleteAt<T>(String userId, String tableName, int index) async {
    final box = await getTypedBox<T>(userId, tableName);
    await box.deleteAt(index);
  }

  // Delete multiple items
  Future<void> deleteMultiple<T>(String userId, String tableName, List<String> keys) async {
    final box = await getTypedBox<T>(userId, tableName);
    await box.deleteAll(keys);
  }

  // Delete items matching condition
  Future<void> deleteWhere<T>(
      String userId,
      String tableName,
      bool Function(T item) test,
      ) async {
    final box = await getTypedBox<T>(userId, tableName);
    final keysToDelete = <dynamic>[];
    for (var entry in box.toMap().entries) {
      if (test(entry.value)) {
        keysToDelete.add(entry.key);
      }
    }
    await box.deleteAll(keysToDelete);
  }

  // Clear all items in table
  Future<void> clear<T>(String userId, String tableName) async {
    final box = await getTypedBox<T>(userId, tableName);
    await box.clear();
  }

  // Delete entire table (box)
  Future<void> deleteTable(String userId, String tableName) async {
    final boxName = '${userId}_$tableName';
    if (_boxes.containsKey(boxName)) {
      await _boxes[boxName]!.close();
      _boxes.remove(boxName);
    }
    await Hive.deleteBoxFromDisk(boxName);
  }

  // Delete all tables for a user
  Future<void> deleteAllUserTables(String userId) async {
    final userBoxes = _boxes.keys.where((key) => key.startsWith(userId)).toList();
    for (final boxName in userBoxes) {
      await _boxes[boxName]!.close();
      _boxes.remove(boxName);
      await Hive.deleteBoxFromDisk(boxName);
    }
  }

  // ==================== UTILITY Operations ====================

  // Check if key exists
  Future<bool> contains<T>(String userId, String tableName, String key) async {
    final box = await getTypedBox<T>(userId, tableName);
    return box.containsKey(key);
  }

  // Get table length
  Future<int> length<T>(String userId, String tableName) async {
    final box = await getTypedBox<T>(userId, tableName);
    return box.length;
  }


  // Check if table is empty
  Future<bool> isEmpty<T>(String userId, String tableName) async {
    final box = await getTypedBox<T>(userId, tableName);
    return box.isEmpty;
  }


  // Watch for changes in table
  Stream<BoxEvent> watch<T>(String userId, String tableName, {String? key}) async* {
    final box = await getTypedBox<T>(userId, tableName);
    if (key != null) {
      yield* box.watch(key: key);
    } else {
      yield* box.watch();
    }
  }


  // Compact table (optimize storage)
  Future<void> compact<T>(String userId, String tableName) async {
    final box = await getTypedBox<T>(userId, tableName);
    await box.compact();
  }

  // Close specific table
  Future<void> closeTable(String userId, String tableName) async {
    final boxName = '${userId}_$tableName';
    if (_boxes.containsKey(boxName)) {
      await _boxes[boxName]!.close();
      _boxes.remove(boxName);
    }
  }

  // Close all tables
  Future<void> closeAll() async {
    for (final box in _boxes.values) {
      if (box.isOpen) {
        await box.close();
      }
    }
    _boxes.clear();
  }

  // Get all table names for a user
  List<String> getUserTables(String userId) {
    return _boxes.keys.where((key) => key.startsWith(userId)).map((key) => key.replaceFirst('${userId}_', '')).toList();
  }
}