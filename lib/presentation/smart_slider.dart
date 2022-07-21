import 'dart:async';

import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  final List<Widget> items;

  const HomeWidget({required this.items, Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  late PageController _pageController;

  int pageNumber = 0;
  int currentIndex = 0;
  Timer? sliderTimer;

  Timer getTimer({int duration = 3}) {
    return Timer.periodic(Duration(seconds: duration), (timer) {
      _pageController.animateToPage(pageNumber,
          duration: const Duration(seconds: 1), curve: Curves.easeInOutCirc);
      pageNumber++;
    });
  }

  final List<String> items = ['1', '2', '3', '4', '5', '6'];
  @override
  void initState() {
    _pageController = PageController(
      initialPage: 0,
      viewportFraction: 0.85,
    );
    sliderTimer = getTimer();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Slider'),
        ),
        body: SizedBox(
          height: 200,
          child: Column(
            children: <Widget>[
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      currentIndex = index % items.length;
                    });
                  },
                  itemBuilder: (_, index) {
                    return AnimatedBuilder(
                      animation: _pageController,
                      builder: (ctx, child) {
                        return child ?? const SizedBox();
                      },
                      child: GestureDetector(
                        onPanDown: (_) {
                          sliderTimer?.cancel();
                          sliderTimer = null;
                        },
                        onPanCancel: () {
                          sliderTimer = getTimer();
                        },
                        child: Container(
                          margin: const EdgeInsets.all(24.0),
                          height: 180,
                          color: Colors.amberAccent,
                          child: Text(items[index % items.length]),
                        ),
                      ),
                    );
                  },
                  // itemCount: 5,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  items.length,
                  (index) => Container(
                    margin: const EdgeInsets.all(2.0),
                    child: Icon(
                      Icons.circle,
                      size: 12.2,
                      color: currentIndex == index
                          ? Colors.indigoAccent
                          : Colors.grey.shade300,
                    ),
                  ),
                ).toList(),
              )
            ],
          ),
        ));
  }
}
