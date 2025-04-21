import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:tasks/core/error/exception_manager.dart';
import 'package:tasks/core/utils/color_manager.dart';
import 'package:tasks/core/utils/text_styles_manager.dart';
import 'package:tasks/core/widgets/widgets.dart';
import 'package:tasks/generated/l10n.dart';
import 'package:tasks/modules/user/cubit/user_cubit.dart';
import 'package:tasks/modules/user/data/models/user.dart';
import 'package:tasks/modules/user/data/models/worker_update_form.dart';
import 'package:tasks/modules/user/ui/widgets/widgets.dart';

class EditWorkerProfileScreen extends StatefulWidget {
  final Worker worker;

  const EditWorkerProfileScreen({super.key, required this.worker});

  @override
  State<EditWorkerProfileScreen> createState() =>
      _EditWorkerProfileScreenState();
}

class _EditWorkerProfileScreenState extends State<EditWorkerProfileScreen> {
  late UserCubit cubit;
  late GlobalKey<FormState> formKey;
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController passwordController;
  late TextEditingController surnameController;
  late TextEditingController emailController;

  bool isPasswordAppears = false;
  File? selectedImage;

  @override
  void initState() {
    super.initState();
    cubit = UserCubit.get();
    formKey = GlobalKey<FormState>();
    nameController = TextEditingController(text: widget.worker.name);
    phoneController = TextEditingController(text: widget.worker.phoneNumber);
    passwordController = TextEditingController();
    surnameController = TextEditingController(text: widget.worker.surname);
    emailController = TextEditingController(text: widget.worker.email);
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    surnameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryDark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorManager.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          S.of(context).editProfile,
          style: TextStylesManager.whiteTitle,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(5.w),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 35.w,
                        height: 35.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorManager.grey.withOpacity(0.3),
                        ),
                        child: selectedImage != null
                            ? ClipOval(
                                child: Image.file(
                                  selectedImage!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : widget.worker.imageUrl != null
                                ? ClipOval(
                                    child: Image.network(
                                      widget.worker.imageUrl!,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) => Icon(
                                        Icons.person_outline,
                                        size: 18.w,
                                        color: ColorManager.grey,
                                      ),
                                    ),
                                  )
                                : Icon(
                                    Icons.person_outline,
                                    size: 18.w,
                                    color: ColorManager.grey,
                                  ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: CircleAvatar(
                            radius: 5.w,
                            backgroundColor: ColorManager.orange,
                            child: Icon(
                              Icons.camera_alt,
                              color: ColorManager.white,
                              size: 6.w,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 3.h),
                LabelText(text: S.of(context).name),
                Row(
                  spacing: 2.w,
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: nameController,
                        hintText: S.of(context).name,
                        prefixIcon: Icon(Icons.person_outline),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).enterName;
                          }
                          return null;
                        },
                      ),
                    ),
                    Expanded(
                      child: CustomTextField(
                        controller: surnameController,
                        hintText: S.of(context).surName,
                        prefixIcon: Icon(Icons.person_outline),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).enterSurname;
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                LabelText(text: S.of(context).phoneNumber),
                CustomTextField(
                  controller: phoneController,
                  hintText: "(XXX) XXX-XXXX",
                  prefixIcon: Icon(Icons.phone_outlined),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).enterPhone;
                    }
                    return null;
                  },
                ),
                LabelText(text: S.of(context).email),
                CustomTextField(
                  controller: emailController,
                  hintText: "worker@company.com",
                  prefixIcon: Icon(Icons.email_outlined),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).enterEmail;
                    }
                    return null;
                  },
                ),
                LabelText(text: S.of(context).newPassword),
                BlocBuilder<UserCubit, UserState>(
                  bloc: cubit,
                  builder: (context, state) {
                    return CustomTextField(
                      controller: passwordController,
                      hintText: S.of(context).leaveEmptyToKeepCurrent,
                      obscureText: isPasswordAppears,
                      suffixIcon: IconButton(
                        onPressed: () {
                          cubit.changePasswordAppearance(isPasswordAppears);
                        },
                        icon: Icon(isPasswordAppears
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                      prefixIcon: Icon(Icons.lock_outlined),
                      keyboardType: TextInputType.visiblePassword,
                    );
                  },
                ),
                SizedBox(height: 4.h),
                BlocConsumer<UserCubit, UserState>(
                  listener: (context, state) {
                    if (state is UpdateWorkerSuccessState) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text(S.of(context).profileUpdatedSuccessfully)),
                      );
                    }
                    if (state is ChangePasswordAppearanceState) {
                      setState(() {
                        isPasswordAppears = state.isPasswordVisible;
                      });
                    }
                    if (state is UserErrorState) {
                      ExceptionManager.showMessage(state.exception);
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      children: [
                        DefaultButton(
                          text: S.of(context).save,
                          isLoading: state is UpdateWorkerLoadingState,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              cubit.updateWorkerProfile(
                                WorkerUpdateForm(
                                  email: emailController.text,
                                  id: widget.worker.id,
                                  name: nameController.text,
                                  surname: surnameController.text,
                                  phoneNumber: phoneController.text,
                                  password: passwordController.text.isEmpty
                                      ? null
                                      : passwordController.text,
                                  image: selectedImage,
                                  imageUrl: widget.worker.imageUrl,
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 2.h),
                        DefaultButton(
                          text: S.of(context).cancel,
                          color: ColorManager.grey.withOpacity(0.3),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
