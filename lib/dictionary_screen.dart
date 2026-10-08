import 'package:flutter/material.dart';
import 'widgets.dart';


class DictionaryScreen extends StatelessWidget {

  final String userName;
  final String avatarUrl;


  const DictionaryScreen({
    super.key,
    required this.userName,
    required this.avatarUrl,
  });



  @override
  Widget build(BuildContext context) {


    final words = [

      {
        "word": "Serendipity",
        "translation": "щаслива випадковість",
      },

      {
        "word": "Eloquent",
        "translation": "красномовний",
      },

      {
        "word": "Wanderlust",
        "translation": "прагнення до подорожей",
      },

      {
        "word": "Ephemeral",
        "translation": "минущий",
      },

      {
        "word": "Ineffable",
        "translation": "невимовний",
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




              const SizedBox(height:32),




              const Text(

                "Dictionary",


                style: TextStyle(

                  fontSize:22,

                  fontWeight:
                  FontWeight.w700,

                  color:fontColor,

                ),

              ),




              const SizedBox(height:18),




              Container(

                height:52,


                decoration: BoxDecoration(

                  color:Colors.white,

                  borderRadius:
                  BorderRadius.circular(28),

                ),




                child: TextField(


                  decoration: InputDecoration(


                    border:
                    InputBorder.none,



                    hintText:
                    "Search word...",




                    hintStyle:
                    const TextStyle(

                      color:
                      Color(0xff8996A6),

                      fontSize:15,

                    ),




                    prefixIcon:
                    const Icon(

                      Icons.search,

                      color:
                      Color(0xff8996A6),

                    ),



                    contentPadding:
                    const EdgeInsets.symmetric(

                      vertical:14,

                    ),



                  ),



                ),


              ),





              const SizedBox(height:24),





              Expanded(


                child: ListView.builder(


                  physics:
                  const BouncingScrollPhysics(),



                  itemCount:
                  words.length,



                  itemBuilder:
                      (context,index){



                    final word =
                    words[index];




                    return Container(



                      margin:
                      const EdgeInsets.only(

                        bottom:16,

                      ),





                      padding:
                      const EdgeInsets.symmetric(

                        horizontal:18,

                        vertical:24,

                      ),




                      decoration:
                      BoxDecoration(



                        color:
                        Colors.white,



                        borderRadius:
                        BorderRadius.circular(22),



                        boxShadow:[


                          BoxShadow(

                            color:
                            Colors.black.withOpacity(.04),

                            blurRadius:15,

                            offset:
                            const Offset(0,6),

                          ),


                        ],



                      ),





                      child: Row(


                        children: [



                          Expanded(


                            child: Text(

                              word["word"]!,


                              style:
                              const TextStyle(

                                fontSize:17,

                                fontWeight:
                                FontWeight.w600,

                                color:
                                fontColor,

                              ),

                            ),

                          ),





                          Expanded(


                            child: Text(


                              word["translation"]!,


                              textAlign:
                              TextAlign.right,



                              style:
                              const TextStyle(

                                fontSize:14,

                                fontWeight:
                                FontWeight.w400,

                                color:
                                fontColor,

                              ),


                            ),


                          ),




                          const SizedBox(width:14),




                          const Icon(

                            Icons.volume_up_outlined,

                            size:22,

                            color:fontColor,

                          ),



                        ],


                      ),


                    );



                  },


                ),


              ),




            ],


          ),


        ),


      ),


    );


  }

}