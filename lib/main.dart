import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'gameword.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeApp(),
    ),
  );
}
class HomeApp extends StatefulWidget {
  const HomeApp({Key? key}) : super(key: key);

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {

  TextEditingController guesscontroller = TextEditingController();
  late int random=1;
  String full_gword="";
  String gword="";
  String ghint="";
  String c_word="";
  String life_image="";
  int life=5;
  String game_msg="Welcome User";
  bool game_over=false;
  String reaction_image="assets/tup.png";


  List<Gameword> gamewords=[
    Gameword("jackpot", "I got a million dollars"),
    Gameword("melody", "Please my ears"),
    Gameword("wizard", "And I call it magic."),
    Gameword("zombie", "I am dead"),
    Gameword("galaxy", "Look at the stars"),
    Gameword("pendulum", "to and fro"),
    Gameword("scratch", "It's itchy everywhere"),
    Gameword("catalyst", "I will help you to your goal"),
    Gameword("rhythm", "sounds so good"),
    Gameword("muscular", "I am hulk"),
    Gameword("chocolate", "Mom. I want a ...."),
    Gameword("ozone", "Burnt without me"),
    Gameword("kryptonite", "I feel weak around you"),
    Gameword("destiny", "Everything is predetermined."),
    Gameword("cocaine", "Stay away from me."),
    Gameword("tequila", "Shot shot shot shot shot"),
    Gameword("mountain", "So tall"),
    Gameword("pyramid", "A wonderful architecture"),
    Gameword("astonish", "I am surprised"),
    Gameword("bankrupt", "I am poor and broke"),
    Gameword("rival", "I have to win"),
    Gameword("stalemate", "I guess we can't move"),


  ];

  List<String> corrects=[
    "Good going. I hope you win.",
    "Inching closer to the finish line",
    "That is correct. Let's go",
    "You are on fire today",
  ];

  List<String> incorrects=[
    "Ooooops. Try another character",
    "That's a wrong guess",
    "Don't loose hope. You got this",
    "Better luck for next character",
  ];

  List<String> first_row=['q','w','e','r','t','y','u','i','o','p'];
  List second_row=['a','s','d','f','g','h','j','k','l'];
  List third_row=['z','x','c','v','b','n', 'm'];


  void gameover()
  {
    setState(() {
      game_over=true;
      gword=full_gword;
    });
  }

  void initialiseGameWord()
  {
    String dummy="";
    String fgw=gword;
    for(int i=0;i<gword.length;i++)
      {
        if(i%4==0)
          {
            dummy=dummy+gword[i];

          }
        else{
          dummy=dummy+"*";
        }

      }

    setState(() {
      gword=dummy;
      full_gword=fgw;
    });
  }

  void updategame(String letter)
  {
    String dummy="";
    String guess="";
    int correct=0;
    guess=letter;
    for(int i=0;i<gword.length;i++)
      {
        if(gword[i]=="*" && full_gword[i]==guess)
          {
            correct=correct+1;
            dummy=dummy+guess;
          }
        else{
          dummy=dummy+gword[i];
        }

      }

    if(correct==0)
      {
        setState(() {
          reaction_image="assets/tdown.png";
          life=life-1;
          game_msg=incorrects[Random().nextInt(100)%4];
          if(life==0)
            {
              game_msg="Better luck next time";
              gameover();
            }
          life_image="assets/life_"+life.toString()+".png";
        });
      }
    else{
      int stars=0;
      for(int i=0;i<gword.length;i++)
        {
          if(gword[i]=="*")
            {
              stars++;
            }
        }

      if(stars-1==0)
        {
          setState(() {
            game_msg="Congratulations you win";
            game_over=true;
            reaction_image="assets/tup.png";
          });
        }
      else{
        setState(() {
          game_msg=corrects[Random().nextInt(100)%4];
          reaction_image="assets/tup.png";
        });
      }

    }
    setState(() {
      gword=dummy;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    int lengthofwords=gamewords.length;
    int random=Random().nextInt(lengthofwords-1);


    setState(() {
      game_over=false;
      life=5;
      gword=gamewords[random].word;
      ghint=gamewords[random].hint;
      life_image="assets/life_5.png";
      game_msg="Welcome. You look like a player";
      reaction_image="assets/tup.png";
    });

    initialiseGameWord();
  }
  void restart()
  {
    int lengthofwords=gamewords.length;
    int random=Random().nextInt(lengthofwords-1);
    setState(() {
      game_over=false;
      life=5;
      gword=gamewords[random].word;
      ghint=gamewords[random].hint;
      life_image="assets/life_5.png";
      game_msg="Welcome. You look like a player";
    });
    initialiseGameWord();
  }

  Widget tobutton(String l)
  {
   return Container(
     child: Expanded(
       flex:1,
       child: TextButton(

         onPressed:game_over?(){}:(){updategame(l);},
         child: Text(l,
         style: TextStyle(
             fontSize: 20,
           color: Colors.black54,
         ),
         ),
       ),
     ) ,
   );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop:() async{
          return false;
        },
        child:Scaffold(
        appBar: AppBar(
          title: Text("MRJK hangman game"),
          centerTitle: true,
          backgroundColor: Colors.grey[600],
        ),
        body: Container(
          margin: EdgeInsets.all(1),
          child: Column(
            children:[
              Expanded(
                flex:1,
                child: Center(
                  child: Text(
                  "Lives Remaining: "+life.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                    fontSize: 20,
                  ),
            ),
                ),
              ),

              Expanded(
                flex:3 ,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex:5,
                      child: Image(
                          image: AssetImage(life_image),
                      ),

                    ),
                    Expanded(
                      flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                                child: Text(
                                    gword,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 2,

                                  ),

                                )
                            ),
                          ],
                        )
                    ),
                  ],
                ),
              ),


              Expanded(
                flex: 1,
                child: Text(
                    "HINT: "+ghint.toUpperCase(),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,

                  ),
                ),
              ),


              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children:[
                    Text(
                      game_msg,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),

                    game_over

                        ?ElevatedButton(onPressed: restart, child: Text("Play again"))

                        :Image(
                      image: AssetImage(reaction_image),
                    )

                  ],
                ),
              ),

              Expanded(
                flex: 3,
                  child: Container(
                    padding: EdgeInsets.all(2),
                    margin: EdgeInsets.fromLTRB(2,2,2,2),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                        children:
                          first_row.map((letter) => tobutton(letter)).toList(),
                        ),
                        Row(
                          children:
                          second_row.map((letter) => tobutton(letter)).toList(),
                        ),
                        Row(
                          children:
                          third_row.map((letter) => tobutton(letter)).toList(),
                        ),

                      ],
                    ),
                  )
              )


            ]
          ),
        ) ,
      ),
    );
  }
}


