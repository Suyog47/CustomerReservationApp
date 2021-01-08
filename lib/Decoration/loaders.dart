import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {

  final int load;
  Loader({this.load});

  @override
  Widget build(BuildContext context) {

    //To show loading widget while data processing
    return (load == 1) ?
    Container(
      color: Colors.black.withOpacity(0.3),
      child: SpinKitCircle(
        color: Colors.blue,
        size: 60.0,
      ),
    ) :
    Text("");
  }
}
