import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
    void birFonksiyon(){
      print('bir fonksiyon çalıştı');
    }


    @override
  void initState() {
    // gps verisi çekme,request istek...
    print("initstate metodu çalıştı ve gps verisi isteniyor.");
    super.initState();
  }



  @override
  void dispose() {
    // sayfa kaldırılırken run edilecek metotlar
    print("dispose metodu çalıştı ve logout istendi.");
    super.dispose();
  }


  
  @override
  Widget build(BuildContext context) {
    print("build run");
    birFonksiyon();

    return Container(
      
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/aramasayfasi.jpg'),
          fit: BoxFit.cover,
          ),
        ),
        child:  Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: (){
            setState(() {
              //print("bu buton çalıştı.");
              print("setstate run");
            });
          }),
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            ),
          body: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                padding: EdgeInsets.symmetric(horizontal:50.0),
                child: TextField(
                  decoration: InputDecoration(hintText: 'şehir seçiniz', border: OutlineInputBorder(borderSide: BorderSide.none)),
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                )
                    ),
          ]
          )
       ), 
       
      ));
  }
}




