import 'package:flutter/material.dart';
import 'package:patient_management_app/data/api/api.dart';
import 'package:patient_management_app/screen/patient_detail/patient_detail_screen.dart';
import 'package:patient_management_app/widget/custom_button.dart';
import 'package:patient_management_app/widget/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          height: height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(children: [
                Container(
                  height: height / 3.2,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(
                            "assets/image/login.png",
                          ),
                          alignment: Alignment.topCenter)),
                ),
                Positioned(
                    top: 100,
                    left: 130,
                    child: Container(
                        height: 75,
                        width: 75,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage(
                            "assets/image/logo.png",
                          ),
                        ))))
              ]),
              const _LoginDetails()
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginDetails extends StatefulWidget {
  const _LoginDetails({Key? key}) : super(key: key);

  @override
  State<_LoginDetails> createState() => _LoginDetailsState();
}

class _LoginDetailsState extends State<_LoginDetails> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoad = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
      child: Form(
        key: _formKey,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                "Login Or Register To Book\nYour Appointments",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 30.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      " Email",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 65,
                      child: CustomTextFormField(
                        filled: true,
                        controller: emailController,
                        hintText: "Enter your email",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is required";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      " Password",
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 65,
                      child: CustomTextFormField(
                        filled: true,
                        hintText: "Enter your password",
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomButton(
                      child: isLoad
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              "Login",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                            ),
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoad = true;
                          });
                          final result = await Api().postLogin(
                              emailController.text.trim().toString(),
                              passwordController.text.trim().toString());
                          if (result) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const PatientDetailScreen();
                            }));
                          }
                          setState(() {
                            isLoad = false;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                "Bye creating or logging into an account you are agreeing",
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.normal, fontSize: 12),
              ),
              Row(
                children: [
                  Text(
                    "       with our ",
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.normal, fontSize: 12),
                  ),
                  Text(
                    "Terms and Condition",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                        color: Colors.blue),
                  ),
                  Text(
                    " and ",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                        ),
                  ),
                  Text("Privacy Policy",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                          color: Colors.blue)),
                ],
              )
            ]),
      ),
    );
  }
}
