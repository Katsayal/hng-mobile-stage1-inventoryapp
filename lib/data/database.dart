import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Products extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get quantity => integer()();
  RealColumn get price => real()();
  TextColumn get category => text().withDefault(Constant('General'))();
  TextColumn get imagePath => text().nullable()();
}

@DriftDatabase(tables: [Products])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          // Create all tables from scratch
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            // Version 2 adds 'category' column
            await m.addColumn(products, products.category);
          }
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'inventory.sqlite'));
    return NativeDatabase(file);
  });
}
