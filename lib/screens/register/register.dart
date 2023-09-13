import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/homeLayout/shopLayout(home).dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/shared/cubit/ShopCubit.dart';
import 'package:shop_app/shared/cubit/ShopState.dart';
import 'package:shop_app/shared/network/local/sharedPref.dart';
import 'package:shop_app/shared/styles/constColors.dart';

import '../widgets/snack_bar_widgets.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneContriller = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<shopCubit, shopState>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          if (state.model!.status == false) {
            showSnackBar(
              context,
              message: state.model!.message.toString(),
              snackColor: const Color(0xFFB71C1C),
            );
          } else {
            showSnackBar(
              context,
              message: state.model!.message.toString(),
              snackColor: baseColor,
            );
            CachHelper.Savedata(key: 'token', value: state.model?.data!.token)
                .then(
              (value) {
                token = state.model?.data!.token;
                print('from register token value is :$value');
                print('from register token from model is :$token');
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShopLayout(),
                  ),
                  (route) => false,
                );
                // navigateToScreen(context, const ShopLayout());
              },
            );
          }
        }
      },
      builder: (context, state) {
        shopCubit cubit = shopCubit.get(context);
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
                        height: 10,
                      ),
                      Text("REGITER",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: Colors.black)),
                      Text("register now to brows our hot offers",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(color: Colors.grey)),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                          controller: nameController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            hintText: "name",
                            hintStyle: const TextStyle(fontSize: 20),
                            prefixIcon: const Icon(Icons.person, size: 25),
                          ),
                          validator: (String? value) =>
                              validation(value, "Please enter your name")),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                          controller: phoneContriller,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            hintText: "phone",
                            hintStyle: const TextStyle(fontSize: 20),
                            prefixIcon: const Icon(Icons.phone, size: 25),
                          ),
                          validator: (String? value) =>
                              validation(value, "Please enter your phone")),
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
                            prefixIcon:
                                const Icon(Icons.email_outlined, size: 25),
                          ),
                          validator: (String? value) =>
                              validation(value, "Please enter your email")),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        obscureText: cubit.isvisiable,
                        controller: passwordController,
                        validator: (String? value) =>
                            validation(value, "Please enter your password"),
                        decoration: InputDecoration(
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            hintText: "Password",
                            hintStyle: const TextStyle(fontSize: 20),
                            prefixIcon: const Icon(Icons.lock, size: 25),
                            suffixIcon: IconButton(
                              onPressed: () {
                                cubit.ChangeVisiablityIcon();
                              },
                              icon: Icon(shopCubit.get(context).icon, size: 25),
                            )),
                        onFieldSubmitted: (value) {
                          // cubit.postRegiserData(null,
                          //     name: nameController.text,
                          //     phone: phoneContriller.text,
                          //     email: emailController.text,
                          //     password: passwordController.text);
                        },
                      ),
                      const SizedBox(height: 20),
                      ConditionalBuilder(
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator()),
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: 50,
                            width: 450,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: baseColor),
                              onPressed: () {
                                // Validate the form
                                if (formstate.currentState!.validate()) {}
                                cubit.postRegiserData(
                                  "",
                                  name: nameController.text,
                                  phone: phoneContriller.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                                print(emailController.text +
                                    passwordController.text);
                              },
                              child: const Text('REGISTER'),
                            ),
                          );
                        },
                        condition: state is! RegisterLoadingState,
                      ),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}

validation(String? value, String AlertTxet) {
  if (value == null || value.isEmpty) {
    return AlertTxet;
  } else {
    return null;
  }
}
