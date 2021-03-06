import 'package:blue_medical_clinic/modules/user.type.screens/doctor_screens/doctor_login_screen/cubit/cubit.dart';
import 'package:blue_medical_clinic/modules/user.type.screens/hr.screens/login.screen/cubit/cubit.dart';
import 'package:blue_medical_clinic/modules/user.type.screens/hr.screens/login.screen/cubit/states.dart';
import 'package:blue_medical_clinic/modules/user.type.screens/patient_screens/home_screen/home_screen.dart';
import 'package:blue_medical_clinic/modules/user.type.screens/patient_screens/login_screen/input_files/header.dart';
import 'package:blue_medical_clinic/shared/components/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DoctorLoginScreen extends StatelessWidget {
  DoctorLoginScreen({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginDoctorCubit(),
      child: BlocConsumer<HrLoginCubit, HrLoginStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          var cubit = HrLoginCubit.get(context);
          return Scaffold(
            body: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, colors: [
                  Color(0xff93f0fc),
                  Color(0xAAf3e5f5),
                ]),
              ),
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 50),
                    const Header(),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: <Widget>[
                                const SizedBox(height: 40),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]!)),
                                        ),
                                        child: defaultTextFormField(
                                          isPassword: false,
                                          keyBoardType:
                                          TextInputType.emailAddress,
                                          validate: (value) {
                                            if (value!.isEmpty) {
                                              return 'Empty Field , please enter your email';
                                            } else if (!value
                                                .contains('@gmail.com')) {
                                              return 'Invalid Email , please Enter a valid email';
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: emailController,
                                          prefixIcon: Icons.alternate_email,
                                          textInputAction: TextInputAction.next,
                                          label: 'Doctor E-mail',
                                          hint: 'HrMail@gmail.com',
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[200]!)),
                                        ),
                                        child: defaultTextFormField(
                                          isPassword: cubit.showPassword,
                                          keyBoardType:
                                          TextInputType.visiblePassword,
                                          validate: (value) {
                                            if (value!.isEmpty) {
                                              return 'Empty Field , please enter your password';
                                            } else if (value.length < 6) {
                                              return 'Too short, password should be more than 6 ';
                                            } else if (value.length > 16) {
                                              return 'Too long, password should be less than 6 ';
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: passwordController,
                                          prefixIcon: Icons.lock,
                                          suffixIcon: cubit.suffixIcon,
                                          suffixIconFun: () {
                                            cubit.changePasswordVisibility();
                                          },
                                          textInputAction: TextInputAction.done,
                                          label: 'Hr Password',
                                          hint: '********',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                                ConditionalBuilder(
                                    builder: (BuildContext context) =>
                                        defaultMaterialButton(
                                            buttonText: 'LOGIN',
                                            function: () {
                                              if (formKey.currentState!
                                                  .validate()) {
                                                navigateAndFinish(
                                                    const PatientHomeScreen(),
                                                    context);
                                              }
                                            }),
                                    condition:
                                    state is! HrLoginLoadingStates,
                                    fallback: (BuildContext context) =>
                                        SpinKitWave(
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return DecoratedBox(
                                              decoration: BoxDecoration(
                                                color: index.isEven
                                                    ? const Color(0xff93f0fc)
                                                    : const Color(0xAAf3e5f5),
                                              ),
                                            );
                                          },
                                        )),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
