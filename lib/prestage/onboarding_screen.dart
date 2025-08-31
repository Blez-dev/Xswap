import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Xswap/controllers/auth_controller.dart';
import 'package:Xswap/prestage/login.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {




  final List<OnboardingItem> _items = [
    OnboardingItem(
      image: "assets/images/intro_pic.png",
      description:
          "Swap cryptocurrencies instantly without delays. fast and easy.",
      title: "Instant Crypto Swaps",
    ),

    OnboardingItem(
      image: "assets/images/intro_pic2.png",
      description: "Maximize your crypto value every time you trade",
      title: "Best Exchange Rates",
    ),

    OnboardingItem(
      image: "assets/images/intro_pic3.png",
      description:
          "Built with top-grade security practices and constant monitoring",
      title: "Secure & Reliable",
    ),
  ];
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],

      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: _items.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },

              itemBuilder: (context,index){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    const SizedBox(height: 80),
                    Image.asset(
                      _items[index].image,
                      height: MediaQuery.of(context).size.height*0.3,
                    ),

                    Text(
                      _items[index].title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        _items[index].description,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey[700]
                        ),
                      ),

                    )
                  ],

                );

              },
            ),

            Positioned(
              bottom: 180,
              left: 0,
              right: 0,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _items.length,
                    (index)=>AnimatedContainer(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: _currentPage==index? 24:8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: _currentPage==index? Colors.black:Colors.grey.shade200
                        ),
                        duration: Duration(milliseconds: 100))
                ),
              ),
            ),

            Positioned(
              bottom: 30,
                left: 240,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(onPressed: (){
                      if(_currentPage<_items.length-1){
                        _controller.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                      }else{
                        AuthController.authController.setFirstTimeDone();
                        _getStarted();
                      }

                    },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black
                      ),


                        child: Text(
                          _currentPage<_items.length-1?"Next Page":"Get Started",

                        ),
                    )
                  ],
                )

            )
          ],
        ),
      ),
    );
  }

  void _getStarted() {
    Get.offAll(()=>Login());
  }
}

class OnboardingItem {
  final String image;
  final String description;
  final String title;

  OnboardingItem({
    required this.image,
    required this.description,
    required this.title,
  });
}
