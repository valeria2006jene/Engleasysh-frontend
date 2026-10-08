import 'package:flutter/material.dart';
import 'widgets.dart';
import 'all_notifications_screen.dart';


class HistoryScreen extends StatelessWidget {

  final String userName;
  final String avatarUrl;


  const HistoryScreen({
    super.key,
    required this.userName,
    required this.avatarUrl,
  });



  @override
  Widget build(BuildContext context) {


    final notifications = [

      {
        "title": "Нещодавні",
        "text": "🐣 Я сьогодні навчився новому слову. А ти?",
        "time": "35 min",
      },


      {
        "title": "Раніше",
        "text": "🌆 Розкажи як сьогодні пройшов твій день?",
        "time": "5h",
      },


      {
        "title": "",
        "text": "🐭 Твоя пацюня засумувала, підбадьорь її мерщій!",
        "time": "2d",
      },

    ];




    return Container(

      color: bgColor,


      child: SafeArea(


        child: Padding(

          padding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 18,
          ),



          child: Column(


            crossAxisAlignment:
            CrossAxisAlignment.start,



            children: [



              HeaderRight(

                userName: userName,

                avatarUrl: avatarUrl,

              ),




              const SizedBox(height: 34),




              const Center(

                child: Text(

                  "Let's have a look!",


                  style: TextStyle(

                    fontSize: 24,

                    fontWeight: FontWeight.w700,

                    color: fontColor,

                  ),

                ),

              ),




              const SizedBox(height: 28),





              Expanded(


                child: Column(


                  children: [



                    Expanded(


                      child: ListView.builder(


                        physics:
                        const NeverScrollableScrollPhysics(),



                        itemCount:
                        notifications.length,



                        itemBuilder:
                            (context,index){



                          final item =
                          notifications[index];




                          return Column(


                            crossAxisAlignment:
                            CrossAxisAlignment.start,



                            children: [




                              if(item["title"]!.isNotEmpty)



                                Padding(

                                  padding:
                                  const EdgeInsets.only(
                                    bottom: 10,
                                  ),



                                  child: Align(


                                    alignment:
                                    Alignment.centerRight,



                                    child: Text(

                                      item["title"]!,


                                      style:
                                      const TextStyle(

                                        fontSize: 13,

                                        color:
                                        Color(0xff73879C),

                                      ),

                                    ),

                                  ),

                                ),






                              Container(


                                margin:
                                const EdgeInsets.only(
                                  bottom: 14,
                                ),



                                padding:
                                const EdgeInsets.symmetric(

                                  horizontal: 18,

                                  vertical: 18,

                                ),




                                decoration:
                                BoxDecoration(

                                  color:
                                  Colors.white,


                                  borderRadius:
                                  BorderRadius.circular(24),


                                  boxShadow: [

                                    BoxShadow(

                                      color:
                                      Colors.black.withOpacity(.05),

                                      blurRadius:18,

                                      offset:
                                      const Offset(0,8),

                                    ),

                                  ],

                                ),





                                child: Row(


                                  children: [



                                    Expanded(


                                      child: Text(

                                        item["text"]!,


                                        style:
                                        const TextStyle(

                                          fontSize:15,

                                          height:1.4,

                                          color:fontColor,

                                          fontWeight:
                                          FontWeight.w500,

                                        ),

                                      ),

                                    ),





                                    Text(

                                      item["time"]!,


                                      style:
                                      const TextStyle(

                                        fontSize:11,

                                        color:
                                        Color(0xff8E9BAB),

                                      ),

                                    ),



                                  ],

                                ),

                              ),



                            ],


                          );



                        },


                      ),


                    ),







                    Align(


                      alignment:
                      Alignment.centerLeft,



                      child: TextButton(


                        onPressed: (){


                          Navigator.push(

                            context,


                            MaterialPageRoute(

                              builder:(context)=>

                              const AllNotificationsScreen(),

                            ),

                          );


                        },



                        child: const Text(

                          "Переглянути всі сповіщення",



                          style:
                          TextStyle(

                            color:fontColor,

                            fontSize:15,

                            fontWeight:
                            FontWeight.w600,

                          ),

                        ),

                      ),

                    ),





                    // місце під пацюка

                    const SizedBox(

                      height:150,

                    ),




                  ],


                ),


              ),




            ],


          ),


        ),


      ),


    );

  }

}