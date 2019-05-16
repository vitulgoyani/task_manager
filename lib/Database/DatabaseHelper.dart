import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_manager/Model/ListsModel.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("""CREATE TABLE List_Master(
                id INTEGER PRIMARY KEY,
                name TEXT,
                color TEXT,
                sound TEXT
                )""");
      await db.execute("""CREATE TABLE Task_Master(
              id INTEGER PRIMARY KEY,
              datetime TEXT,
              name TEXT,
              note TEXT,
              repeat_category TEXT,
              noti_status TEXT,
              noti_sound TEXT,
              noti_time TEXT,
              auto_complete TEXT,
              image TEXT,
              list_master_id INTEGER,
              FOREIGN KEY (list_master_id) REFERENCES List_Master(id) ON DELETE NO ACTION ON UPDATE NO ACTION
              )""");

      var table =
          await db.rawQuery("SELECT MAX(id)+1 as id FROM List_Master");
      int id = table.first["id"];
      //insert to the table using the new id
      await db.rawInsert(
          "INSERT Into List_Master (id,name,color,sound)"
          " VALUES (?,?,?,?)",
          [id, "Office", "0xffd50000","slow_spring_board"]);
      var table2 =
      await db.rawQuery("SELECT MAX(id)+1 as id FROM List_Master");
      int id2 = table2.first["id"];
      //insert to the table using the new id
      await db.rawInsert(
          "INSERT Into List_Master (id,name,color,sound)"
              " VALUES (?,?,?,?)",
          [id2, "Home", "0xffffea00","slow_spring_board"]);
    });
  }

  //get all Lists
  Future<List<ListMaster>> getAllLists() async {
    final db = await database;
    var res = await db.query("List_Master");
    List<ListMaster> list = res.isNotEmpty
        ? res.map((c) => ListMaster.fromMap(c)).toList()
        : [];
    return list;
  }



  //Insert List
  newList(ListMaster newList) async {
    final db = await database;
    //get the biggest id in the table
    var table =
        await db.rawQuery("SELECT MAX(id)+1 as id FROM List_Master");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into List_Master (id,name,color,sound)"
        " VALUES (?,?,?,?)",
        [id, newList.name, newList.color,newList.sound]);
    return raw;
  }

/*

  //Insert ExpenseCategory
  newExpenseCategory(ExpenseCategory newExpenseCategory) async {
    final db = await database;
    //get the biggest id in the table
    var table =
        await db.rawQuery("SELECT MAX(id)+1 as id FROM Expense_Category");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Expense_Category (id,name,amount)"
        " VALUES (?,?,?)",
        [id, newExpenseCategory.name, newExpenseCategory.amount]);
    return raw;
  }

  //Insert ResourseType
  newResourseType(ResourseType newResourseType) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Resource_Type");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Resource_Type (id,name,amount)"
        " VALUES (?,?,?)",
        [id, newResourseType.name, newResourseType.amount]);
    return raw;
  }

  //Insert Income Entry
  newEntry(Entry newEntry) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Entry");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Entry (id,date,amount,note,image,etype,income_category_id,expense_category_id,resource_type_id)"
        "VALUES (?,?,?,?,?,?,?,?,?)",
        [
          id,
          newEntry.date,
          newEntry.amount,
          newEntry.note,
          newEntry.image,
          newEntry.etype,
          newEntry.incomeCategoryId,
          newEntry.expenseCategoryId,
          newEntry.resourceTypeId
        ]);
    return raw;
  }*/

  /*//get all ExpenseCategory
  Future<List<ExpenseCategory>> getAllExpenseCategory() async {
    final db = await database;
    var res = await db.query("Expense_Category");
    List<ExpenseCategory> list = res.isNotEmpty
        ? res.map((c) => ExpenseCategory.fromMap(c)).toList()
        : [];
    return list;
  }

  //get all ExpenseCategory
  Future<List<ResourseType>> getAllResourseType() async {
    final db = await database;
    var res = await db.query("Resource_Type");
    List<ResourseType> list =
        res.isNotEmpty ? res.map((c) => ResourseType.fromMap(c)).toList() : [];
    return list;
  }

  //get all Entry
  Future<List<Entry>> getAllEntry() async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Entry ORDER BY date DESC");
    List<Entry> list =
        res.isNotEmpty ? res.map((c) => Entry.fromMap(c)).toList() : [];
    return list;
  }

  //get all Entry by income Category wise
  Future<List<Entry>> getAllEntryincategorywise(int id) async {
    final db = await database;
    var res = await db.rawQuery(
        "SELECT * FROM Entry WHERE etype=0 and income_category_id=$id ORDER BY date DESC");
    List<Entry> list =
        res.isNotEmpty ? res.map((c) => Entry.fromMap(c)).toList() : [];
    return list;
  }

  //get all Entry by expense Category wise
  Future<List<Entry>> getAllEntryexcategorywise(int id) async {
    final db = await database;
    var res = await db.rawQuery(
        "SELECT * FROM Entry WHERE etype=1 and expense_category_id=$id ORDER BY date DESC");
    List<Entry> list =
        res.isNotEmpty ? res.map((c) => Entry.fromMap(c)).toList() : [];
    return list;
  }

  //get all Entry by resource type wise
  Future<List<Entry>> getAllEntryresourcewise(int id) async {
    final db = await database;
    var res = await db.rawQuery(
        "SELECT * FROM Entry WHERE resource_type_id=$id ORDER BY date DESC");
    List<Entry> list =
        res.isNotEmpty ? res.map((c) => Entry.fromMap(c)).toList() : [];
    return list;
  }

  //get latest 10 entry
  Future<List<Entry>> getlatestEntry() async {
    final db = await database;
    var res =
        await db.rawQuery("SELECT * FROM Entry ORDER BY date DESC LIMIT 10");
    List<Entry> list =
        res.isNotEmpty ? res.map((c) => Entry.fromMap(c)).toList() : [];
    return list;
  }

  Future<String> getCurrency() async {
    final db = await database;
    var dbQuery = await db.rawQuery('SELECT * FROM Currency_Type');
    if (dbQuery.length > 0) {
      String currency = dbQuery.toString();
      return currency;
    } else {
      return 'ruppye';
    }
  }

  //Category Name
  Future<List<Categoryname>> getcategoryname(int id, int etype) async {
    String tablename;
    etype == 0 ? tablename = "Income_Category" : tablename = "Expense_Category";
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM $tablename WHERE id=$id");
    List<Categoryname> list =
        res.isNotEmpty ? res.map((c) => Categoryname.fromMap(c)).toList() : [];
    return list;
  }

  //Resourse Name
  Future<List<Resourcename>> getresourcename(int id) async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Resource_Type WHERE id=$id");
    List<Resourcename> list =
        res.isNotEmpty ? res.map((c) => Resourcename.fromMap(c)).toList() : [];
    return list;
  }

  //Total Income Amount
  Future<List<TotalIncome>> gettotalincome(String datatext) async {
    if (datatext == "Past Year") {
      String quary =
          "datetime('now','start of year','-1 year') and datetime('now','start of year','-1 day')";
      final db = await database;
      var res = await db.rawQuery(
          "SELECT SUM(amount) as amount FROM Entry WHERE etype=0 and date BETWEEN $quary");
      List<TotalIncome> list =
          res.isNotEmpty ? res.map((c) => TotalIncome.fromMap(c)).toList() : [];
      return list;
    } else if (datatext == "This Month") {
      String quary =
          "datetime('now','start of month') and datetime('now','start of month','+1 month','-1 day')";
      final db = await database;
      var res = await db.rawQuery(
          "SELECT SUM(amount) as amount FROM Entry WHERE etype=0 and date BETWEEN $quary");
      List<TotalIncome> list =
          res.isNotEmpty ? res.map((c) => TotalIncome.fromMap(c)).toList() : [];
      return list;
    } else if (datatext == "This Year") {
      String quary =
          "datetime('now','start of year') and datetime('now','start of year','+1 year','-1 day')";
      final db = await database;
      var res = await db.rawQuery(
          "SELECT SUM(amount) as amount FROM Entry WHERE etype=0 and date BETWEEN $quary");
      List<TotalIncome> list =
          res.isNotEmpty ? res.map((c) => TotalIncome.fromMap(c)).toList() : [];
      return list;
    }
  }

  //Total Expense Amount
  Future<List<TotalExpense>> gettotalexpense(String datatext) async {
    if (datatext == "Past Year") {
      String quary =
          "datetime('now','start of year','-1 year') and datetime('now','start of year','-1 day')";
      final db = await database;
      var res = await db.rawQuery(
          "SELECT SUM(amount) as amount FROM Entry WHERE etype=1 and date BETWEEN $quary");
      List<TotalExpense> list = res.isNotEmpty
          ? res.map((c) => TotalExpense.fromMap(c)).toList()
          : [];
      return list;
    } else if (datatext == "This Month") {
      String quary =
          "datetime('now','start of month') and datetime('now','start of month','+1 month','-1 day')";
      final db = await database;
      var res = await db.rawQuery(
          "SELECT SUM(amount) as amount FROM Entry WHERE etype=1 and date BETWEEN $quary");
      List<TotalExpense> list = res.isNotEmpty
          ? res.map((c) => TotalExpense.fromMap(c)).toList()
          : [];
      return list;
    } else if (datatext == "This Year") {
      String quary =
          "datetime('now','start of year') and datetime('now','start of year','+1 year','-1 day')";
      final db = await database;
      var res = await db.rawQuery(
          "SELECT SUM(amount) as amount FROM Entry WHERE etype=1 and date BETWEEN $quary");
      List<TotalExpense> list = res.isNotEmpty
          ? res.map((c) => TotalExpense.fromMap(c)).toList()
          : [];
      return list;
    }
  }

  *//* //Total Expense Amount
  Future<List<TotalExpense>> gettotalexpense(String datatext) async {
    final db = await database;
    var res = await db.rawQuery(
        "SELECT SUM(amount) as amount FROM Entry WHERE etype=1 and date BETWEEN datetime('now','start of month') and datetime('now','start of month','+1 month','-1 day')");
    List<TotalExpense> list =
    res.isNotEmpty ? res.map((c) => TotalExpense.fromMap(c)).toList() : [];
    return list;
  }*//*

  //Total Income Category Amount
  Future<List<TotalIncome>> gettotalincomecategory(int id) async {
    final db = await database;
    var res = await db.rawQuery(
        "SELECT SUM(amount) as amount FROM Entry WHERE etype=0 and income_category_id=$id");
    List<TotalIncome> list =
        res.isNotEmpty ? res.map((c) => TotalIncome.fromMap(c)).toList() : [];
    return list;
  }

  //Total Expense Category Amount
  Future<List<TotalExpense>> gettotalexpensecategory(int id) async {
    final db = await database;
    var res = await db.rawQuery(
        "SELECT SUM(amount) as amount FROM Entry WHERE etype=1 and expense_category_id=$id");
    List<TotalExpense> list =
        res.isNotEmpty ? res.map((c) => TotalExpense.fromMap(c)).toList() : [];
    return list;
  }

  //Total Resource Type Amount
  Future<List<TotalExpense>> gettotalresourcetypeex(int id) async {
    final db = await database;
    var res = await db.rawQuery(
        "SELECT SUM(amount) as amount FROM Entry WHERE etype=1 and resource_type_id=$id");
    List<TotalExpense> list =
        res.isNotEmpty ? res.map((c) => TotalExpense.fromMap(c)).toList() : [];
    return list;
  }

  //Total Income Category Amount
  Future<List<TotalIncome>> gettotalresourcetypein(int id) async {
    final db = await database;
    var res = await db.rawQuery(
        "SELECT SUM(amount) as amount FROM Entry WHERE etype=0 and resource_type_id=$id");
    List<TotalIncome> list =
        res.isNotEmpty ? res.map((c) => TotalIncome.fromMap(c)).toList() : [];
    return list;
  }

  //Update Income Category
  updateIncomeCategory(IncomeCategory newIncomeCategory) async {
    final db = await database;
    var res = await db.update("Income_Category", newIncomeCategory.toMap(),
        where: "id = ?", whereArgs: [newIncomeCategory.id]);
    return res;
  }

  //Update Expense Category
  updateExpenseCategory(ExpenseCategory newExpenseCategory) async {
    final db = await database;
    var res = await db.update("Expense_Category", newExpenseCategory.toMap(),
        where: "id = ?", whereArgs: [newExpenseCategory.id]);
    return res;
  }

  //Update Resource Type
  updateResourseType(ResourseType newResourseType) async {
    final db = await database;
    var res = await db.update("Resource_Type", newResourseType.toMap(),
        where: "id = ?", whereArgs: [newResourseType.id]);
    return res;
  }

  //Update Entry
  updateEntry(Entry newEntry) async {
    final db = await database;
    var res = await db.update("Entry", newEntry.toMap(),
        where: "id = ?", whereArgs: [newEntry.id]);
    return res;
  }

  //Update Currency
  updateCurrency(CurrencyType newCurrency) async {
    final db = await database;
    var res = await db.update("Currency_Type", newCurrency.toMap(),
        where: "id = ?", whereArgs: [newCurrency.id]);
    return res;
  }*/



/*blockOrUnblock(Client client) async {
    final db = await database;
    Client blocked = Client(
        id: client.id,
        firstName: client.firstName,
        lastName: client.lastName,
        blocked: !client.blocked);
    var res = await db.update("Client", blocked.toMap(),
        where: "id = ?", whereArgs: [client.id]);
    return res;
  }

  updateClient(Client newClient) async {
    final db = await database;
    var res = await db.update("Client", newClient.toMap(),
        where: "id = ?", whereArgs: [newClient.id]);
    return res;
  }

  getClient(int id) async {
    final db = await database;
    var res = await db.query("Client", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Client.fromMap(res.first) : null;
  }

  Future<List<Client>> getBlockedClients() async {
    final db = await database;

    print("works");
    // var res = await db.rawQuery("SELECT * FROM Client WHERE blocked=1");
    var res = await db.query("Client", where: "blocked = ? ", whereArgs: [1]);

    List<Client> list =
    res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Client>> getAllClients() async {
    final db = await database;
    var res = await db.query("Client");
    List<Client> list =
    res.isNotEmpty ? res.map((c) => Client.fromMap(c)).toList() : [];
    return list;
  }

  deleteClient(int id) async {
    final db = await database;
    return db.delete("Client", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Client");
  }*/
}
