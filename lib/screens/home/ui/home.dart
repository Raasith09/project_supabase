import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_supabase/screens/error/error_page.dart';
import 'package:project_supabase/screens/home/bloc/home_bloc.dart';
import 'package:project_supabase/utils/colors.dart';
import 'package:project_supabase/utils/sized_box.dart';
import 'package:project_supabase/widgets/search_input.dart';
import '../../nointernet/nointernet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();
  List<Map<String, dynamic>> myList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        centerTitle: true,
        title: const Text(
          "Accounts Quality",
          style: TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: AppColors.mainThemeColor,
        actions: [
          IconButton(
              onPressed: () {
                context.read<HomeBloc>().add(DataRequested());
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              )),
        ],
      ),
      backgroundColor: AppColors.secondaryThemeColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.secondaryThemeColor,
                      offset: const Offset(-1, -3),
                    )
                  ],
                  color: AppColors.mainThemeColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    8.kH,
                    const Center(
                      child: Text(
                        "Welcome",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    25.kH,
                    SearchInput(
                        textController: title,
                        hintText: "Enter title",
                        myIcons: Icons.file_copy),
                    25.kH,
                    SearchInput(
                        textController: description,
                        hintText: "Enter description",
                        myIcons: Icons.title),
                    25.kH,
                    Center(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.purple, // Text color
                              elevation: 5, // Shadow elevation
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    12), // Rounded corners
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20), // Button padding
                            ),
                            onPressed: () {
                              if (title.text.isEmpty ||
                                  description.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      "Enter Valid Data.",
                                    ),
                                  ),
                                );
                              } else {
                                FocusManager.instance.primaryFocus?.unfocus();
                                context.read<HomeBloc>().add(
                                    DataPost(title.text, description.text));
                              }
                            },
                            child: const Text("Submit")))
                  ],
                ),
              ),
              30.kH,
              BlocListener<HomeBloc, HomeState>(
                listener: (context, state) {
                  if (state is HomeDataPostedSuccesfully) {
                    title.clear();
                    description.clear();
                    context.read<HomeBloc>().add(DataRequested());
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Data Updated Successfully",
                        ),
                      ),
                    );
                  }
                  if (state is HomeDataPostedUnSuccesfully) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.message,
                        ),
                      ),
                    );
                  }
                  if (state is HomewithNoInternet) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Nointernet()));
                  }
                  if (state is HomeError) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ErrorPage()));
                  }
                },
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoading) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    if (state is HomeGetData) {
                      myList = state.value;
                    }

                    return myList.isNotEmpty
                        ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: myList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: SizedBox(
                                  height: 70,
                                  child: ListTile(
                                    tileColor: AppColors.mainThemeColor,
                                    title: Text(
                                      myList[index]["title"],
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    isThreeLine: true,
                                    subtitle: Text(
                                      myList[index]["description"],
                                      style: TextStyle(
                                          fontSize: 14,
                                          color:
                                              AppColors.unhighlightedTextColor),
                                    ),
                                  ),
                                ),
                              );
                            })
                        : Column(
                            children: [
                              30.kH,
                              Center(
                                child: Image.asset(
                                  "assets/images/7466073.png",
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              10.kH,
                              const Text(
                                "No Data Found",
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
