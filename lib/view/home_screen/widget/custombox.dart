import 'package:flutter/material.dart';



class CustomBox extends StatelessWidget {
final String image;
final String mainText;
final String subText;
final Color color;
final VoidCallback onpressed;

  const CustomBox(
      {required this.image,
      required this.mainText,
      required this.subText,
      required this.color,
      required this.onpressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8,),
      child: InkWell(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(0),
            bottomRight: Radius.circular(10),
            bottomLeft: Radius.circular(0)),
        onTap: () {
          onpressed();
        },
        child: Container(
          height: 300,
          width: 250,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(0),
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(0)),
            color: color,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: 125,
                width: 125,
              ),
              Text(
                mainText,
                style: const TextStyle(color: Colors.white, fontSize: 23),
              ),
              Text(
                subText,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 15),
              )
            ],
          ),
        ),
      ),
    );
  }
}
