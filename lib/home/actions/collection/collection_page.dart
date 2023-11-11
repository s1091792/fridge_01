import 'package:flutter/material.dart';
import 'package:flutter_app_test/home/actions/collection/recipe/recipe_page.dart';
import 'package:flutter_app_test/mainpage/recipesearch/title_with_text.dart';
import '../../../colors.dart';
import 'getCollection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CollectionPage extends StatefulWidget {
  const CollectionPage({
    Key? key,
    required this.press,
  }) : super(key: key);
  final Function() press;

  @override
  State<CollectionPage> createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> _stream;
  final firestoreInstance = FirebaseFirestore.instance;

  var text;
  var imagepath;
  var step;
  var liked;

  @override
  void initState() {
    super.initState();
    print("Initializing stream...");
    _stream = FirebaseFirestore.instance.collection('recipes')
        .where('liked', isEqualTo: true).snapshots();
    print("Stream initialized!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Image.asset("assets/icons/back.png"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          '我的收藏',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          QuerySnapshot<Map<String, dynamic>> querySnapshot = snapshot.data!;
          List<DocumentSnapshot<Map<String, dynamic>>> documents = querySnapshot.docs;

          return SafeArea(
            child: ListView.builder(
              itemCount: documents.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {
                var title = documents[index]['recipe_name'];
                return ListTile(
                  title: Text(
                    '$title',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 30,
                    ),
                  ),
                  onTap: () {
                    print('$title');
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RecipePage(
                        title: '$title',
                        // title: title ?? '',
                        text: '${text[index]}',
                        imagepath: '${imagepath[index]}',
                        step: '${step[index]}',
                        liked: liked[index],
                      ),
                    ));
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
