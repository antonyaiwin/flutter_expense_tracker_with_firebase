import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/controller/add_record_screen_controller.dart';
import 'package:flutter_expense_tracker/controller/database_controller.dart';
import 'package:flutter_expense_tracker/model/record_model.dart';
import 'package:provider/provider.dart';
import '../../core/constants/color_constants.dart';
import '../add_record_screen/add_record_screen.dart';
import 'widgets/summary_card.dart';
import 'widgets/transaction_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: ColorConstants.black26,
            title: Row(
              children: [
                const CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(
                      'https://images.pexels.com/photos/2380794/pexels-photo-2380794.jpeg?auto=compress&cs=tinysrgb&w=600'),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello Aiwin',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: ColorConstants.primaryWhite,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                    ),
                    Text(
                      'Welcome Back!',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: ColorConstants.primaryWhite,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.menu,
                  color: ColorConstants.primaryWhite,
                ),
              ),
            ],
          ),
          const SliverToBoxAdapter(
            child: SummaryCard(),
          ),
          SliverAppBar(
            primary: false,
            pinned: true,
            title: Text(
              'Recent Transactions',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 20),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(
              left: 25,
              right: 25,
              bottom: 100,
              top: 5,
            ),
            sliver: StreamBuilder(
                stream: context
                    .read<DatabaseController>()
                    .collection
                    .orderBy(
                      'date',
                      descending: true,
                    )
                    .snapshots(),
                builder: (context, snapshot) {
                  log('new snapshot');
                  if (!snapshot.hasData) {
                    return const SliverFillRemaining(
                      child: Center(
                        child: Text('No records found!'),
                      ),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SliverFillRemaining(
                        child: Center(child: CircularProgressIndicator()));
                  }
                  return SliverList.separated(
                    itemBuilder: (context, index) {
                      return TransactionCard(
                        item: RecordModel.fromMap(snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemCount: snapshot.data?.docs.length ?? 0,
                  );
                }),
          ),
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
        child: BottomNavigationBar(
          backgroundColor: ColorConstants.black26,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: ColorConstants.primaryWhite,
          unselectedItemColor: ColorConstants.primaryWhite.withOpacity(0.3),
          onTap: (value) {
            if (value == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ChangeNotifierProvider<AddRecordScreenController>(
                    create: (context) => AddRecordScreenController(),
                    child: const AddRecordScreen(),
                  ),
                ),
              );
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart_outlined), label: ''),
            BottomNavigationBarItem(
                icon: CircleAvatar(
                  backgroundColor: ColorConstants.primaryWhite,
                  radius: 16,
                  child: Icon(
                    Icons.add,
                    color: ColorConstants.black26,
                  ),
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.notifications_outlined), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: ''),
          ],
        ),
      ),
    );
  }
}
