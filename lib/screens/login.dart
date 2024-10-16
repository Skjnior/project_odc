import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}


dynamic _formKey = GlobalKey<FormBuilderState>();


class _LoginPageState extends State<LoginPage> {


  void Login({required Map data}) async {

    var dioClient = new dio.Dio();

    ProgressDialog dialog = ProgressDialog(context: context);

    dialog.show(
      max: 100,
      msg: "Patientez...",
    );


    try{
      dio.Response response = await dioClient.post(
        "https://reques.in/api/login",
        data: data
      );
      //print(response.statusCode);
      //Get.off(()=> HomePage(());

      dialog.show();

    }


    catch (e)
    {
      //print(e)
      Get.snackbar(
        "Erreur",
        "Email ou mot de passe invalide",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        icon: Icon(
          Icons.error,
        )
      );
    dialog.show();
    }

  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitHeight,
          image: AssetImage(
              "assets/images/fond.jpg"
          ),
        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 68.0, left: 12, right: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding:  EdgeInsets.only(right: 180.0, bottom: 20, top: 50),
                  child:  Text(
                    "Creat Account",
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.cyanAccent
                              ),
                            ),
                ),
          
          
          
               FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                          Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: FormBuilderTextField(
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.email(),
                            ]),
                            style: const TextStyle(
                                color: Colors.cyanAccent
                            ),
                            autofocus: true,
                            cursorColor: Colors.cyanAccent,
                            name: 'email',
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(
                                  color: Colors.cyanAccent
                              ),
                                prefixIcon: Icon(
                                    Icons.email,
                                  size: 24,
                                  color: Colors.cyanAccent,
                                ),
                                hintText: 'Email',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                      style: BorderStyle.solid,
                                    ),
                                ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.cyanAccent,
                                  width: 1
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 1
                                ),
                              ),
                            ),
                          ),
                        ),


                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: FormBuilderTextField(
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.min(6),
                            ]),
                            style: const TextStyle(
                              color: Colors.cyanAccent
                            ),
                            autofocus: true,
                            cursorColor: Colors.cyanAccent,
                            name: 'password',
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(
                                color: Colors.cyanAccent
                              ),
                              prefixIcon: Icon(
                                  Icons.password,
                                size: 24,
                                color: Colors.cyanAccent,
                              ),
                                hintText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 1
                                ),
                              ),
                              // montre le champ
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.cyanAccent,
                                    width: 1
                                ),
                              ),
                             focusedBorder: OutlineInputBorder(
                               borderSide: BorderSide(
                                   color: Colors.white,
                                   width: 1
                               ),
                             ),
          
                            ),
                            obscureText: true,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: Container(
                            width: 250,
                            height: 45,
                            child: ElevatedButton(
                              style:  ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all(Colors.cyanAccent)),
                              onPressed: ()
                              {
                                if(_formKey.currentState!.saveAndValidate()){
                                  ///print(_formKey.text);
                                  print("${_formKey.currentState!.value}");
                                  print("messsage");
                                  // si on utilise un controller
                                  ///print(_emailControlller.text);
                                }

                              },
                              child: const SizedBox(
                                child: Text(
                                    'Sing up',
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    const Padding(
                          padding:  EdgeInsets.all(10.0),
                          child:  Text(
                            '- or -',
                            style: TextStyle(
                                color: Colors.cyanAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                                              ),
                                            ),
                        ),


                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Container(
                        width: 250,
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.cyanAccent,
                          border: Border.all(
                            color: Colors.black54,
                          )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: (){},
                              child: const Text(
                                'Sign up with Google ',
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16
                                ),
                              ),
                            ),
                            const Padding(
                              padding:  EdgeInsets.only(right: 8.0),
                              child:  CircleAvatar(
                                backgroundImage: AssetImage("assets/images/google.png"),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 50,),
                      const Padding(
                        padding:  EdgeInsets.only(top: 38.0),
                        child:  Text(
                            "Already have an account?",
                          style: TextStyle(
                            color: Colors.cyanAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    TextButton(
                        onPressed: (){},
                        child: const Text(
                            "Login",
                          style: TextStyle(
                            color: Colors.cyanAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ))
              ],
            ),
          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
