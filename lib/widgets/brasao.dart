import 'package:flutter/widgets.dart';

class Brasao extends StatelessWidget{
  final String image;
  final double width;

  const Brasao({required Key key, required this.image, required this.width}) : super(key:key);

  @override
  Widget build(BuildContext context){
    return SizedBox(
      width: width,
      child: Hero(
        tag: image,
        child: Image.asset(
          image,
          fit: BoxFit.contain,        
        ),  
      ),
    );
  }
}