import 'package:flutter/material.dart';
import 'widgets.dart';


class HomeScreen extends StatelessWidget {

  final String userName;
  final String avatarUrl;


  const HomeScreen({
    super.key,
    required this.userName,
    required this.avatarUrl,
  });



  @override
  Widget build(BuildContext context) {

    return Container(

      color: bgColor,


      child: SafeArea(

        child: Padding(

          padding: const EdgeInsets.symmetric(
            horizontal: 26,
            vertical: 18,
          ),


          child: Column(

            children: [


              HeaderLeft(
                userName: userName,
                avatarUrl: avatarUrl,
              ),



              const SizedBox(height: 34),



              const WeekStrikeWidget(),



              const SizedBox(height: 65),




              const Text(

                "🥲 Сьогодні трошки сумно,\nрозкажи щось!",


                textAlign: TextAlign.center,


                style: TextStyle(

                  fontSize: 18,

                  height: 1.45,

                  color: fontColor,

                  fontWeight: FontWeight.w600,

                ),

              ),




              const SizedBox(height: 45),




              Container(

                width: 140,

                height: 140,


                decoration: const BoxDecoration(

                  color: Colors.black,

                  shape: BoxShape.circle,

                ),



                child: const Icon(

                  Icons.mic_none_rounded,

                  color: Colors.white,

                  size: 70,

                ),

              ),




              const SizedBox(height: 35),




              const Text(

                "Натисніть, щоб говорити",


                style: TextStyle(

                  color: fontColor,

                  fontSize: 17,

                  fontWeight: FontWeight.w600,

                ),

              ),


            ],

          ),

        ),

      ),

    );

  }

}