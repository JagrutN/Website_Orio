import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import '../grpc/user.pbgrpc.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  bool useBiometric = false;
  String message = "";

  Future<void> registerUser() async {
    final channel = ClientChannel(
      'localhost',
      port: 50051,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );

    final stub = UserServiceClient(channel);
    try {
      final response = await stub.register(
        RegisterRequest(
          emailOrPhone: _emailController.text,
          otp: "123456",  // Mocked OTP, replace with real OTP handling later
          password: _passwordController.text,
          username: _usernameController.text,
          useBiometric: useBiometric,
        ),
      );
      setState(() {
        message = response.success ? "Registration Successful! Please Login" : response.message;
      });
    } catch (e) {
      setState(() {
        message = "Failed to connect to server";
      });
    }
    await channel.shutdown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _emailController, decoration: InputDecoration(labelText: "Email or Phone")),
            TextField(controller: _usernameController, decoration: InputDecoration(labelText: "Username")),
            TextField(controller: _passwordController, decoration: InputDecoration(labelText: "Password"), obscureText: true),
            Row(
              children: [
                Checkbox(value: useBiometric, onChanged: (bool? value) {
                  setState(() {
                    useBiometric = value!;
                  });
                }),
                Text("Enable Biometric Login")
              ],
            ),
            ElevatedButton(onPressed: registerUser, child: Text("Register")),
            Text(message),
          ],
        ),
      ),
    );
  }
}
