
import 'package:ffa_app/screens/needExistList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'screens/scrap_map.dart';
import 'screens/selection_need.dart';
import 'screens/selection_have.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/need_food_map.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
final hintFont = GoogleFonts.poiretOne(
  color: const Color.fromARGB(255, 101, 101, 101),
  fontWeight: FontWeight.w800,
  letterSpacing: 1,
);
final mainFont = GoogleFonts.poiretOne(
  color: Colors.black,
  fontWeight: FontWeight.w800,
  fontSize: 20,
  letterSpacing: 1,
);
final containerDecor = BoxDecoration(
  border: Border.all(
    color: Colors.black,
    width: 2,
  ), // Thicker black border
  borderRadius: BorderRadius.circular(10), // Increased border radius
);
final Color forestGreen = Color.fromRGBO(42, 77, 20, 1.0);
final Color jade = Color.fromRGBO(4, 167, 119, 1.0);
final ButtonStyle customButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: forestGreen,
  shadowColor: forestGreen,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),  // Border radius
  ),
);

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
  FlutterError.onError = (FlutterErrorDetails details) {
    print('flutter error hidden from console');
    // FlutterError.dumpErrorToConsole(details, forceReport: false);
  };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Food For All',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 93, 196, 255)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),

    );
  }
}
class HomePage extends StatefulWidget{
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          NeedFoodPage(),
          existingListings(),
          // Add more pages as needed
        ],
      ),
      bottomNavigationBar:
      Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 0),
              ),
            ],
          ),

          child: BottomNavigationBar(

            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                print("Current Index: $_currentIndex");
              });
            },
            unselectedItemColor: Colors.black,
            selectedItemColor: Colors.green[800],
            selectedFontSize: 10,
            unselectedFontSize: 10,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.map),
                label: 'Maps',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list_outlined),
                label: 'Listings',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle_outline, size:30),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Account',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.info_outline),
                label: 'Help',
              ),
            ],
          ),
        )

    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late String errorText = "";
  late bool _passwordVisible;
  late bool _confirmPasswordVisible;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    _passwordVisible = false;
    _confirmPasswordVisible = false;
  }
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(0, 3, 3, 3),
          elevation: 0, toolbarHeight: 0
        ),
        body: Center(
          child: Container(
            width: 300,
            child:
            SingleChildScrollView(child:
            Column(
              children: [
                Text(
                  'Food For All NYC',
                  style: GoogleFonts.luckiestGuy(fontSize: 55, color: const Color.fromARGB(255, 44, 132, 39), height: 0.8),
                  textAlign: TextAlign.center,
                ),
                Text("Sign Up", style: mainFont.copyWith(fontSize: 30)),
                const SizedBox(height: 15),
                Container(
                  decoration: containerDecor,
                  child: Theme(
                    data: ThemeData(
                      inputDecorationTheme: InputDecorationTheme(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey), // Remove the blue underline
                        ),
                      ),
                      elevatedButtonTheme: ElevatedButtonThemeData(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent, // Remove the blue background
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle: hintFont,
                              labelText: "Email",

                            ),
                            style: mainFont,
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: hintFont,
                                    labelText: "Password",
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey), // Customize underline color
                                    ),
                                  ),
                                  style: mainFont,
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: passwordController,
                                  obscureText: !_passwordVisible,
                                ),
                              ),
                              SizedBox(
                                width: 50,
                                child:
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,

                                    ),
                                    icon: Icon(
                                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                      color: Colors.black, // Customize button icon color
                                    ),
                                    iconSize: 20,

                                  )
                              ),

                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Confirm Password",
                                    hintStyle: hintFont,
                                    labelText: "Confirm Password",
                                  ),
                                  style: mainFont,
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: confirmPasswordController,
                                  obscureText: !_confirmPasswordVisible,
                                ),
                              ),
                              SizedBox(
                                  width: 50,
                                  child:
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _confirmPasswordVisible = !_confirmPasswordVisible;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,

                                    ),
                                    icon: Icon(
                                      _confirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                                      color: Colors.black, // Customize button icon color
                                    ),
                                    iconSize: 20,

                                  )
                              ),

                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),


                const SizedBox(height: 15),
                Text(errorText, style: mainFont.copyWith(color: Colors.red, fontSize: 14)),
                ElevatedButton(
                  style: customButtonStyle,
                  onPressed: () async {
                    if(passwordController.text == confirmPasswordController.text){
                      try {
                        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text,
                        );


                      } on FirebaseAuthException catch (e) {

                        if (e.code == 'weak-password') {
                          setState(() {
                            errorText = ('The password provided is too weak.');
                          });
                        } else if (e.code == 'email-already-in-use') {
                          setState(() {
                            errorText = ('E-mail already in use.');
                          });

                        }
                        if (e.code == 'invalid-email'){
                          setState(() {
                            errorText = ("Email provided is invalid");
                          });
                        }
                      } catch (e) {
                        print(e);
                      }
                      setState(() {
                        errorText = "";
                      });
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const MyHomePage(title: "Home"),
                        ),
                      );
                    }
                    else{
                      setState(() {
                        errorText = "Password do not match";
                      });
                    }

                  },
                  child: Text("Create account", style:mainFont.copyWith(color: Colors.white))
                ),
                const SizedBox(height: 20),
                Text("or", style:mainFont),
                const SizedBox(height: 20),
                Container(
                  decoration: containerDecor,
                  child:
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,

                                ),
                              ),
                            ),
                            child:
                              ElevatedButton(
                                  onPressed: () {
                                    signInWithGoogle();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: Colors.white.withOpacity(0.0),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.zero))
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 15),
                                    child: Row(
                                      children: [
                                        Image.network(
                                          'http://pngimg.com/uploads/google/google_PNG19635.png',
                                          fit:BoxFit.cover,
                                          height: 40,
                                        ),
                                        Text("Sign in with Google", style: mainFont),

                                      ],
                                    ),
                                  )
                              ),
                          ),

                          ElevatedButton(
                            onPressed: () {

                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: Colors.white.withOpacity(0.0),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.zero))
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Row(
                                children: [
                                  Image.network(
                                    'https://pngimg.com/uploads/apple_logo/apple_logo_PNG19666.png',
                                    fit:BoxFit.cover,
                                    height: 35,
                                  ),
                                  SizedBox(width: 5),
                                  Text("Sign in with Apple", style: mainFont),

                                ],
                              ),
                            )
                          ),
                        ],
                      )
                    )
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Already have account? ',
                      style: mainFont.copyWith(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                        text: 'Login',
                        style: mainFont.copyWith(
                          fontSize: 14,
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          }),
                  ]),
                ),


              ],
            ),
          ),
        ),
      ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  late String errorText = "";
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    _passwordVisible = false;

  }
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(0, 3, 3, 3),
          elevation: 0,
            toolbarHeight: 0
        ),
        body: Center(
          child: Container(
            width: 300,
            child: SingleChildScrollView(child:Column(
              children: [
                Text(
                  'Food For All NYC',
                  style: GoogleFonts.luckiestGuy(fontSize: 55, color: const Color.fromARGB(255, 44, 132, 39), height: 0.8),
                  textAlign: TextAlign.center,
                ),
                Text("Login", style: mainFont.copyWith(fontSize: 30)),
                const SizedBox(height: 15),
                Container(
                  decoration: containerDecor,
                  child: Theme(
                    data: ThemeData(
                      inputDecorationTheme: InputDecorationTheme(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey), // Remove the blue underline
                        ),
                      ),
                      elevatedButtonTheme: ElevatedButtonThemeData(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent, // Remove the blue background
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              hintText: "Email",
                              hintStyle: hintFont,
                              labelText: "Email",
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey), // Customize underline color
                              ),
                            ),
                            style: mainFont,
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Password",
                                    hintStyle: hintFont,
                                    labelText: "Password",
                                  ),
                                  style: mainFont,
                                  keyboardType: TextInputType.visiblePassword,
                                  controller: passwordController,
                                  obscureText: !_passwordVisible,
                                ),
                              ),
                              SizedBox(
                                  width: 50,
                                  child:
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,

                                    ),
                                    icon: Icon(
                                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                      color: Colors.black, // Customize button icon color
                                    ),
                                    iconSize: 20,

                                  )
                              ),

                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),


                const SizedBox(height: 15),
                Text(errorText, style: mainFont.copyWith(color: Colors.red, fontSize: 14)),
                ElevatedButton(
                    onPressed: () async {
                      try {
                        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                        );
                        setState(() {
                          errorText = "";
                        });
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const MyHomePage(title: "Home"),
                          ),
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          setState(() {
                            errorText = "Could not find a user with that email";
                          });
                        } else if (e.code == 'wrong-password') {
                          setState(() {
                            errorText = "Incorrect password";
                          });
                        }
                      }

                    },
                    child: Text("Log in", style:mainFont.copyWith(color: Colors.white))
                ),
                const SizedBox(height: 20),
                Text("or", style:mainFont),
                const SizedBox(height: 20),
                Container(
                    decoration: containerDecor,
                    child:
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: Column(
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child:
                              ElevatedButton(
                                  onPressed: () {
                                    signInWithGoogle();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: Colors.white.withOpacity(0.0),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.zero))
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 15),
                                    child: Row(
                                      children: [
                                        Image.network(
                                          'http://pngimg.com/uploads/google/google_PNG19635.png',
                                          fit:BoxFit.cover,
                                          height: 40,
                                        ),
                                        Text("Sign in with Google", style: mainFont),

                                      ],
                                    ),
                                  )
                              ),
                            ),

                            ElevatedButton(
                                onPressed: () {

                                },
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: Colors.white.withOpacity(0.0),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.zero))
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  child: Row(
                                    children: [
                                      Image.network(
                                        'https://pngimg.com/uploads/apple_logo/apple_logo_PNG19666.png',
                                        fit:BoxFit.cover,
                                        height: 35,
                                      ),
                                      SizedBox(width: 5),
                                      Text("Sign in with Apple", style: mainFont),

                                    ],
                                  ),
                                )
                            ),
                          ],
                        )
                    )
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: 'Dont have an account? ',
                      style: mainFont.copyWith(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                        text: 'Sign up',
                        style: mainFont.copyWith(
                          fontSize: 14,
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SignUpPage(),
                              ),
                            );
                          }),
                  ]),
                ),


              ],
            ),
          ),
        ),
      ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? firstSelectedValue;
  var firstItems = [
    'See food pantry locations',
    'See community fridge locations',
    'See soup kitchen locations',
  ];

  String? secondSelectedValue;
  var secondItems = [
    'I am an individual',
    'I am an organization',
  ];

  String? thirdSelectedValue;
  var thirdItems = [
    'See food pantry locations',
    'See community fridge locations',
    'See soup kitchen locations',
  ];

  @override
  void initState() {
    super.initState();
    firstSelectedValue = null; // Initially no option is selected
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      body: Center(
        child:
        SingleChildScrollView(child:

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Food For All NYC',
              style: GoogleFonts.luckiestGuy(fontSize: 55, color: const Color.fromARGB(255, 44, 132, 39), height: 0.8),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'We are a nonprofit organization with a mission of fighting food insecurity and food waste',
                style: GoogleFonts.fasthand(fontSize: 20, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              width: 300, // Adjust the width as desired
              height: 500,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2), // Thicker black border
                        borderRadius: BorderRadius.circular(10), // Increased border radius
                      ),
                      child: DropdownButton<String>(
                        value: secondSelectedValue,
                        hint: Text(
                          'I have extra food to be salvaged',
                          style: GoogleFonts.poiretOne(color: Colors.black, fontWeight: FontWeight.w800),
                        ),
                        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
                        itemHeight: 70,
                        isExpanded: true,
                        underline: Container(), // Remove the default underline
                        onChanged: (String? newValue) {
                          if (newValue == "I am an individual") {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ScrapMapPage(),
                              ),
                            );
                          } else if (newValue == "I am an organization") {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const SelectionFormPage(),
                              ),
                            );
                          }
                        },
                        items: secondItems.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item, style: GoogleFonts.poiretOne(color: Colors.black, fontWeight: FontWeight.w800),),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SelectionHaveFormPage(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2), // Thicker black border
                        borderRadius: BorderRadius.circular(10), // Increased border radius
                      ),
                      child: Text(
                        'I am a food resource in need of extra food',
                        style: GoogleFonts.poiretOne(color: Colors.black, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2), // Thicker black border
                      borderRadius: BorderRadius.circular(10), // Increased border radius
                    ),
                    child: DropdownButton<String>(
                      value: firstSelectedValue,
                      hint: Text(
                        'I am an individual looking for food resources',
                        style: GoogleFonts.poiretOne(color: Colors.black, fontWeight: FontWeight.w800),
                      ),
                      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.black),
                      itemHeight: 70,
                      isExpanded: true,
                      underline: Container(), // Remove the default underline
                      onChanged: (String? newValue) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => NeedFoodPage(selectedValue: newValue),
                          ),
                        );
                      },
                      items: firstItems.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item, style: GoogleFonts.poiretOne(color: Colors.black, fontWeight: FontWeight.w800),),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      )
    );
  }
}
