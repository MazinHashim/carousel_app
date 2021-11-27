import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carousel App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<List<String>> products = [
    ["assets/images/bg-1.jpg", "Hugo Boss Oxygen", "100 \$"],
    ["assets/images/bg-2.jpg", "Hugo Boss Signature", "120 \$"],
    ["assets/images/bg-3.jpg", "Hugo Boss Premium", "80 \$"],
    ["assets/images/bg-4.jpg", "Hugo Boss Premium", "200 \$"],
    ["assets/images/bg-5.jpg", "Hugo Boss Premium", "180 \$"],
    ["assets/images/bg-6.jpg", "Hugo Boss Premium", "66 \$"],
    ["assets/images/bg-7.jpg", "Hugo Boss Premium", "210 \$"]
  ];

  int currentIndex = 0;
  ScrollController _scrollController  = ScrollController();
  void _next() {
    setState(() {
      if (currentIndex < products.length - 1) {
        currentIndex++;
      } else {
        currentIndex = currentIndex;
      }
    });
  }

  void _prev() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
      } else {
        currentIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        // anchor: 0.05,
        slivers: <Widget>[
          SliverAppBar(
            // pinned: true,
            backgroundColor: Colors.white,
            expandedHeight: MediaQuery.of(context).size.height * 0.6,
            title: Text("Find the Watch you Need", style: TextStyle(color: Colors.black.withOpacity(0.5)),),
            centerTitle: true,
            flexibleSpace: FlexibleSpaceBar(
              background: GestureDetector(
                onHorizontalDragEnd: (DragEndDetails details) {
                  if (details.velocity.pixelsPerSecond.dx > 0) {
                    _prev();
                  } else if (details.velocity.pixelsPerSecond.dx < 0) {
                    _next();
                  }
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("${products[currentIndex][0]}"),
                          fit: BoxFit.fill)),
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.bottomRight,
                            colors: [
                          Colors.grey[700].withOpacity(0.9),
                          Colors.grey.withOpacity(0.0)
                        ])),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 60.0),
                          width: products.length * 30.0,
                          child: Row(
                            children: _buildIndicators(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            child: Container(
              padding: EdgeInsets.all(30.0),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("${products[currentIndex][1]}",
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "SpicyRice")),
                  SizedBox(height: 15.0),
                  Row(
                    children: <Widget>[
                      Text("${products[currentIndex][2]}",
                          style: TextStyle(
                              color: Colors.yellow[700],
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                      SizedBox(width: 10.0),
                      Row(
                        children: <Widget>[
                          Icon(Icons.star,
                              color: Colors.yellow[700], size: 18.0),
                          Icon(Icons.star,
                              color: Colors.yellow[700], size: 18.0),
                          Icon(Icons.star,
                              color: Colors.yellow[700], size: 18.0),
                          Icon(Icons.star,
                              color: Colors.yellow[700], size: 18.0),
                          Icon(Icons.star_half,
                              color: Colors.yellow[700], size: 18.0),
                          SizedBox(width: 5.0),
                          Text("(4.2/70 reviews)",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12.0))
                        ],
                      ),
                    ],
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 45.0,
                        decoration: BoxDecoration(
                            color: Colors.yellow[700],
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                          child: Text(
                            "ADD TO CART",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _indicators(bool isAcive) {
    return Expanded(
      child: Container(
        height: 4.0,
        margin: EdgeInsets.only(right: 5.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: isAcive ? Colors.grey[800] : Colors.white),
      ),
    );
  }

  List<Widget> _buildIndicators() {
    List<Widget> indicators = [];
    for (var i = 0; i < products.length; i++) {
      if (currentIndex == i) {
        indicators.add(_indicators(true));
      } else {
        indicators.add(_indicators(false));
      }
    }
    return indicators;
  }
}