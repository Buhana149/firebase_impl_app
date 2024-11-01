import 'package:firebase_impl_app/utilities/dialogs/generic_dialog.dart';
import 'package:flutter/widgets.dart';

Future<void> showPasswordResetSentDialog(
  BuildContext context,
) {
  return showGenericDialog(
    context: context,
    title: 'Password reset',
    content:
        'We have now sent you a password reset link. Please check your email for more information',
    optionsBuilder: () => {
      'Ok': null,
    },
  );
}
