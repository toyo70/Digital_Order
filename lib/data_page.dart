import 'package:flutter/material.dart';

class DataSpace {
  //商品名
  List<List<String>> productName = [
    ["ハンバーガー", "トマトバーガー", "チーズバーガー", "ダブルチーズバーガー"],
    ["コーラ", "オレンジ", "アップル"],
    ["ポテト", "オニオンリング", "ナゲット"],
  ];

  void makeDisplayName() {
    for (int i = 0; i < productName.length; i++) {
      for (final item in productName[i]) {
        displayName.add(item);
      }
    }
  }

  List<String> displayName = [];

  // List<int> displayNameIndex = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  List<IconData> iconData = [
    Icons.lunch_dining,
    Icons.local_drink,
    Icons.tapas
  ];

  //Iconのために種類ごとに分類
  int displayIcon(int index) {
    if (index - (productName[0].length - 1) <= 0) {
      return 0;
    } else if (index - (productName[0].length + productName[1].length - 1) <=
        0) {
      return 1;
    } else {
      return 2;
    }
  }

  //何バーガーか分類
  int displayIcon2(int index) {
    if (index - (productName[0].length - 1) <= 0) {
      return index;
    } else if (index - (productName[0].length + productName[1].length - 1) <=
        0) {
      return index - productName[0].length;
    } else {
      return index - (productName[0].length + productName[1].length);
    }
  }

  //tSelectが入力される、注文履歴を読みだして商品の合計を計算する
  int totalCalc(int table) {
    int total = 0;
    for (int i = 0; i < orderHistory[table].length; i++) {
      int num1 = orderHistory[table][i];
      total += price[displayIcon(num1)][displayIcon2(num1)];
    }
    return total;
  }

  //注文履歴
  List<List<int>> orderHistory = [[], [], [], [], [], [], [], []];
  //注文商品の名前保持
  List<List<String>> orderHistoryName = [[], [], [], [], [], [], [], []];

  DateTime getDate() {
    DateTime now = DateTime.now();
    return now;
  }

  //商品削除
  void delProduct(int table, int index) {
    orderHistory[table].remove(searchIndex(displayName[index]) - 1);
    orderHistoryName[table].remove(displayName[index]);
  }

  void resetDatabase() {
    orderHistory[tSelect].clear();
    orderHistoryName[tSelect].clear();
  }

  //index検索
  int searchIndex(String pName) {
    int num = 0;
    for (int i = 0; i < productName.length; i++)
      // ignore: curly_braces_in_flow_control_structures
      for (int j = 0; j < productName[i].length; j++) {
        num++;
        if (pName == productName[i][j]) {
          return num;
        }
      }
    return 0;
  }

  //商品追加
  void addProduct(int table, int index) {
    orderHistory[table].add(index);
  }

  void addProductName(int table, String name) {
    orderHistoryName[table].add(name);
  }

  //商品価格
  static List<List<int>> price = [
    [100, 150, 200, 250],
    [100, 100, 100],
    [1000, 1200, 1500],
  ];
  static int tSelect = 0;
  static List<int> total = [0, 0, 0, 0, 0, 0, 0, 0];
  static List<String> cName = [
    "スティーブ",
    "イーロン",
    "ティム",
    "マーク",
    "リサ",
    "ビル",
    "ジェフ",
    "ラリー"
  ];
}
