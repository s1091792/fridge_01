import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_test/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_vision/google_vision.dart' as go;
import 'package:flutter/src/widgets/image.dart' as Im;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';
import 'dart:convert';

//翻譯

import 'package:http/http.dart' as http;

FirebaseFirestore firestore = FirebaseFirestore.instance;

class NewFood extends StatefulWidget {
  const NewFood({Key? key}) : super(key: key);

  @override
  State<NewFood> createState() => _NewFoodState();
}

class _NewFoodState extends State<NewFood> {
  //確認按一次後不給按
  bool isEnabled = true;
  //名字篩選

  //翻譯
  List<String> name = [];

  //圖片標籤
  XFile? imageFile;
  String _image = '';

  //控制數量
  final controller = TextEditingController();
  int count=1;

  String imageUrl = '';
  String path = '';
  List<int> imageData = [];
  List<int> imageBytes = [];

  void incrementCounter() {
    setState(() {
      count++;
    });
  }

  void decrementCounter() {
    setState(() {
      if (count > 1) {
        count--;
      }
    });
  }

  //date
  DateTime _dateTime = DateTime.now();
  String date = '';

  @override
  void inidState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
    print('新增食材的dispose方法');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false, //不讓畫面因為鍵盤超出頁面
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Im.Image.asset("assets/icons/back.png"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            '新增食材',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
        //主要新增的地方
        body: Form(
          autovalidateMode: AutovalidateMode.always,
          child: Center(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _image == ''
                      ? imageFile == null
                          ? Container(
                              width: 200,
                              height: 200,
                              color: Colors.grey[300]!,
                            )
                          : Im.Image.file(
                              File(imageFile!.path),
                              height: 200,
                              width: 200,
                            )
                      : Im.Image.file(
                          File(_image),
                          height: 200,
                          width: 200,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: Colors.grey,
                            width: 200,
                            height: 200,
                            child: const Center(
                              child: Text('Error load image',
                                  textAlign: TextAlign.center),
                            ),
                          ),
                        ),
                  //相簿或相機
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kHomeBackgroundColor,
                              foregroundColor: Colors.blueGrey,
                              shadowColor: Colors.grey[400],
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                            ),
                            onPressed: () {
                              getImage(ImageSource.gallery);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              child: const Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.image,
                                    size: 30,
                                    color: Colors.blueGrey,
                                  ),
                                  Text(
                                    "Gallery",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          )),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kHomeBackgroundColor,
                              foregroundColor: Colors.blueGrey,
                              shadowColor: Colors.grey[400],
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0)),
                            ),
                            onPressed: () {
                              getImage(ImageSource.camera);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 5),
                              child: const Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    size: 30,
                                    color: Colors.blueGrey,
                                  ),
                                  Text(
                                    "Camera",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          )),
                    ],
                  ),

                  //名字
                  Container(
                    alignment: Alignment.center,
                    //外部間距
                    //margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    //外部間距
                    //padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    width: size.width,
                    color: Colors.grey[100],
                    child: TextFormField(
                      controller: controller,
                      validator: (v) {
                        return v!.trim().isNotEmpty ? null : "名稱不能為空";
                      },
                      decoration: InputDecoration(
                        labelText: "名稱：",
                        labelStyle: TextStyle(
                          color: kPrimaryColor.withOpacity(0.5),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                            width: 2,
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.cyan,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),

                  //數量
                  Container(
                    alignment: Alignment.center,
                    //外部間距
                    //margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    //外部間距
                    padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kHomeBackgroundColor,
                            foregroundColor: Colors.blueGrey,
                            textStyle: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () => {
                            decrementCounter(),
                          },
                          child: Text("-"),
                        ),
                        Container(
                          width: 150,
                          color: Colors.white,
                          child: Text(
                            "$count",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kHomeBackgroundColor,
                            foregroundColor: Colors.blueGrey,
                            textStyle: TextStyle(fontSize: 30.0),
                          ),
                          onPressed: () => {
                            incrementCounter(),
                          },
                          child: const Text("+"),
                        ),
                      ],
                    ),
                  ),

                  //時間
                  Container(
                    width: size.width,
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width - 120,
                          child: Text(
                            "${_dateTime.year}/${_dateTime.month}/${_dateTime.day}",
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kHomeBackgroundColor,
                            foregroundColor: Colors.blueGrey,
                          ),
                          onPressed: () => {_showDatePiker()},
                          child: const Icon(
                            Icons.calendar_month_outlined,
                            size: 30,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kHomeBackgroundColor,
                          foregroundColor: Colors.blueGrey,
                          textStyle: TextStyle(
                            fontSize: 30.0,
                          ),
                        ),
                        onPressed: () => {Navigator.pop(context)},
                        child: Text("取消"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kHomeBackgroundColor,
                          foregroundColor: Colors.blueGrey,
                          disabledBackgroundColor: Colors.grey,
                          disabledForegroundColor: Colors.black54,
                          textStyle: TextStyle(fontSize: 30.0),
                        ),
                        onPressed: isEnabled
                            ? () async {
                                //新增進資料庫(各個變數名)：照片路徑是imagefile!.path,食材名稱->controller.text,到期日->date,數量->count
                                // uploadImageToImgur();
                                if (controller.text != "" ) {
                                  setState(() {
                                    isEnabled = false;
                                  });
                                  await createNewfoodDocument();
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                    content: Text("新增成功"),
                                    duration: Duration(seconds: 1),
                                  ));
                                  //回前一頁
                                  Navigator.pop(context);
                                  controller.clear();
                                }
                              }
                            : null,
                        child: Text("確認"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void getImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage != null) {
        imageFile = pickedImage;
        setState(() {});
        await saveVisionImageDataLocally(pickedImage);
        getvisionai(pickedImage);
      }
    } catch (e) {
      imageFile = null;
      //imageLabel = "Error occurred while getting image Label";
      print(e);
      setState(() {});
    }
  }

  Future<String> getTempFile([String? fileName]) async {
    final tempDir = await getTemporaryDirectory();

    return '${tempDir.path}${Platform.pathSeparator}${fileName ?? const Uuid().v4()}';
  }

  // void getvisionai(XFile image) async {
  Future<Uint8List> getvisionai(XFile image) async {
    final credentialsJsonAsString = await rootBundle
        .loadString('assets/speedy-cargo-395914-3b5978de2782.json');
    final googleVision = await go.GoogleVision.withJwt(credentialsJsonAsString);

    final painter = go.Painter.fromFilePath(image.path);
    // cropping an image can save time uploading the image to Google
    final cropped = painter.copyCrop(0, 0, painter.width, painter.height);

    final filePath = await getTempFile(image.name); //獲取暫存路徑，把辨識後的圖片存在這裡

    final requests = go.AnnotationRequests(requests: [
      go.AnnotationRequest(image: go.Image(painter: cropped), features: [
        go.Feature(maxResults: 10, type: 'FACE_DETECTION'),
        go.Feature(maxResults: 10, type: 'OBJECT_LOCALIZATION')
      ])
    ]);

    print('checking...');

    go.AnnotatedResponses annotatedResponses =
        await googleVision.annotate(requests: requests);

    print('done.\n');

    for (var annotatedResponse in annotatedResponses.responses) {
      for (var faceAnnotation in annotatedResponse.faceAnnotations) {
        go.GoogleVision.drawText(
            cropped,
            faceAnnotation.boundingPoly.vertices.first.x + 2,
            faceAnnotation.boundingPoly.vertices.first.y + 2,
            'Face - ${faceAnnotation.detectionConfidence}');

        go.GoogleVision.drawAnnotations(
            cropped, faceAnnotation.boundingPoly.vertices);
      }
    }

    for (var annotatedResponse in annotatedResponses.responses) {
      annotatedResponse.localizedObjectAnnotations
          .where((localizedObjectAnnotation) =>
              localizedObjectAnnotation.name != 'Person')
          .toList()
          .forEach((localizedObjectAnnotation) {
        go.GoogleVision.drawText(
            cropped,
            (localizedObjectAnnotation.boundingPoly.normalizedVertices.first.x)
                .toInt(),
            (localizedObjectAnnotation.boundingPoly.normalizedVertices.first.y)
                .toInt(),
            ''
            //'${localizedObjectAnnotation.name} - ${localizedObjectAnnotation.score}'
            );

        go.GoogleVision.drawAnnotationsNormalized(
            cropped, localizedObjectAnnotation.boundingPoly.normalizedVertices);

        name.add(localizedObjectAnnotation.name);
      });
      void tranlatename() async {
        //翻譯
        final Key = 'AIzaSyCnDmAlXqAYNaXKAkxjM5GhlOPoKgfGCWo';
        final targetLanguage = 'zh-tw'; // 目標語言代碼
        final apiUrl = Uri.parse(
            'https://translation.googleapis.com/language/translate/v2?key=$Key');
        // 建立請求主體
        print("請求翻譯中");
        final body = jsonEncode({
          'q': name[0],
          'target': targetLanguage,
        });
        final response = await http.post(apiUrl,
            body: body, headers: {'Content-Type': 'application/json'});
        if (response.statusCode == 200) {
          final decodedResponse = jsonDecode(response.body);
          final translatedText =
              decodedResponse['data']['translations'][0]['translatedText'];
          print('翻譯結果：$name,$translatedText');
          name.clear();
          setState(() {
            controller.text = translatedText;
          });
        } else {
          print('翻譯請求失敗：${response.reasonPhrase}');
        }
      }

      setState(() {
        if (name[0] != null) {
          tranlatename();
        } else {
          controller.text = "超出範圍請重新辨識或手動輸入";
        }
      });
    }

    await cropped.writeAsJpeg(filePath);
    setState(() {
      _image = filePath; //將處理後的圖片寫入臨時文件，文件路徑存進_image
    });

    final imageBytes = await File(filePath).readAsBytes();
    print('imageBytes length: ${imageBytes.length}');
    return imageBytes;
  }

  void _showDatePiker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime(2026))
        .then((value) {
      setState(() {
        _dateTime = value!;
        date = "${_dateTime.year}/${_dateTime.month}/${_dateTime.day}";
      });
    });
  }

  //創建新文件到firestore
  Future<void> createNewfoodDocument() async {
    var imageUrl = await uploadImageToImgur();
    if (imageUrl == null) {
      imageUrl = "https://i.imgur.com/W5IkanQ.jpg";
    }
    String foodId = firestore.collection('food').doc().id;

    try {
      Map<String, dynamic> foodData = {
        'food_name': controller.text,
        'amount': count,
        'EXP': _dateTime,
        'image': imageUrl,
      };
      await firestore.collection('food').doc(foodId).set(foodData);
      print('創建食材文件成功');
    } catch (e) {
      print('創建食材文件時發生錯誤：$e');
    }
  }

  //api
  Future<String?> uploadImageToImgur() async {
    final imageBytes = imageData;
    String base64Image = base64Encode(imageBytes);
    print(base64Image);

    var headers = {
      'Authorization': 'Bearer fc5342ff41672755b2d33b4ff804e78840d5c29b'
    };

    var request = http.MultipartRequest(
        'POST', Uri.parse('https://api.imgur.com/3/image'));
    request.fields.addAll({'image': base64Image});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseData = json.decode(await response.stream.bytesToString());
      final imageUrl = responseData['data']['link'];
      print('Image URL: $imageUrl');

      return imageUrl;
    } else {
      print(response.reasonPhrase);

      return null;
    }
  }

  // 隨機英文數字的文件名
  String generateRandomFileName() {
    final random = Random();
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final fileName =
        List.generate(10, (index) => chars[random.nextInt(chars.length)])
            .join();
    // print('$fileName');
    return '$fileName';
  }

  Future<String> getLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  //從vision ai存到本地路徑
  Future<void> saveVisionImageDataLocally(XFile image) async {
    try {
      final imageData = await getvisionai(imageFile!);
      final fileName = generateRandomFileName();
      await saveImageLocally(fileName, imageData);
      print('保存圖像到本地成功');
    } catch (e) {
      print('保存圖像到本地時出錯：$e');
    }
  }

  Future<void> saveImageLocally(String fileName, List<int> data) async {
    final path = await getLocalPath();
    final file = File('$path/$fileName');

    await file.writeAsBytes(data);

    setState(() {
      // print(data);
      imageData = data;
    });
  }
}
