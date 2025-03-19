import 'package:flutter/material.dart';
import 'package:grpc/grpc_web.dart';
import '../grpc/user.pbgrpc.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String message = "";

  Future<void> loginUser() async {
    final channel = GrpcWebClientChannel.xhr(
    Uri.parse("http://localhost:50051"), // Ensure your gRPC server runs on 8080
  );

    final stub = UserServiceClient(channel);
    try {
      print("Sending Login Request to gRPC server...");
      final response = await stub.login(
        LoginRequest(
          emailOrPhone: _emailController.text,
          password: _passwordController.text,
          useBiometric: false,
        ),
      );
      print("Response received: ${response.message}");
      setState(() {
        message = response.success ? "Welcome ${response.username}" : response.message;
      });
    } catch (e) {
      print("Failed to connect: $e"); // Print error message
      setState(() {
        message = "Failed to connect to server";
      });
    }
    await channel.shutdown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _emailController, decoration: InputDecoration(labelText: "Email or Phone")),
            TextField(controller: _passwordController, decoration: InputDecoration(labelText: "Password"), obscureText: true),
            ElevatedButton(onPressed: loginUser, child: Text("Login")),
            Text(message),
          ],
        ),
      ),
    );
  }
}
