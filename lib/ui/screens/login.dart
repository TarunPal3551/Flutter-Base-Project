import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kmerchant/controllers/login_controller.dart';
import 'package:kmerchant/mainhome.dart';
import 'package:kmerchant/theme.dart';
import 'package:kmerchant/ui/components/custom_containers.dart';
import 'package:kmerchant/ui/components/loading_dialog.dart';
import 'package:kmerchant/ui/components/my_textfields.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'login_screen';
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  LoginController controller = LoginController();

  final _emailController = TextEditingController(text: "merchant");
  final _passController = TextEditingController(text: "merchant");

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(10),
              physics: BouncingScrollPhysics(),
              children: [
                Container(
                    height: 100,
                    margin: EdgeInsets.all(10),
                    child: Image.asset("assets/images/logo.png")),
                MyTextField(
                  controller: _emailController,
                  labelText: "Username",
                  margin: EdgeInsets.all(10),
                  prefixIcon: SizedBox(
                    child: Icon(Icons.account_circle),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (String value) {
                    if (value == null || value.trim() == "")
                      return "Please enter an username";
                  },
                ),
                MyTextField(
                  controller: _emailController,
                  labelText: "Password",
                  isPasswordField: true,
                  margin: EdgeInsets.all(10),
                  prefixIcon: SizedBox(
                    child: Icon(Icons.account_circle),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (String value) {
                    if (value == null || value.trim() == "")
                      return "Please enter an password";
                    else if (value.length < 6)
                      return "Please enter a valid password";
                  },
                ),
                CustomContainer(
                  height: 50,
                  backgroundColor: kAccentColor,
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Center(
                    child: Text(
                      "Log in",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  onTap: () {
                    login();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void login() {
    Get.dialog(LoadingDialog(), barrierDismissible: false);
    controller
        .login(_emailController.text, _passController.text)
        .then((value) async {
      if (value) {
        if (Get.isDialogOpen) Get.back();
        Get.snackbar("Login Success", "Login successful",
            backgroundColor: Colors.green[700],
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            margin: EdgeInsets.fromLTRB(20, 20, 20, 20));
        //Get.offAndToNamed(MyHomePage.id);

        Get.offAll(MainHome());
      } else {
        if (Get.isDialogOpen) Get.back();
        Get.snackbar(
            "Login Failed", "Incorrect username and password combination",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            margin: EdgeInsets.fromLTRB(20, 20, 20, 20));
      }
    });
  }
}
