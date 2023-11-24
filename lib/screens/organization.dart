
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';

FirebaseDatabase database = FirebaseDatabase.instance;
DatabaseReference ref = FirebaseDatabase.instance.ref();

final hintFont = GoogleFonts.poiretOne(color: const Color.fromARGB(255, 101, 101, 101), fontWeight: FontWeight.w800, letterSpacing: 1);
final mainFont = GoogleFonts.poiretOne(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 20, letterSpacing: 1);
final containerDecor = BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2), // Thicker black border
                          borderRadius: BorderRadius.circular(10), // Increased border radius
                        );

late String typeOfOrganization;
late String nameOfOrganization;
late String addressOfOrganization;
late String emailOfContact;
late String nameOfContact;
late String phoneOfContact;
List allPerishables = [];
List allPerishablesQuantities = [];
List allNonPerishables = [];
List allNonPerishablesQuantities = [];
List allPrepareds = [];
List allPreparedsQuantities = [];
late String startDate;
late String endDate;
late String startTime;
late String endTime;

class organizationFormPage extends StatefulWidget {
  
  final String? selectedValue;
  const organizationFormPage({Key? key, this.selectedValue}) : super(key: key);
  @override
  State<organizationFormPage> createState() => _organizationFormPageState();
}
class _organizationFormPageState extends State<organizationFormPage> {
  late double nextElevation = 0;
  late String validEmail = "nothing";
  String? orgType;
  final typeItems = [
    'Restaurant',
    'Deli',
    'Grocery Store',
    'Nonprofit',
    'Food Manufacturer/Distributor',
    'Farm/Agricultural Organization',
    'Community Organization',
    'Food Recovery Program',
    'Homeless Shelter',
    'School'
  ];
  @override
  
  void initState() {
    super.initState();
    orgType = null; // Initially no option is selected
  }
  
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final orgNameController = TextEditingController();
  final phoneController = TextEditingController();

  late String email = "";
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    addressController.dispose();
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(0, 3, 3, 3),
          leading: BackButton(
            onPressed: () => Navigator.of(context).pop(),
            color: const Color.fromRGBO(72,164,244, 1),
          ),
          elevation: 0,
        ),
        body:SingleChildScrollView(child: Center(child: Column(

          children: [
            const SizedBox(height: 15, width: 50),
            Text(
              'Organization Information',
              style: mainFont,
              
            ),
            const SizedBox(height: 15, width: 50),
            
            Container(
              width: 300,
              height: 53,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: containerDecor,
              child: DropdownButton<String>(
                value: orgType,
                hint:
                  Text(
                    'Select type of organization',
                    style: hintFont,
                  ),
                icon: const Icon(Icons.keyboard_arrow_down, color:  Color.fromRGBO(72,164,244, 1)),
                itemHeight: 70,
                isExpanded: true,
                underline: Container(), // Remove the default underline
                onChanged: (String? newValue) {
                  setState(() {
                    orgType = newValue;
                    if(
                      phoneController.text.length == 14 &&
                      orgNameController.text.isNotEmpty &&
                      nameController.text.isNotEmpty &&
                      addressController.text.isNotEmpty &&
                      orgType != null &&
                      validEmail == "valid"){
                        nextElevation = 3;
                      } else{
                        nextElevation = 0;
                      }
                  });
                },
                
                items: typeItems.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(item, style: GoogleFonts.poiretOne(color: Colors.black, fontWeight: FontWeight.w800),),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 15, width: 50),
            Container(
              
              width: 300,
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              decoration: containerDecor,
              
              child: 
               TextField(
                decoration: InputDecoration(hintText: "Enter Organization Address", hintStyle: hintFont),
                controller: addressController,
                style: mainFont,
                onChanged: (value){
                  setState(() {
                    if(
                  phoneController.text.length == 14 &&
                  orgNameController.text.isNotEmpty &&
                  nameController.text.isNotEmpty &&
                  addressController.text.isNotEmpty &&
                  orgType != null &&
                  validEmail == "valid"){
                    nextElevation = 3;
                  } else{
                    nextElevation = 0;
                  }
                  });
                },
            )
               
            ),
            const SizedBox(height: 15, width: 50),
            Container(
              
              width: 300,
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              decoration: containerDecor,
              
              child: 
               TextField(
                decoration: InputDecoration(hintText: "Enter Organization Name", hintStyle: hintFont),
                controller: orgNameController,
                style: mainFont,
                onChanged: (value){
                  setState(() {
                    if(
                  phoneController.text.length == 14 &&
                  orgNameController.text.isNotEmpty &&
                  nameController.text.isNotEmpty &&
                  addressController.text.isNotEmpty &&
                  orgType != null &&
                  validEmail == "valid"){
                    nextElevation = 3;
                  } else{
                    nextElevation = 0;
                  }
                  });
                },
               )
               
            ),
            const SizedBox(height: 15, width: 50),
            Column(children: [
              Text('Contact Information',
                    style: mainFont,
                    ),
              const SizedBox(height: 15, width: 50),
              Container(
                  width: 300,
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  decoration: containerDecor,
                  child: 
                  TextField(
                    decoration: InputDecoration(hintText: "Your Name", hintStyle: hintFont,),
                    controller: nameController,
                    style: mainFont,
                    onChanged: (value){
                      setState(() {
                        if(
                      phoneController.text.length == 14 &&
                      orgNameController.text.isNotEmpty &&
                      nameController.text.isNotEmpty &&
                      addressController.text.isNotEmpty &&
                      orgType != null &&
                      validEmail == "valid"){
                        nextElevation = 3;
                      } else{
                        nextElevation = 0;
                      }
                      });
                    },
                  )
                ),
                Padding(padding: const EdgeInsets.symmetric(vertical: 16),
                child:
                  Container(
                    width: 300,
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 3),
                    decoration: containerDecor,
                    child: Column(children: [ 
                    TextField(
                      decoration: InputDecoration(hintText: "Email", hintStyle: hintFont),
                      controller: emailController,
                      style: validEmail == "valid" ? mainFont : mainFont.copyWith(color: Colors.red),
                      onChanged: (value) {
                        setState(() {
                          validEmail = EmailValidator.validate(value) ? "valid" : "notvalid";
                          email = value;
                          if(
                            phoneController.text.length == 14 &&
                            orgNameController.text.isNotEmpty &&
                            nameController.text.isNotEmpty &&
                            addressController.text.isNotEmpty &&
                            orgType != null &&
                            validEmail == "valid"){
                              nextElevation = 3;
                            } else{
                              nextElevation = 0;
                            }
                        });
                      
                      },

                    ),
                    //Padding(padding: const EdgeInsets.all(5), child: Text(validEmail == "notvalid" ? "*Please enter a valid email" : "", style: GoogleFonts.poiretOne(color: const Color.fromARGB(255, 255, 0, 0), fontWeight: FontWeight.w800)))
                    ]
                    )
                  ),
                ),
                Container(
                  width: 300,
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                  decoration: containerDecor,
                  child: 
                  TextField(
                    style: mainFont,
                    decoration: InputDecoration(
                      hintText: "Phone number",
                      hintStyle: hintFont,
                      errorStyle: const TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    autocorrect: false,
                    inputFormatters: [
                      PhoneInputFormatter(
                        allowEndlessPhone: false,
                        defaultCountryCode: "US",
                      )
                    ],
                    onChanged: (value){
                      setState(() {
                        if(
                      phoneController.text.length == 14 &&
                      orgNameController.text.isNotEmpty &&
                      nameController.text.isNotEmpty &&
                      addressController.text.isNotEmpty &&
                      orgType != null &&
                      validEmail == "valid"){
                        nextElevation = 3;
                      } else{
                        nextElevation = 0;
                      }
                      });
                    },
                  )
                ),
                const SizedBox(height: 15, width: 50),
                TextButton(
                  onPressed: (){
                    if(
                      phoneController.text.length == 14 &&
                      orgNameController.text.isNotEmpty &&
                      nameController.text.isNotEmpty &&
                      addressController.text.isNotEmpty &&
                      orgType != null &&
                      validEmail == "valid"){
                        setState(() {
                          nameOfOrganization = orgNameController.text;
                          typeOfOrganization = orgType.toString();
                          addressOfOrganization = addressController.text;
                          emailOfContact = emailController.text;
                          nameOfContact = nameController.text;
                          phoneOfContact = phoneController.text;
                        });
                        
                        Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const FoodFormPage(),
                            ),
                          );
                      }
                  },  
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    elevation: MaterialStatePropertyAll(nextElevation),
                  ),
                  child: Text(
                    'Next',
                    style: GoogleFonts.poiretOne(
                      color: const Color.fromRGBO(72,164,244, 1),
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                )
            ]
            ,)
          ]
        )
      ),
    )));
  }
}

class otherItemClass {
  String name;
  double quantity;

  otherItemClass({required this.name, required this.quantity});
}

class FoodFormPage extends StatefulWidget {
  
  final String? selectedValue;
  const FoodFormPage({Key? key, this.selectedValue}) : super(key: key);
  @override
  State<FoodFormPage> createState() => _FoodFormPageState();
}
class _FoodFormPageState extends State<FoodFormPage> {
  final perishableController = TextEditingController();
  final nonperishableController = TextEditingController();
  final preparedController = TextEditingController();
  
  List<otherItemClass> otherPerishables = [];
  List<otherItemClass> otherNonPerishables = [];
  List<otherItemClass> otherPreparedMeals = [];

  late bool perishButtonEnabled = false;
  late bool nonpButtonEnabled = false;
  late bool prepButtonEnabled = false;
  
  // PERISHABLES
  late bool? fruits;
  late bool? vegetables;
  late bool? dairy;
  late bool? poultry;
  late bool? fish;
  late bool? deli;
  late bool? othermeat;

  // DRY GOODS
  late bool? dryfruits;
  late bool? pasta;
  late bool? rice;
  late bool? beans;
  late bool? crackers;
  late bool? nutsandoats;
  late bool? peanutbutter;
  late bool? bottled;

  // PREPARED
  late bool? canned;
  late bool? shelfstable;
  late bool? boxed;
  late bool? frozen;
  late bool? sandwich;
  late bool? salad;

  // Controllers
  TextEditingController fruitsController = TextEditingController();
  TextEditingController vegetablesController = TextEditingController();
  TextEditingController dairyController = TextEditingController();
  TextEditingController poultryController = TextEditingController();
  TextEditingController fishController = TextEditingController();
  TextEditingController deliController = TextEditingController();
  TextEditingController othermeatController = TextEditingController();
  TextEditingController dryfruitsController = TextEditingController();
  TextEditingController pastaController = TextEditingController();
  TextEditingController riceController = TextEditingController();
  TextEditingController beansController = TextEditingController();
  TextEditingController crackersController = TextEditingController();
  TextEditingController nutsandoatsController = TextEditingController();
  TextEditingController peanutbutterController = TextEditingController();
  TextEditingController bottledController = TextEditingController();
  TextEditingController cannedController = TextEditingController();
  TextEditingController shelfstableController = TextEditingController();
  TextEditingController boxedController = TextEditingController();
  TextEditingController frozenController = TextEditingController();
  TextEditingController sandwichController = TextEditingController();
  TextEditingController saladController = TextEditingController();

  List<String> fixedPerishables = ["Fresh Fruits", "Fresh Vegetables", "Dairy", "Poultry", "Fish", "Deli Meats", "Other Meat"];
  List<double?> fixedPerishableQuantities = [0, 0, 0, 0, 0, 0, 0];
  List<bool?> perishableBools = [];
  List<TextEditingController> perishableControllersList = [];
  List<String> fixedNonperishables = ["Dry Fruits", "Pasta", "Rice", "Beans", "Crackers", "Nuts/Oats", "Peanut Butter/Jelly/Jam", "Bottled Beverage"];
  List<double?> fixedNonperishableQuantities = [0, 0, 0, 0, 0, 0, 0];
  List<bool?> nonperishableBools = [];
  List<TextEditingController> nonperishableControllersList = [];
  List<String> fixedPrepared = ["Canned Goods", "Shelf-stable Meals", "Boxed Meals", "Frozen Meals", "Sandwiches", "Salads"];
  List<double?> fixedPreparedQuantities = [0, 0, 0, 0, 0, 0, 0];
  List<bool?> preparedBools = [];
  List<TextEditingController> preparedControllersList = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    // PERISHABLES
    fruits = false;
    vegetables = false;
    dairy = false;
    poultry = false;
    fish = false;
    deli = false;
    othermeat = false;

    // NONPERISHABLES
    dryfruits = false;
    pasta = false;
    rice = false;
    beans = false;
    crackers = false;
    nutsandoats = false;
    peanutbutter = false;
    bottled = false;

    // PREPARED
    canned = false;
    shelfstable = false;
    boxed = false;
    frozen = false;
    sandwich = false;
    salad = false;

    perishableBools = [fruits, vegetables, dairy, poultry, fish, deli, othermeat];
    nonperishableBools = [dryfruits, pasta, rice, beans, crackers, nutsandoats, peanutbutter, bottled];
    preparedBools = [canned, shelfstable, boxed, frozen, sandwich, salad];

    perishableControllersList = [
      fruitsController,
      vegetablesController,
      dairyController,
      poultryController,
      fishController,
      deliController,
      othermeatController,
    ];
    nonperishableControllersList = [
      dryfruitsController,
      pastaController,
      riceController,
      beansController,
      crackersController,
      nutsandoatsController,
      peanutbutterController,
      bottledController,
    ];
    preparedControllersList = [
      cannedController,
      shelfstableController,
      boxedController,
      frozenController,
      sandwichController,
      saladController,
    ];
  }


  late PageController _pageController;
  int _currentPage = 0;
  late bool seenPage2 = false;
  late bool seenPage3 = false;
  void disposePage() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    if (_currentPage < 3) {
      _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
    if(_currentPage == 0){
      setState(() {
        seenPage2 = true; 
      });
      
    }
    if(_currentPage == 1){
      setState(() {
        seenPage3 = true; 
      });
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }
  ThemeMode themeMode = ThemeMode.dark;
  bool useMaterial3 = true;
  DateTime? selectedDateFrom;
  DateTime? selectedDateTo;
  TimeOfDay? selectedTimeFrom;
  TimeOfDay? selectedTimeTo;
  Future<void> _selectDate(BuildContext context, bool isFrom) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: isFrom ? selectedDateFrom ?? DateTime.now() : selectedDateTo ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 3),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            // Customize the date picker theme
            primaryColor: const Color.fromARGB(255, 255, 255, 255), // Change the primary color// Change the accent color
            dialogBackgroundColor: Colors.white, // Change the dialog background color
            textTheme: TextTheme(
              // Apply your custom font to the date picker text styles
              displayLarge: mainFont.copyWith(fontSize: 16),
              displayMedium: mainFont.copyWith(fontSize: 16),
              displaySmall: mainFont.copyWith(fontSize: 16),
              headlineLarge: mainFont,
              headlineMedium: mainFont,
              headlineSmall: mainFont,
              titleLarge: mainFont,
              titleMedium: mainFont,
              titleSmall: mainFont,
              bodyLarge: mainFont,
              bodyMedium: mainFont,
              bodySmall: mainFont,
              labelLarge: mainFont,
              labelMedium: mainFont,
              labelSmall: mainFont,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        isFrom? selectedDateFrom = selectedDate : selectedDateTo = selectedDate;
      });
    }
  }
  Future<void> _selectTime(BuildContext context, bool isFrom) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: isFrom ? selectedTimeFrom ?? TimeOfDay.now() : selectedTimeTo ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
          // Customize the time picker theme
          primaryColor: Colors.blue, // Change the primary color
          
          dialogBackgroundColor: Colors.white, // Change the dialog background color
          textTheme: TextTheme(
            displayLarge: mainFont,
            displayMedium: mainFont,
            displaySmall: mainFont,
            headlineLarge: mainFont,
            headlineMedium: mainFont,
            titleLarge: mainFont,
            titleMedium: mainFont,
            titleSmall: mainFont,
            headlineSmall: mainFont,
            bodyLarge: mainFont,
            bodyMedium: mainFont,
            labelLarge: mainFont,
            labelSmall: mainFont,
          ),
        ),
          child: child!,
        );
      },
    );

    if (selectedTime != null) {
      setState(() {
        if (isFrom) {
          selectedTimeFrom = selectedTime;
        } else {
          selectedTimeTo = selectedTime;
        }
      });
    }
  }

  bool nextEnabled(){
    bool response = false;
    if(selectedTimeTo == null || selectedTimeFrom == null || selectedDateFrom == null || selectedDateTo == null){
      return false;
    }
    if(DateTime.now().copyWith(year: selectedDateTo!.year, month: selectedDateTo!.month, day: selectedDateTo!.day).isBefore(DateTime.now().copyWith(year: selectedDateFrom!.year, month: selectedDateFrom!.month, day: selectedDateFrom!.day)) == true){
      if(selectedDateTo!.month == selectedDateFrom!.month && selectedDateTo!.year == selectedDateFrom!.year && selectedDateTo!.day == selectedDateFrom!.day){

      }else{
        return false;
      }
      
    }
    if(DateTime.now().copyWith(hour: selectedTimeTo!.hour, minute: selectedTimeTo!.minute).isBefore(DateTime.now().copyWith(hour: selectedTimeFrom!.hour, minute: selectedTimeFrom!.minute))){
      return false;
    }
    if(seenPage2 & seenPage3){
      for (var boool in perishableBools){
        if(boool == true){
          if(fixedPerishableQuantities[perishableBools.indexOf(boool)] != 0.0){
            response = true;
          }
          else{
            return false;
          }
        }
      }
      for (var boool in preparedBools){
        if(boool == true){
          if(fixedPreparedQuantities[preparedBools.indexOf(boool)] != 0.0){
            response = true;
          }
          else{
            return false;
          }
        }
      }
      for (var boool in nonperishableBools){
        if(boool == true){
          if(fixedNonperishableQuantities[nonperishableBools.indexOf(boool)] != 0.0){
            response = true;
          }
          else{
            return false;
          }
        }
      }
      for(var item in otherPerishables){
        if(item.quantity == 0){
          return false;
        }
        else{
          response = true;
        }
      }
      for(var item in otherNonPerishables){
        if(item.quantity == 0){
          return false;
        }
        else{
          response = true;
        }
      }
      for(var item in otherPreparedMeals){
        if(item.quantity == 0){
          return false;
        }
        else{
          response = true;
        }
      }
      return response;
    } else{
      return false;
    }
    
  }
  
  late String foodType = "Prepared Meals";

  Widget otherColumn(List<otherItemClass> group){
    return Column(
      children: <Widget>[
      for (var otherItem in group)
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 1.0,
              ),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                title: Row(
                  children: [
                    Container(
                      width: 180,
                      child: Expanded(
                        child: Text(
                          otherItem.name,
                          style: GoogleFonts.poiretOne(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(const CircleBorder()),
                          backgroundColor:
                              MaterialStateProperty.all(const Color.fromARGB(255, 202, 0, 0)),
                        ),
                        onPressed: () {
                          setState(() {
                            group.remove(otherItem);
                          });
                        },
                        child: const Icon(
                          Icons.remove,
                          color: Color.fromARGB(255, 255, 255, 255),
                          size: 20.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 180,
                child: Center(
                  child: otherItem.quantity != 0
                      ? Text(
                          "${otherItem.quantity.toString()} lbs",
                          style: GoogleFonts.poiretOne(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                          ),
                        )
                      : TextField(
                          style: GoogleFonts.poiretOne(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                          ),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Enter quantity (lbs)',
                            hintStyle: GoogleFonts.poiretOne(
                              color: const Color.fromARGB(255, 101, 101, 101),
                            ),
                            border: InputBorder.none,
                          ),
                          textAlign: TextAlign.center,
                          onSubmitted: (value) {
                            setState(() {
                              otherItem.quantity = double.tryParse(value) ?? 0.0;
                            });
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
    ],
  );
  }
  Widget otherButton(TextEditingController controller, bool enabled,List<otherItemClass> group){
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1.0,
          ),
        ),
      ),                             
      child: Row(
        children: [
          Expanded(
            child: 
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 20),
                child: TextField(
                  maxLength: 20,
                  style: GoogleFonts.poiretOne(color: const Color.fromARGB(255, 101, 101, 101), fontWeight: FontWeight.w800, fontSize: 20),
                  decoration: InputDecoration(hintText: "Other", 
                                              hintStyle: GoogleFonts.poiretOne(color: const Color.fromARGB(255, 101, 101, 101), 
                                              fontWeight: FontWeight.w800),
                                              border: InputBorder.none,
                                              counterText: "",
                                              ),
                  controller: controller,
                  onChanged:(value) {
                    setState(() {
                      enabled = !value.isEmpty;
                      if(group == otherPreparedMeals){
                        prepButtonEnabled = enabled;
                      }
                      else if(group == otherNonPerishables){
                        nonpButtonEnabled = enabled;
                      }
                      else if(group == otherPerishables){
                        perishButtonEnabled = enabled;
                      }
                    });
                  },
                )
              )
          ),
          ElevatedButton(
            style:ButtonStyle(
              shape:  MaterialStateProperty.all(const CircleBorder()),

            ),
            onPressed: enabled ? (){
              
              otherItemClass newItem = otherItemClass(name: controller.text, quantity: 0);
              setState(() {
                group.add(newItem);
                controller.text = "";
                if(group == otherPreparedMeals){
                  prepButtonEnabled = false;
                }
                else if(group == otherNonPerishables){
                  nonpButtonEnabled = false;
                }
                else if(group == otherPerishables){
                  perishButtonEnabled = false;
                }
              });
            } : null,
            child: const Icon(
                      Icons.add,
                      color: Color.fromARGB(255, 255, 255, 255),
                      size: 20.0,
                  ),
          )
        ]
      )
    );
  }
  Widget buildContainerWithCheckboxAndTextField(
    String title,
    bool? checkboxValue,
    TextEditingController controller,
    void Function(bool?) onChanged,
  ) {
  return Container(
    decoration: const BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
    ),
    child: Column(
      children: [
        CheckboxListTile(
          side: const BorderSide(color: Colors.black, width: 1),
          title: Text(
            title,
            style: GoogleFonts.poiretOne(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          ),
          value: checkboxValue,
          activeColor: Color.fromARGB(255, 0, 0, 0),
          checkColor: Color.fromARGB(255, 255, 255, 255),
          onChanged: onChanged,
        ),
        if (checkboxValue == true)
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Color.fromARGB(255, 0, 0, 0),
                  width: 1.0,
                ),
              ),
            ),
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter quantity (lbs)',
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 101, 101, 101),
                ),
                border: InputBorder.none,
              ),
              style: GoogleFonts.poiretOne(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
              onChanged: (value) {
                if(fixedPerishables.contains(title)){
                  setState(() {
                    fixedPerishableQuantities[fixedPerishables.indexOf(title)] = double.tryParse(value) ?? 0.0;
                  });
                } else if(fixedNonperishables.contains(title)){
                  setState(() {
                    fixedNonperishableQuantities[fixedNonperishables.indexOf(title)] = double.tryParse(value) ?? 0.0;
                  });
                } else{
                  setState(() {
                    fixedPreparedQuantities[fixedPrepared.indexOf(title)] = double.tryParse(value) ?? 0.0;
                  });
                }
              },
            ),
          ),
      ],
    ),
  );
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      home:  Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(0, 3, 3, 3),

          elevation: 0,
        ),
        body: Center(child: Column(
          children: [
            Text('What type of food do you have?',
              style: GoogleFonts.poiretOne(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 25),
            ),
            const SizedBox(height: 15),
            Text(foodType,
              style: mainFont,
            ),
            Expanded(
              flex: 2,
              child: PageView(        
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;    
                  });
                  if(page == 0){
                    setState(() {
                      foodType = "Prepared Meals";
                    });
                  }
                  else if(page == 1){
                    setState(() {
                      foodType = "Perishables";
                    });
                  }
                  else if(page == 2){
                    setState(() {
                      foodType = "Non-perishables";
                    });
                  }
                },
                children: [
                  Padding(  
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                        width: 300,
                        height: 430,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                        decoration: containerDecor,
                        child: SingleChildScrollView(
                          child: 
                            Column(
                              children: [
                                for (var i = 0; i < fixedPrepared.length; i++)
                                  buildContainerWithCheckboxAndTextField(
                                    fixedPrepared[i],
                                    preparedBools[i],
                                    preparedControllersList[i],
                                    (bool? value) {
                                      setState(() {
                                        preparedBools[i] = value;
                                      });
                                    }),
                                otherColumn(otherPreparedMeals),
                                otherButton(preparedController, prepButtonEnabled, otherPreparedMeals),
                              ],
                            ),
                        )
                      ),
                  ),
                  Padding(  
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                        width: 300,
                        height: 430,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                        decoration: containerDecor,
                        child: 
                        SingleChildScrollView(
                          child:
                          Column(children: [
                            for (var i = 0; i < fixedPerishables.length; i++)
                                  buildContainerWithCheckboxAndTextField(
                                    fixedPerishables[i],
                                    perishableBools[i],
                                    perishableControllersList[i],
                                    (bool? value) {
                                      setState(() {
                                        perishableBools[i] = value;
                                      });
                                    }),
                            otherColumn(otherPerishables),
                            otherButton(perishableController, perishButtonEnabled, otherPerishables)
                          ]
                        ),
                      )
                    ),
                  ),        
                  Padding(  
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                        width: 300,
                        height: 430,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                        decoration: containerDecor,
                        child: SingleChildScrollView(
                          child: 
                            Column(children: [
                              for (var i = 0; i < fixedNonperishables.length; i++)
                                  buildContainerWithCheckboxAndTextField(
                                    fixedNonperishables[i],
                                    nonperishableBools[i],
                                    nonperishableControllersList[i],
                                    (bool? value) {
                                      setState(() {
                                        nonperishableBools[i] = value;
                                      });
                                    }),
                              otherColumn(otherNonPerishables),
                              otherButton(nonperishableController, nonpButtonEnabled, otherNonPerishables)
                            ]
                          ),
                        )
                      ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, size: 15),
                  onPressed: _goToPreviousPage,
                ),
                Text("${(_currentPage + 1).toString()}/3", style: mainFont.copyWith(fontSize: 10)),
                IconButton(
                  icon: const Icon(Icons.arrow_forward, size: 15),
                  onPressed: _goToNextPage,
                ),
              ],
            ),
            const SizedBox(height: 25),
            Expanded(
              flex: 1,
              child: 
              
              Container(
                width: 320,
                height: 200,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                decoration: containerDecor,
                child: SingleChildScrollView(child: Column(
                  children: [
                    Text("Select Pick-up Date and Time", style: mainFont),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectDate(context, true),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal:5, vertical: 10),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    selectedDateFrom != null ? "${selectedDateFrom!.month.toString()}/${selectedDateFrom!.day.toString()}/${selectedDateFrom!.year.toString()[2]}${selectedDateFrom!.year.toString()[3]}" : 'Start Date',
                                    style: selectedDateFrom != null && selectedDateTo != null ? DateTime.now().copyWith(year: selectedDateTo!.year, month: selectedDateTo!.month, day: selectedDateTo!.day).isAfter(DateTime.now().copyWith(year: selectedDateFrom!.year, month: selectedDateFrom!.month, day: selectedDateFrom!.day)) || (selectedDateTo!.month == selectedDateFrom!.month && selectedDateTo!.year == selectedDateFrom!.year && selectedDateTo!.day == selectedDateFrom!.day) ? mainFont.copyWith(fontSize: 17) : mainFont.copyWith(fontSize: 17, color: Colors.red) : mainFont.copyWith(fontSize: 17),
                                  ),
                                  const Icon(Icons.calendar_month_outlined, size:20),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text("to", style: mainFont),
                        const SizedBox(width: 5),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectDate(context, false),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal:5, vertical: 10),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    selectedDateTo != null ? "${selectedDateTo!.month.toString()}/${selectedDateTo!.day.toString()}/${selectedDateTo!.year.toString()[2]}${selectedDateTo!.year.toString()[3]}" : 'End Date',
                                    style: selectedDateFrom != null && selectedDateTo != null ? DateTime.now().copyWith(year: selectedDateTo!.year, month: selectedDateTo!.month, day: selectedDateTo!.day).isAfter(DateTime.now().copyWith(year: selectedDateFrom!.year, month: selectedDateFrom!.month, day: selectedDateFrom!.day)) || (selectedDateTo!.month == selectedDateFrom!.month && selectedDateTo!.year == selectedDateFrom!.year && selectedDateTo!.day == selectedDateFrom!.day) ? mainFont.copyWith(fontSize: 17) : mainFont.copyWith(fontSize: 17, color: Colors.red) : mainFont.copyWith(fontSize: 17),
                                  ),
                                  const Icon(Icons.calendar_month_outlined, size:20),
                                ],
                              ),
                            ),
                          ),

                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectTime(context, true),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal:5, vertical: 10),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    selectedTimeFrom != null ? selectedTimeFrom!.format(context) : "Start Time",
                                    style: selectedTimeTo != null && selectedTimeFrom != null ? DateTime.now().copyWith(hour: selectedTimeTo!.hour, minute: selectedTimeTo!.minute).isAfter(DateTime.now().copyWith(hour: selectedTimeFrom!.hour, minute: selectedTimeFrom!.minute)) ?  mainFont.copyWith(fontSize: 17) : mainFont.copyWith(fontSize: 17, color: Colors.red) : mainFont.copyWith(fontSize:17),
                                  ),
                                  const Icon(Icons.arrow_drop_down),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text("to", style: mainFont),
                        const SizedBox(width: 5),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => _selectTime(context, false),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal:5, vertical: 10),
                              decoration: BoxDecoration(
                                border: Border.all(color: const Color.fromARGB(255, 0, 0, 0)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    selectedTimeTo != null ? selectedTimeTo!.format(context) : "End Time",
                                    style: selectedTimeTo != null && selectedTimeFrom != null ? DateTime.now().copyWith(hour: selectedTimeTo!.hour, minute: selectedTimeTo!.minute).isAfter(DateTime.now().copyWith(hour: selectedTimeFrom!.hour, minute: selectedTimeFrom!.minute)) ?  mainFont.copyWith(fontSize: 17) : mainFont.copyWith(fontSize: 17, color: Colors.red) : mainFont.copyWith(fontSize:17),
                                  ),
                                  const Icon(Icons.arrow_drop_down),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
            )
              )
              ),
            const SizedBox(height:20),
            ElevatedButton(onPressed: nextEnabled() ? (){
              
              for(var item in fixedPrepared){
                if(preparedBools[fixedPrepared.indexOf(item)] == true){
                  final itemQuantity = fixedPreparedQuantities[fixedPrepared.indexOf(item)];
                  if(itemQuantity != 0){
                    setState(() {
                      allPrepareds.add(item);
                      allPreparedsQuantities.add(itemQuantity);
                    });
                  }
                  
                }
              }
              for(var item in otherPreparedMeals){
                setState(() {
                  allPrepareds.add(item.name);
                  allPreparedsQuantities.add(item.quantity);
                });
              }

              for(var item in fixedPerishables){
                if(perishableBools[fixedPerishables.indexOf(item)] == true){
                  final itemQuantity = fixedPerishableQuantities[fixedPerishables.indexOf(item)];
                  if(itemQuantity != 0){
                    setState(() {
                      allPerishables.add(item);
                      allPerishablesQuantities.add(itemQuantity);
                    });
                  }

                }
              }
              for(var item in otherPerishables){
                setState(() {
                  allPerishables.add(item.name);
                  allPerishablesQuantities.add(item.quantity);
                });
              }

              for(var item in fixedNonperishables){
                if(nonperishableBools[fixedNonperishables.indexOf(item)] == true){
                  final itemQuantity = fixedNonperishableQuantities[fixedNonperishables.indexOf(item)];
                  if(itemQuantity != 0){
                    setState(() {
                      allNonPerishables.add(item);
                      allNonPerishablesQuantities.add(itemQuantity);
                    });
                  }

                }
              }
              for(var item in otherNonPerishables){
                setState(() {
                  allNonPerishables.add(item.name);
                  allNonPerishablesQuantities.add(item.quantity);
                });
              }

              setState(() {
                startDate = "${selectedDateFrom!.month.toString()}/${selectedDateFrom!.day.toString()}/${selectedDateFrom!.year.toString()[2]}${selectedDateFrom!.year.toString()[3]}";
                endDate = "${selectedDateTo!.month.toString()}/${selectedDateTo!.day.toString()}/${selectedDateTo!.year.toString()[2]}${selectedDateTo!.year.toString()[3]}";
                startTime = selectedTimeFrom!.format(context);
                endTime = selectedTimeTo!.format(context);
              });

              Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ConfirmationPage(),
                      ),
                    );
            }: null,            
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
                child: Text(
                'Next',
                style: GoogleFonts.poiretOne(color: const Color.fromRGBO(72,164,244, 1), fontWeight: FontWeight.w800, fontSize: 20),
                )
              ,),
            const SizedBox(height: 20),
          ]
        )
      ),
      
    ));
  }
}
class ConfirmationPage extends StatefulWidget {
  const ConfirmationPage({Key? key}) : super(key: key);

  @override
  State<ConfirmationPage> createState() => _ConfirmationPageState();
}

class _ConfirmationPageState extends State<ConfirmationPage> {
  bool editNameOfOrganization = false;
  bool editAddress = false;
  bool editEmail = false;
  bool editContactPerson = false;
  bool editPhone = false;

  late TextEditingController _organizationNameController;
  late TextEditingController _addressController;
  late TextEditingController _emailController;
  late TextEditingController _contactPersonController;
  late TextEditingController _phoneController;
  final additionalInfoController = TextEditingController();
  final PageController _pageViewController = PageController(initialPage: 0);
  final int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
     
    _organizationNameController = TextEditingController(text: nameOfOrganization);
    _addressController = TextEditingController(text: addressOfOrganization);
    _emailController = TextEditingController(text: emailOfContact);
    _contactPersonController = TextEditingController(text: nameOfContact);
    _phoneController = TextEditingController(text: phoneOfContact);
  }

  void onConfirm() {
    setState(() {
      editNameOfOrganization ? nameOfOrganization = _organizationNameController.text : null;
      editAddress ? addressOfOrganization = _addressController.text : null;
      editEmail ? EmailValidator.validate(_emailController.text) ? emailOfContact = _emailController.text : null : null;
      editContactPerson ? nameOfContact = _contactPersonController.text : null;
      editPhone ? _phoneController.text.length == 14 ? phoneOfContact = _phoneController.text : null : null;

      editNameOfOrganization = false;
      editAddress = false;
      editEmail = EmailValidator.validate(_emailController.text) ? false : true;
      editContactPerson = false;
      editPhone = _phoneController.text.length == 14 ? false : true;
    });
  }


  bool _isScrollEnabled = false; // To track if scrolling is enabled

  // Function to toggle scrolling
  void _toggleScrolling(bool enableScrolling) {
    setState(() {
      _isScrollEnabled = enableScrolling;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(0, 3, 3, 3),
          leading: BackButton(
            onPressed: () {
              Navigator.of(context).pop();
              allPerishables = [];
              allPerishablesQuantities = [];
              allNonPerishables = [];
              allNonPerishablesQuantities = [];
              allPrepareds = [];
              allPreparedsQuantities = [];
            },
            color: const Color.fromRGBO(72, 164, 244, 1),
          ),
          elevation: 0,
        ),
        body: Center(
          child: Column(
            children: [
              Text("Confirm Information\n", style: mainFont.copyWith(fontSize: 25)),
              Expanded(
                child: PageView(
                  controller: _pageViewController,
                  physics: _isScrollEnabled ? const AlwaysScrollableScrollPhysics() : const NeverScrollableScrollPhysics(), // Disable swiping
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        width: 300,
                        height: 500,
                        padding: const EdgeInsets.all(16.0),
                        decoration: containerDecor,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Organization Information", style: mainFont),
                              Text(
                                'Type of Organization: $typeOfOrganization',
                                style: mainFont.copyWith(fontSize: 13),
                              ),
                              const SizedBox(height: 10),
                              const Divider(),
                              const SizedBox(height: 10),

                              _buildEditableField('Name of Organization:', nameOfOrganization,
                                  _organizationNameController, editNameOfOrganization),
                              _buildEditableField('Address:', addressOfOrganization, _addressController, editAddress),
                              _buildEditableField('Email:', emailOfContact, _emailController, editEmail),
                              _buildEditableField('Contact Person:', nameOfContact, _contactPersonController, editContactPerson),
                              _buildEditableField('Phone:', phoneOfContact, _phoneController, editPhone),

                              const SizedBox(height: 16),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    _toggleScrolling(true); // Enable scrolling temporarily
                                    _pageViewController.animateToPage(
                                      _currentPageIndex + 1,
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.ease,
                                    );
                                    _toggleScrolling(false); // Disable scrolling after scrolling to the next page
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: const CircleBorder(),
                                  ),
                                  child: const Icon(Icons.check, color: Colors.white),
                                ),
                              ),

                              const SizedBox(height: 5),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        width: 300,
                        height: 300,
                        padding: const EdgeInsets.all(16.0),
                        decoration: containerDecor,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text("Food Information", style: mainFont),
                              Text(
                                'Perishables:',
                                style: mainFont.copyWith(fontSize: 18),
                              ),
                              allPerishables.length == 0 ?
                                Text("None", style: mainFont.copyWith(color: Colors.red, fontSize: 13)) :
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: allPerishables.length,
                                  itemBuilder: (context, index) {
                                    return Text(
                                      '${allPerishables[index]} - ${allPerishablesQuantities[index]} lbs',
                                      style: mainFont.copyWith(fontSize: 13),
                                    );
                                  },
                                ),
                              
                              const SizedBox(height: 16.0),
                              Text(
                                'Non-Perishables:',
                                style: mainFont.copyWith(fontSize: 18),
                              ),
                              allNonPerishables.length == 0 ?
                              Text("None", style: mainFont.copyWith(color: Colors.red, fontSize: 13)) :
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: allNonPerishables.length,
                                itemBuilder: (context, index) {
                                  return Text(
                                    '${allNonPerishables[index]} - ${allNonPerishablesQuantities[index]} lbs',
                                    style: mainFont.copyWith(fontSize: 13),
                                  );
                                },
                              ),
                              const SizedBox(height: 16.0),
                              Text(
                                'Prepared Foods:',
                                style: mainFont.copyWith(fontSize: 18),
                              ),
                              allPrepareds.length == 0 ?
                              Text("None", style: mainFont.copyWith(color: Colors.red, fontSize: 13)) :
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: allPrepareds.length,
                                itemBuilder: (context, index) {
                                  return Text(
                                    '${allPrepareds[index]} - ${allPreparedsQuantities[index]} lbs',
                                    style: mainFont.copyWith(fontSize: 13),
                                  );
                                },
                              ),
                              const SizedBox(height: 16.0),
                              Text("Confirm Pick-up Time Range", style: mainFont),
                              Text('Start Date: $startDate', style: mainFont.copyWith(fontSize: 13)),
                              Text('End Date: $endDate', style: mainFont.copyWith(fontSize: 13)),
                              Text('Start Time: $startTime', style: mainFont.copyWith(fontSize: 13)),
                              Text('End Time: $endTime', style: mainFont.copyWith(fontSize: 13)),
                              Text("Additional Information", style: mainFont),
                              Container(
                                decoration: containerDecor,
                                child: 
                                Padding(padding: const EdgeInsets.only(left: 15, right: 15), child:TextField(
                                  maxLength: 500,
                                  style: GoogleFonts.poiretOne(color: const Color.fromARGB(255, 101, 101, 101), fontWeight: FontWeight.w800, fontSize: 14),
                                  decoration: InputDecoration(hintText: "Pickup instructions, specific days of the week you are available, specific food information, etc.", 
                                                              
                                                              hintStyle: GoogleFonts.poiretOne(color: const Color.fromARGB(255, 101, 101, 101), 
                                                              fontWeight: FontWeight.w800),
                                                              border: InputBorder.none,
                                                              
                                                              ),
                                  minLines: 5,
                                  maxLines: 15,
                                  controller: additionalInfoController
                                
                              ),)
                                
                                
                              ),
                              
                              ElevatedButton(
                                onPressed: () {
                                  Post newPost = Post(
                                    orgType: typeOfOrganization,
                                    orgAdd: addressOfOrganization,
                                    orgName: nameOfOrganization,
                                    contactName: nameOfContact,
                                    contactEmail: emailOfContact,
                                    contactPhone: phoneOfContact,
                                    allPerishables: allPerishables,
                                    allPerishablesQuantities: allPerishablesQuantities,
                                    allNonPerishables: allNonPerishables,
                                    allNonPerishablesQuantities: allNonPerishablesQuantities,
                                    allPrepareds: allPrepareds,
                                    allPreparedsQuantities: allPreparedsQuantities,
                                    startDate: startDate,
                                    endDate: endDate,
                                    startTime: startTime,
                                    endTime: endTime,
                                    additionalInfo: additionalInfoController.text,
                                    timestamp: DateTime.now(),
                                    author: FirebaseAuth.instance.currentUser!.uid.toString(),
                                  );
                                  Map<String, dynamic> postMap = newPost.toMap();
                                  ref.child('posts').push().set(postMap).then((_) {
                                        print('Post added to the database.');
                                      }).catchError((error) {
                                        print('Error adding post: $error');
                                      });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: const CircleBorder(),
                                ),
                                child: const Icon(Icons.check, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50,),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditableField(String label, String value, TextEditingController controller, bool isEditing) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: mainFont.copyWith(fontSize: 13)),
        const SizedBox(height: 5),
        if (isEditing)
          if(label == "Phone:")
            TextField(
              style: mainFont.copyWith(fontSize: 13),
              controller: controller,
              keyboardType: TextInputType.phone,
              autocorrect: false,
              inputFormatters: [
                PhoneInputFormatter(
                  allowEndlessPhone: false,
                  defaultCountryCode: "US",
                )
              ],
            )
          else
          TextFormField(
            controller: controller,
            style: mainFont.copyWith(fontSize: 13),
          )
        else
          Text(
            value,
            style: mainFont.copyWith(fontSize: 13),
          ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed:
              
              () {
                
                setState(() {
                  if (isEditing) {
                    onConfirm();
                  } else {
                    if (label == 'Name of Organization:') {
                      editNameOfOrganization = true;
                      editAddress = false;
                      editEmail = false;
                      editContactPerson = false;
                      editPhone = false;
                    } else if (label == 'Address:') {
                      editAddress = true;
                      editNameOfOrganization = false;
                      editEmail = false;
                      editContactPerson = false;
                      editPhone = false;
                    } else if (label == 'Email:') {
                      editEmail = true;
                      editNameOfOrganization = false;
                      editAddress = false;
                      editContactPerson = false;
                      editPhone = false;
                    } else if (label == 'Contact Person:') {
                      editContactPerson = true;
                      editNameOfOrganization = false;
                      editAddress = false;
                      editEmail = false;
                      editPhone = false;
                    } else if (label == 'Phone:') {
                      editPhone = true;
                      editNameOfOrganization = false;
                      editAddress = false;
                      editEmail = false;
                      editContactPerson = false;
                    }
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                primary: isEditing ? Colors.green : Colors.grey,
                shape: const CircleBorder(),
              ),
              child: Icon(isEditing ? Icons.check : Icons.edit, color: Colors.white),
            ),
          ],
        ),
        const Divider(),
        const SizedBox(height: 10),
      ],
      
    );
  }
}
class Post {
  final String orgType;
  final String orgAdd;
  final String orgName;
  final String contactName;
  final String contactEmail;
  final String contactPhone;
  final List allPerishables;
  final List allPerishablesQuantities;
  final List allNonPerishables;
  final List allNonPerishablesQuantities;
  final List allPrepareds;
  final List allPreparedsQuantities;
  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;
  final String additionalInfo;
  final DateTime timestamp;
  final String author;

  Post({
    required this.orgType,
    required this.orgAdd,
    required this.orgName,
    required this.contactName,
    required this.contactEmail,
    required this.contactPhone,
    required this.allPerishables,
    required this.allPerishablesQuantities,
    required this.allNonPerishables,
    required this.allNonPerishablesQuantities,
    required this.allPrepareds,
    required this.allPreparedsQuantities,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.additionalInfo,
    required this.timestamp,
    required this.author,
  });

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      orgType: map['orgType'],
      orgAdd: map['orgAdd'],
      orgName: map['orgName'],
      contactName: map['contactName'],
      contactEmail: map['contactEmail'],
      contactPhone: map['contactPhone'],
      allPerishables: map['allPerishables'],
      allPerishablesQuantities: map['allPerishablesQuantities'],
      allNonPerishables: map['allNonPerishables'],
      allNonPerishablesQuantities: map['allNonPerishablesQuantities'],
      allPrepareds: map['allPrepareds'],
      allPreparedsQuantities: map['allPreparedsQuantities'],
      startDate: map['startDate'],
      endDate: map['endDate'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      additionalInfo: map['additionalInfo'],
      timestamp: DateTime.parse(map['timestamp']),
      author: map['author']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orgType': orgType,
      'orgAdd': orgAdd,
      'orgName': orgName,
      'contactName': contactName,
      'contactEmail': contactEmail,
      'contactPhone': contactPhone,
      'allPerishables': allPerishables,
      'allPerishablesQuantities': allPerishablesQuantities,
      'allNonPerishables': allNonPerishables,
      'allNonPerishablesQuantities': allNonPerishablesQuantities,
      'allPrepareds': allPrepareds,
      'allPreparedsQuantities': allPreparedsQuantities,
      'startDate': startDate,
      'endDate': endDate,
      'startTime': startTime,
      'endTime': endTime,
      'timestamp': timestamp.toIso8601String(),
      'author': FirebaseAuth.instance.currentUser!.uid.toString()
    };
  }
}
