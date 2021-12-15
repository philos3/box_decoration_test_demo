import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver,RouteAware{

  late ScrollController _controller;

  Timer? _timer;
  var _index = 0;
  late Duration duration;
  late double horizontalSwiperItemWidth;
  late double horizontalSwiperItemHeight;
  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
    var totalSwiperWidth = Get.width-50;
    horizontalSwiperItemWidth = totalSwiperWidth/4.0;
    horizontalSwiperItemHeight = 1.76875*horizontalSwiperItemWidth;
    print("==========totalSwiperWidth:$totalSwiperWidth======horizontalSwiperItemWidth:$horizontalSwiperItemWidth====horizontalSwiperItemHeight:$horizontalSwiperItemHeight==");
    _controller = ScrollController();
    duration = const Duration(milliseconds: 2000);
    _timer = Timer.periodic(duration, (Timer time) => setState(() => _indexFun()));
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
    _timer?.cancel();
    _controller.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      print("==========didChangeAppLifecycleState=====paused============");
      _timer?.cancel();
      _timer = null;
    }
    else if (state == AppLifecycleState.resumed) {
      print("==========didChangeAppLifecycleState=====resumed============");
      if(_timer == null || !(_timer!.isActive)){
        _timer = Timer.periodic(duration, (Timer time) => setState(() => _indexFun()));
      }
    }
  }
  @override
  void didPushNext() {
    super.didPushNext();
    // 当前页面push到其他页面走这里
    print("生命周期监听 当前页面push到其他页面走这里 didPushNext,${Get.currentRoute}");
    _timer?.cancel();
    _timer = null;
  }

  @override
  void didPop() {
    super.didPop();
    // pop出当前页面时走这里
    print("生命周期监听 didPop");
  }

  @override
  void didPopNext() {
    // 从其他页面pop回当前页面走这里
    print("生命周期监听 从其他页面pop回当前页面走这里 didPopNext,${Get.currentRoute}");
    if(_timer == null || !(_timer!.isActive)){
      _timer = Timer.periodic(duration, (Timer time) => setState(() => _indexFun()));
    }
    super.didPopNext();
  }

  _indexFun() {
    ++_index;
    double offset = _index*horizontalSwiperItemWidth;
    // _index = _index % widget.children.length;
    if(_index >=160000){
      _index = _index % 16;
    }
    if(_index ==0){
      _controller.jumpTo(offset);
    } else {
      _controller.animateTo(offset,duration: const Duration(milliseconds: 2000),curve: Curves.linear);
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF9F9F9F),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:Column(
        children: [
          ///test1
          Container(
              alignment: Alignment.center,
              height: horizontalSwiperItemHeight,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),//禁止滑动
                scrollDirection:Axis.horizontal,
                controller: _controller,
                itemCount: 160000,
                itemExtent: horizontalSwiperItemWidth,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      height: horizontalSwiperItemHeight,
                      width: horizontalSwiperItemWidth,
                      margin:const EdgeInsets.symmetric(horizontal: 4),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(18.0)),
                        image: DecorationImage(
                          image: AssetImage('assets/images/pic_background.png'),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      child: SizedBox(
                        height: horizontalSwiperItemHeight,
                        width: horizontalSwiperItemWidth - 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin:const EdgeInsets.only(top: 10,bottom: 15),
                              alignment:Alignment.center,
                              child: Text(
                                "index:$index",
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style:const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    // letterSpacing:2.w,
                                    height: 1,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              // color: Colors.red,
                              alignment: Alignment.center,
                              height: horizontalSwiperItemHeight - 50,
                              child:const Text("￥99999", style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFD91111),
                                  // letterSpacing:2.w,
                                  height: 1,
                                  fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      )
                  );
                },
              )
          ),

          ///test2
          Container(
              alignment: Alignment.center,
              height: horizontalSwiperItemHeight,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),//禁止滑动
                scrollDirection:Axis.horizontal,
                controller: _controller,
                itemCount: 160000,
                itemExtent: horizontalSwiperItemWidth,
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    children: [
                      Padding(padding:const EdgeInsets.symmetric(horizontal: 4),
                        child: Image.asset('assets/images/pic_background.png',
                          fit: BoxFit.fitWidth,
                          height: horizontalSwiperItemHeight,
                          width: horizontalSwiperItemWidth,
                        ),
                      ),
                      SizedBox(
                        height: horizontalSwiperItemHeight,
                        width: horizontalSwiperItemWidth - 8,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin:const EdgeInsets.only(top: 10,bottom: 15),
                              alignment:Alignment.center,
                              child: Text(
                                "index:$index",
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style:const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    // letterSpacing:2.w,
                                    height: 1,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              // color: Colors.red,
                              alignment: Alignment.center,
                              height: horizontalSwiperItemHeight - 50,
                              child:const Text("￥99999", style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFFD91111),
                                  // letterSpacing:2.w,
                                  height: 1,
                                  fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              )
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
