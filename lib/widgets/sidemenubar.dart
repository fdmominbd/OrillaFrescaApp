import 'package:flutter/material.dart';
import 'package:orilla_fresca_app/helpers/appcolors.dart';
import 'package:orilla_fresca_app/helpers/iconhelper.dart';
import 'package:orilla_fresca_app/services/loginservice.dart';
import 'package:orilla_fresca_app/widgets/iconfont.dart';
import 'package:provider/provider.dart';

class SideMenuBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    LoginService loginService = Provider.of<LoginService>(context, listen: false);
    bool userLoggedIn = loginService.loggedInUserModel != null;
    
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(50),
        color: AppColors.MAIN_COLOR,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                TextButton(
                  onPressed: () async {
                    if (userLoggedIn) {
                      await loginService.signOut();
                      Navigator.of(context).pushReplacementNamed('/welcomepage');
                    }
                    else {
                      bool success = await loginService.signInWithGoogle();
                      if (success) {
                        Navigator.of(context).pushNamed('/categorylistpage');
                      }
                    }
                  },
                  child: Row(
                    children: [
                      Icon(userLoggedIn ? Icons.logout : Icons.login, color: Colors.white, size: 20),
                      SizedBox(width: 10),
                      Text(userLoggedIn ? 'Sign Out' : 'Sign In',
                        style: TextStyle(color: Colors.white, fontSize: 20)
                      )
                    ],
                  )
                ),
                SizedBox(height: 10),
                Visibility(
                  visible: !userLoggedIn,
                  child: TextButton(
                    onPressed: () async {
                      Navigator.of(context).pushNamed('/welcomepage');
                    },
                    child: Row(
                      children: [
                        Icon(Icons.home, color: Colors.white, size: 20),
                        SizedBox(width: 10),
                        Text('Welcome',
                          style: TextStyle(color: Colors.white, fontSize: 20)
                        )
                      ],
                    )
                  )
                )
              ],
            ),
            IconFont(
              iconName: IconFontHelper.LOGO,
              size: 70,
              color: Colors.white
            )
          ],
        )
      )
    );
  }

}