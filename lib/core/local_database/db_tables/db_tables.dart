import 'package:camerasync/core/app/app_context.dart';
import 'package:camerasync/core/local_database/table_models/offline_session_model.dart';


class DBTables {
  static const String tableOfflineSession = "TABLE_OFFLINE_SESSION";
  static const String tableSyncBatches = "TABLE_SYNC_BATCHES";

  static void registerAdapter() {
    AppContext.hiveService.registerAdapter(OfflineSessionAdapter(), 0);

  }
}