import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_test/colors.dart';
import 'package:get/get.dart';
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
  //名字篩選

  //翻譯
  List<String> name = [];

  //圖片標籤
  XFile? imageFile;
  String _image = '';

  //控制數量
  final controller = TextEditingController();
  int count = 0;

  String apiKey = '';
  String apiUrl = '';
  String path = '';
  List<int> imagett = [];
  List<int> imageData = [];
  List<int> imageBytes = [];


  void incrementCounter() {
    setState(() {
      count++;
    });
  }

  void decrementCounter() {
    setState(() {
      count--;
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
    Size size = MediaQuery
        .of(context)
        .size;
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
        body: Center(
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
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
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
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
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
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  width: size.width,
                  color: Colors.grey[100],
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: "名稱：",
                      labelStyle: TextStyle(
                        color: kPrimaryColor.withOpacity(0.5),
                      ),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
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
                        onPressed: () =>
                        {
                          decrementCounter(),
                        },
                        child: Text("-"),
                      ),
                      Container(
                        width: 150,
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
                        onPressed: () =>
                        {
                          incrementCounter(),
                        },
                        child: Text("+"),
                      ),
                    ],
                  ),
                ),

                //時間
                Container(
                  width: size.width,
                  child: Row(
                    children: [
                      Container(
                        width: size.width - 120,
                        child: Text(
                          _dateTime.year.toString() +
                              "/" +
                              _dateTime.month.toString() +
                              "/" +
                              _dateTime.day.toString() +
                              "    ",
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
                        child: Icon(
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
                        textStyle: TextStyle(fontSize: 30.0),
                      ),
                      onPressed: () {
                        //新增進資料庫(各個變數名)：照片路徑是imagefile!.path,食材名稱->controller.text,到期日->date,數量->count
                        createNewfoodDocument();

                        //回前一頁
                        Navigator.pop(context);
                        controller.clear();
                      },
                      child: Text("確認"),
                    ),
                  ],
                ),
              ],
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
        await saveVisionImageDataLocally();
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

    return '${tempDir.path}${Platform.pathSeparator}${fileName ??
        const Uuid().v4()}';
  }

  // void getvisionai(XFile image) async {
  Future<Uint8List> getvisionai(XFile image) async {
    final credentialsJsonAsString = await rootBundle
        .loadString('assets/speedy-cargo-395914-3b5978de2782.json');
    final googleVision = await go.GoogleVision.withJwt(credentialsJsonAsString);

    final painter = go.Painter.fromFilePath(image.path);
    // cropping an image can save time uploading the image to Google
    final cropped = painter.copyCrop(0, 0, 1080, 1080);

    final filePath = await getTempFile(image.name);  //獲取暫存路徑，把辨識後的圖片存在這裡

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
      _image = filePath;  //將處理後的圖片寫入臨時文件，文件路徑存進_image
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
        date = _dateTime.year.toString() +
            "/" +
            _dateTime.month.toString() +
            "/" +
            _dateTime.day.toString() +
            "    ";
      });
    });
  }

  //創建新文件到firestore
  void createNewfoodDocument() async {
    String foodId = firestore
        .collection('food')
        .doc()
        .id;

    try {
      Map<String, dynamic> foodData = {
        'food_name': controller.text,
        'amount': count,
        // 'EXP': date,
        'EXP': _dateTime,
        'image': imageFile!.path,

      };
      await firestore.collection('food').doc(foodId).set(foodData);
      uploadImageToImge();
      print('創建食材文件成功');
    } catch (e) {
      print('創建食材文件時發生錯誤：$e');
    }
  }

  //im.ge的api
  void uploadImageToImge() async {
    final apiKey = '26qrIzVXzPe1m1NrnbvgRvMslW0NAvzPmrCgWLDd';

    //測試用圖片(已確定有內容)
    final test64 = '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';

    // 圖像文件的本地路徑
    // final imagePath1 = File(imageFile!.path);
    // String imagePath2 = "http://" + imageFile!.path.toString();
    // final source = imagePath2;
    final source = path;

    // final localFilePath = '/path/to/your/local/file.jpg'; // 本地文件的路徑
    // final uri = Uri.file(imageFile!.path);

    // print(imagePath2.toString()); // 這將打印有效的http URI

    // 讀取圖像文件的內容
    // final imageBytes = File(imagePath2).readAsBytesSync();
    final imageBytes = imageData;
    // final imageBb = imagett;
    // String base64Image = base64Encode(imageBytes);
    // print(base64Image);


    // if (imageBytes.isNotEmpty) {
    //   print('圖像內容有');

      // 構建 API 請求
      //方法一
      // final uri = Uri.parse('https://im.ge/api/1/upload?key=$apiKey&format=json');
      // final request = http.MultipartRequest('POST', uri)
      //   ..files.add(http.MultipartFile.fromBytes('$source', filename: generateRandomFileName()));
      // final httpImage = http.MultipartFile.fromBytes("$source", imageBytes, filename: generateRandomFileName());
      // request.files.add(httpImage);

      //方法二
    final baseUrl = 'https://im.ge';
    final endpoint = '/api/1/upload';
    final queryParams = {
      'key': apiKey,
      'action': 'upload',
      'source': test64,
      'format': 'json',
    };

    final uri = Uri.parse('$baseUrl$endpoint?$queryParams');
    var request = new http.MultipartRequest('POST', uri);

    // final apiUrl = Uri.parse('https://im.ge/api/1/upload?key=$apiKey&format=json');
    // final body = jsonEncode({
    //   'source': test64
    // });





      // try {
      //   final response = await http.Response.fromStream(await request.send());
      //
      //   // 解析 API 回應
      //   final data = json.decode(response.body);
      //   final statusCode = data['status_code'];
      //
      //   if (statusCode == 200) {
      //     final imageUrl = data['image']['url'];
      //     print('圖片連結：$imageUrl');
      //   } else {
      //     final statusTxt = data['status_txt'];
      //     print('上傳失敗，狀態代碼：$statusCode，狀態訊息：$statusTxt');
      //   }
      // } catch (e) {
      //   print('api_error：$e');
      // }
    try {
      // final imageBytes = await File(imageFile!.path).readAsBytes();
      // final response = await http.post(apiUrl, body: body, headers: {'Content-Type': 'application/json'});
      // final response = await http.post(apiUrl, body: {'source': base64Encode(test64)});
      // print('base64編碼：' + base64Encode(imageBytes));


      final response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          final data = json.decode(response.body);
          final statusCode = data['status_code'];

          if (statusCode == 200) {
            final imageUrl = data['image']['url'];
            print('圖片連結：$imageUrl');
          } else {
            final statusTxt = data['status_txt'];
            print('上傳失敗，狀態代碼：$statusCode，狀態訊息：$statusTxt');
          }
        } else {
          print('響應內容為空');
        }
      } else {
        print('HTTP請求失敗，狀態碼：${response.statusCode}');
        urlfetch();
      }
    } catch (e) {
      print('api_error：$e');
    }



    // } else {
    //   // `imageBytes` 為空，沒有有效內容
    //   print('圖像內容為空');
    // }


  }

  // 隨機英文數字的文件名
  String generateRandomFileName() {
    final random = Random();
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final fileName = List.generate(10, (index) => chars[random.nextInt(chars.length)]).join();
    // print('$fileName');
    return '$fileName';
  }

  Future<String> getLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }


  //從vision ai存到本地路徑
  Future<void> saveVisionImageDataLocally() async {
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


  Future<void> urlfetch() async {
    // final response = await http.get(Uri.parse('https://im.ge/api/1/upload?key=$apiKey&format=json'));
    final apiUrl = Uri.parse('https://im.ge/api/1/upload?key=$apiKey&format=json');
    final response = await http.post(apiUrl, body: {'source': base64Encode(imageBytes)});

    if (response.statusCode == 301) {
      // 提取重定向URL
      final redirectUrl = response.headers['location'];


      if (redirectUrl != null) {
        // 使用重定向URL重新发起请求
        final newResponse = await http.get(Uri.parse(redirectUrl));
        print("正在重新定向");
        // 处理新响应
        if (newResponse.statusCode == 200) {
          // 解析新响应数据
          print("可以");
        } else {
          // 处理其他状态码
          print('HTTP不行，狀態碼：${response.statusCode}');
        }
      }
    } else if (response.statusCode == 200) {
      // 处理正常响应
      print("可以");
    } else {
      // 处理其他状态码
      print('HTTP不行，狀態碼：${response.statusCode}');
    }
  }



//




}