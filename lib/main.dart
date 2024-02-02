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
                //ハンバーガーメニュー

                for (int i = 0; i < dataSp.productName[0].length; i++)
                  ListTile(
                    leading: Icon(dataSp.iconData[0]),
                    title: Text("${dataSp.productName[0][i]}"),
                    trailing: Text("${DataSpace.price[0][i].toString()}円"),
                    onTap: () {
                      confCheck();
                      // DateTime madeTime = dataSp.getDate();
                      int index = DataSpace.tSelect;

                      DataSpace.total[DataSpace.tSelect] +=
                          DataSpace.price[0][i];
                      dataSp.addProduct(index, i);
                      dataSp.addProductName(index, dataSp.productName[0][i]);
                      // print(index);
                      // print(i);
                      // print(dataSp.productName[0][i]);
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
        dataSp.makeDisplayName();
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
                      // print(
                      // "${DataSpace.price[dataSp.displayIcon(mNum)][dataSp.displayIcon2(mNum)]}");
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
                content: const Text("お会計でよろしいですか?"),
                actions: [
                  TextButton(
                    child: const Text("Cancel"),
                    onPressed: () => Navigator.pop(context),
                  ),
                  TextButton(
                      child: const Text("OK"),
                      onPressed: () {
                        // dataSp.delProduct(table, index);
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
            // color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                    "${DataSpace.tSelect + 1}番 ${dataSp.cName[DataSpace.tSelect]} 様"),
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
        return Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 4,
            mainAxisSpacing: 4,
            children: [
              ListTile(
                leading: const Icon(Icons.table_bar),
                title: const Text("1"),
                subtitle: Text("${dataSp.cName[0]} 様"),
                onTap: () {
                  DataSpace.tSelect = 0;
                },
              ),
              ListTile(
                leading: const Icon(Icons.table_bar),
                title: const Text("2"),
                subtitle: Text("${dataSp.cName[1]} 様"),
                onTap: () {
                  DataSpace.tSelect = 1;
                },
              ),
              ListTile(
                leading: const Icon(Icons.table_bar),
                title: const Text("3"),
                subtitle: Text("${dataSp.cName[2]} 様"),
                onTap: () {
                  DataSpace.tSelect = 2;
                },
              ),
              ListTile(
                leading: const Icon(Icons.table_bar),
                title: const Text("4"),
                subtitle: Text("${dataSp.cName[3]} 様"),
                onTap: () {
                  DataSpace.tSelect = 3;
                },
              ),
              ListTile(
                leading: const Icon(Icons.table_bar),
                title: const Text("5"),
                subtitle: Text("${dataSp.cName[4]} 様"),
                onTap: () {
                  DataSpace.tSelect = 4;
                },
              ),
              ListTile(
                leading: const Icon(Icons.table_bar),
                title: const Text("6"),
                subtitle: Text("${dataSp.cName[5]} 様"),
                onTap: () {
                  DataSpace.tSelect = 5;
                },
              ),
              ListTile(
                leading: const Icon(Icons.table_bar),
                title: const Text("7"),
                subtitle: Text("${dataSp.cName[6]} 様"),
                onTap: () {
                  DataSpace.tSelect = 6;
                },
              ),
              ListTile(
                leading: const Icon(Icons.table_bar),
                title: const Text("8"),
                subtitle: Text("${dataSp.cName[7]} 様"),
                onTap: () {
                  DataSpace.tSelect = 7;
                },
              ),
            ],
          ),
        ));
    }
  }
}

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
