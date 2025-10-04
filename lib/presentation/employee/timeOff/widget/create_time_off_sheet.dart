import 'package:employee_service_system/app/models/empInfoModels/time_off.dart';
import 'package:employee_service_system/app/providers/employeeProviders/employeeInfo/employee_info_provider.dart';
import 'package:employee_service_system/app/providers/employeeProviders/employeeInfo/time_offs_provider.dart';
import 'package:employee_service_system/app/providers/startDataProviders/timeoff_types_provider.dart';
import 'package:employee_service_system/app/services/pref_service.dart';
import 'package:employee_service_system/generated/l10n.dart';
import 'package:employee_service_system/presentation/resources/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class CreateTimeOffSheet extends ConsumerStatefulWidget {
  const CreateTimeOffSheet({super.key});

  @override
  ConsumerState<CreateTimeOffSheet> createState() => _CreateTimeOffSheetState();
}

class _CreateTimeOffSheetState extends ConsumerState<CreateTimeOffSheet> {
  final _formKey = GlobalKey<FormState>();
  Types? _selectedType;
  DateTime? _from;
  DateTime? _to;
  final TextEditingController _descCtrl = TextEditingController();

  @override
  void dispose() {
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localLang = S.of(context);
    final df = DateFormat('MMM dd, yyyy');
    final types = ref.watch(timeoffTypesProvider);
    return DraggableScrollableSheet(
      expand: true,
      initialChildSize: 0.95,
      minChildSize: 0.8,
      maxChildSize: 0.95,
      builder: (context, scrollCtl) {
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
              controller: scrollCtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          localLang.newTimeOffReq,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  DropdownButtonFormField<Types>(
                    initialValue: _selectedType,
                    decoration: InputDecoration(labelText: localLang.type),
                    items: types
                        .map(
                          (t) => DropdownMenuItem<Types>(
                            value: t,
                            child: Text(
                              t.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (v) =>
                        setState(() => _selectedType = v ?? _selectedType),
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: context,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              initialDate: _from ?? DateTime.now(),
                            );
                            if (picked != null) setState(() => _from = picked);
                          },
                          child: InputDecorator(
                            decoration: InputDecoration(
                              labelText: localLang.from,
                            ),
                            child: Text(
                              _from == null
                                  ? localLang.selectDate
                                  : df.format(_from!),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: context,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              initialDate: _to ?? (_from ?? DateTime.now()),
                            );
                            if (picked != null) setState(() => _to = picked);
                          },
                          child: InputDecorator(
                            decoration: InputDecoration(
                              labelText: localLang.to,
                            ),
                            child: Text(
                              _to == null
                                  ? localLang.selectDate
                                  : df.format(_to!),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  TextFormField(
                    controller: _descCtrl,
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
                      labelText: localLang.enterDescription,
                      alignLabelWithHint: true,
                    ),
                    minLines: 1,
                    maxLines: null,
                  ),
                  SizedBox(height: 30.h),
                  AppButton(
                    onPressed: _submit,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.send, color: Colors.white),
                        SizedBox(width: 10.w),
                        Text(
                          localLang.submit,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.copyWith(color: Colors.white),
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

  void _submit() async {
    if (_from == null || _to == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select from and to dates')),
      );
      return;
    }
    final newItem = TimeOff(
      type: _selectedType!.name,
      dateFrom: _from!,
      dateTo: _to!,
      description: _descCtrl.text.trim(),
      state: 'pending',
    );
    try {
      final currentToken = await PrefService.getToken();
      final emp = ref.read(empInfoProvider).value;
      if (emp == null) return;
      print('entering provider');
      final result = await ref
          .read(timeOffProvider.notifier)
          .addTimeOff(newItem, emp, currentToken!);
      print(result);
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
            content: Text(e.toString()),
            duration: const Duration(seconds: 10),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
