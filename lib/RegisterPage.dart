
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team/CalendarHomePage.dart';
import 'SuccessRegisterPage.dart';
import 'package:team/LoginPage.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: const RegisterForm(),
    );
  }
}

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  // 파이어베이스랑 연동을 시킬 뭔가 주체가 될 만한 걸 만들어 놓음
  final _authentication = FirebaseAuth.instance;
  // Form 위젯을 쓸 땐 global key 를 넣어야 함
  final _formkey = GlobalKey<FormState>();
  String email = '';
  String password = ''; // 입력할때마다 이 변수에 값 넣어줄거야
  String userName = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('Assets/Images/snow7.gif'),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          // global key를 사용하는 거의 유일한 사용
          key: _formkey,
          child: ListView(
            children: [
              const SizedBox(height: 50,),
              const Text(' 회원가입 ', style: TextStyle(
                fontFamily: 'title',
                  color: Color(0xFFFdf6eb),
                  fontSize: 25 , fontWeight: FontWeight.bold), ),
              const Text('\n가입을 하고 일정을 효율적으로 관리해보세요!', style: TextStyle(
                color: Colors.white,
              ),),
              const SizedBox(height: 30,),
              TextFormField(            // Email 입력창
                style: TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.people, color: Color(0xFF9c9c94),),
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color : Color(0xFF9c9c94),
                        width: 3,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20),
                    ),
                    ),
                labelText: 'Email',
                  labelStyle: TextStyle(color: Color(0xFF9c9c94),),
                ),
              onChanged: (value) { // value를 input 으로 넣음
                email = value; // 입력할 때 마다 변할거임
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              style: TextStyle(color: Colors.white),
              obscureText: true, // 입력시 ****** 처리
              obscuringCharacter: '*',
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.password, color: Color(0xFF9c9c94),),
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 3, color: Color(0xFF9c9c94),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(20),
                  ),
                ),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Color(0xFF9c9c94),),
                ),
                onChanged: (value) {
                  password = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: TextStyle(color: Colors.white),
                // 생성후 터미널에 flutter pub add cloud_firestore 치기
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.account_circle_sharp, color: Color(0xFF9c9c94),),
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3, color: Color(0xFF9c9c94),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20),
                    ),
                  ),
                  labelText: 'User Name',
                  labelStyle: TextStyle(color: Color(0xFF9c9c94),),
                ),
                onChanged: (value) {
                  userName = value;
                },
              ),
              SizedBox(height: 30,),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(elevation: 10,
                    backgroundColor: Color(0xFF9c9c94),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                      side: BorderSide(color: Color(0xFF9c9c94),),
                    ),
                  ),
                  // 버튼 눌렀을 때 register 하는 기능
                  // create를 하면 파이어 베이스랑 연동시키는 부분은 이거 하나임
                  // 주의해야할 점: 함수가 future 타입(비동기 방식)
                  // 우리는 로그인 하고 무언가 되길 원하는데(동기적인걸), 이게 등록이 된 다음에 뭔가가 되길 원하고 있음
                  // 따라서 await 를 붙여줌 -> 붙여주려면 async 함수에서만 쓸 수 있음
                  onPressed: () async {
                    try {
                      final newUser = await _authentication.createUserWithEmailAndPassword(email: email, password: password);
                      // set은 futuer type 이므로 비동기적 방식으로 불러와지는데, 우린 동기적 방식으로 사용할거야
                      await FirebaseFirestore.instance.collection('user').doc(newUser.user!.uid).set({
                        'userName' : userName,
                        'email' : email,
                      });
                      if (newUser.user != null) { // null이 아니면 입력한 폼들을 다 비울 것이다.(빈칸으로)
                        _formkey.currentState!.reset(); // 빨간줄 -> null이 되면 안된다 -> ! 붙여주기
                        if (!mounted) return;
                        // state가 tree에 마운트가 되었다를 확인하고 push를 하는게 좋음(오류 없음)
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const SuccessRegisterPage()));
                      }
                    } catch (e) { // 익명함수 e를 받음
                      print(e);
                    }
                  },
                  child: const Text('가입하기', style: TextStyle(fontFamily: 'title'),)),
              SizedBox(height: 20,),
              Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container( height:1.0,
                        width:150.0,
                        color:Color(0xFFFdf6eb),),
                      Text('  또는  ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.grey),),
                      Container( height:1.0,
                        width:150.0,
                        color:Color(0xFFFdf6eb),),
                    ],
                  )
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text('이미 회원이신가요?, ', style: TextStyle(
                    color: Color(0xFFFdf6eb),
                  ),),
                  TextButton(
                    child: const Text('이메일로 로그인', style: TextStyle(
                      color: Color(0xFFFdf6eb),
                      fontFamily: 'title',
                    ),),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
