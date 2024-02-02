import 'package:digital_order/data_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Data dataclass2 = Data(tSelect: 0, total: []);
  // int a = -1;
  // @override
  // initState() {
  //   a = dataclass2.tSelect;
  //   print(a);
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digital_Order',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  int counter = 0;
  int tSelect = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Text("${DataSpace.tSelect + 1}卓"),
        actions: const <Widget>[
          Icon(Icons.add),
          Icon(Icons.share),
        ],
      ),
      body: Row(
        children: [
          NavigationRail(
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.menu_book),
                label: Text('Menu'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.list), //history
                label: Text('History'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.price_check),
                label: Text('Check'),
              ),
            ],
            selectedIndex: _selectedIndex,

            //サイドバーの背景色
            backgroundColor: Colors.white,

            //浮いてるような表現、影がつく。0が標準
            elevation: 5,

            //選択されてるボタンにテキストがつく。動的
            labelType: NavigationRailLabelType.selected,

            // labelType: NavigationRailLabelType.all,
            // selectedIconTheme: const IconThemeData(color: Colors.green),
            // selectedLabelTextStyle: const TextStyle(color: Colors.purple),
            // unselectedIconTheme: IconThemeData(color: Colors.green[100]),
            // unselectedLabelTextStyle: TextStyle(color: Colors.red[100]),

            //選択されている項目を強調表示
            useIndicator: true,
            indicatorColor: Colors.grey[300],

            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          MainContents(index: _selectedIndex)
        ],
      ),
    );
  }
}

class MainContents extends StatefulWidget {
  const MainContents({super.key, required this.index});

  final int index;

  @override
  State<MainContents> createState() => _MainContentsState();
}

class _MainContentsState extends State<MainContents> {
  final formatter = NumberFormat("#,###");
  //コンストラクタ
  DataSpace dataSp = DataSpace();
  var _editText = '';
  var _alertText = '';

  @override
  Widget build(BuildContext context) {
    switch (widget.index) {
      // メニュー画面
      case 1:
        void confCheck() {
          Fluttertoast.showToast(
            msg: '追加しました',
            toastLength: Toast.LENGTH_LONG,
          );
        }

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                //ハンバーガーのメニュー
                for (int i = 0; i < dataSp.productName[0].length; i++)
                  ListTile(
                    leading: Icon(dataSp.iconData[0]),
                    title: Text(dataSp.productName[0][i]),
                    trailing: Text("${DataSpace.price[0][i].toString()}円"),
                    onTap: () {
                      confCheck();

                      int index = DataSpace.tSelect;

                      DataSpace.total[DataSpace.tSelect] +=
                          DataSpace.price[0][i];
                      dataSp.addProduct(index, i);
                      dataSp.addProductName(index, dataSp.productName[0][i]);
                    },
                  ),
                const Divider(
                  height: 10,
                  thickness: 1,
                  color: Colors.grey,
                ),

                //ドリンクメニュー
                for (int i = 0; i < dataSp.productName[1].length; i++)
                  ListTile(
                    leading: Icon(dataSp.iconData[1]),
                    title: Text(dataSp.productName[1][i]),
                    trailing: Text("${DataSpace.price[1][i].toString()}円"),
                    onTap: () {
                      confCheck();
                      // DateTime madeTime = dataSp.getDate();
                      int index = DataSpace.tSelect;
                      DataSpace.total[DataSpace.tSelect] +=
                          DataSpace.price[1][i];
                      dataSp.addProduct(index, i + 4);
                      dataSp.addProductName(index, dataSp.productName[1][i]);
                    },
                  ),

                const Divider(
                  height: 10,
                  thickness: 1,
                  color: Colors.grey,
                ),

                //サイドメニュー
                for (int i = 0; i < dataSp.productName[2].length; i++)
                  ListTile(
                    leading: Icon(dataSp.iconData[2]),
                    title: Text(dataSp.productName[2][i]),
                    trailing: Text("${DataSpace.price[2][i].toString()}円"),
                    onTap: () {
                      confCheck();
                      // DateTime madeTime = dataSp.getDate();
                      int index = DataSpace.tSelect;
                      DataSpace.total[DataSpace.tSelect] +=
                          DataSpace.price[2][i];
                      dataSp.addProduct(index, i + 7);
                      dataSp.addProductName(index, dataSp.productName[2][i]);
                      // print(index);
                      // print(i);
                      // print(dataSp.productName[0][i]);
                    },
                  ),
              ],
            ),
          ),
        );

      //注文履歴画面
      case 2:
        // dataSp.makeDisplayName();
        //削除POPUP
        void deleteProcess(int table, int index) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("アイテムの削除"),
                content: const Text("このアイテムを削除しますか?"),
                actions: [
                  TextButton(
                    child: const Text("Cancel"),
                    onPressed: () => Navigator.pop(context),
                  ),
                  TextButton(
                      child: const Text("OK"),
                      onPressed: () {
                        dataSp.delProduct(table, index);
                        Navigator.pop(context);
                      }),
                ],
              );
            },
          );
        }

        //注文履歴画面
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                for (int i = 0;
                    i < dataSp.orderHistory[DataSpace.tSelect].length;
                    i++)
                  // final j in dataSp.orderHistory[NextPageState().tSelect].length
                  ListTile(
                    leading: Icon(dataSp.iconData[dataSp.displayIcon(
                        dataSp.orderHistory[DataSpace.tSelect][i])]),
                    title: Text(dataSp.orderHistoryName[DataSpace.tSelect][i]),
                    trailing: const Icon(Icons.clear),
                    onTap: () {
                      int mNum = dataSp.orderHistory[DataSpace.tSelect][i];
                      DataSpace.total[i] =
                          DataSpace.price[dataSp.displayIcon(mNum)]
                              [dataSp.displayIcon2(mNum)];
                      int sIndex = DataSpace.tSelect;
                      deleteProcess(sIndex, dataSp.orderHistory[sIndex][i]);
                    },
                  ),
              ],
            ),
          ),
        );

      //   Check
      case 3:
        void checkProcess() {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("お会計"),
                content: const Text("注文をリセットします\nよろしいですか?"),
                actions: [
                  TextButton(
                    child: const Text("Cancel"),
                    onPressed: () => Navigator.pop(context),
                  ),
                  TextButton(
                      child: const Text("OK"),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ],
              );
            },
          );
        }
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                    "${DataSpace.tSelect + 1}番 ${DataSpace.cName[DataSpace.tSelect]} 様"),
                Text(
                    "会計：${formatter.format(dataSp.totalCalc(DataSpace.tSelect))}円"),
                OutlinedButton(
                  onPressed: () {
                    //ここに押したら反応するコードを書く
                    dataSp.resetDatabase();
                    checkProcess();
                  },
                  child: const Text(
                    "会計",
                    style: TextStyle(
                      color: Colors.purple,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );

      //   Home
      default:
        //テーブル名変更
        void changeProcess(int table) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("名前を変更"),
                content: TextField(
                  autofocus: true,
                  onChanged: (value) {
                    setState(() {
                      _editText = value;
                    });
                  },
                ),
                actions: [
                  TextButton(
                    child: const Text("Cancel"),
                    onPressed: () => Navigator.pop(context),
                  ),
                  TextButton(
                      child: const Text("OK"),
                      onPressed: () {
                        setState(() {
                          _alertText = _editText; //編集用を保存用に
                          DataSpace.cName[table] = _alertText;
                          // print(_alertText);
                          // print(DataSpace.cName[table]);
                        });
                        Navigator.pop(context);
                      }),
                ],
              );
            },
          );
        }

        return Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            children: [
              for (int i = 0; i < DataSpace.cName.length; i++)
                ListTile(
                  leading: const Icon(Icons.table_bar),
                  title: Text((i + 1).toString()),
                  subtitle: Text("${DataSpace.cName[i]} 様"),
                  onTap: () {
                    DataSpace.tSelect = i;
                  },
                  onLongPress: () {
                    changeProcess(i);
                  },
                ),
            ],
          ),
        ));
    }
  }
}
