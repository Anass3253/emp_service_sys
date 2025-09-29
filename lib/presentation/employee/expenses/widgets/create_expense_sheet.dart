import 'package:employee_service_system/app/models/empInfoModels/expenses.dart';
import 'package:employee_service_system/app/providers/employeeProviders/employeeInfo/employee_info_provider.dart';
import 'package:employee_service_system/app/providers/employeeProviders/employeeInfo/expenses_provider.dart';
import 'package:employee_service_system/app/providers/startDataProviders/expenses_categories_providers.dart';
import 'package:employee_service_system/app/services/pref_service.dart';
import 'package:employee_service_system/presentation/resources/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CreateExpenseSheet extends ConsumerStatefulWidget {
  const CreateExpenseSheet({super.key});

  @override
  ConsumerState<CreateExpenseSheet> createState() => _CreateExpenseSheetState();
}

class _CreateExpenseSheetState extends ConsumerState<CreateExpenseSheet> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime? date;

  Categories? _selectedCategory;
  String? _selectedCurrency;

  final List<String> _currencies = <String>[
    'USD',
    'EUR',
    'GBP',
    'AED',
    'SAR',
    'EGP',
  ];

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final newItem = Expenses(
      description: _descriptionController.text,
      category: _selectedCategory!.name.split(']').last.trim(),
      amount: double.parse(_amountController.text),
      currency: _selectedCurrency!,
      date: date!,
      state: 'Approved',
    );
    try {
      final currentToken = await PrefService.getToken();
      final emp = ref.read(empInfoProvider).value;
      if (emp == null) return;
      await ref
          .read(expensesProvider.notifier)
          .addExpense(newItem, emp, currentToken!);
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(
          Navigator.of(context, rootNavigator: true).context,
        ).showSnackBar(
          SnackBar(
            content: Text('$e'),
            duration: const Duration(seconds: 10),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(expensesCategoriesProvider);
    final df = DateFormat('yyyy-MM-dd');
    return DraggableScrollableSheet(
      expand: true,
      initialChildSize: 0.95,
      minChildSize: 0.8,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            16.w,
            12.h,
            16.w,
            16.h + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  Text(
                    'New Expense Request',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        DropdownButtonFormField<Categories>(
                          initialValue: _selectedCategory,
                          decoration: const InputDecoration(
                            labelText: 'Category',
                          ),
                          items: categories
                              .map(
                                (c) => DropdownMenuItem<Categories>(
                                  value: c,
                                  child: Text(c.name),
                                ),
                              )
                              .toList(),
                          onChanged: (value) => setState(() {
                            _selectedCategory = value;
                          }),
                          validator: (value) =>
                              value == null ? 'Please select a category' : null,
                        ),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _amountController,
                                decoration: const InputDecoration(
                                  labelText: 'Amount',
                                ),
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                      decimal: true,
                                    ),
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Amount is required';
                                  }
                                  final parsed = double.tryParse(value);
                                  if (parsed == null || parsed <= 0) {
                                    return 'Enter a valid amount';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                initialValue: _selectedCurrency,
                                decoration: const InputDecoration(
                                  labelText: 'Currency',
                                ),
                                items: _currencies
                                    .map(
                                      (c) => DropdownMenuItem<String>(
                                        value: c,
                                        child: Text(c),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) => setState(() {
                                  _selectedCurrency = value;
                                }),
                                validator: (value) => value == null
                                    ? 'Please select a currency'
                                    : null,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        InkWell(
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: context,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              initialDate: date ?? DateTime.now(),
                            );
                            if (picked != null) setState(() => date = picked);
                          },
                          child: InputDecorator(
                            decoration: const InputDecoration(
                              labelText: 'Date',
                            ),
                            child: Text(
                              date == null ? 'Select date' : df.format(date!),
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        TextFormField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            focusColor: Theme.of(context).colorScheme.onPrimary,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            labelStyle: Theme.of(
                              context,
                            ).textTheme.bodyLarge!.copyWith(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            labelText: 'Description',
                            alignLabelWithHint: true,
                          ),
                          minLines: 1,
                          maxLines: null,
                          textInputAction: TextInputAction.next,
                          validator: (value) =>
                              (value == null || value.trim().isEmpty)
                              ? 'Description is required'
                              : null,
                        ),
                        SizedBox(height: 20.h),
                        AppButton(
                          onPressed: _submit,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.send),
                              SizedBox(width: 10.w),
                              const Text('Submit'),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).viewInsets.bottom,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
