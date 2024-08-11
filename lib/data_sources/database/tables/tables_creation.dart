import 'package:hotspot_chat/data_sources/database/tables/tables.dart';
import 'package:sqflite/sqflite.dart';

Future<void> createTables(Database db) async {
  ///Todo: mlo,user id,repetition,
  await db.execute('''
      CREATE TABLE ${Tables.users} (
      device_identifier TEXT PRIMARY KEY,
      name TEXT,
      ip TEXT
    )
        ''');
  await db.execute('''
      CREATE TABLE ${Tables.messages} (
      timestamp INTEGER PRIMARY KEY,
      content TEXT,
      chat_id TEXT,
      sender_id TEXT,
      receiver_id TEXT,
      FOREIGN KEY(sender_id) REFERENCES ${Tables.users}(device_identifier) ON DELETE CASCADE,
     FOREIGN KEY(receiver_id) REFERENCES ${Tables.users}(device_identifier) ON DELETE CASCADE,
     FOREIGN KEY(chat_id) REFERENCES ${Tables.chats}(id)
    )
        ''');
  await db.execute('''
      CREATE TABLE ${Tables.indirectMessages} (
      timestamp INTEGER PRIMARY KEY,
      content TEXT,
      chat_id TEXT,
      sender_id TEXT,
      receiver_id TEXT
    )
        ''');

  await db.execute('''
      CREATE TABLE ${Tables.chats} (
      id TEXT PRIMARY KEY,
      user_list TEXT
    )
        ''');
}
