import 'package:employee_service_system/app/providers/employeeProviders/employeeInfo/employee_info_provider.dart';
import 'package:employee_service_system/app/providers/employeeProviders/employeeInfo/expenses_provider.dart';
import 'package:employee_service_system/app/providers/startDataProviders/expenses_categories_providers.dart';
import 'package:employee_service_system/app/services/pref_service.dart';
import 'package:employee_service_system/generated/l10n.dart';
import 'package:employee_service_system/presentation/employee/expenses/widgets/create_expense_sheet.dart';
import 'package:employee_service_system/presentation/employee/expenses/widgets/state_chip.dart';
import 'package:employee_service_system/routing/route_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ExpensesScreen extends ConsumerStatefulWidget {
  const ExpensesScreen({super.key});

  @override
  ConsumerState<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends ConsumerState<ExpensesScreen>
    with RouteAware {
  @override
  void initState() {
    Future.microtask(() async {
      final currentToken = await PrefService.getToken();
      if (currentToken != null) {
        ref
            .read(expensesCategoriesProvider.notifier)
            .getExpensesCategories(currentToken);
        final currentEmp = ref.read(empInfoProvider).value;
        if (currentEmp != null) {
          return ref
              .read(expensesProvider.notifier)
              .getExpenses(currentToken, currentEmp);
        }
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    Future.microtask(() async {
      final currentToken = await PrefService.getToken();
      if (currentToken != null) {
        final currentEmp = ref.read(empInfoProvider).value;
        if (currentEmp != null) {
          return ref
              .read(expensesProvider.notifier)
              .getExpenses(currentToken, currentEmp);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localLang = S.of(context);
    final expensesAsync = ref.watch(expensesProvider);

    Future<void> refresh() async {
      final currentToken = await PrefService.getToken();
      if (currentToken != null) {
        final currentEmp = ref.read(empInfoProvider).value;
        if (currentEmp != null) {
          await ref
              .read(expensesProvider.notifier)
              .getExpenses(currentToken, currentEmp);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(localLang.expensesTitle)),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: _openCreateSheet,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          localLang.requestExpense,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(color: Colors.white),
        ),
      ),
      body: expensesAsync.when(
        loading: () => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      SizedBox(height: 16.h),
                      Text(
                        localLang.loadingExpenses,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
        error: (e, __) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Colors.redAccent),
              SizedBox(height: 8.h),
              Text(localLang.failedToLoadExpenses),
              SizedBox(height: 8.h),
              TextButton(onPressed: refresh, child: Text(localLang.retry)),
            ],
          ),
        ),
        data: (expenses) {
          if (expenses.isEmpty) {
            return RefreshIndicator(
              onRefresh: refresh,
              child: Padding(
                padding: EdgeInsets.only(left: 15.w),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        localLang.noExpenses,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: refresh,
            child: ListView.separated(
              padding: EdgeInsets.all(12.h),
              itemCount: expenses.length,
              separatorBuilder: (_, __) => SizedBox(height: 8.h),
              itemBuilder: (context, index) {
                final expense = expenses[index];
                return Card(
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    title: Text(
                      expense.description,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4.h),
                        Text(
                          expense.category ?? localLang.uncategorized,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          _formatDate(expense.date),
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _formatAmount(expense.amount, expense.currency),
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4.h),
                        StateChip(state: expense.state),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

String _formatAmount(double amount, String currency) {
  return 'EGB ${amount.toStringAsFixed(2)}';
}

String _formatDate(DateTime date) {
  print(date);
  // return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  return DateFormat('yyyy-MM-dd').format(date);
}

extension on _ExpensesScreenState {
  Future<void> _openCreateSheet() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      constraints: const BoxConstraints(maxHeight: double.infinity),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(20.r),
      ),
      builder: (ctx) => const CreateExpenseSheet(),
    );

    final currentToken = await PrefService.getToken();
    if (currentToken != null) {
      final currentEmp = ref.read(empInfoProvider).value;
      if (currentEmp != null) {
        await ref
            .read(expensesProvider.notifier)
            .getExpenses(currentToken, currentEmp);
      }
    }
  }
}
