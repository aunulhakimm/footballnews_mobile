import 'package:flutter/material.dart';
import 'package:footballnews_mobile/app/modules/signin/controllers/signin_controller.dart';
import 'package:get/get.dart';

class SigninView extends StatelessWidget {
  final SigninController controller = Get.put(SigninController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [const Color.fromARGB(255, 8, 39, 86), Color.fromARGB(255, 17, 72, 117)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),
                _buildTextField(
                  controller: emailController,
                  hintText: 'Email',
                  icon: Icons.email,
                ),
                SizedBox(height: 10),
                _buildTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  icon: Icons.lock,
                  obscureText: true,
                ),
                SizedBox(height: 20),
                Obx(() => controller.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 0, 239, 64),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        onPressed: () {
                          // Validasi input field
                          if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                            Get.snackbar('Error', 'All fields are required',
                                backgroundColor: Colors.red, colorText: Colors.white);
                            return;
                          }

                          // Jika validasi lolos, lakukan proses signin
                          controller.signin(
                            emailController.text,
                            passwordController.text,
                          );
                        },

                          child: Text(
                            'Login',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                      )),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Get.toNamed('/signup'); // Arahkan ke halaman Sign Up
                  },
                  child: Text(
                    'Don’t have an account? Register',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        prefixIcon: Icon(icon, color: Colors.blue),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      style: TextStyle(color: Colors.black),
    );
  }
}
