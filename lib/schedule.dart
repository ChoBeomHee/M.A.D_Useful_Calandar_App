import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:team/SubjectsProvider.dart';

import 'package:team/personalView.dart';
User? loggedUser;
class Subject {
  String title;
  String start;
  String end;
  String memo;
  String type;
  String quiz_name;

  Subject(this.title, this.start, this.end, this.memo, this.type, this.quiz_name);
}
class ScheduleDetail extends StatefulWidget {
  ScheduleDetail({Key? key}) : super(key: key);

  @override
  State<ScheduleDetail> createState() => _ScheduleDetailState();
}

class _ScheduleDetailState extends State<ScheduleDetail> {

  /*List<Subject> todoList = [                          // 그냥 예시입니다!!
    Subject('DB','13:00-14:30','DB레포트 작성'),
    Subject('Graphics', '15:00-18:00', 'Texture, Lighting, 할거 짱 많네 아오'),
    Subject('Algorithm', '21:00-23:00', 'BFS'),
    Subject('DB','13:00-14:30','DB레포트 작성'),
    Subject('Graphics', '15:00-18:00', 'Texture, Lighting'),
    Subject('Algorithm', '21:00-23:00', 'BFS'),
    Subject('DB','13:00-14:30','DB레포트 작성'),
    Subject('Grahics', '15:00-18:00', 'Texture, Lighting'),
  ];*/

  final _authentication = FirebaseAuth.instance;

  // 이 페이지가 생성될 그 때만 인스턴스 전달만 해주면 됨
  Future<void> setSchedure_Assingment() async {
    var sub =  FirebaseFirestore.instance.collection('user').doc(_authentication.currentUser!.uid).collection('Subject').
    where('uid', isEqualTo: _authentication.currentUser!.uid).get();
    var check = await sub;

    for (int i = 0; i < check.docs.length; i++) {
      var todayAssingn =  FirebaseFirestore.instance.collection('user').doc(_authentication.currentUser!.uid).collection('Subject').
      doc(check.docs[i]['SubjectName']).collection('Assignment').get();

      var list = await todayAssingn;
      for (int i = 0; i < list.docs.length; i++) {
        if (intoDay(list.docs[i]['startYMDT'], list.docs[i]['endYMDT']) == true) {
          context
              .read<Subs>()
              .quizname
              .add(list.docs[i]['assignexamname']);
          context
              .read<Subs>()
              .prov_subjectname
              .add(list.docs[i]['subject']);
          context
              .read<Subs>()
              .prov_memo
              .add(list.docs[i]['memo']);
          context
              .read<Subs>()
              .start
              .add(list.docs[i]['startYMDT']);
          context
              .read<Subs>()
              .end
              .add(list.docs[i]['endYMDT']);
          context
              .read<Subs>()
              .type
              .add('과제');
          context
              .read<Subs>()
              .anoder_quizname
              .add(list.docs[i]['assignexamname']);
          context
              .read<Subs>()
              .anoder_prov_subjectname
              .add(list.docs[i]['subject']);
          context
              .read<Subs>()
              .anoder_prov_memo
              .add(list.docs[i]['memo']);
          context
              .read<Subs>()
              .anoder_start
              .add(list.docs[i]['startYMDT']);
          context
              .read<Subs>()
              .anoder_end
              .add(list.docs[i]['endYMDT']);
          context
              .read<Subs>()
              .anoder_type
              .add('과제');

        }
      }
    }
    for (int i = 0; i < check.docs.length; i++) {
      var todayExam =  FirebaseFirestore.instance.collection('user').doc(_authentication.currentUser!.uid).collection('Subject').
      doc(check.docs[i]['SubjectName']).collection('Exam').get();

      var list = await todayExam;
      for (int i = 0; i < list.docs.length; i++) {
        if (intoDay(list.docs[i]['startYMDT'], list.docs[i]['endYMDT']) == true) {
          context
              .read<Subs>()
              .quizname
              .add(list.docs[i]['assignexamname']);
          context
              .read<Subs>()
              .prov_subjectname
              .add(list.docs[i]['subject']);
          context
              .read<Subs>()
              .prov_memo
              .add(list.docs[i]['memo']);
          context
              .read<Subs>()
              .start
              .add(list.docs[i]['startYMDT']);
          context
              .read<Subs>()
              .end
              .add(list.docs[i]['endYMDT']);
          context
              .read<Subs>()
              .type
              .add('시험');
          context
              .read<Subs>()
              .anoder_quizname
              .add(list.docs[i]['assignexamname']);
          context
              .read<Subs>()
              .anoder_prov_subjectname
              .add(list.docs[i]['subject']);
          context
              .read<Subs>()
              .anoder_prov_memo
              .add(list.docs[i]['memo']);
          context
              .read<Subs>()
              .anoder_start
              .add(list.docs[i]['startYMDT']);
          context
              .read<Subs>()
              .anoder_end
              .add(list.docs[i]['endYMDT']);
          context
              .read<Subs>()
              .anoder_type
              .add('시험');

        }
      }
    }
    for (int i = 0; i < check.docs.length; i++) {
      var todayQuiz =  FirebaseFirestore.instance.collection('user').doc(_authentication.currentUser!.uid).collection('Subject').
      doc(check.docs[i]['SubjectName']).collection('Quiz').get();

      var list = await todayQuiz;
      for (int i = 0; i < list.docs.length; i++) {
        if(intoDay(list.docs[i]['startYMDT'], list.docs[i]['endYMDT']) == true) {
          context
              .read<Subs>()
              .quizname
              .add(list.docs[i]['assignexamname']);
          context
              .read<Subs>()
              .prov_subjectname
              .add(list.docs[i]['subject']);
          context
              .read<Subs>()
              .prov_memo
              .add(list.docs[i]['memo']);
          context
              .read<Subs>()
              .start
              .add(list.docs[i]['startYMDT']);
          context
              .read<Subs>()
              .end
              .add(list.docs[i]['endYMDT']);
          context
              .read<Subs>()
              .type
              .add('퀴즈');
          context
              .read<Subs>()
              .anoder_quizname
              .add(list.docs[i]['assignexamname']);
          context
              .read<Subs>()
              .anoder_prov_subjectname
              .add(list.docs[i]['subject']);
          context
              .read<Subs>()
              .anoder_prov_memo
              .add(list.docs[i]['memo']);
          context
              .read<Subs>()
              .anoder_start
              .add(list.docs[i]['startYMDT']);
          context
              .read<Subs>()
              .anoder_end
              .add(list.docs[i]['endYMDT']);
          context
              .read<Subs>()
              .anoder_type
              .add('퀴즈');
        }
      }
    }
  }
  Future<void> setanother_() async{
    var sub =  FirebaseFirestore.instance.collection('user').doc(_authentication.currentUser!.uid).collection('Subject').
    where('uid', isEqualTo: _authentication.currentUser!.uid).get();
    var check = await sub;

    for (int i = 0; i < check.docs.length; i++) {
      var todayAssingn =  FirebaseFirestore.instance.collection('user').doc(_authentication.currentUser!.uid).collection('Subject').
      doc(check.docs[i]['SubjectName']).collection('Assignment').get();

      var list = await todayAssingn;
      for (int i = 0; i < list.docs.length; i++) {
        if (intoDay(list.docs[i]['startYMDT'], list.docs[i]['endYMDT']) == false) {
          context
              .read<Subs>()
              .anoder_quizname
              .add(list.docs[i]['assignexamname']);
          context
              .read<Subs>()
              .anoder_prov_subjectname
              .add(list.docs[i]['subject']);
          context
              .read<Subs>()
              .anoder_prov_memo
              .add(list.docs[i]['memo']);
          context
              .read<Subs>()
              .anoder_start
              .add(list.docs[i]['startYMDT']);
          context
              .read<Subs>()
              .anoder_end
              .add(list.docs[i]['endYMDT']);
          context
              .read<Subs>()
              .anoder_type
              .add('과제');
        }
      }
    }



    for (int i = 0; i < check.docs.length; i++) {
      var todayExam =  FirebaseFirestore.instance.collection('user').doc(_authentication.currentUser!.uid).collection('Subject').
      doc(check.docs[i]['SubjectName']).collection('Exam').get();

      var list = await todayExam;
      for (int i = 0; i < list.docs.length; i++) {
        if (intoDay(list.docs[i]['startYMDT'], list.docs[i]['endYMDT']) ==
            false) {
          context
              .read<Subs>()
              .anoder_quizname
              .add(list.docs[i]['assignexamname']);
          context
              .read<Subs>()
              .anoder_prov_subjectname
              .add(list.docs[i]['subject']);
          context
              .read<Subs>()
              .anoder_prov_memo
              .add(list.docs[i]['memo']);
          context
              .read<Subs>()
              .anoder_start
              .add(list.docs[i]['startYMDT']);
          context
              .read<Subs>()
              .anoder_end
              .add(list.docs[i]['endYMDT']);
          context
              .read<Subs>()
              .anoder_type
              .add('시험');
        }
      }
    }
    for (int i = 0; i < check.docs.length; i++) {
      var todayQuiz =  FirebaseFirestore.instance.collection('user').doc(_authentication.currentUser!.uid).collection('Subject').
      doc(check.docs[i]['SubjectName']).collection('Quiz').get();

      var list = await todayQuiz;
      for (int i = 0; i < list.docs.length; i++) {
        if(intoDay(list.docs[i]['startYMDT'], list.docs[i]['endYMDT']) == false) {
          context
              .read<Subs>()
              .anoder_quizname
              .add(list.docs[i]['assignexamname']);
          context
              .read<Subs>()
              .anoder_prov_subjectname
              .add(list.docs[i]['subject']);
          context
              .read<Subs>()
              .anoder_prov_memo
              .add(list.docs[i]['memo']);
          context
              .read<Subs>()
              .anoder_start
              .add(list.docs[i]['startYMDT']);
          context
              .read<Subs>()
              .anoder_end
              .add(list.docs[i]['endYMDT']);
          context
              .read<Subs>()
              .anoder_type
              .add('퀴즈');
        }
      }
    }

  }
  String slicedDate(String d) {
    // 연도를 제거한 문자열(월,일,시간) 리턴
    return d.substring(5);
  }

  @override
  // State가 처음 만들어졌을때만 하는 것
  void initState() {
    // TODO: implement initState
    super
        .initState(); // 이걸 먼저 해줘야함(부모 클래스로부터 받아옴, Stateful 위젯 안에 initState가 있기때문에)
    getCurrentUser();
  }

  void getCurrentUser() {
    try {
      final user = _authentication.currentUser; // _authentication 의 currentUser을 대입
      if (user != null) {
        loggedUser = user;
      }
    } catch (e) {
      print(e);
    }
  }
  bool intoDay(String startDay, String endDay){
    /*String year = startDay.substring(0, 4);
      String month = startDay.substring(5,7);
      String day = startDay.substring() // 20221202   20221204    20221208
      */
    String newToDay = getcompareDay().substring(0,11);
    String newStartDay = startDay.substring(0,11);
    String newendDay = endDay.substring(0,11);
    int resultstart = newStartDay.compareTo(newToDay);
    int resultend = newendDay.compareTo(newToDay);

    if(resultstart <= 0 && resultend >= 0){
      return true;
    }
    else
      return false;
  }

  bool intoDay_per(String startDay, String endDay){
    String newToDay = getcompareDay().substring(0,11);
    String newStartDay = startDay.substring(0,11);
    String newendDay = endDay.substring(0,11);
    int resultstart = newStartDay.compareTo(newToDay);
    int resultend = newendDay.compareTo(newToDay);

    if(resultstart <= 0 && resultend >= 0){
      return true;
    }
    else
      return false;
  }
  @override
  Widget build(BuildContext context) {
    context
        .read<Subs>()
        .quizname
        .clear();
    context
        .read<Subs>()
        .prov_subjectname
        .clear();
    context
        .read<Subs>()
        .prov_memo
        .clear();
    context
        .read<Subs>()
        .start
        .clear();
    context
        .read<Subs>()
        .end
        .clear();
    context
        .read<Subs>()
        .type
        .clear();
    context
        .read<Subs>()
        .quizname
        .clear();
    context
        .read<Subs>()
        .anoder_prov_subjectname
        .clear();
    context
        .read<Subs>()
        .anoder_prov_memo
        .clear();
    context
        .read<Subs>()
        .anoder_start
        .clear();
    context
        .read<Subs>()
        .anoder_end
        .clear();
    context
        .read<Subs>()
        .anoder_type
        .clear();
    context
        .read<Subs>()
        .anoder_quizname
        .clear();
    return
      DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: AppBar(
                backgroundColor: Color(0xFFF6F9FD),
                bottom: TabBar(tabs: [
                  Tab(icon: Icon(Icons.schedule),),
                  Tab(icon: Icon(Icons.book),),
                  Tab(icon: Icon(Icons.auto_awesome_motion_rounded),),
                ],
                  indicatorColor: Color(0xFF343434),
                  labelColor: Color(0xFF343434),
                  unselectedLabelColor: Color(0xFFA1A3A8),
                ),
              ),
            ),
            body: TabBarView(
              children: [
                //////////////////////////////////////////////////////////// 개인 일정
                SafeArea(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60), // 모서리를 둥글게
                        border: Border.all(color: Color(0xFF343434), width: 10)),
                    child: Column(
                      children: <Widget>[
                        Text('\n\n오늘 일정 (${getToday()})', // 제목
                            style: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'title')),
                        const SizedBox(
                          height: 15,
                        ),
                        Text('개인 일정',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        Expanded(
                          child: StreamBuilder<QuerySnapshot>(
                            stream:  FirebaseFirestore.instance.collection('user').doc(_authentication.currentUser!.uid)
                                .collection('Personal')
                                .where('comparedate',
                                isEqualTo: getcompareDay().substring(0, 10))
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }
                              final docs = snapshot.data!.docs;
                              return ListView.builder(
                                itemCount: docs.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    child: Dismissible(
                                      key: ValueKey(
                                        docs[index]['title'],
                                      ),
                                      child: ListTile(
                                        title: Expanded(
                                          child: Row(
                                            children: [
                                              Text('     ${slicedDate(docs[index]['time'])} :',style: const TextStyle(
                                                height: 3, fontSize: 18, fontFamily: 'title',
                                              ),),
                                              Text(
                                                  '    ${docs[index]['title'].toString()}',
                                                  style: const TextStyle(
                                                    height: 3, fontSize: 21,
                                                  ),
                                                  textAlign: TextAlign.start),
                                            ],
                                          ),
                                        ),
                                        onTap: () {
                                          // 개인 일정이 클릭되면 메모 띄우기
                                          showDialog(
                                              context: context,
                                              barrierDismissible: true,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                    shape:
                                                    const RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                22.0))),
                                                    content: Container(
                                                      padding:
                                                      const EdgeInsets.all(8.0),
                                                      width: 300,
                                                      height: 300,
                                                      child: Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                            child: Center(
                                                                child: Text(
                                                                    '${docs[index]['title']}',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                        22,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                        fontFamily:
                                                                        'title'))),
                                                          ),
                                                          Container(
                                                            height: 3.0,
                                                            width: 200.0,
                                                          ), // 실선
                                                          const Text('\n메모',
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                          const SizedBox(
                                                            height: 20,
                                                          ),
                                                          Container(
                                                            width: 250,
                                                            height: 150,
                                                            padding: EdgeInsets.all(
                                                                16.0),
                                                            decoration:
                                                            BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                    .circular(
                                                                    22.0)),
                                                                border:
                                                                Border.all(
                                                                    width: 1,
                                                                    color: Color(0xFF343434)
                                                                )),
                                                            child: Expanded(
                                                              child: Text(
                                                                '${docs[index]['memo']}',
                                                                style: TextStyle(
                                                                    fontSize: 17),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ));
                                        },
                                      ),
                                      onDismissed: (direction){
                                        FirebaseFirestore.instance.collection('user').doc(_authentication.currentUser!.uid).collection('Personal').doc(docs[index]['title']).delete();},
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // 공부
                SafeArea(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60), // 모서리를 둥글게
                        border: Border.all(color: Color(0xFF343434), width: 10)),
                    child: Column(
                      children: <Widget>[
                        Text('\n\n오늘 일정(${getToday()})',
                            style: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'title')),
                        const SizedBox(
                          height: 15,
                        ),
                        Text('공부 일정',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        FutureBuilder(
                            future: setSchedure_Assingment(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text('');
                              } else {
                                return Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: ListView.builder(
                                      itemCount: context
                                          .read<Subs>()
                                          .prov_subjectname
                                          .length,
                                      itemBuilder: (context, index) {
                                        return Dismissible(
                                          key: ValueKey(context
                                              .read<Subs>()
                                              .prov_subjectname[index]),
                                          child: SubjectTile(Subject(
                                              context
                                                  .read<Subs>()
                                                  .prov_subjectname[index],
                                              context
                                                  .read<Subs>()
                                                  .start[index],
                                              context
                                                  .read<Subs>()
                                                  .end[index],
                                              context
                                                  .read<Subs>()
                                                  .prov_memo[index],
                                              context
                                                  .read<Subs>()
                                                  .type[index],
                                          context.read<Subs>().quizname[index]
                                          )
                                          ),
                                          onDismissed: (direction) {
                                            if(context.read<Subs>().type[index] == '시험') {
                                              FirebaseFirestore.instance
                                                  .collection('user').doc(
                                                  _authentication.currentUser!
                                                      .uid)
                                                  .collection('Subject')
                                                  .doc(context
                                                  .read<Subs>()
                                                  .prov_subjectname[index])
                                                  .collection('Exam')
                                                  .doc(context
                                                  .read<Subs>()
                                                  .quizname[index])
                                                  .delete();
                                            }else if(context.read<Subs>().type[index] == '과제') {
                                              FirebaseFirestore.instance.collection('user').doc(_authentication.currentUser!.uid)
                                                  .collection('Subject')
                                                  .doc(context
                                                  .read<Subs>()
                                                  .prov_subjectname[index])
                                                  .collection('Assignment')
                                                  .doc(context
                                                  .read<Subs>()
                                                  .quizname[index])
                                                  .delete();
                                            }
                                            else if(context.read<Subs>().type[index].toString() == '퀴즈') {
                                              FirebaseFirestore.instance.collection('user').doc(_authentication.currentUser!.uid)
                                                  .collection('Subject')
                                                  .doc(context
                                                  .read<Subs>()
                                                  .prov_subjectname[index])
                                                  .collection('Quiz')
                                                  .doc(context
                                                  .read<Subs>()
                                                  .quizname[index])
                                                  .delete();
                                            }
                                            print(context.read<Subs>().type[index]);
                                            print(context.read<Subs>().quizname[index]);
                                            context.read<Subs>().prov_subjectname.removeAt(index);
                                            context.read<Subs>().prov_memo.removeAt(index);
                                            context.read<Subs>().start.removeAt(index);
                                            context.read<Subs>().end.removeAt(index);
                                            context.read<Subs>().type.removeAt(index);
                                            context.read<Subs>().quizname.removeAt(index);

                                            context.read<Subs>().startDay.removeAt(index);
                                            context.read<Subs>().endDay.removeAt(index);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                );
                              }
                            }),
                      ],
                    ),
                  ),
                ),
                // 모든 일정
                SafeArea(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60), // 모서리를 둥글게
                        border: Border.all(color: Color(0xFF343434), width: 10)),
                    child: Column(
                      children: <Widget>[
                        Text('\n\n모든 일정',
                            style: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'title')),
                        const SizedBox(
                          height: 15,
                        ),
                        Text('공부 일정',
                            style: const TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                        FutureBuilder(
                            future: setanother_(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text('');
                              } else {
                                return Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: ListView.builder(
                                      itemCount: context
                                          .read<Subs>()
                                          .anoder_prov_subjectname
                                          .length,
                                      itemBuilder: (context, index) {
                                        return Dismissible(
                                          key: ValueKey(context
                                              .read<Subs>()
                                              .anoder_prov_subjectname[index]),
                                          child: SubjectTile(Subject(
                                              context
                                                  .read<Subs>()
                                                  .anoder_prov_subjectname[index],
                                              context
                                                  .read<Subs>()
                                                  .anoder_start[index],
                                              context
                                                  .read<Subs>()
                                                  .anoder_end[index],
                                              context
                                                  .read<Subs>()
                                                  .anoder_prov_memo[index],
                                              context
                                                  .read<Subs>()
                                                  .anoder_type[index],
                                              context.read<Subs>().anoder_quizname[index]
                                          )),
                                          onDismissed: (direction) {
                                            if(context.read<Subs>().anoder_type[index] == '시험') {
                                              FirebaseFirestore.instance.collection('user').doc(_authentication.currentUser!.uid)
                                                  .collection('Subject')
                                                  .doc(context
                                                  .read<Subs>()
                                                  .anoder_prov_subjectname[index])
                                                  .collection('Exam')
                                                  .doc(context
                                                  .read<Subs>()
                                                  .anoder_quizname[index])
                                                  .delete();
                                            }else if(context.read<Subs>().anoder_type[index] == '과제') {
                                              FirebaseFirestore.instance.collection('user').doc(_authentication.currentUser!.uid)
                                                  .collection('Subject')
                                                  .doc(context
                                                  .read<Subs>()
                                                  .anoder_prov_subjectname[index])
                                                  .collection('Assignment')
                                                  .doc(context
                                                  .read<Subs>()
                                                  .anoder_quizname[index])
                                                  .delete();
                                            }
                                            else if(context.read<Subs>().anoder_type[index].toString() == '퀴즈') {
                                              FirebaseFirestore.instance.collection('user').doc(_authentication.currentUser!.uid)
                                                  .collection('Subject')
                                                  .doc(context
                                                  .read<Subs>()
                                                  .anoder_prov_subjectname[index])
                                                  .collection('Quiz')
                                                  .doc(context
                                                  .read<Subs>()
                                                  .anoder_quizname[index])
                                                  .delete();
                                            }
                                            context.read<Subs>().anoder_prov_subjectname.removeAt(index);
                                            context.read<Subs>().anoder_prov_memo.removeAt(index);
                                            context.read<Subs>().anoder_start.removeAt(index);
                                            context.read<Subs>().anoder_end.removeAt(index);
                                            context.read<Subs>().anoder_type.removeAt(index);
                                            context.read<Subs>().anoder_quizname.removeAt(index);

                                            context.read<Subs>().anoder_startDay.removeAt(index);
                                            context.read<Subs>().anoder_endDay.removeAt(index);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                );
                              }
                            }),
                        Expanded(
                          child: Column(
                            children: [
                              Text('개인 일정',
                                  style: const TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.bold)),

                              Expanded(
                                child: StreamBuilder<QuerySnapshot>(
                                  stream:  FirebaseFirestore.instance.collection('user').doc(_authentication.currentUser!.uid)
                                      .collection('Personal')
                                      .where('uid',
                                      isEqualTo: _authentication.currentUser!.uid)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                    final docs = snapshot.data!.docs;
                                    return ListView.builder(
                                      itemCount: docs.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          child: Dismissible(
                                            key: ValueKey(
                                              docs[index]['title'],
                                            ),
                                            child: ListTile(
                                              title: Row(
                                                children: [
                                                  Text('     ${slicedDate(docs[index]['time'])} :',style: const TextStyle(
                                                    height: 3, fontSize: 18, fontFamily: 'title',
                                                  ),),
                                                  Text(
                                                      '    ${docs[index]['title'].toString()}',
                                                      style: const TextStyle(
                                                        height: 3, fontSize: 18,
                                                      ),
                                                      textAlign: TextAlign.start),
                                                ],
                                              ),
                                              onTap: () {
                                                // 개인 일정이 클릭되면 메모 띄우기
                                                showDialog(
                                                    context: context,
                                                    barrierDismissible: true,
                                                    builder: (BuildContext context) =>
                                                        AlertDialog(
                                                          shape:
                                                          const RoundedRectangleBorder(
                                                              borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      22.0))),
                                                          content: Container(
                                                            padding:
                                                            const EdgeInsets.all(8.0),
                                                            width: 300,
                                                            height: 300,
                                                            child: Column(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                                  child: Center(
                                                                      child: Text(
                                                                          '${docs[index]['title']}',
                                                                          style: TextStyle(
                                                                              fontSize:
                                                                              16,
                                                                              fontWeight:
                                                                              FontWeight
                                                                                  .bold,
                                                                              fontFamily:
                                                                              'title'))),
                                                                ),
                                                                Container(
                                                                  height: 3.0,
                                                                  width: 200.0,
                                                                  color: Color(0xFF343434),
                                                                ), // 실선
                                                                const Text('\n메모',
                                                                    style: TextStyle(
                                                                        fontSize: 18,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                                const SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Container(
                                                                  width: 250,
                                                                  height: 150,
                                                                  padding: EdgeInsets.all(
                                                                      16.0),
                                                                  decoration:
                                                                  BoxDecoration(
                                                                      borderRadius: BorderRadius
                                                                          .all(Radius
                                                                          .circular(
                                                                          22.0)),
                                                                      border:
                                                                      Border.all(
                                                                          width: 1,
                                                                          color: Color(0xFF343434)
                                                                      )),
                                                                  child:Expanded(
                                                                  child : Text(
                                                                    '${docs[index]['memo']}',
                                                                    style: TextStyle(
                                                                        fontSize: 17),
                                                                  ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ));
                                              },
                                            ),
                                            onDismissed: (direction){
                                              FirebaseFirestore.instance.collection('user').doc(_authentication.currentUser!.uid).collection('Personal').doc(docs[index]['title']).delete();},
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
        ),
      );
  }
}
class SubjectTile extends StatefulWidget {
  SubjectTile(this._subject);
  final Subject _subject;

  @override
  State<SubjectTile> createState() => _SubjectTileState();
}

class _SubjectTileState extends State<SubjectTile> {
  double _currentSliderValue = 25;
  bool _check = false;
  @override
  Widget build(BuildContext context) {
    String _endTime = '';
    for(int i = 5; i < 16; i++){
      _endTime += widget._subject.end[i];
    }
    return ListTile(
      //trailing:Icon( Icons.check, color: _check ?  Colors.green : Colors.grey),
      title: Row(
        children: [
          SizedBox(
              width: 120,
              child:
              Text(widget._subject.title,
                  style: const TextStyle(height: 1, fontSize: 16, fontFamily: 'title'),
                  textAlign: TextAlign.center)
          ),
          Text('  마감일 '),
          Expanded(child: Text(_endTime)),            // '할 일' 잘리는 것 방지
          Text(widget._subject.type),
        ],
      ),
      /*onTap: (){        // 리스트 타일이 클릭되면
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) => AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(22.0))),
              title: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Text(widget._subject.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'title'),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3),
                    const SizedBox(width: 15),
                    Expanded(                                 // '할 일' 잘리는 것 방지
                      child: Text(widget._subject.memo,
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              content: Container(
                padding: const EdgeInsets.all(16.0),
                width: 300,
                height: 300,
                child: Column(
                  children: [
                    const SizedBox(height: 40,),
                    Row(
                      children: [
                        const Text('마감 기한'),
                        SizedBox(width: 30,),
                        Container(
                          child: Text(widget._subject.end),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30,),
                    Row(
                      children: [
                        const Text('시작'),
                        SizedBox(width: 30,),
                        Container(
                          child: Text(widget._subject.start.substring(11)),       // 시작 시간만 잘라서 넣기
                        ),
                      ],
                    ),
                    const SizedBox(height: 30,),
                    Row(
                      children: [
                        const Text('종료'),
                        SizedBox(width: 30,),
                        Container(
                          child: Text(widget._subject.end.substring(11)),       // 끝나는 시간만 잘라서 넣기
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            )
        );
      },*/
      onTap: (){        // 리스트 타일이 클릭되면
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) => AlertDialog(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(22.0))),
              title: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Text(widget._subject.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'title'),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3),
                    const SizedBox(width: 15),
                    Expanded(                                 // '할 일' 잘리는 것 방지
                      child: Text(widget._subject.quiz_name,
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              content: Container(
                padding: const EdgeInsets.all(16.0),
                width: 300,
                height: 300,
                child: Column(
                  children: [
                    // const Text('진행도'),
                    // const SizedBox(height: 20,),
                    // Slider(
                    //   value: _currentSliderValue,
                    //   max: 100,
                    //   divisions: 5,
                    //   label: _currentSliderValue.round().toString(),
                    //   onChanged: (double value) {
                    //     setState(() {
                    //       _currentSliderValue = value;
                    //       if(_currentSliderValue == 100)
                    //         _check = true;
                    //       else
                    //         _check = false;
                    //     });
                    //   },
                    // ),
                    Row(
                      children: [
                        const Text('날짜'),
                        SizedBox(width: 30,),
                        Container(
                          child: Text(getToday()),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30,),
                    Row(
                      children: [
                        const Text('시작'),
                        SizedBox(width: 30,),
                        Container(
                          child: Text(widget._subject.start.substring(11)),       // 시작 시간만 잘라서 넣기
                        ),
                      ],
                    ),
                    const SizedBox(height: 30,),
                    Row(
                      children: [
                        const Text('종료'),
                        SizedBox(width: 30,),
                        Container(
                          child: Text(widget._subject.end.substring(11)),       // 끝나는 시간만 잘라서 넣기
                        ),
                      ],
                    ),
                    const SizedBox(height: 30,),
                      Row(
                        children: [
                          const Text('메모'),
                          const SizedBox(width: 30,),
                          Container(child: Expanded(child: Text(widget._subject.memo)),)
                        ],
                      ),

                  ],
                ),
              ),

            )
        );
      },

    );
  }
}
String getToday(){      // 오늘 날짜 가져오는 함수
  var now = DateTime.now();
  String formatDate = DateFormat('MM/dd').format(now);
  return formatDate;
}

String getcompareDay(){
  var now = DateTime.now();
  return now.toString();
}
