import 'package:flutter/material.dart';
import 'package:my_bank/custom_widgets/chart_container.dart';
import 'package:my_bank/models/user_transactions.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math';

class SummaryCharts extends StatelessWidget {
  const SummaryCharts({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Transcation charts',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.onPrimary),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Chart summary',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 50),
                lineChart(context),
                const SizedBox(height: 25),
                barChart(context),
                const SizedBox(height: 25),
                pieChart(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // summary charts
  Widget lineChart(BuildContext context) {
    // for line chart
    final List<SampleTransactions> lineChart = List.generate(12, (index) {
      return SampleTransactions(
        xData: [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec'
        ][index],
        yData: Random().nextDouble() * 100000,
      );
    });

    return ChartContainer(
      child: SfCartesianChart(
        title: ChartTitle(
          text: 'Yearly Transactions Summary',
          alignment: ChartAlignment.center,
          textStyle: Theme.of(context).textTheme.bodyMedium,
          borderWidth: 1.2,
          borderColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        series: <CartesianSeries>[
          LineSeries<SampleTransactions, String>(
            dataSource: lineChart,
            xValueMapper: (SampleTransactions sales, _) => sales.xData,
            yValueMapper: (SampleTransactions sales, _) => sales.yData,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
            name: 'Amount transacted',
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          )
        ],
        legend: const Legend(
          isVisible: true,
        ),
        primaryXAxis: const CategoryAxis(
          title: AxisTitle(text: 'Months'),
          labelRotation: -45,
          labelStyle: TextStyle(fontSize: 12),
          interval: 1,
        ),
        primaryYAxis: const NumericAxis(
          labelRotation: -40,
        ),
      ),
    );
  }

  Widget barChart(BuildContext context) {
    final List<SampleTransactions> barChart = [
      SampleTransactions(
          xData: 'December',
          yData: Random().nextDouble() * 70000,
          yData2: Random().nextDouble() * 50000),
      SampleTransactions(
          xData: 'January',
          yData: Random().nextDouble() * 70000,
          yData2: Random().nextDouble() * 50000),
      SampleTransactions(
          xData: 'February',
          yData: Random().nextDouble() * 70000,
          yData2: Random().nextDouble() * 50000),
    ];

    return ChartContainer(
      child: SfCartesianChart(
        title: ChartTitle(
          text: 'Category Transaction Summary for the Past 3 Months',
          alignment: ChartAlignment.center,
          textStyle: Theme.of(context).textTheme.bodyMedium,
          borderWidth: 1.2,
          borderColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        enableSideBySideSeriesPlacement: true,
        primaryXAxis: const CategoryAxis(
          title: AxisTitle(text: 'Months'),
          labelRotation: -45,
        ),
        series: <CartesianSeries>[
          ColumnSeries<SampleTransactions, String>(
            dataSource: barChart,
            name: 'Mobile Money',
            xValueMapper: (SampleTransactions sales, _) => sales.xData,
            yValueMapper: (SampleTransactions sales, _) => sales.yData,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
          ColumnSeries<SampleTransactions, String>(
            dataSource: barChart,
            name: 'Bank to Bank',
            xValueMapper: (SampleTransactions sales, _) => sales.xData,
            yValueMapper: (SampleTransactions sales, _) => sales.yData2,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          ),
        ],
        legend: const Legend(
          isVisible: true,
        ),
      ),
    );
  }

  // pie chart
  Widget pieChart(BuildContext context) {
    final List<SampleTransactions> pieData = [
      SampleTransactions(xData: 'Send money to bank', yData: 35),
      SampleTransactions(xData: 'Pay bill', yData: 45),
      SampleTransactions(xData: 'Mobile money', yData: 20),
    ];

    return ChartContainer(
      child: SfCircularChart(
        title: const ChartTitle(
          text: 'Transaction Distribution',
        ),
        legend: const Legend(
          isVisible: true,
        ),
        series: <PieSeries>[
          PieSeries<SampleTransactions, String>(
            dataSource: pieData,
            xValueMapper: (SampleTransactions data, _) => data.xData,
            yValueMapper: (SampleTransactions data, _) => data.yData,
            dataLabelSettings: const DataLabelSettings(isVisible: true),
          )
        ],
      ),
    );
  }
}
