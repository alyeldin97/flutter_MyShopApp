import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/layout_screen.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/cubit/cubit/log_in_cubit.dart';
import 'package:shop_app/shared/cubit/states/log_in_states.dart';
import 'package:shop_app/models/components.dart';
import 'package:shop_app/shared/network/shared_preferneces.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, Loginstates>(
          listener: (context, state) {
            if(state is LoginSuccesstate){
              if(state.loginModel.status){
                  CacheHelper.saveData(key: 'token',value: state.loginModel.data.token
    ).then((value) {
                    print('success');
                    navigateandFinish(context, LayOutScreen());
                  });
              }else{

                showToast(message: state.loginModel.message,color: Colors.red);

              }
            }
          },
          builder: (context, state) {
            var cubit = LoginCubit.get(context);
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'log in now to browse our hot offers',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.grey),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                        type: TextInputType.emailAddress,
                        controller: emailController,
                        validate: (String value) {
                          if (value.isEmpty)
                            {return 'Please Enter Your Email Address';}
                        },
                        icon: Icon(Icons.email),
                        title: 'E-mail Address',
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      defaultFormField(
                        suffix: IconButton(
                          icon: Icon(cubit.suffix),
                          onPressed: () {
                            cubit.changePasswordVisibility();
                          },
                        ),
                        type: TextInputType.visiblePassword,
                        controller: passwordController,
                        validate: (String value) {
                          if (value.isEmpty) {return 'Password is too short';}
                        },
                        isPassword:cubit.isPassword,
                        icon: Icon(Icons.lock),
                        title: 'Password',
                        onSubmit: (value){
                          if(formKey.currentState.validate())
                          {cubit.userLogin(email: emailController.text, password: passwordController.text);}
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ConditionalBuilder(
                        builder:(context)=> Container(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  if(formKey.currentState.validate())
                                  {cubit.userLogin(email: emailController.text, password: passwordController.text);}
                                }, child: Text('LOGIN'))),
                        fallback:(context)=> Center(child: CircularProgressIndicator(),),
                        condition: state is! LoginLoadingstate,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account?",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              navigateTo(context, RegisterScreen());
                            },
                            child: Text('REGISTER HERE'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
