import 'package:shop_online/models/auth/login_model.dart';
import 'package:shop_online/views/shared/export_packages.dart';
import 'package:shop_online/views/shared/export.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool validation = false;

  void formValidation() {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      validation = true;
    } else {
      validation = false;
    }
  } 

  @override
  Widget build(BuildContext context) {
    var authNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 50,
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
        decoration: const BoxDecoration(
          image: DecorationImage(
            opacity: 0.2,
            image: AssetImage('assets/images/bg.png'),
          ),
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ReusableText(
              text: 'Welcome!',
              style: appstyle(30, Colors.white, FontWeight.w600),
            ),
            ReusableText(
              text: 'Fill in your details to login to your account',
              style: appstyle(14, Colors.white, FontWeight.normal),
            ),
            const SizedBox(
              height: 50,
            ),
            CustomTextField(
                keyboard: TextInputType.emailAddress,
                hintText: 'Email',
                validator: (email) {
                  if (email!.isEmpty || !email.contains('@')) {
                    return 'Please enter a valid email address!';
                  } else {
                    return null;
                  }
                },
                controller: email),
            const SizedBox(
              height: 15,
            ),
            CustomTextField(
              hintText: 'Password',
              controller: password,
              obscureText: !authNotifier.isObsecure,
              suffixIcon: GestureDetector(
                onTap: () {
                  authNotifier.isObsecure = !authNotifier.isObsecure;
                },
                child: Icon(
                  authNotifier.isObsecure
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.black,
                ),
              ),
              validator: (password) {
                if (password!.isEmpty || password.length < 7) {
                  return 'Password Too Weak!';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Register(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ReusableText(
                    text: "Register",
                    style: appstyle(12, Colors.white, FontWeight.normal),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                formValidation();
                if (validation) {
                  LoginModel model =
                      LoginModel(email: email.text, password: password.text);

                  authNotifier.userLogin(model).then((response) {
                    if (response == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainScreen(),
                        ),
                      );
                    } else {
                      debugPrint('Login Failed');
                    }
                  });
                } else {
                  debugPrint('Login Failed');
                }
              },
              child: Container(
                height: 55,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: ReusableText(
                    text: 'L O G I N',
                    style: appstyle(16, Colors.black, FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
