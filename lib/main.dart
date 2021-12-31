import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'home_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
 void main()  {
  WidgetsFlutterBinding.ensureInitialized();
   MobileAds.instance.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
       home: AnimatedSplashScreen(
          splash: 'lib/assets/logoEApp2.png',
          nextScreen:MyHomePage(),
          splashTransition: SplashTransition.scaleTransition,
          backgroundColor: Colors.blue
        ),
      );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, }) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BannerAd? bannerAd;
  bool isLoaded=false;
  
  late InterstitialAd _interstitialAd;
  bool _isInterstitialAdReady = false;

 @override
  void initState(){
  super.initState();
  
    fToast = FToast();
    fToast.init(context);
   InterstitialAd.load(
       adUnitId: "ca-app-pub-5417429060364094/1694416586",//real id:ca-app-pub-5417429060364094/1694416586
        request: const AdRequest(),
         adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad){
           this._interstitialAd = ad;
           _isInterstitialAdReady = true;
         },
          onAdFailedToLoad:(error){
          print('failed geçiş reklamı');
          }
         ));}
 
@override
  void dispose() {
    super.dispose();
    _interstitialAd.dispose();
  }

  @override
  didChangeDependencies(){
  super.didChangeDependencies();

  bannerAd=BannerAd(
  size: AdSize.banner,
  adUnitId:'ca-app-pub-5417429060364094/5966518293',//real id: ca-app-pub-5417429060364094/5966518293
  listener: BannerAdListener(
      onAdLoaded: (ad){
        setState(() {
          isLoaded=true;
        });
        print("banner added");
      },
      onAdFailedToLoad: (ad, error){
        ad.dispose();
        print("hata:$error");
      }
    ),
     request: AdRequest(),
     );
     bannerAd!.load();     
}

 double sizedboxheight=50;
  late FToast fToast;
 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: Center(child: Text('Çek Kazan Ana Sayfa')) ,
        ),
        body: Container(
          decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage("lib/assets/konfeti.jpg"),
              fit: BoxFit.cover,

            ),
              ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 70, 20, 60),
            child: Center(
              child: Column(
                 children: <Widget>[

                  ElevatedButton.icon(             //çekiliş nedir?
                    style: ElevatedButton.styleFrom(
      primary: Colors.greenAccent,
      shadowColor: Colors.lime[200],   
       fixedSize: const Size(240, 60),  
      ),
        onPressed: () => showToast(context, Text('Çek Kazan:Çekilişe Katıl Nedir?\n\n Her hafta çekilişe katılabileceğiniz ve haftanın sonunda kazananı instagram adresimizden'
'(cekkazan.8) açıklayıp para ödülü dağıttığımız bir uygulamadır.\n\n Para ödülü katılımcı sayısıyla doğru orantılı olup gelirin bir kısmını da ihtiyaç sahiplerine nakit para veya market hediye çekleriyle bağışlıyoruz!\n\n Hemen Çekilişe katılmak için Çekilişe Katıl butonuna tıkla ve kazanan sen ol!')),
        label: Text('Çekiliş Nedir?'),
        icon: Icon(Icons.help_center)),
SizedBox(height: sizedboxheight,),

 ElevatedButton.icon(                           //çekiliş
      style: ElevatedButton.styleFrom(
      primary: Colors.purple,
      shadowColor: Colors.lime[200],  
       fixedSize: const Size(240, 60)    

      ),
       onPressed: () {Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => CekilisSayfa(title: 'Çekilişe Katıl!',)),);
                        setState(() {
                        _interstitialAd.show();
                          
                        });},
              icon: Icon(Icons.card_giftcard),
              label: Text('Çekilişe Katıl!'),),
                     
SizedBox(height: sizedboxheight,),

ElevatedButton.icon(                           //iletişim
      style: ElevatedButton.styleFrom(
      primary: Colors.lightBlue,
      shadowColor: Colors.lime[200],  
       fixedSize: const Size(240, 60)    
      ),
       onPressed:  () => showToast(context,Text('İnstagram: cekkazan.8\n\n Email: guvendikel8@gmail.com'),),
              icon: Icon(Icons.phone),
              label: Text('İletişim'),), 
                Spacer(),//banner reklam gösterme
                isLoaded
             ?  SizedBox(
               height: 50,
               child:AdWidget(ad: bannerAd!),
               ):const SizedBox(),   
                 ],
                 
                ),
            ),
          ),
        ),
        ),
      );
  }
}
     //toast mesaj
     showToast(BuildContext context, Text text) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: text,
        action: SnackBarAction(label: 'Ok', onPressed: scaffold.hideCurrentSnackBar),
        duration: Duration(seconds: 10),      
      ),
    );
  }