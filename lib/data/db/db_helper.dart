import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  //Future
  Future<Database> initDb() async { 
    // Lấy đường dẫn tới thư mục lưu trữ database
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'example.db'); //path là đường dẫn đến cơ sở dữ liệu SQLite mà ứng dụng sẽ sử dụng
    //path xác định vị trí lưu trữ của cơ sở dữ liệu trên thiết bị
    // Mở cơ sở dữ liệu và tạo bảng nếu nó chưa tồn tại
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          '''CREATE TABLE tasks(
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              content TEXT, 
              time TEXT, 
              status INTEGER
          )''',
          //create table tasks with trường id tự khóa chính , tự tăng , nội dung , time String , status 0 : 1
        );
      },
      version: 1, //Phiên bản
    );
  }
}