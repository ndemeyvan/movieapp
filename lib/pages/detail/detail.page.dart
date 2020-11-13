import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app_yt/animation/FadeAnimation.dart';
import 'package:movie_app_yt/services/ApiServices.dart';
import 'package:movie_app_yt/utils/style.dart';
import 'package:movie_app_yt/widget/AnimButton.dart';
import '../../Utils/Constant.dart' as constant;

List imgList = [];
Style style = new Style();

class DetailPage extends StatefulWidget {

  String image;
  String description;
  String outDate;
  String author;
  String title;
  String category_name;
  String id;

  DetailPage({
    this.image,
    this.description,
    this.outDate,
    this.author,
    this.title,
    this.category_name,
    this.id,
  });

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  ApiService api = new ApiService();

  Future getSimilarFuture;

  @override
  void initState() {
    super.initState();
    getSimilarFuture =
        api.getVideos(context, widget.category_name, id: widget.id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: 450,
                backgroundColor: Colors.black,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                              "${constant.ImageBaseUrl}/file/${widget.image}",
                            ),
                            fit: BoxFit.cover)),
                    child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomRight,
                              colors: [
                            Colors.black,
                            Colors.black.withOpacity(.3)
                          ])),
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            FadeAnimation(
                                1,
                                Text(
                                  "${widget.title}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40),
                                )),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                FadeAnimation(
                                    1.3,
                                    Text(
                                      "View 240K ",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 16),
                                    )),
                                FadeAnimation(
                                    1.3,
                                    AnimButton(
                                      pressEvent: () {},
                                      text: "Play",
                                      color: Colors.deepOrange,
                                      isFixedHeight: false,
                                      width: 150,
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FadeAnimation(
                            1.6,
                            Text(
                              "${widget.description}",
                              style: TextStyle(color: Colors.grey, height: 1.4),
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        FadeAnimation(
                            1.6,
                            Text(
                              "Out date :",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        FadeAnimation(
                            1.6,
                            Text(
                              "${DateFormat.yMMMEd().format(DateTime.parse(widget.outDate))}",
                              style: TextStyle(color: Colors.grey),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                            1.6,
                            Text(
                              "Author(s) :",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        FadeAnimation(
                            1.6,
                            Text(
                              "${widget.author}",
                              style: TextStyle(color: Colors.grey),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                            1.6,
                            Text(
                              "Similar video",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                            1.8,
                            Container(
                                height: 200,
                                child: FutureBuilder(
                                    future: getSimilarFuture,
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (snapshot.data == null) {
                                        return Container(
                                          child: Center(
                                              child:
                                                  CircularProgressIndicator()),
                                        );
                                      } else {
                                        if (snapshot.data.length <= 0) {
                                          return Center(
                                              child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.05,
                                              ),
                                            ],
                                          ));
                                        } else {
                                          return BuildMovies(snapshot);
                                        }
                                      }
                                    }))),
                        SizedBox(
                          height: 120,
                        )
                      ],
                    ),
                  )
                ]),
              )
            ],
          ),
        ],
      ),
    );
  }
}

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
          return AspectRatio(
            aspectRatio: 1.5 / 1,
            child: Container(
              margin: EdgeInsets.only(right: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(
                        "${constant.ImageBaseUrl}/file/${snapshot.data[index]["image"]}",
                      ),
                      fit: BoxFit.cover)),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomRight,
                        colors: [
                      Colors.black.withOpacity(.9),
                      Colors.black.withOpacity(.3)
                    ])),
                child: Align(
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 70,
                  ),
                ),
              ),
            ),
          );
        });
  }
}
