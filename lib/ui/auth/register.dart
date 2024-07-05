import 'package:shop_online/models/auth/signup_model.dart';
import 'package:shop_online/views/shared/export_packages.dart';
import 'package:shop_online/views/shared/export.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool validation = false;

  void formValidation() {
    if (email.text.isNotEmpty &&
        password.text.isNotEmpty &&
        username.text.isNotEmpty) {
      validation = true;
    } else {
      validation = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var authNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 50,
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
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
              text: 'Fill in your details to Register',
              style: appstyle(14, Colors.white, FontWeight.normal),
            ),
            const SizedBox(
              height: 50,
            ),
            CustomTextField(
                keyboard: TextInputType.emailAddress,
                hintText: 'Username',
                validator: (username) {
                  if (username!.isEmpty) {
                    return 'Please enter a valid Username!';
                  } else {
                    return null;
                  }
                },
                controller: username),
            const SizedBox(
              height: 15,
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
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ReusableText(
                    text: "Login",
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
                  SignupModel model = SignupModel(
                      email: email.text,
                      password: password.text,
                      username: username.text);
                  authNotifier.registerUser(model).then(
                    (response) {
                      if (response == true) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      } else {
                        debugPrint('register failed');
                      }
                    },
                  );
                } else {
                  debugPrint('form invalid');
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
                    text: 'R E G I S T E R',
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
