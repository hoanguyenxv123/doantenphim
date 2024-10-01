import 'package:flutter/material.dart';
import 'movie.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                  minimumSize: Size(100, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  )))),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int vitri = 0;
  String ketQua = '';
  int point = 0;
  final int maxPoint = 100;
  late List<bool> answeredQuestions; // Danh sách theo dõi câu hỏi đã trả lời

  @override
  void initState() {
    super.initState();
    answeredQuestions = List<bool>.filled(questions.length, false); // Khởi tạo danh sách
  }

  @override
  Widget build(BuildContext context) {
    // Lấy kích thước của màn hình hiện tại
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: screenSize.height * 0.1, // 10% chiều cao màn hình
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: Icon(
          Icons.menu,
          size: screenSize.height * 0.04, // Tự động điều chỉnh kích thước
        ),
        title: Text(
          'Child game',
          style: TextStyle(fontSize: screenSize.height * 0.03),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Icon(
              Icons.child_care,
              size: screenSize.height * 0.04,
            ),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey[300]),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Container(
                      width: screenSize.width * 0.6, // 60% chiều rộng màn hình
                      height: screenSize.height * 0.03, // 3% chiều cao màn hình
                      child: LinearProgressIndicator(
                        value: point / maxPoint, // Tỷ lệ dựa trên số điểm
                        backgroundColor: Colors.greenAccent,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '${point}/100',
                      style: TextStyle(fontSize: screenSize.height * 0.025),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Đây là bộ phim gì ?',
                    style: TextStyle(
                      fontSize: screenSize.height * 0.04,
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: show(vitri),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: screenSize.width * 0.25, // 25% chiều rộng màn hình
                    height: screenSize.height * 0.06, // 6% chiều cao màn hình
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          vitri--;
                          if (vitri < 0) {
                            vitri = questions.length - 1;
                          }
                          ketQua = '';
                        });
                      },
                      icon: Icon(Icons.navigate_before),
                      iconSize: screenSize.height * 0.04,
                    ),
                  ),
                  Text(
                    '${vitri + 1}/${questions.length}',
                    style: TextStyle(fontSize: screenSize.height * 0.04),
                  ),
                  Container(
                    width: screenSize.width * 0.25,
                    height: screenSize.height * 0.06,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          vitri++;
                          if (vitri >= questions.length) {
                            vitri = 0;
                          }
                          ketQua = '';
                        });
                      },
                      icon: Icon(Icons.navigate_next),
                      iconSize: screenSize.height * 0.04,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: screenSize.height * 0.08, // 8% chiều cao màn hình
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.cyan, borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      ketQua,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: screenSize.height * 0.04),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget show(hih) {
    final screenSize = MediaQuery.of(context).size;

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: screenSize.height * 0.3, // 30% chiều cao màn hình
            decoration: BoxDecoration(
              color: Colors.orange,
              image: DecorationImage(
                image: AssetImage(questions[hih]['img']),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          SizedBox(height: screenSize.height * 0.04), // Khoảng cách linh hoạt
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    check(hih, questions[hih]['options'][0]);
                  },
                  child: Text(
                    questions[hih]['options'][0],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: screenSize.height * 0.02),
                  ),
                ),
              ),
              SizedBox(width: screenSize.width * 0.03), // Khoảng cách linh hoạt
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    check(hih, questions[hih]['options'][1]);
                  },
                  child: Text(
                    questions[hih]['options'][1],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: screenSize.height * 0.02),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenSize.height * 0.02),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    check(hih, questions[hih]['options'][2]);
                  },
                  child: Text(
                    questions[hih]['options'][2],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: screenSize.height * 0.02),
                  ),
                ),
              ),
              SizedBox(width: screenSize.width * 0.03),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    check(hih, questions[hih]['options'][3]);
                  },
                  child: Text(
                    questions[hih]['options'][3],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: screenSize.height * 0.02),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void check(int vitri, String luaChon) {
    String dapAn = questions[vitri]['correctAnswer'];
    setState(() {
      if (luaChon == dapAn) {
        if (!answeredQuestions[vitri]) { // Kiểm tra nếu câu hỏi chưa được trả lời
          ketQua = 'Đúng';
          point += 5;
          answeredQuestions[vitri] = true; // Đánh dấu câu hỏi đã được trả lời
        }
      } else {
        ketQua = 'Sai';
      }
    });
  }
}
