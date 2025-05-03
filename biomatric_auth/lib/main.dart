import 'package:biomatric_auth/Home.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isAuthencated = false;

  final LocalAuthentication auth = LocalAuthentication();
  String _message = "Not Authenticated";

  Future<void> _authenticate() async {
    try {
        bool canCheckBiometrics=await auth.canCheckBiometrics; //check biomatric auth is available
        print("canCheckBiometrics - ${canCheckBiometrics}");

        bool isDeviceSupported=await auth.isDeviceSupported(); //check is device support auth
        print("isDeviceSupported - ${isDeviceSupported}");

        List<BiometricType> getAvailableBiometrics=await auth.getAvailableBiometrics();
         print("getAvailableBiometrics - ${getAvailableBiometrics}");

         

      bool isAuthencated = await auth.authenticate(
          
        localizedReason: 'Scan your fingerprint to authenticate',
        options: const AuthenticationOptions(
          biometricOnly: false, //if true then can also use other auth options

          stickyAuth: true,
          //  Used when the application goes into background for any reason while the authentication is in 
          //progress. Due to security reasons, the authentication has to be stopped at that time. 
          //If stickyAuth is set to true, authentication resumes when the app is resumed. 
          //If it is set to false (default), then as soon as app is paused a failure message is sent back to 
          //Dart and it is up to the client app to restart authentication or do something else.
          useErrorDialogs: true
        ),
      );


      setState(() {
        _message = isAuthencated ? "Authenticated!" : "Failed to authenticate.";
      });
      
    if(isAuthencated){
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
    }

    } catch (e) {
      setState(() {
        _message = "Error: $e";
      });
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      backgroundColor: Colors.amber,
      title: Text("Fingerprint Login")),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_message),
          SizedBox(height: 20),
          _message == "Authenticated!"
              ? ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _message = "Not Authenticated";
                    });
                  },
                  child: Text("Exit Authentication",style: TextStyle(color:Colors.green),),
                )
              : ElevatedButton(
                  onPressed: _authenticate,
                  child: Text("Authenticate",style: TextStyle(color:Colors.red),),
                ),
             // : Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()))
        ],
      ),
    ),
  );
}
}