import 'package:get/get.dart';

class FieldController extends GetxController{
  final RxBool obscureText= false.obs;

  changeObscureState(){
    if(obscureText.value==false){
      obscureText.value=true;
    }else{
      obscureText.value=false;
    }
  }
}