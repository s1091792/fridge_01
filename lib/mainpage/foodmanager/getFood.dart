import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:intl/intl.dart';

import 'main_foods_pic.dart';


List<Map<String, dynamic>> commentsData0 = []; //過期的
List<Map<String, dynamic>> commentsData7 = []; // 7日內到期的 List
List<Map<String, dynamic>> commentsData15 = []; // 15天內到期的list
List<Map<String, dynamic>> commentsData30 = []; // 一個月後到期的list
List<Map<String, dynamic>> commentsData31 = []; // 其他食材的 List


//過期的
StreamBuilder<QuerySnapshot> getFood0() {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('food')
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (!snapshot.hasData)
        return Center(
          child: CircularProgressIndicator(),
        );else{
        final int commentCount0 = snapshot.data!.docs.length;

        // 獲取當前時間
        DateTime currentDate = DateTime.now();
        DateTime oneDaysLater = currentDate.add(Duration(days: -1));

        // 將留言資料保存到 commentsData 中
        commentsData0 = snapshot.data!.docs.map((document) {

          // DateTime foodDate = DateTime.parse(document['date']);
          Timestamp timestamp = document['EXP'] as Timestamp;
          DateTime expDate = timestamp.toDate();

          if (expDate.isBefore(oneDaysLater) == true){
            // print("有抓到");
            String formattedDate = DateFormat('yyyy-MM-dd').format(expDate);
            return {
              'title': document['food_name'] as String,
              'date':  formattedDate,
              'number': document['amount'] as int,
              'image': document['image'] as String,
            };
          } else {
            print("沒有抓到7日內到期");
            return null;
          }
          // };


        }).whereType<Map<String, dynamic>>().toList();
        print(commentsData0);

        if (commentCount0 > 0) {
          // 這裡不再回傳 Widget，只回傳一個空的 Container
          return seven_food_pic(
            title: commentsData0.map((comment) => comment['title'] as String).toList(),
            date: commentsData0.map((comment) => comment['date'] as String).toList(),
            number: commentsData0.map((comment) => comment['number'] as int).toList(),
            press: () {},
            image: commentsData0.map((comment) => comment['image'] as String).toList(),
          );
        } else {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            alignment: Alignment.center,
            child: Text(
              'no food...',
              style: TextStyle(fontSize: 20),
            ),
          );
        }
      }
    },
  );
}


//7日內到期 0-7天
StreamBuilder<QuerySnapshot> getFood7() {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('food')
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (!snapshot.hasData)
        return Center(
          child: CircularProgressIndicator(),
        );else{
        final int commentCount7 = snapshot.data!.docs.length;

        // 獲取當前時間
        DateTime currentDate = DateTime.now();
        // 計算七天後的日期
        DateTime oneDaysLater = currentDate.add(Duration(days: -1));
        DateTime sevenDaysLater = currentDate.add(Duration(days: 7));
        print('七天後的日期：$sevenDaysLater');


        // 將留言資料保存到 commentsData 中
        commentsData7 = snapshot.data!.docs.map((document) {

          // DateTime foodDate = DateTime.parse(document['date']);
          Timestamp timestamp = document['EXP'] as Timestamp;
          DateTime expDate = timestamp.toDate();

          if (expDate.isAfter(oneDaysLater) == true && expDate.isBefore(sevenDaysLater) == true){
            // print("有抓到");
            String formattedDate = DateFormat('yyyy-MM-dd').format(expDate);
            return {
              'title': document['food_name'] as String,
              'date':  formattedDate,
              'number': document['amount'] as int,
              'image': document['image'] as String,
            };
          } else {
            print("沒有抓到7日內到期");
            return null;
          }
          // };


        }).whereType<Map<String, dynamic>>().toList();
        print(commentsData7);

        if (commentCount7 > 0) {
          // 這裡不再回傳 Widget，只回傳一個空的 Container
          return seven_food_pic(
            title: commentsData7.map((comment) => comment['title'] as String).toList(),
            date: commentsData7.map((comment) => comment['date'] as String).toList(),
            number: commentsData7.map((comment) => comment['number'] as int).toList(),
            press: () {},
            image: commentsData7.map((comment) => comment['image'] as String).toList(),
          );
        } else {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            alignment: Alignment.center,
            child: Text(
              'no food...',
              style: TextStyle(fontSize: 20),
            ),
          );
        }
      }
    },
  );
}

//15日內到期 8-15天
StreamBuilder<QuerySnapshot> getFood15() {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('food')
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (!snapshot.hasData)
        return Center(
          child: CircularProgressIndicator(),
        );
      final int commentCount15 = snapshot.data!.docs.length;

      // 獲取當前時間
      DateTime currentDate = DateTime.now();
      // 計算七天後的日期
      DateTime eightDaysLater = currentDate.add(Duration(days: 7));
      DateTime fifteenDaysLater = currentDate.add(Duration(days: 15));
      print('8天後的日期：$eightDaysLater，15天後：$fifteenDaysLater');


      // 將留言資料保存到 commentsData 中
      commentsData15 = snapshot.data!.docs.map((document) {

        // DateTime foodDate = DateTime.parse(document['date']);
        Timestamp timestamp = document['EXP'] as Timestamp;
        DateTime expDate = timestamp.toDate();


        // for (var comment in commentsData7){
        //   bool isInSevenDays = expDate.isBefore(sevenDaysLater);
        if (expDate.isAfter(eightDaysLater) == true && expDate.isBefore(fifteenDaysLater) == true){
          // print("有抓到");
          String formattedDate = DateFormat('yyyy-MM-dd').format(expDate);
          return {
            'title': document['food_name'] as String,
            // 'date': document['EXP'] as String,
            'date':  formattedDate,
            'number': document['amount'] as int,
            'image': document['image'] as String,
          };
        } else {
          print("沒有抓到15日內到期");
          return null;
        }
        // };


      }).whereType<Map<String, dynamic>>().toList();
      print(commentsData15);

      if (commentCount15 > 0) {
        // 這裡不再回傳 Widget，只回傳一個空的 Container
        return seven_food_pic(
          title: commentsData15.map((comment) => comment['title'] as String).toList(),
          date: commentsData15.map((comment) => comment['date'] as String).toList(),
          number: commentsData15.map((comment) => comment['number'] as int).toList(),
          press: () {},
          image: commentsData15.map((comment) => comment['image'] as String).toList(),
        );
      } else {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          alignment: Alignment.center,
          child: Text(
            'no food...',
            style: TextStyle(fontSize: 20),
          ),
        );
      }
    },
  );
}

//30日內到期 16-30天
StreamBuilder<QuerySnapshot> getFood30() {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('food')
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (!snapshot.hasData)
        return Center(
          child: CircularProgressIndicator(),
        );
      final int commentCount30 = snapshot.data!.docs.length;

      // 獲取當前時間
      DateTime currentDate = DateTime.now();
      // 計算七天後的日期
      DateTime sixteenDaysLater = currentDate.add(Duration(days: 15));
      DateTime thirtyDaysLater = currentDate.add(Duration(days: 30));
      print('16天後的日期：$sixteenDaysLater，30天後：$thirtyDaysLater');


      // 將留言資料保存到 commentsData 中
      commentsData30 = snapshot.data!.docs.map((document) {

        // DateTime foodDate = DateTime.parse(document['date']);
        Timestamp timestamp = document['EXP'] as Timestamp;
        DateTime expDate = timestamp.toDate();


        // for (var comment in commentsData7){
        //   bool isInSevenDays = expDate.isBefore(sevenDaysLater);
        if (expDate.isAfter(sixteenDaysLater) == true && expDate.isBefore(thirtyDaysLater) == true){
          // print("有抓到");
          String formattedDate = DateFormat('yyyy-MM-dd').format(expDate);
          return {
            'title': document['food_name'] as String,
            // 'date': document['EXP'] as String,
            'date':  formattedDate,
            'number': document['amount'] as int,
            'image': document['image'] as String,
          };
        } else {
          print("沒有抓到30日內到期");
          return null;
        }
        // };


      }).whereType<Map<String, dynamic>>().toList();
      print(commentsData30);

      if (commentCount30 > 0) {
        // 這裡不再回傳 Widget，只回傳一個空的 Container
        return seven_food_pic(
          title: commentsData30.map((comment) => comment['title'] as String).toList(),
          date: commentsData30.map((comment) => comment['date'] as String).toList(),
          number: commentsData30.map((comment) => comment['number'] as int).toList(),
          press: () {},
          image: commentsData30.map((comment) => comment['image'] as String).toList(),
        );
      } else {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          alignment: Alignment.center,
          child: Text(
            'no food...',
            style: TextStyle(fontSize: 20),
          ),
        );
      }
    },
  );
}

//其餘食材 31-
StreamBuilder<QuerySnapshot> getFood31() {
  return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('food')
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (!snapshot.hasData)
        return Center(
          child: CircularProgressIndicator(),
        );
      final int commentCount31 = snapshot.data!.docs.length;

      // 獲取當前時間
      DateTime currentDate = DateTime.now();
      // 計算後的日期
      DateTime thirtyoneDaysLater = currentDate.add(Duration(days: 30));
      print('31天後：$thirtyoneDaysLater');


      // 將留言資料保存到 commentsData 中
      commentsData31 = snapshot.data!.docs.map((document) {

        // DateTime foodDate = DateTime.parse(document['date']);
        Timestamp timestamp = document['EXP'] as Timestamp;
        DateTime expDate = timestamp.toDate();


        // for (var comment in commentsData7){
        //   bool isInSevenDays = expDate.isBefore(sevenDaysLater);
        if (expDate.isAfter(thirtyoneDaysLater) == true){
          // print("有抓到");
          String formattedDate = DateFormat('yyyy-MM-dd').format(expDate);
          return {
            'title': document['food_name'] as String,
            // 'date': document['EXP'] as String,
            'date':  formattedDate,
            'number': document['amount'] as int,
            'image': document['image'] as String,
          };
        } else {
          print("沒有抓到其餘食材到期");
          return null;
        }
        // };


      }).whereType<Map<String, dynamic>>().toList();
      print(commentsData31);

      if (commentCount31 > 0) {
        // 這裡不再回傳 Widget，只回傳一個空的 Container
        return seven_food_pic(
          title: commentsData31.map((comment) => comment['title'] as String).toList(),
          date: commentsData31.map((comment) => comment['date'] as String).toList(),
          number: commentsData31.map((comment) => comment['number'] as int).toList(),
          press: () {},
          image: commentsData31.map((comment) => comment['image'] as String).toList(),
        );
      } else {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          alignment: Alignment.center,
          child: Text(
            'no food...',
            style: TextStyle(fontSize: 20),
          ),
        );
      }
    },
  );
}


