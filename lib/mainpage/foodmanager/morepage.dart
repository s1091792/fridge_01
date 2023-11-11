//參考：https://www.youtube.com/watch?v=M0Gs1aJniv0
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../colors.dart';

class MorePage extends StatefulWidget {
  MorePage({Key? key, required this.title, required this.date, required this.number, required this.image, required this.press}) : super(key: key);

  final List<String> title, date;
  final List<int> number;
  final List<String> image;
  final Function() press;

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('food')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
              '全部食材',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: widget.title.length==0?SafeArea(
              child: Text(
                '目前沒有食材喔~~~',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 30,
                ),),
            ):SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, //兩條直的
                      crossAxisSpacing: 12.0,//直的空白
                      mainAxisSpacing: 12.0,//橫的
                      mainAxisExtent: 286,
                    ),
                    itemCount: widget.title.length,
                    itemBuilder: (_, index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            16.0,
                          ),
                          color: kHomeBackgroundColor,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16.0),
                                topRight: Radius.circular(16.0),
                              ),
                              child: Image.network(
                                widget.image[index],
                                height: 170,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${widget.title[index]}",
                                    style: Theme.of(context).textTheme.titleMedium!.merge(
                                          const TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${widget.date[index]}",
                                        style: Theme.of(context).textTheme.titleSmall!.merge(
                                              TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.grey.shade500,
                                              ),
                                            ),
                                      ),
                                      Spacer(),//放最右邊
                                      Text(
                                        "${widget.number[index]}",
                                        style: Theme.of(context).textTheme.titleSmall!.merge(
                                          TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          //編輯食材
                                        },
                                        icon: Icon(
                                          Icons.mode,
                                        ),
                                      ),
                                      Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          //刪除食材
                                        },
                                        icon: Icon(
                                          CupertinoIcons.trash,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
