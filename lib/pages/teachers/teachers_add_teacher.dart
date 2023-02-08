import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/teacher.dart';
import '../../repository/teachers_repository.dart';

class AddTeacher extends ConsumerStatefulWidget {
  const AddTeacher({super.key});

  @override
  ConsumerState<AddTeacher> createState() => _AddTeacherState();
}

class _AddTeacherState extends ConsumerState<AddTeacher> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _gender;
  Map<String, dynamic> _formData = {};
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe7e5df),
      appBar: AppBar(
        title: const Text("Add a teacher"),
        backgroundColor: const Color(0xff540d6e),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                enabled: isLoading ? false : true,
                decoration: const InputDecoration(label: Text("Name")),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "You have to enter a name to continue.";
                  }
                },
                onSaved: (newValue) {
                  _formData["name"] = newValue;
                },
              ),
              TextFormField(
                enabled: isLoading ? false : true,
                decoration: const InputDecoration(label: Text("Surname")),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "You have to enter a surname to continue.";
                  }
                },
                onSaved: (newValue) {
                  _formData["surname"] = newValue;
                },
              ),
              TextFormField(
                enabled: isLoading ? false : true,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(label: Text("Age")),
                validator: (value) {
                  if (value == null || int.tryParse(value) == null) {
                    return "You have to enter a age to continue.";
                  }
                },
                onSaved: (newValue) {
                  _formData["age"] = int.parse(newValue!);
                },
              ),
              DropdownButtonFormField(
                validator: (value) {
                  if (value == null) {
                    return "You have to select a gender to continue.";
                  }
                },
                items: isLoading
                    ? null
                    : const <DropdownMenuItem>[
                        DropdownMenuItem(
                          value: "male",
                          child: Text("Male"),
                        ),
                        DropdownMenuItem(
                          value: "female",
                          child: Text("Female"),
                        ),
                      ],
                onChanged: (value) => setState(() {
                  _gender = value;
                }),
              ),
              const SizedBox(height: 16),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      onPressed: () {
                        final FormState? formState = _formKey.currentState;
                        if (formState == null) return;
                        if (formState.validate() == true) {
                          formState.save();
                          _save();
                        }
                      },
                      child: const Text("Save & Add"),
                    )
            ],
          ),
        ),
      ),
    );
  }

  void _save() async {
    bool loop = true;

    while (loop) {
      try {
        setState(() {
          isLoading = true;
        });
        await runSave();
        loop = false;
        Navigator.of(context).pop(true);
      } catch (e) {
        final snackBar = ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
        await snackBar.closed;
      } finally {
        setState(() {
          isLoading = false;
          loop = false;
        });
      }
    }
  }

  Future<void> runSave() async {
    await ref.read(teachersProvider).uploadTeacher(Teacher.fromMap(_formData));
  }
}
