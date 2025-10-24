import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<void> exportInventoryCSV(String csvData) async {
  try {
    // ... file writing logic remains the same ...
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/inventory_export.csv';
    final file = File(path);
    await file.writeAsString(csvData);

    print('CSV exported to $path');

    await Share.shareXFiles([XFile(path)], text: 'Inventory CSV Export');
  } catch (e) {
    print('Error exporting CSV: $e');
  }
}