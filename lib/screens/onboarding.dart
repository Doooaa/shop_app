import 'package:flutter/material.dart';
import 'package:shop_app/screens/login/login.dart';
import 'package:shop_app/shared/SharedWidget.dart';
import 'package:shop_app/shared/styles/constColors.dart';
import 'package:shop_app/shared/network/local/sharedPref.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// ignore_for_file: non_constant_identifier_names

class BoardingModel {
  Widget? image;
  String? title;
  String? discribtion;
  BoardingModel({this.image, this.title, this.discribtion});
}

List<BoardingModel> onboardingListItems = [
  BoardingModel(
      image:const Image(
        image: AssetImage('assets/images/onboarding1.png'),
      ),
      title: 'Welcome to ShopEase',
      discribtion:
          'Discover a world of convenience at your fingertips. Shop for the latest trends, exclusive deals, and more. Join millions of shoppers and experience the future of shopping with ShopEase.'),
  BoardingModel(
      image: Image(
        image: AssetImage(
            'assets/images/search-bar.png'),width: 200,height: 200,
      ),
      title: 'Explore Trendy Collections',
      discribtion: ' Dive into a vast collection of fashion, electronics, home decor, and more. Explore curated collections tailored to your preferences. Stay in style and up-to-date with the latest trends.'),
  BoardingModel(
      image: Image(
        image: AssetImage(
            'assets/images/delivery-truck.gif',),width: 300,height: 200,
      ),
      title: 'Easy Checkout & Fast Delivery',
      discribtion: 'Shop with confidence! Our seamless checkout process makes buying a breeze. Enjoy lightning-fast deliveries right to your doorstep. Experience hassle-free shopping like never before.'),
];
var BoardingController = PageController();
bool isend = false;
subimtToshared(context) {
  CachHelper.Savedata(key: 'onBoarding', value: true).then((value) {
    if (value) navigateandFinish(context, Login());
  }).catchError((e) {
    print(e.toString());
  });
}

class BoardingScreen extends StatefulWidget {
  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        //delete the background
        backgroundColor: Colors.white,
        elevation: 0.0,
        actions: [
          TextButton(
              onPressed: () {
                //save clicked skip {from boarding} ✅
                subimtToshared(context);
              },
              child: const Text(
                'SKIP',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ))
        ],
      ),
      body: Container(
      color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            
            children: [
              Expanded(
                child: PageView.builder(
                  allowImplicitScrolling:true ,
                  physics: const BouncingScrollPhysics(),
                  controller: BoardingController,
                  itemBuilder: (context, index) =>
                      BoardingItems(onboardingListItems[index]),
                  itemCount: 3,
                  onPageChanged: (value) {
                    if (onboardingListItems.length - 1 == value) {
                      setState(() {
                        isend = true;
                      });
                    } else {
                      setState(() {
                        isend = false;
                      });
                    }
                  },
                ),
              ),
            
              Row(
                children: [
                  SmoothPageIndicator(
                      controller: BoardingController,
                      effect: ExpandingDotsEffect(
                        spacing: 12,
                        activeDotColor: baseColor,
                        expansionFactor: 4.0,
                        dotHeight: 12,
                        dotWidth: 12,
                      ),
                      count: onboardingListItems.length),
                  const Spacer(),
                  FloatingActionButton(
                    backgroundColor: baseColor,
                    shape: const CircleBorder(eccentricity: 1),
                    onPressed: () {
                      if (!isend) {
                        BoardingController.nextPage(
                            duration: const Duration(
                              milliseconds: 800,
                            ),
                            curve: Curves.decelerate);
                      } else {
                        //go to login & save to pref ✅
                        subimtToshared(context);
                      }
                    },
                    child: const Icon(Icons.arrow_forward_ios_sharp,color: Colors.white,),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget BoardingItems(BoardingModel Model) {
  return Column(
    children: [
    
       SizedBox(height: 10,),
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Model.image,
      ),
      const SizedBox(
        height: 5,
      ),
      Text(
        Model.title.toString(),
        //  onboardingListItems[index]('title'),
        style:  TextStyle(fontSize: 25, fontWeight: FontWeight.w700,color: baseColor),
      ),
      const SizedBox(
        height: 20,
      ),
      Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
      
          Model.discribtion.toString(),
          style: const TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 87, 86, 84),
              fontWeight: FontWeight.w500),textAlign: TextAlign.start,
        ),
      ),
      const Spacer(
        flex: 2,
      ),
    ],
  );
}
