//This page displays a list of the most recent posts made by organizations that have excess food.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ffa_app/main.dart';
import 'package:ffa_app/screens/need_food_map.dart';


FirebaseDatabase database = FirebaseDatabase.instance;

//Function to get 10 most recent posts
Future<List<String>> retrieveRecents() async {
  List<String> postIDs = [];

  final ref = FirebaseDatabase.instance
      .ref('posts/')
      .limitToLast(10)
      .orderByChild('timestamp');
  await ref.get().then((snapshot) {
    for (final post in snapshot.children) {
      postIDs.add(post.key.toString());
    }
  });

  return postIDs;
}

//Function to get list all Perishables/Nonperishables/Prepareds from a specific post
Future<List<List<String>>> retrieveAll(String id, String allWhat) async {
  List<List<String>> myList = [[], []];

  List<String> recentPostIDs = await retrieveRecents(); // Await the Future

  if (recentPostIDs.isNotEmpty) {
    final snapshot = await FirebaseDatabase.instance.ref('posts/$id').get();

    if (snapshot.exists) {
      myList[0] = snapshot
          .child('all$allWhat')
          .value
          .toString()
          .replaceAll('[', '')
          .replaceAll(']', '')
          .trim()
          .split(',');
      myList[1] = snapshot
          .child('all${allWhat}Quantities')
          .value
          .toString()
          .replaceAll('[', '')
          .replaceAll(']', '')
          .trim()
          .split(',');
      print(myList);
    } else {
      print('No data available.');
    }
  } else {
    print('No recent post IDs available.');
  }

  return myList;
}
//Get information of a user from a user id
Future<String> retrieveUserInformation(String id, String path) async {
  try {
    final snapshot =
    await FirebaseDatabase.instance.ref('users/$id/$path').get();
    return snapshot.value.toString();
  } catch (e) {
    print('Error retrieving user information: $e');
    return 'Error: Unable to retrieve user information';
  }
}
//Get user information given a post id
Future<String> retrieveUserInformationFromPost(String id, String path) async{
  try {
    final snapshot =
    await FirebaseDatabase.instance.ref('posts/$id/author').get();
    print("AUTHOR: ${snapshot.value.toString()}");
    print("USERINFO: ${retrieveUserInformation(snapshot.value.toString(), '')}");
    return retrieveUserInformation(snapshot.value.toString(), path);
  } catch (e) {
    print('Error retrieving user information: $e');
    return 'Error: Unable to information';
  }
}
//Where each post is displayed
class existingListings extends StatefulWidget {
  final String? selectedValue;

  const existingListings({Key? key, this.selectedValue}) : super(key: key);

  @override
  State<existingListings> createState() => _existingListingsState();
}

class _existingListingsState extends State<existingListings> {
  List<String> LoadedPosts = [];
  //Load posts
  refresh() async{
    List<String> recentPostIDs = await retrieveRecents();

    setState(() {
      LoadedPosts = recentPostIDs;
      print("LOADING POSTS $LoadedPosts");
    });
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  //_selectedIndex for bottom bar
  int _selectedIndex = 1;
  //Text for bottom bar
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Maps'),
    Text('Show Listings'),
    Icon(Icons.add),
    Text('Account'),
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(0, 3, 3, 3),
          leading: BackButton(
            onPressed: () => Navigator.of(context).pop(),
            color: const Color.fromRGBO(72, 164, 244, 1),
          ),
          elevation: 0,
        ),
        body: Center(
          child: Column(
            children: [
              //Refresh button to update listings
              ElevatedButton(
                onPressed: () async {
                  List<String> recentPostIDs = await retrieveRecents();

                  setState(() {
                    LoadedPosts = recentPostIDs;
                    print("LOADING POSTS $LoadedPosts");
                  });
                },
                child: Text("Refresh"),
              ),
              Expanded(
                //Posts are displayed inside of the ListView widget
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  itemCount: LoadedPosts.length,
                  itemBuilder: (context, index) {
                    Future<String> userInfoFuture = retrieveUserInformation(
                        'UGLc5x02UabhgqiBhZvYzKUId262', //Temporarily manually putting a user id. In the future it will get the user id from the post id
                        'organizationInfo/name');
                    //Container to show preview of each post
                    return Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        decoration: containerDecor,
                        child:
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5),
                          child:
                          Column(
                            children: [
                              //Display relevant user information
                              FutureBuilder<String>(
                                future: userInfoFuture,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    return Column(
                                      children: [
                                        ListTile(
                                          title: Text(snapshot.data ??
                                              'User information not found',
                                              style: mainFont.copyWith(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Divider(
                                          thickness: 2,
                                          color: Colors.black,
                                        ),
                                      ],
                                    );
                                  }
                                },
                              ),
                              //Preview of the prepared meals available in the post
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Prepared Meals",
                                  style: mainFont.copyWith(fontSize: 18),
                                ),
                              ),
                              FutureBuilder<List<List<String>>>(
                                future: retrieveAll(
                                    LoadedPosts[index], "Prepareds"),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    List<String> prepareds =
                                        snapshot.data?[0] ??
                                            ['Information not found'];



                                    return ListTile(
                                      //If there are prepared meals available, display them seperated with a ', ', otherwise display a red '--' indicator
                                      title: prepareds[0] == 'null' ? Text("--", style: mainFont.copyWith(fontSize: 16, color: Colors.red)) : Text(
                                        prepareds.join(', '),
                                        style: mainFont.copyWith(fontSize: 16),
                                      ),
                                    );
                                  }
                                },
                              ),
                              if (LoadedPosts.isNotEmpty)
                                //Preview of perishables available in post
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Perishables",
                                    style: mainFont.copyWith(fontSize: 18),
                                  ),
                                ),
                              if (LoadedPosts.isNotEmpty)
                                FutureBuilder<List<List<String>>>(
                                  future: retrieveAll(
                                      LoadedPosts[index], "Perishables"),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      List<String> perishables =
                                          snapshot.data?[0] ?? [];

                                      return ListTile(
                                        //If there are perishables available, display them seperated with a ', ', otherwise display a red '--' indicator
                                        title: perishables[0] == 'null' ? Text("--", style: mainFont.copyWith(fontSize: 16, color: Colors.red)) : Text(
                                          perishables.join(', '),
                                          style: mainFont.copyWith(fontSize: 16),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              if (LoadedPosts.isNotEmpty)
                                //Preview of nonperishables available in post
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Non-Perishables",
                                    style: mainFont.copyWith(fontSize: 18),
                                  ),
                                ),
                              if (LoadedPosts.isNotEmpty)
                                FutureBuilder<List<List<String>>>(
                                  future: retrieveAll(
                                      LoadedPosts[index], "NonPerishables"),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return CircularProgressIndicator();
                                    } else if (snapshot.hasError) {
                                      return Text('Error: ${snapshot.error}');
                                    } else {
                                      List<String> nonPerishables =
                                          snapshot.data?[0] ?? [];

                                      return ListTile(
                                        //If there are nonperishables available, display them seperated with a ', ', otherwise display a red '--' indicator
                                        title: nonPerishables[0] == 'null' ? Text("--", style: mainFont.copyWith(fontSize: 16, color: Colors.red)) : Text(
                                          nonPerishables.join(', '),
                                          style: mainFont.copyWith(fontSize: 16),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              //See more information button
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      //Direct user to the page with more information on the post
                                      builder: (context) => postPage(postID: LoadedPosts[index]),
                                    ),
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("View Post", style: mainFont.copyWith(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w900)),
                                    Icon(Icons.arrow_forward),
                                  ],
                                ),
                              )

                            ],
                          ),
                        ));
                  },
                ),
              ),
            ],
          ),
        ),


      )
    );
  }
}
//Page template for each post
class postPage extends StatefulWidget {
  final String postID;

  const postPage({Key? key, required this.postID}) : super(key: key);

  @override
  State<postPage> createState() => _postPageState();
}
class _postPageState extends State<postPage> {
  String userName = '';
  String userAddress = '';
  String contactName = '';
  String contactEmail = '';
  String contactPhone = '';
  bool isContactInfoExpanded = false;

  bool isFoodInfoExpanded = false;
  @override
  void initState() {
    super.initState();
    loadUserInformation();
    foodInformationFuture = retrieveFoodInformation(widget.postID);
  }


  Future<void> loadUserInformation() async {
    userName = await retrieveUserInformationFromPost(widget.postID, 'organizationInfo/name');
    userAddress = await retrieveUserInformationFromPost(widget.postID, 'organizationInfo/address');
    contactName = await retrieveUserInformationFromPost(widget.postID, 'organizationInfo/contact/name');
    contactEmail = await retrieveUserInformationFromPost(widget.postID, 'organizationInfo/contact/email');
    contactPhone = await retrieveUserInformationFromPost(widget.postID, 'organizationInfo/contact/phone');

    setState(() {});
  }
  Future<List<List<String>>> retrieveFoodInformation(String id) async {
    List<List<String>> foodInfo = [[], [], [], [], [], []];
    //Retrieve food names and quantities
    List<String> preparedMeals = await retrieveAll(id, 'Prepareds').then((value) => value[0]);
    List<String> preparedMealsQuantities = await retrieveAll(id, 'PreparedsQuantities').then((value) => value[0]);
    List<String> perishables = await retrieveAll(id, 'Perishables').then((value) => value[0]);
    List<String> perishablesQuantities = await retrieveAll(id, 'PerishablesQuantities').then((value) => value[0]);
    List<String> nonPerishables = await retrieveAll(id, 'NonPerishables').then((value) => value[0]);
    List<String> nonPerishablesQuantities = await retrieveAll(id, 'NonPerishablesQuantities').then((value) => value[0]);
    //Store food names and quantities
    foodInfo[0] = preparedMeals;
    foodInfo[1] = perishables;
    foodInfo[2] = nonPerishables;
    foodInfo[3] = preparedMealsQuantities;
    foodInfo[4] = perishablesQuantities;
    foodInfo[5] = nonPerishablesQuantities;

    return foodInfo;
  }
  Future<List<List<String>>>? foodInformationFuture;

  void toggleContactInfoExpansion() {
    setState(() {
      isContactInfoExpanded = !isContactInfoExpanded;
    });
  }
  void toggleFoodInfoExpansion() {
    setState(() {
      isFoodInfoExpanded = !isFoodInfoExpanded;
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
            onPressed: () => Navigator.of(context).pop(),
            color: const Color.fromRGBO(72, 164, 244, 1),
          ),
          elevation: 0,
        ),
        body:
    SingleChildScrollView(
    child:Column(
          children: [
            // Display user name
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                userName.isNotEmpty ? userName : 'Name: Information not found',
                style: mainFont.copyWith(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),

            // Display user address
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                userAddress.isNotEmpty ? userAddress : 'Address: Information not found',
                style: mainFont.copyWith(fontSize: 20),
              ),
            ),
            //Divider
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                thickness: 2,
                color: Colors.black,
                height: 40,
              ),
            ),
            //Toggleable section for displaying contact information
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child:
              Container(
                width: double.infinity,
                decoration: containerDecor,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: toggleContactInfoExpansion,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Contact Information',
                              style: mainFont.copyWith(fontSize: 25),
                            ),
                            Icon(
                              isContactInfoExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Display contact details if expanded
                    if (isContactInfoExpanded)
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Name:',
                                  style: mainFont.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  contactName.isNotEmpty ? contactName : 'Information not found',
                                  style: mainFont.copyWith(fontSize: 20),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),  // Add some vertical spacing between items
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Email:',
                                  style: mainFont.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  contactEmail.isNotEmpty ? contactEmail : 'Information not found',
                                  style: mainFont.copyWith(fontSize: 20),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),  // Add some vertical spacing between items
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Phone:',
                                  style: mainFont.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  contactPhone.isNotEmpty ? contactPhone : 'Information not found',
                                  style: mainFont.copyWith(fontSize: 20),
                                ),
                              ],
                            ),
                            // Add more contact details as needed
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            //Toggleable section for displaying food information
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: double.infinity,
                decoration: containerDecor,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: toggleFoodInfoExpansion,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Food Information',
                              style: mainFont.copyWith(fontSize: 25),
                            ),
                            Icon(
                              isFoodInfoExpanded
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Display food details if expanded
                    if (isFoodInfoExpanded && foodInformationFuture != null)
                      FutureBuilder<List<List<String>>>(
                        future: foodInformationFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else if (snapshot.hasData) {
                            return Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Food Item',
                                          style: mainFont.copyWith(fontSize: 23, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                                        ),
                                        Text(
                                          'Quantity (lbs)',
                                          style: mainFont.copyWith(fontSize: 23, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                                        ),
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Prepared meals',
                                        style: mainFont.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    for (int i = 0; i < snapshot.data![0].length; i++)
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot.data![0][i],
                                              style: mainFont.copyWith(fontSize: 16),
                                            ),
                                            Text(
                                              '${snapshot.data![3][i]}',  // Display the quantity
                                              style: mainFont.copyWith(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),

                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Perishables',
                                        style: mainFont.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    for (int i = 0; i < snapshot.data![1].length; i++)
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot.data![1][i],
                                              style: mainFont.copyWith(fontSize: 16),
                                            ),
                                            Text(
                                              '${snapshot.data![4][i]}',  // Display the quantity
                                              style: mainFont.copyWith(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),

                                    Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Non-Perishables',
                                        style: mainFont.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    for (int i = 0; i < snapshot.data![2].length; i++)
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot.data![2][i],
                                              style: mainFont.copyWith(fontSize: 16),
                                            ),
                                            Text(
                                              '${snapshot.data![5][i]}',  // Display the quantity
                                              style: mainFont.copyWith(fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),

                                  ],
                                ),

                            );
                          } else {
                            return Center(child: Text('No food information available.'));
                          }
                        },
                      ),

                  ],
                ),
              ),
            ),


          ],
        ),
      ),

      )
    );
  }

}
