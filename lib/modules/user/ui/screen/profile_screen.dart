import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:tasks/core/error/exception_manager.dart';
import 'package:tasks/core/routing/navigation_manager.dart';
import 'package:tasks/core/utils/color_manager.dart';
import 'package:tasks/core/utils/text_styles_manager.dart';
import 'package:tasks/generated/l10n.dart';
import 'package:tasks/modules/user/cubit/user_cubit.dart';
import 'package:tasks/modules/user/ui/screen/edit_worker_profile_screen.dart';

class WorkerProfileScreen extends StatelessWidget {
  const WorkerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserCubit cubit = UserCubit.get();

    // Load worker info if not loaded yet
    if (cubit.worker == null) {
      cubit.getUserInfo();
    }

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
          S.of(context).profile,
          style: TextStylesManager.whiteTitle,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: ColorManager.white),
            onPressed: () {
              if (cubit.worker != null) {
                context.push(EditWorkerProfileScreen(worker: cubit.worker!));
              }
            },
          ),
        ],
      ),
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserErrorState) {
            ExceptionManager.showMessage(state.exception);
          }
        },
        builder: (context, state) {
          if (state is GetUserInfoLoadingState || cubit.worker == null) {
            return Center(
                child: CircularProgressIndicator(color: ColorManager.orange));
          }

          final worker = cubit.worker!;

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 35.w,
                      height: 35.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorManager.grey.withOpacity(0.3),
                      ),
                      child: worker.imageUrl != null
                          ? ClipOval(
                              child: Image.network(
                                worker.imageUrl!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(
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
                  ),
                  SizedBox(height: 4.h),

                  // Worker Information Cards
                  _buildInfoCard(
                    context,
                    S.of(context).personalInformation,
                    [
                      _buildInfoItem(context, S.of(context).name,
                          "${worker.name} ${worker.surname}"),
                      _buildInfoItem(
                          context, S.of(context).email, worker.email),
                      _buildInfoItem(context, S.of(context).phoneNumber,
                          worker.phoneNumber),
                    ],
                  ),

                  SizedBox(height: 2.h),

                  _buildInfoCard(
                    context,
                    S.of(context).job,
                    [
                      _buildInfoItem(
                          context, S.of(context).job, worker.categoryId),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard(
      BuildContext context, String title, List<Widget> children) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: ColorManager.primaryDark.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorManager.grey.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: ColorManager.orange,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(color: ColorManager.grey.withOpacity(0.3)),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoItem(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: ColorManager.grey,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 0.8.h),
          Text(
            value,
            style: TextStyle(
              color: ColorManager.white,
              fontSize: 17.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
