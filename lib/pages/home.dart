import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hello_world/components/expense-summary.dart';
import 'package:hello_world/components/expense-tile.dart';
import 'package:hello_world/data/expense_data.dart';
import 'package:hello_world/models/expense_item.dart';
import 'package:hello_world/navbar/navbar.dart';
import 'package:uuid/uuid.dart'; 
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nPengeluaranController = TextEditingController();
  final jPengeluaranController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _editFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  void addPengeluaran() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text("Tambah Pengeluaran"),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nPengeluaranController,
                  decoration: InputDecoration(
                    hintText: 'Jenis Pengeluaran',
                    labelStyle: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Jenis Pengeluaran';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: jPengeluaranController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Jumlah Pengeluaran',
                    labelStyle: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Jumlah Pengeluaran';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Masukkan jumlah yang valid';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: batal,
            child: Text('Batal'),
          ),
          MaterialButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                tambah();
              }
            },
            child: Text('Tambah'),
          ),
        ],
      ),
    );
  }

  void tambah() {
    var uuid = Uuid();
    ExpenseItem pengeluaranBaru = ExpenseItem(
      id: uuid.v4(),
      nama: nPengeluaranController.text,
      jumlah: jPengeluaranController.text,
      tanggal: DateTime.now(),
    );
    Provider.of<ExpenseData>(context, listen: false).tambahPengeluaran(pengeluaranBaru);

    Navigator.pop(context);
    clear();
  }

  void editPengeluaran(ExpenseItem expense) {
    nPengeluaranController.text = expense.nama;
    jPengeluaranController.text = expense.jumlah;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text("Edit Pengeluaran"),
        content: SingleChildScrollView(
          child: Form(
            key: _editFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nPengeluaranController,
                  decoration: InputDecoration(
                    hintText: 'Jenis Pengeluaran',
                    labelStyle: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Jenis Pengeluaran';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: jPengeluaranController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Jumlah Pengeluaran',
                    labelStyle: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Masukkan Jumlah Pengeluaran';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Masukkan jumlah yang valid';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: batal,
            child: Text('Batal'),
          ),
          MaterialButton(
            onPressed: () {
              if (_editFormKey.currentState!.validate()) {
                var updatedExpense = ExpenseItem(
                  id: expense.id,
                  nama: nPengeluaranController.text,
                  jumlah: jPengeluaranController.text,
                  tanggal: expense.tanggal,
                );
                Provider.of<ExpenseData>(context, listen: false).updatePengeluaran(updatedExpense);
                Navigator.pop(context);
                clear();
              }
            },
            child: Text('Simpan'),
          ),
        ],
      ),
    );
  }

  void hapus(ExpenseItem expense) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text("Hapus Pengeluaran"),
        content: Text("Apakah Anda yakin ingin menghapus pengeluaran ini?"),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Batal'),
          ),
          MaterialButton(
            onPressed: () {
              Provider.of<ExpenseData>(context, listen: false).hapusPengeluaran(expense);
              Navigator.pop(context);
            },
            child: Text('Hapus'),
            splashColor: Colors.red,
          ),
        ],
      ),
    );
  }

  void batal() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    nPengeluaranController.clear();
    jPengeluaranController.clear();
  }

  @override
  Widget build(BuildContext context) {
    List<ExpenseItem> currentPageItems = Provider.of<ExpenseData>(context).getCurrentPageItems();

    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Center(
              child: Text(
                '${DateFormat('EEEE, MMMM d, y').format(DateTime.now())}',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        floatingActionButton: FloatingActionButton(
          onPressed: addPengeluaran,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          foregroundColor: Theme.of(context).colorScheme.background,
          child: Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ExpenseSummary(awalMinggu: value.awalMingguHari()),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "Histori Transaksi",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: currentPageItems.length,
                  itemBuilder: (context, index) {
                    ExpenseItem expense = currentPageItems[index];
                    return ExpenseTile(
                      nama: expense.nama,
                      jumlah: expense.jumlah,
                      tanggal: expense.tanggal,
                      deleteTapped: (p0) => hapus(expense),
                      editTapped: (p0) => editPengeluaran(expense),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (value.currentPage > 1) {
                        value.setCurrentPage(value.currentPage - 1);
                      }
                    },
                    child: Text('Previous', style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),),
                  ),
                  SizedBox(width: 15,),
                  ElevatedButton(
                    onPressed: () {
                      if ((value.currentPage * value.pageSize) < value.listPengeluaranKeseluruhan.length) {
                        value.setCurrentPage(value.currentPage + 1);
                      }
                    },
                    child: Text('Next', style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNav(selectedItem: 0),
      ),
    );
  }
}
