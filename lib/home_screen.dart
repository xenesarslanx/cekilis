import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class CekilisSayfa extends StatefulWidget {
  const CekilisSayfa({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _CekilisSayfaState createState() => _CekilisSayfaState();
}

class _CekilisSayfaState extends State<CekilisSayfa> {
  late PurchaserInfo purchaserInfo;

   @override
  void initState() {
    initPlatformState();
    super.initState();
  }

  Future<void> initPlatformState() async {
    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup("goog_crqnxpezQItZIohCHKDkXfIpjLU"); //revenue cat id key
    purchaserInfo = await Purchases.getPurchaserInfo();
  }//fHzUrCzMXYGoQawVvkGbcjNyNnlDVdGa eskisi

  /*Future<bool> userIsPremium() async {
    purchaserInfo = await Purchases.getPurchaserInfo();
    return purchaserInfo.entitlements.all["cekilis2"] != null && //google_weekly
        purchaserInfo.entitlements.all["cekilis2"]!.isActive;
  }*/

  Future<void> showPaywall() async {
    Offerings offerings = await Purchases.getOfferings();
    if (offerings.current != null  && offerings.current!.weekly != null
    ) {
      final currentWeeklyProduct = offerings.current!.weekly!.product;
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text(currentWeeklyProduct.description),
                content: Row(
                  children: [
                    Text('Fiyat '+ currentWeeklyProduct.priceString)
                    ],
                ),
                actions: [
                  ElevatedButton(
                      onPressed: () async {
                        await makePurchases(offerings.current!.weekly!);
                      },
                      child: Text('Satın Al'))
                ],
              ));
    }
  }

  Future<void> makePurchases(Package package) async {
    try {
      purchaserInfo = await Purchases.purchasePackage(package);
      //Text('Satın alma başarılı');
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        Text(e.message!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.lightGreen,
        ),
        body: Container(
           decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("lib/assets/konfeti.jpg"),
              fit: BoxFit.cover,
            ),
              ),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children:[        
               cekilis_buton(Text ('1'), Colors.red,),
               cekilis_buton(Text ('2'), Colors.blue,),
               cekilis_buton(Text ('3'), Colors.green,),
               cekilis_buton(Text ('4'), Colors.lime,),
               cekilis_buton(Text ('5'), Colors.purple,),
               cekilis_buton(Text ('6'), Colors.grey,),
               cekilis_buton(Text ('7'), Colors.brown,),
               cekilis_buton(Text ('8'), Colors.cyan,),
               cekilis_buton(Text ('9'), Colors.indigoAccent,),
               cekilis_buton(Text ('10'), Colors.teal,),
               cekilis_buton(Text ('11'), Colors.deepOrangeAccent,),
               cekilis_buton(Text ('12'), Colors.lightBlueAccent,),
               cekilis_buton(Text ('13'), Colors.red,),
               cekilis_buton(Text ('14'), Colors.blue,),
               cekilis_buton(Text ('15'), Colors.green,),
               cekilis_buton(Text ('16'), Colors.lime,),
               cekilis_buton(Text ('17'), Colors.cyan,),
               cekilis_buton(Text ('18'), Colors.indigoAccent,),
               cekilis_buton(Text ('19'), Colors.teal,),
               cekilis_buton(Text ('20'), Colors.deepOrangeAccent,),
               cekilis_buton(Text ('21'), Colors.red,),
               cekilis_buton(Text ('22'), Colors.blue,),
               cekilis_buton(Text ('23'), Colors.green,),
               cekilis_buton(Text ('24'), Colors.lime,),
               cekilis_buton(Text ('25'), Colors.purple,),
               cekilis_buton(Text ('26'), Colors.grey,),
               cekilis_buton(Text ('27'), Colors.brown,),
               cekilis_buton(Text ('28'), Colors.cyan,),
               cekilis_buton(Text ('29'), Colors.indigoAccent,),
               cekilis_buton(Text ('30'), Colors.teal,),
               cekilis_buton(Text ('31'), Colors.deepOrangeAccent,),
               cekilis_buton(Text ('32'), Colors.lightBlueAccent,),
               cekilis_buton(Text ('33'), Colors.red,),
               cekilis_buton(Text ('34'), Colors.blue,),
               cekilis_buton(Text ('35'), Colors.green,),
                ],
                
              ),
              
            ),
          ),
        ),
      ),
    );
  }

  Padding cekilis_buton(Text text, Color color ) {
    return Padding(
   padding: const EdgeInsets.all(10.0),
   child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  primary: color,
                  fixedSize: const Size(100, 60),
                  ),
              onPressed: () {
                showPaywall();       
              },
               label: text,
               icon: Icon(Icons.card_giftcard),
           ),
          );
         } 
        }
