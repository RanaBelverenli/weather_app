import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  String selectedCity = '';

    
  /*void birFonksiyon(){
    print('bir fonksiyon çalıştı');
  }

    @override
  void initState() {
     gps verisi çekme,request istek...
    print("initstate metodu çalıştı ve gps verisi isteniyor.");
    super.initState();
  }

    @override
  void dispose() {
     sayfa kaldırılırken run edilecek metotlar
    print("dispose metodu çalıştı ve logout istendi.");
    super.dispose();
  }*/


  
  @override
  Widget build(BuildContext context) {
    
  final String key = 'b7e858e8f208308427e3567a1b9f9ca6';

    return Container(
      
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/aramasayfasi.jpg'),
          fit: BoxFit.cover,
          ),
        ),
        child:  Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            ),
          body:  Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding( 
                padding:const EdgeInsets.symmetric(horizontal:50.0),
                child: TextField(
                  onChanged: (value) {

                    selectedCity = value;
                    print("textfield daki değer: &value ");
                  },
                  decoration: const InputDecoration(hintText: 'şehir seçiniz', border: OutlineInputBorder(borderSide: BorderSide.none)),
                  style: const TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                )
                    ),
                    ElevatedButton(onPressed: () async {
                    /// bu şehir için api yanıt veriyor mu? 
                    http.Response response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$selectedCity&appid=$key&units=metric'));

                    if(response.statusCode==200){
                      Navigator.pop(context, selectedCity);
                      }else{
                        ///kullanıcıya uyarı ver ve sayfada kal 
                        ///alert diolog göster
                        
                        _showMyDialog();
                        
                        
                      }


                      
                    }, child: const Text('Select City'))
          ]
          )
       ), 
       
      ));
  }

  Future<void> _showMyDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('location not found'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('please enter a valid location'),
              
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

}




