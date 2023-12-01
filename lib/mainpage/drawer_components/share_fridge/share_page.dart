import 'package:flutter/material.dart';

import 'package:flutter_app_test/colors.dart';

class SharePage extends StatelessWidget {
  const SharePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      //backgroundColor: kHomeBackgroundColor,
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
          '共享冰箱',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 4,
              width: MediaQuery.of(context).size.width,
              child: const Center(
                  child: Text(
                "冰箱代碼：",
                style: TextStyle(fontSize: 20),
              )),
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: kDefaultPadding),
                child: const Text(
                  "共享成員",
                  style: TextStyle(fontSize: 20),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Row(
                children: [
                  const Icon(
                    Icons.account_circle_outlined,
                    size: 40,
                  ),
                  const Text(
                    "data",
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kHomeBackgroundColor,
                      foregroundColor: Colors.blueGrey,
                      textStyle: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    onPressed: () => {Navigator.pop(context)},
                    child: const Text("移除"),
                  ),
                ],
              ),
            ),
            Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: kDefaultPadding),
                child: const Text(
                  "共享要求",
                  style: TextStyle(fontSize: 20),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Row(
                children: [
                  const Icon(
                    Icons.account_circle_outlined,
                    size: 40,
                  ),
                  Text(
                    "data",
                    style: TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kHomeBackgroundColor,
                      foregroundColor: Colors.blueGrey,
                      textStyle: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    onPressed: () => {Navigator.pop(context)},
                    child: const Text("確認"),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kHomeBackgroundColor,
                      foregroundColor: Colors.blueGrey,
                      textStyle: const TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    onPressed: () => {Navigator.pop(context)},
                    child: Text("刪除"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
