import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/database_handler.dart';

/// Database access for the providers (can be overridden with a fake in tests)
final databaseHandlerProvider =
    Provider<DatabaseHandler>((ref) => DatabaseHandler());
