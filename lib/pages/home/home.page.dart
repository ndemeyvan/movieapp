import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lamp_bottom_navigation/lamp_bottom_navigation.dart';
import 'package:movie_app_yt/services/ApiServices.dart';
import 'package:movie_app_yt/utils/style.dart';
import '../detail/detail.page.dart';
import '../../Utils/Constant.dart' as constant;

List imgList = [];

Style style = new Style();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _pageController;
  int _page = 0;
  Future futureForAllVideos;
  Future futureForComediesVideos;
  Future futureForActionsVideos;
  Future futureForAnimationsVideos;
  Future futureForMustLikedVideos;
  ApiService api = new ApiService();

  void _navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    futureForAllVideos = api.getVideos(context, "all");
    futureForMustLikedVideos =
        api.getVideos(context, "MustLiked").then((response) {
//      print("this is the response : ${response}");
      setState(() {
        for (int i = 0; i < response.length; i++) {
          imgList.add(response[i]);
        }
        print("this is the imgList ${imgList}");
        getCarouselElement();
      });
    });

    futureForComediesVideos = api.getVideos(context, "Comedies");
    futureForActionsVideos = api.getVideos(context, "Actions");
    futureForAnimationsVideos = api.getVideos(context, "Animations");
  }

  List<Widget> imageSliders = [];

  getCarouselElement() {
    imageSliders = imgList
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.network(
                            '${constant.ImageBaseUrl}/file/${item['image']}',
                            fit: BoxFit.cover,
                            width: 1000.0),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color.fromARGB(200, 0, 0, 0),
                                  Color.fromARGB(0, 0, 0, 0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            child: Text(
                              '${item['title']}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ))
        .toList();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: style.bg,
      appBar: AppBar(
        backgroundColor: style.bg,
        elevation: 0,
//          leading: Icon(
//            Icons.list,
//            color: style.primary,
//          ),
        leading: Container(),
        title: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Icon(
              FontAwesomeIcons.play,
              color: Colors.deepOrange,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "SevenVideo",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontFamily: "longCang",
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: Icon(
              Icons.search,
              color: style.primary,
            ),
          )
        ],
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: <Widget>[
          Center(
            child: SingleChildScrollView(
              child: Container(
                width: size.width,
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Hello \nAkah Larry",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    imageSliders.length <= 0
                        ? Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                CircularProgressIndicator(),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          )
                        : CarouselSlider(
                            options: CarouselOptions(
                              autoPlay: true,
                              aspectRatio: 2.0,
                              enlargeCenterPage: true,
                            ),
                            items: imageSliders,
                          ),
                    SizedBox(
                      height: 20,
                    ),
                    CategorySeparator(
                      title: 'Nouveautes',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        width: size.width,
                        height: 180,
                        child: FutureBuilder(
                            future: futureForAllVideos,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.data == null) {
                                return Container(
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                );
                              } else {
                                if (snapshot.data.length <= 0) {
                                  return Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          child: Text("No Videos")),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                      ),
                                    ],
                                  ));
                                } else {
                                  return BuildMovies(snapshot);
                                }
                              }
                            })),
                    SizedBox(
                      height: 20,
                    ),
                    CategorySeparator(
                      title: 'Films de comedies',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        width: size.width,
                        height: 180,
                        child: FutureBuilder(
                            future: futureForComediesVideos,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.data == null) {
                                return Container(
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                );
                              } else {
                                if (snapshot.data.length <= 0) {
                                  return Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          child: Text("No Videos")),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                      ),
                                    ],
                                  ));
                                } else {
                                  return BuildMovies(snapshot);
                                }
                              }
                            })),
                    SizedBox(
                      height: 40,
                    ),
                    CategorySeparator(
                      title: 'Films d\'animations',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        width: size.width,
                        height: 180,
                        child: FutureBuilder(
                            future: futureForAnimationsVideos,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.data == null) {
                                return Container(
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                );
                              } else {
                                if (snapshot.data.length <= 0) {
                                  return Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          child: Text("No Videos")),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                      ),
                                    ],
                                  ));
                                } else {
                                  return BuildMovies(snapshot);
                                }
                              }
                            })),
                    SizedBox(
                      height: 20,
                    ),
                    CategorySeparator(
                      title: 'Films d\'actions',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        width: size.width,
                        height: 180,
                        child: FutureBuilder(
                            future: futureForActionsVideos,
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.data == null) {
                                return Container(
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                );
                              } else {
                                if (snapshot.data.length <= 0) {
                                  return Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15,
                                          child: Text("No Videos")),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                      ),
                                    ],
                                  ));
                                } else {
                                  return BuildMovies(snapshot);
                                }
                              }
                            })),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Text(
              "Page 2",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          ),
          Center(
            child: Text(
              "Page 3",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          ),
          Center(
            child: Text(
              "Page 4",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          ),
          Center(
            child: Text(
              "Page 5",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
          ),
        ],
      ),
      bottomNavigationBar: LampBottomNavigationBar(
        items: <IconData>[
          FontAwesomeIcons.film,
          Icons.favorite_border,
          Icons.search,
          FontAwesomeIcons.userCircle,
          Icons.more_horiz,
        ],
        width: double.infinity,
        onTap: _navigationTapped,
        currentIndex: _page,
      ),
    );
  }
}

class CategorySeparator extends StatelessWidget {
  final String title;

  CategorySeparator({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              color: style.primary, fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Text(
          'Voir tout',
          style: TextStyle(
              color: style.secondary,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

//class ListMovies extends StatelessWidget {
//  final Size size;
//  final List movies;
//
//  ListMovies({@required this.size, @required this.movies});
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      width: size.width,
//      height: 180,
//      child: ListView.builder(
//        itemCount: movies.length,
//        scrollDirection: Axis.horizontal,
//        itemBuilder: (context, index) {
//          return GestureDetector(
//            onTap: () {
//              Navigator.push(
//                  context,
//                  PageRouteBuilder(
////                      transitionDuration: Duration(milliseconds: 500),
//                      pageBuilder: (_, __, ___) => DetailPage()));
//            },
//            child: Padding(
//                padding: EdgeInsets.only(right: 10.0),
//                child: Stack(children: [
//                  ClipRRect(
//                    borderRadius: BorderRadius.circular(10),
//                    child: Image.asset(
//                      'assets/images/${movies[index]}',
//                      width: 170,
//                      height: 180,
//                      fit: BoxFit.cover,
//                    ),
//                  ),
////coeur pour liker une video
////                  Positioned(
////                      top: 10,
////                      right: 10,
////                      child: Container(
////                        width: 25,
////                        height: 25,
////                        decoration: BoxDecoration(
////                            color: style.bg,
////                            borderRadius: BorderRadius.circular(20)),
////                        child: Icon(Icons.favorite,
////                            color:
////                                (index % 2) == 0 ? style.accent : style.primary,
////                            size: 15),
////                      )),
//                  Positioned(
//                      bottom: 10,
//                      left: 10,
//                      child: Text('Filme filme filme',
//                          style: TextStyle(
//                              color: style.primary,
//                              fontSize: 16,
//                              fontWeight: FontWeight.w900)))
//                ])),
//          );
//        },
//      ),
//    );
//  }
//}

class BuildMovies extends StatelessWidget {
  final AsyncSnapshot snapshot;

  BuildMovies(
    this.snapshot,
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (_, __, ___) => DetailPage(
                            image: snapshot.data[index]['image'],
                            description: snapshot.data[index]['description'],
                            outDate: snapshot.data[index]['outDate'],
                            author: snapshot.data[index]['realisator'],
                            title: snapshot.data[index]['title'],
                            category_name: snapshot.data[index]
                                ['category_name'],
                          )));
            },
            child: Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: Stack(children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        "${constant.ImageBaseUrl}/file/${snapshot.data[index]["image"]}",
                        width: 170,
                        height: 180,
                        fit: BoxFit.cover,
                      )),
                  Positioned(
                      bottom: 10,
                      left: 10,
                      child: Text('${snapshot.data[index]["title"]}',
                          style: TextStyle(
                              color: style.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.w900)))
                ])),
          );
        });
  }
}
