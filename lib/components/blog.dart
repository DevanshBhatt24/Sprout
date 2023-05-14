import 'package:Sprout/components/constant.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html/dom.dart' as html;
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'customtoast.dart';

class Blog extends StatefulWidget {
  const Blog({Key? key}) : super(key: key);

  @override
  State<Blog> createState() => _BlogState();
}

class _BlogState extends State<Blog> {
  bool isloading = true;
  List<Articles> articles = [];
  Future getwebsitedata() async {
    final url = Uri.parse("https://thehouseplantguru.com/");
    final response = await http.get(url);
    html.Document dom = html.Document.html(response.body);
    final titles = dom
        .querySelectorAll('h2 > a')
        .map((el) => el.innerHtml.trim())
        .toList();
    final desciptions = dom
        .querySelectorAll('div.post-content > div > p')
        .map((el) => el.innerHtml.trim())
        .toList();
    final urls = dom
        .querySelectorAll('h2 > a')
        .map((el) => el.attributes['href'])
        .toList();
    final images = dom
        .querySelectorAll('div.et_pb_image_container > a > img')
        .map((el) => el.attributes['src'])
        .toList();
    // print(urls);
    // print(titles);
    @override
    void setState(fn) {
      if (mounted) {
        super.setState(fn);
      }
    }

    setState(() {
      articles = List.generate(
          titles.length,
          (index) => Articles(
              title: titles[index],
              url: urls[index],
              desc: desciptions[index],
              image: images[index]));
      isloading = false;
    });
  }

  final PageController? _controller = PageController();
  var _currPage = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller!.addListener(() {
      setState(() {
        _currPage = _controller!.page!;
      });
    });
    getwebsitedata();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !isloading
        ? Column(
            children: [
              Container(
                height: 200,
                color: Color(0xfffcfff6),
                width: MediaQuery.of(context).size.width * .91,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: EdgeInsets.only(
                            right: 5, left: 5, top: 5, bottom: 5),
                        child: blogContain(
                          headingtxt: "Plant Arcticle",
                          txt: articles[_currPage.toInt()].title,
                          descptxt: articles[_currPage.toInt()].desc,
                          img: articles[_currPage.toInt()].image,
                          launchurl: articles[_currPage.toInt()].url,
                        ));
                  },
                  scrollDirection: Axis.horizontal,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              DotsIndicator(
                dotsCount: 4,
                position: _currPage,
                decorator: DotsDecorator(
                  activeColor: kPrimaryColor,
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              )
            ],
          )
        : Shimmer.fromColors(
            child: Container(
              height: 200,
              width: 355,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.black.withOpacity(.1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        width: 330,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: kPrimaryColor.withOpacity(.17),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: kPrimaryColor.withOpacity(.17),
                        ),
                      )
                    ]),
              ),
            ),
            baseColor: Colors.grey.shade400,
            highlightColor: Colors.grey.shade300);
  }
}

class blogContain extends StatefulWidget {
  String? txt;
  String? headingtxt;
  String? descptxt;
  String? img;
  String? launchurl;
  blogContain(
      {this.descptxt, this.img, this.headingtxt, this.txt, this.launchurl});

  @override
  State<blogContain> createState() => _blogContainState();
}

class _blogContainState extends State<blogContain> {
  bool tap = true;
  // launch() async {
  //   final url = Uri.parse(widget.launchurl!);
  //   print(url);
  //   if (await canLaunchUrl(url)) {
  //     await launchUrl(url);
  //   }
  // }
  FToast? _fToast;
  @override
  void initState() {
    // TODO: implement initState
    _fToast = FToast();
    _fToast!.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 365,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(.25), blurRadius: 3)
          ]),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.headingtxt!,
              style: kSmalltext.copyWith(
                  fontWeight: FontWeight.w600, fontSize: 20),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  tap = !tap;
                });
              },
              child: tap
                  ? Icon(
                      Icons.bookmark_outline,
                      color: kPrimaryColor,
                    )
                  : Icon(
                      Icons.bookmark,
                      color: kPrimaryColor,
                    ),
            )
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 124,
              width: 130,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage(widget.img!), fit: BoxFit.cover)),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 155,
                  height: 50,
                  child: RichText(
                      text: TextSpan(
                          style: kSmalltext.copyWith(
                              color: Color(0xff4e4e4e),
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                          text: widget.txt!,
                          recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              final url = Uri.parse(widget.launchurl!);
                              // print(url);
                              if (await canLaunchUrl(url)) {
                                launchUrl(
                                  url,
                                );
                              } else {
                                _fToast!.showToast(
                                    child: customToast(
                                      txt: "Could not launch url",
                                    ),
                                    toastDuration: Duration(seconds: 2),
                                    gravity: ToastGravity.BOTTOM);
                              }
                            })),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 150,
                  height: 60,
                  child: Text(
                    widget.descptxt!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: ksmalltext.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Color(0xff707070),
                        fontSize: 12),
                  ),
                ),
              ],
            )
          ],
        ),
      ]),
    );
  }
}

class Articles {
  final String? title;
  final String? url;
  final String? desc;
  final String? image;
  Articles({this.title, this.image, this.url, this.desc});
}
