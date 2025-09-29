import 'package:employee_service_system/app/models/empInfoModels/time_off.dart';
import 'package:employee_service_system/app/providers/employeeProviders/employeeInfo/employee_info_provider.dart';
import 'package:employee_service_system/app/providers/employeeProviders/employeeInfo/time_offs_provider.dart';
import 'package:employee_service_system/app/services/pref_service.dart';
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
  TimeOffTypes _type = TimeOffTypes.clientVisit;
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
    final df = DateFormat('MMM dd, yyyy');
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
                          'New Time Off Request',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  DropdownButtonFormField<TimeOffTypes>(
                    initialValue: _type,
                    decoration: const InputDecoration(labelText: 'Type'),
                    items: TimeOffTypes.values
                        .map(
                          (t) => DropdownMenuItem(
                            value: t,
                            child: Text(_typeLabel(t)),
                          ),
                        )
                        .toList(),
                    onChanged: (v) => setState(() => _type = v ?? _type),
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
                            decoration: const InputDecoration(
                              labelText: 'From',
                            ),
                            child: Text(
                              _from == null ? 'Select date' : df.format(_from!),
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
                            decoration: const InputDecoration(labelText: 'To'),
                            child: Text(
                              _to == null ? 'Select date' : df.format(_to!),
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
                      labelText: 'Description',
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
                        const Icon(Icons.send),
                        SizedBox(width: 10.w),
                        const Text('Submit'),
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
      type: _type,
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

String _typeLabel(dynamic type) {
  final String t = type.toString();
  return t
      .replaceAll('TimeOffTypes.', '')
      .replaceAllMapped(RegExp(r'([A-Z])'), (m) => ' ${m.group(1)}')
      .replaceAll('_', ' ')
      .trim()
      .splitMapJoin(
        ' ',
        onNonMatch: (s) => s.isEmpty ? '' : s[0].toUpperCase() + s.substring(1),
      );
}
