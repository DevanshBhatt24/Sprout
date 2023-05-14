import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Reviews extends StatefulWidget {
  const Reviews({Key? key}) : super(key: key);

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> with WidgetsBindingObserver {
  FocusNode myfocus = FocusNode();
  TextEditingController _controller = TextEditingController();
  String? userreview;
  double? userrating;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Container(
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Write Review",
              style: TextStyle(
                  fontFamily: 'Mada',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff4b4b4b)),
            ),
            RatingBar.builder(
                itemBuilder: (context, _) => ImageIcon(
                      AssetImage('assets/images/leaf-svgrepo-com 10.png'),
                      color: Color(0xff49a010),
                    ),
                itemSize: 22,
                itemCount: 5,
                initialRating: 0,
                minRating: 1,
                allowHalfRating: true,
                itemPadding: EdgeInsets.symmetric(horizontal: 2.5),
                onRatingUpdate: (rating) {
                  setState(() {
                    userrating = rating;
                  });
                })
          ],
        ),
        SizedBox(
          height: 23,
        ),
        Container(
          height: h / 5,
          child: Column(children: [
            Expanded(
                child: TextField(
              controller: _controller,
              textAlign: TextAlign.start,
              focusNode: myfocus,
              decoration: InputDecoration.collapsed(
                  filled: true,
                  hintText: 'Type Here...',
                  hintStyle: TextStyle(
                      color: Color(0xffc6c6c6),
                      fontSize: 16,
                      fontFamily: 'Mada',
                      fontWeight: FontWeight.w600),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Color(0xffd6d6d6))),
                  fillColor: Colors.white),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              expands: true,
              onChanged: ((value) => setState(() {
                    userreview = value;
                  })),
            )),
          ]),
        ),
        SizedBox(
          height: 16,
        ),
        SizedBox(
          height: h / 15,
          width: w,
          child: ElevatedButton(
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                backgroundColor: MaterialStateProperty.all(Color(0xffebebeb))),
            onPressed: () {
              print(userreview);
              print(userrating);
            },
            child: const Text(
              'Submit',
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  color: Color(0xffab9e9e)),
            ),
          ),
        ),
      ]),
    );
  }

  @override
  void didChangeMetrics() {
    super.didChangeMetrics();
    final value = WidgetsBinding.instance.window.viewInsets.bottom;
    if (MediaQuery.of(context).viewInsets.bottom != 0) if (value == 0)
      myfocus.unfocus();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    myfocus.dispose();
    super.dispose();
  }
}
