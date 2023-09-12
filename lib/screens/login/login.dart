import 'package:shop_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/SharedWidget.dart';
import 'package:shop_app/screens/register/register.dart';
import 'package:shop_app/shared/styles/constColors.dart';
import 'package:shop_app/homeLayout/shopLayout(home).dart';
import 'package:shop_app/screens/login/cubit/loginCubit.dart';
import 'package:shop_app/screens/login/cubit/loginState.dart';
import 'package:shop_app/shared/network/local/sharedPref.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class Login extends StatelessWidget {
  const Login({super.key});
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formstate = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          //  print(CachHelper.getdata(key: 'token',));
          // TODO: implement listener
          if (state is LoginSuccessgState) {
            if (state.model?.status == true) {
              //status true success go to home
              // print("state is succc");
              // print(state.model?.message);
              print(state.model?.data!.token);
              CachHelper.Savedata(key: 'token', value: state.model?.data!.token)
                  .then((value) {
                    token= state.model?.data!.token;
                print(CachHelper.getdata(key: 'token'));
              });
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: baseColor,
                  content: Text(
                    state.model!.message.toString(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  )));
              navigateToScreen(context, ShopLayout());
            } else {
              //error + alert toast
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  backgroundColor: Colors.red[900],
                  content: Text(
                    state.model!.message.toString(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  )));
            }
          }
        },
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              ),
              body: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formstate,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        Text("LOGIN",
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(color: Colors.black)),
                        Text("log in now to brows our hot offers",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: Colors.grey)),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              hintText: "Email",
                              hintStyle: const TextStyle(fontSize: 20),
                              prefixIcon: Icon(Icons.email_outlined, size: 25),
                            ),
                            validator: (String? value) =>
                                validation(value, "Please enter your email")),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          obscureText: LoginCubit.get(context).isvisiable,
                          controller: passwordController,
                          validator: (String? value) =>
                              validation(value, "Please enter your password"),
                          decoration: InputDecoration(
                              filled: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              hintText: "Password",
                              hintStyle: const TextStyle(fontSize: 20),
                              prefixIcon: Icon(Icons.lock, size: 25),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  LoginCubit.get(context)
                                      .ChangeVisiablityIcon();
                                },
                                icon: Icon(LoginCubit.get(context).icon,
                                    size: 25),
                              )),
                          onFieldSubmitted: (value) {
                            cubit.userlogin(
                              email: emailController
                                  .text, // Get the text value from the controller
                              password: passwordController
                                  .text, // Get the text value from the controller
                            );
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator()),
                          builder: (BuildContext context) {
                            return Container(
                              height: 50,
                              width: 450,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: baseColor),
                                onPressed: () {
                                  // Validate the form
                                  if (formstate.currentState!.validate()) {}
                                  cubit.userlogin(
                                    email: emailController
                                        .text, // Get the text value from the controller
                                    password: passwordController
                                        .text, // Get the text value from the controller
                                  );
                                  print(emailController.text +
                                      passwordController.text);
                                },
                                child: const Text('LOGIN'),
                              ),
                            );
                          },
                          condition: state is! LoginLoadingState,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(60, 20, 0, 0),
                          child: Row(
                            children: [
                              const Text(
                                "Don't have account  ",
                                style: TextStyle(fontSize: 18),
                              ),
                              InkWell(
                                onTap: () {
                                  CachHelper.removeKey(key: 'token')
                                      .then((value) {
                                    navigateToScreen(context, RegisterScreen());
                                  });
                                },
                                child: Text(
                                  "register",
                                  style:
                                      TextStyle(fontSize: 20, color: baseColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}

validation(String? value, String AlertTxet) {
  if (value == null || value.isEmpty) {
    return AlertTxet;
  } else
    return null;
}
