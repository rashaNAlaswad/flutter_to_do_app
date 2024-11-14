import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../core/utils/app_strings.dart';

import '../../../../../core/utils/app_assets.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          AppAssets.noTasks,
          width: 300.w,
          height: 300.h,
          fit: BoxFit.fill,
        ),
        Text(
          AppStrings.noTaskTitle,
          style: Theme.of(context).textTheme.bodyMedium!,
        ),
        Text(
          AppStrings.noTaskSubTitle,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}
