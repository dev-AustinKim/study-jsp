<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
   <!-- Form 작성 후 controller에 joinAction.member URL로 doPOST를 사용하도록 전달 
       POST METHOD: parameter 가려줌 -->
   <form action="joinAction.member" name="joinForm" method="post">
      <div>
         <!-- name은 parameter로 불러올 변수 이름 -->
         <input type="text" name="memberIdentification" placeholder="아이디">
         <!-- 연산결과(아이디 중복체크)가 올라올 p태그 (JS사용) -->
         <p id="result"></p>
      </div>
      <div>
         <input type="text" name="memberPassword" placeholder="비밀번호">
      </div>
      <!-- form submit button -->
      <!-- class명 또는 id명은 예약어를 사용하지 말자! -->
      <input id="finish" type="button" value="완료">
   </form>      
</body>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<script>
   /* 전역변수 (available -> 아이디 사용 가능: true / 아이디 사용 불가능: false) */
   globalThis.available = false;

   /* 화면단과 소통하는 일회용 함수를 담음 */
   let dom = (function(){
      function changeResult(result){
         /* RESULT를 아이디로 갖는 객체 선언 */
         const $p = $("#result");
         /* JSON.stringify() : Javascript의 값이나 객체를 JSON 문자열로 변환 */
         /* JSON형식의 result를 jsObject형식으로 형변환 */
         result = JSON.parse(result);
         
         /* 만약 RESULT에 들어있는 check값(DAO method 사용의 결과값)이 false 이면 (중복이 없으면)*/
         /* 위에서 jsObject 형식으로 변환해줬기 때문에 result.check를 해줄 수 있다. */
         if(!result.check){
            /* 사용가능한 아이디이면 글로벌 전역변수를 true로 담아줌 */
            available = true;
            /* 태그 스타일과 내용 변경 */
            $p.css("color", "blue");
            $p.text("사용 가능한 아이디입니다.")
         }else{
         /* 만약 RESULT에 들어있는 check값(DAO method 사용의 결과값)이 true 이면 (중복이 있으면)*/
            /* 사용가능한 아이디이면 글로벌 전역변수를 false로 담아줌 */
            available = false;
            /* 태그 스타일과 내용 변경 */
            $p.css("color", "red");
            $p.text("중복된 아이디입니다.")
         }
      }
      /* a를 key값으로 갖는 map형태의 결과값 리턴(value는 함수 필드 전체를 값으로) */
      return {a: changeResult};
   })();
   
   
   /* DB단과 소통하는 일회용 함수를 담음 */
   /* 중복체크 한 일회용 함수 결과값 service에 담기*/
   let service = (function(){
      /* 중복체크하는 callback 함수 */
      function checkId(callback){
         /* ajax로 비동기 통신 사용 : 객체로 리턴 */
         /* ajax를 사용하여 data 가져오기*/
         /* web.xml -> frontController -> ActionController -> DAO -> DB -> DAO -> ActionController -> frontController
         순으로 접근하고 "{check: boolean result}"를 반환 */
         $.ajax({
            /* data를 전달 할 경로 (앞의 경로 잘리는 사고 방지) */
            url: "${pageContext.request.contextPath}/checkIdAction.member",
            /* url에 전달할 정보: ActionController에서 parameter로 접근 가능*/
            data: {"memberIdentification": $("input[name='memberIdentification']").val()},
            /* data무사히 가지고 오면 실행 */
            success: function(result){
               /* 콜백이 있다면 RESULT 매개변수로 전달 */
               if(callback){
                  callback(result);
               }
            }
         });
      }
      /* MAP 형식으로 함수 리턴 (가져온 값이 없거나 실패하면 NULL 또는 UNDEFINED 가능) */
      return {checkId: checkId};
   })();
   
   /* 아이디 input 태그에서 focus가 해제되면 함수 실행 */
   $("input[name='memberIdentification']").on("blur", function(){
      /* check false로 초기화: input 태그에 값을 넣고 다시 포커스 할 때마다, 지울 때마다 초기화 */
      globalThis.available = false;
      /* service 필드에 있는 checkId() 함수 사용, 콜백으로 dom 필드 사용시 리턴된 값: key 값을 a로 갖는 vale 전달(함수필드 전체) */
      /* service.checkId(function dom.changeResult(result){console.log(result);}) */
      service.checkId(dom.a);
   });

   /* id가 finish인 태그가 클릭되면 (여기서는 form 태그 submit 버튼) */
   $("#finish").on("click", function(){
      /* 아이디와 비밀번호를 입력한 태그(객체)를 불러옴 */
      const $identification = $("input[name='memberIdentification']");
      const $password = $("input[name='memberPassword']");
      
      /* 입력한 아이디 값이 없으면 함수 탈출 */
      if(!$identification.val()){
         return;
      }
      /* 입력한 비번 값이 없으면 함수 탈출 */
      if(!$password.val()){
         return;
      }
      /* check(사용가능/불가능)가 true이면 == 중복값이 있으면 함수 탈출 */
      if(!globalThis.available) {
         return;
      }
      
      /* 비밀번호 암호화 */
      $password.val(btoa($password.val()));
      /* form submit */
      joinForm.submit();
   });
</script>
</html>







