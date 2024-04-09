import 'package:flutter/material.dart';
import 'package:flutter_expense_tracker/controller/add_record_screen_controller.dart';
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
                const CircleAvatar(radius: 24),
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
            sliver: SliverList.separated(
              itemBuilder: (context, index) {
                return TransactionCard(
                  item: RecordModel(
                      title: 'title',
                      category: 'category',
                      amount: 12345,
                      date: DateTime(2024, 4, 7),
                      isIncome: true),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemCount: 50,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorConstants.black26,
        shape: const CircleBorder(),
        onPressed: () {
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
        },
        child: const Icon(
          Icons.add,
          color: ColorConstants.primaryWhite,
        ),
      ),
    );
  }
}
