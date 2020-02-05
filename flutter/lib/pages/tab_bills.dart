import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'learn_dropdown_button.dart';
import 'page_add.dart';
import 'page_search.dart';

class DetailsTable extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DetailsTableState();
}

class _DetailsTableState extends State<DetailsTable> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;/*PaginatedDataTable 一个带有分页的table*/

  int _sortColumnIndex;
  bool _sortAscending = true;
  /*数据源*/
  final DessertDataSource _dessertsDataSource = DessertDataSource();


  void _sort<T>(Comparable<T> getField(Dessert d), int columnIndex, bool ascending) {
    _dessertsDataSource._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  PaginatedDataTable getDataTable() {
    return PaginatedDataTable(

        header: const Text(''),
        rowsPerPage: _rowsPerPage,
        onRowsPerPageChanged: (int value) { setState(() { _rowsPerPage = value; }); },
        sortColumnIndex: _sortColumnIndex,/*当前主排序的列的index*/
        sortAscending: _sortAscending,
        onSelectAll: _dessertsDataSource._selectAll,
        columns: <DataColumn>[
          DataColumn(
              label: const Text('大类'),
              onSort: (int columnIndex, bool ascending) => _sort<String>((Dessert d) => d.name, columnIndex, ascending)
          ),
          DataColumn(
              label: const Text('小类'),
              tooltip: '小类.',
              numeric: false,
              onSort: (int columnIndex, bool ascending) => _sort<String>((Dessert d) => d.calories, columnIndex, ascending)
          ),
          DataColumn(
              label: const Text('货号'),
              numeric: false,
              onSort: (int columnIndex, bool ascending) => _sort<String>((Dessert d) => d.fat, columnIndex, ascending)
          ),
          DataColumn(
              label: const Text('数量'),
              numeric: true,
              onSort: (int columnIndex, bool ascending) => _sort<num>((Dessert d) => d.carbs, columnIndex, ascending)
          ),
          DataColumn(
              label: const Text('订单'),
              numeric: true,
              onSort: (int columnIndex, bool ascending) => _sort<num>((Dessert d) => d.tm, columnIndex, ascending)
          ),
          DataColumn(
              label: const Text('时间'),
              numeric: false,
              onSort: (int columnIndex, bool ascending) => _sort<String>((Dessert d) => d.bill, columnIndex, ascending)
          ),
        ],
        source: _dessertsDataSource
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text(''),
          actions: <Widget>[/*跟header 在一条线的antion*/
            IconButton(icon: Icon(Icons.refresh), onPressed: () {
              _dessertsDataSource.notifyListeners();
            }),
            IconButton(icon: Icon(Icons.add), onPressed: () {
              // _dessertsDataSource.addRow();
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new SecondePage(
                        title: '新建',
                      )
                  )
              );
              //LoadingDialog();
            }),
            IconButton(icon: Icon(Icons.delete), onPressed: () {
              _dessertsDataSource.removeSelected();
            }),
            IconButton(icon: Icon(Icons.edit), onPressed: () {
            }),
            IconButton(icon: Icon(Icons.search), onPressed: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new SearchPage(
                        title: '查询',
                      )
                  )
              );
            }),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(1.0),
          children: <Widget>[
            getDataTable(),
          ],
        ),
      );
  }
}


class Dessert {
  Dessert(this.name, this.calories, this.fat, this.carbs, this.tm, this.bill);
  final String name;
  final String calories;
  final String fat;
  final int carbs;
  final int tm;
  final String bill;

  bool selected = false;
}

class  DessertDataSource extends DataTableSource{
  /*数据源*/
  final List<Dessert> _desserts = <Dessert>[
    Dessert(
        'Frozen yogurt',
        'haha',
        'haha',
        24,
        0,
        'b1'),
    Dessert(
        'Ice cream sandwich',
        'haha',
        'haha',
        37,
        0,
        'c1'),
    Dessert(
        'Gingerbread',
        'haha',
        'haha',
        49,
        0,
        'd1')
  ];

/*ascending 上升 这里排序 没看懂比较的是个啥*/
  void _sort<T> (Comparable<T> getField(Dessert d),bool ascending){
    _desserts.sort((Dessert a, Dessert b) {
      if (!ascending) {
        final Dessert c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  int _selectedCount = 0;


  @override
  DataRow getRow(int index) {
    if (index >= _desserts.length)
      return null;
    final Dessert dessert = _desserts[index];
    return DataRow.byIndex(
        index: index,
        selected: dessert.selected,
        onSelectChanged: (bool value) {
          if (dessert.selected != value) {
            _selectedCount += value ? 1 : -1;
            assert(_selectedCount >= 0);
            dessert.selected = value;
            notifyListeners();
          }
        },
        cells: <DataCell>[
          DataCell(Text('${dessert.name}')),
          DataCell(Text('${dessert.calories}')),
          DataCell(Text('${dessert.fat}')),
          DataCell(Text('${dessert.carbs}')),
          DataCell(Text('${dessert.tm}')),
          DataCell(Text('${dessert.bill}')),
        ]);
  }

  // TODO: implement isRowCountApproximate
  @override
  bool get isRowCountApproximate => false;

  // TODO: implement rowCount
  @override
  int get rowCount => _desserts.length + 2;

  // TODO: implement selectedRowCount
  @override
  int get selectedRowCount => _selectedCount;

  void _selectAll(bool checked){
    for (Dessert dessert in _desserts)
      dessert.selected = checked;
    _selectedCount = checked ? _desserts.length : 0;
    notifyListeners();
  }

  void addRow() {
    _desserts.add(Dessert(
        'Coconut slice and KitKat',
        'haha',
        'haha',
        72,
        0,
        'a1')
    );
    notifyListeners();
  }

  void removeSelected() {
    _desserts.removeWhere((value) => value.selected == true);
    notifyListeners();

  }

}