import 'package:flutter/material.dart';

ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.red,
      titleTextStyle: TextStyle(
        color: Colors.white,
      ),
    ),
    textTheme: const TextTheme(
      headline5: TextStyle(
        color: Colors.black,
        fontFamily: "OpenSans",
     
      ),
      headline2: TextStyle(
        color: Colors.black,
      ),
      bodyText1: TextStyle(color: Colors.black, fontFamily: "OpenSans"),
      bodyText2: TextStyle(color: Colors.black),
      subtitle1: TextStyle(
        color: Colors.black,
        fontFamily: "OpenSans",
 
      ),
      subtitle2: TextStyle(color: Colors.yellow),
      caption: TextStyle(
        color: Colors.black,
        fontFamily: "OpenSans",
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
         enabledBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueAccent,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      
                    ),
                  
                    focusedBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blueAccent,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  
                    ),
          
                     errorBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  
                    ),
                    focusedErrorBorder:  OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  
                    ),

                   
    ),
  );

}
