import 'package:financial_management/src/models/financial_record.dart';
import 'package:financial_management/src/ui/screens/common/left_side_bar.dart';
import 'package:financial_management/src/ui/screens/common/top_bar.dart';
import 'package:financial_management/src/ui/screens/dashboard/dashbard_screen.dart';
import 'package:financial_management/src/ui/screens/lottery/lottery.dart';
import 'package:financial_management/src/ui/screens/common/strings.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomeScreen> {
  List<FinancialRecord> records = [];
  Widget? contentWidget;

  void updateContent(Widget? content) {
    setState(() {
      contentWidget = content!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      const Expanded(
        flex: 1,
        child: TopBar(),
      ),
      Expanded(
          flex: 12,
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      LeftSideItem(
                          title: Strings.dashboard,
                          icon: Icons.dashboard,
                          onPressed: () {
                            updateContent(const DashboardScreen());
                          }),
                      LeftSideItem(
                        title: Strings.investing,
                        icon: Icons.money,
                        onPressed: () {
                          updateContent(null);
                        },
                      ),
                      LeftSideItem(
                        title: Strings.saving,
                        icon: Icons.savings,
                        onPressed: () {
                          updateContent(null);
                        },
                      ),
                      LeftSideItem(
                          title: Strings.lottery,
                          icon: Icons.payment,
                          onPressed: () {
                            updateContent(const Lottery());
                          }),
                      LeftSideItem(
                          title: Strings.exit,
                          icon: Icons.exit_to_app,
                          onPressed: () {
                            updateContent(Container());
                          }),
                    ],
                  )),
              Expanded(flex: 1, child: Container()),
              Expanded(flex: 6, child: Container(child: contentWidget)),
              Expanded(flex: 4, child: Container()),
            ],
          )),
      Expanded(
        flex: 1,
        child: Container(),
      )
    ]));
  }
}
