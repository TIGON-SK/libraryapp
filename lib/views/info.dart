import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class Info extends StatefulWidget {
  const Info(Map map, {Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(50),
      child:Column(children: [
        Padding(padding: EdgeInsets.only(top: 16.0),),
        Center(child: Text("Kontakty",style: TextStyle(fontWeight: FontWeight
            .w600,fontSize: 40),),),
        Padding(padding: EdgeInsets.only(top: 30.0),),
        Center(child: Text("Lorem ipsum dolor sit amet, consectetur "
            "adipiscing elit. Quisque libero urna, aliquam in lacinia non, "
            "sollicitudin ornare velit. Praesent hendrerit est aliquam augue "
            "tristique, sit amet iaculis turpis mollis. Morbi luctus erat in vehicula vehicula. Donec id felis elit. Duis convallis lacinia viverra. Nunc sollicitudin finibus erat, ac laoreet velit egestas quis. Proin a imperdiet sem, ut cursus nibh. Sed vitae augue interdum, varius velit a, tincidunt magna.",
          style: TextStyle(fontSize: 17),textAlign: TextAlign.justify,),),
        Padding(padding: EdgeInsets.only(top: 50.0),),
        Container(width: 290,
        child: Column(children: [Row(mainAxisAlignment: MainAxisAlignment.start,children: [Icon(Icons
            .phone,size: 40.0,),SizedBox(width: 50,),Text("0925 688 752",
          style: TextStyle(fontSize: 20),)],),
          Padding(padding: EdgeInsets.only(top: 20.0),),
          Row(mainAxisAlignment: MainAxisAlignment.start,children: [Icon(Icons
              .location_pin,size: 40.0,),SizedBox(width: 50,),Text("nova "
              "lubovna 7",style: TextStyle(fontSize: 20),)],),
          Padding(padding: EdgeInsets.only(top: 20.0),),
          Row(mainAxisAlignment: MainAxisAlignment.start,children: [Icon(Icons
              .email,size: 40.0,),SizedBox(width: 50,),Text("nova@kniznica.com",style: TextStyle(fontSize: 20),)],),
          Padding(padding: EdgeInsets.only(top: 20.0),),
          Row(mainAxisAlignment: MainAxisAlignment.start,children: [Icon(Icons
              .web,size: 40.0,),SizedBox(width: 50,),Text("www.novalubovnak"
              ".sk",style: TextStyle(fontSize: 20),)],),],),),
        SizedBox(height: 30,),
        Center(child:GestureDetector(
          onTap: ()  async {
            String url = 'https://www.pantarhei.sk';
            try {
              await launchUrl(Uri.parse(url));
            } catch (error) {
              showWebToast();
            }
          },
          child: Text.rich(
            TextSpan(
              text: 'Ďakujeme ',
              style: TextStyle(fontSize: 16),
              children: <TextSpan>[
                TextSpan(
                  text: 'Panta Rhei',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color.fromRGBO(0,36,90,1),
                  ),
                ),
                TextSpan(
                  text: ' za povolenie použiť ich náhľadové obrázky v našej aplikácii.',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        )
        )
      ],),
    );
  }
  showWebToast(){
    // return Fluttertoast.showToast(
    //     msg: 'Nepodarilo sa načítať stránku pantarhei.sk',
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Color.fromRGBO(0, 36, 90, 1),
    //     textColor: Colors.white,
    //     fontSize: 16.0
    // );
  }

}
