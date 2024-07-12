<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>
    
<!-- 비밀번호 변경 페이지 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/idFind.css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- 카카오 인증번호 코드를 받기위한 jquery  -->



<div align="center" style="margin-top: 40px; margin-bottom: 20px;">
   <h1><span style="font-weight: bold; color:#fa0050; font-family: 'Gothic A1', sans-serif;">비밀번호 변경</span></h1>
   <h4><span style="font-weight: bold; color:#black; font-family: 'Gothic A1', sans-serif;">이름 아이디 전화번호를 입력해주세요.</span></h4>
   </div>
    <script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.2/kakao.min.js"
  integrity="sha384-TiCUE00h649CAMonG018J2ujOgDKW/kVWlChEuu4jK2vxfAAD0eZxzCKakxg55G4" crossorigin="anonymous"></script>
   <script>
   Kakao.init('1892f5fb59d85cadf550e26ec6d0855a'); // 카카오 rest api 코드
   Kakao.isInitialized();
   
   function sendToMe() {
      var url = new URL(window.location.href);
      // AJAX 요청 예시
      $.ajax({
          url: 'https://kauth.kakao.com/oauth/token',
          type: 'POST',
          data: {
              grant_type: 'authorization_code', // 이 코드는 고정 값
              client_id: '1892f5fb59d85cadf550e26ec6d0855a', // 카카오 rest api 코드
              redirect_url: 'http://localhost:7080/login/pw_find.do', // 카카오에 등록한 redirect_url
              code : url.searchParams.get('code') // jquery를 통해 받아오는 코드
          },
          success: function(response) {
              console.log(response)
                accessToken = response.access_token;
              console.log('추출된 access_token:', accessToken);
              Kakao.Auth.setAccessToken(accessToken);
            Kakao.API.request({
                 url: '/v2/api/talk/memo/default/send',// 나에게 메세지를 보내기위한 카카오 url 
                 data: {                        // requst post 방식
                   template_object: {
                     object_type: 'feed', // feed 방식 post 등 방식도 있음
                     content: {
                       title: '${random}',
                       description: '회원가입을 위한 인증 코드를 확인해주세요.',
                             image_url:
                                'https://developers.kakao.com',
                             link: {
                               web_url: 'https://developers.kakao.com',
                               mobile_web_url: 'https://developers.kakao.com',
                       },
                     },
                    
                     buttons: [
                       {
                         title: '웹으로 보기',
                         link: {
                           mobile_web_url: 'https://developers.kakao.com',
                           web_url: 'https://developers.kakao.com',
                         },
                       },
                       {
                         title: '앱으로 보기',
                         link: {
                           mobile_web_url: 'https://developers.kakao.com',
                           web_url: 'https://developers.kakao.com',
                         },
                       },
                     ],
                   },
                 },
               })
                 .then(function(response) {
                   console.log(response);
                   // 인증 코드를 서버에 전송하여 검증
                         $.ajax({
                             url: 'verifyCode.do',
                             type: 'POST',
                             data: {
                                 access_token: accessToken,
                                 auth_code: response.auth_code // 인증 코드 전송
                             },
                             success: function(verificationResult) {
                                 if (verificationResult === 'success') {
                                     alert('인증이 성공적으로 완료되었습니다.');
                                 } else {
                                     alert('인증에 실패했습니다.');
                                 }
                             },
                             error: function(err) {
                                 console.error('서버 오류:', err);
                             }
                         });
                 })
                 .catch(function(error) {
                   console.log(error);
                 });
          },
          error: function(xhr, status, error) {
              console.error('에러 발생:', error);
              alert('인증번호 전송 실패! 카카오 로그인 먼저 해주세요!');
             /* 카카오 로그인을 하지 않고 인증번호 전송시 알림창이 뜸 */
          }
      });
   } 
</script>

<script type="text/javascript">

    function out() {
            // // 사용자가 입력한 랜덤으로 온 인증번호
             var code = document.getElementById("code").value;
            // 서버(controller)에서 받은 랜덤 값
            var random = <%= request.getAttribute("random") %>;
            // 랜덤 값으로 온 인증번호 유효성 검사
            if (code == random) {
                // 인증 성공 메시지 표시
                /* document.getElementById("message").innerHTML = "인증이 완료되었습니다."; */
                var messageElement = document.getElementById("message");
            messageElement.innerHTML = "인증이 완료되었습니다.";
            messageElement.style.color = "black"; // 알림에 대한 색상
                // 확인 버튼 활성화
                // 카카오톡 인증 코드가 맞으면 모든 text 값 활성화
                document.getElementById("ok").disabled = false;
                document.getElementById("id").disabled = false;
                document.getElementById("name").disabled = false;
                document.getElementById("p1").disabled = false;
                document.getElementById("p2").disabled = false;
                document.getElementById("p3").disabled = false;
                
                
            } else {
                // 인증 실패 메시지 표시
               /*  document.getElementById("message").innerHTML = "인증번호가 일치하지 않습니다. 다시 시도해 주세요."; */
                  var messageElement = document.getElementById("message");
            messageElement.innerHTML = "인증번호가 일치하지 않습니다. 다시 시도해 주세요.";
            messageElement.style.color = "black"; // 알림에 대한 색상
                // 확인 버튼 비활성화
                // 카카오 인증 코드가 틀렸을시 모든 text 값 비활성화
                document.getElementById("ok").disabled = true;
                document.getElementById("id").disabled = true;
                document.getElementById("name").disabled = true;
                document.getElementById("p1").disabled = true;
                document.getElementById("p2").disabled = true;
                document.getElementById("p3").disabled = true;
     
            }
       }
    
    /* 인증번호 전송 버튼을 눌렀을때 click_div에 대한 값 사라짐, 나타남 */
   /*  function btnclick(){
       const click_div = document.getElementById('click_div');
       if(click_div.style.display === 'none'){ /* click_div에 대한 요소 사라지게함 */
          //click_div.style.display = 'block';  /* 함수가 호출 되었을때 click_div에 대한 값 나타내지게하고 block */
       //}
   // } */
   
    function show(){
       const con = document.getElementById('con');
       if(con.style.display ==='none' || con.style.display === ''){       
            con.style.display = 'block';
            document.getElementById('under').innerText = '상세내용 닫기';
        }else{       
            con.style.display = 'none';
            document.getElementById('under').innerText = '상세내용 펼치기';
        } 
       } 
   
    function check() {
        /* text 입력 안할 시 title에 대한 알림창이 나옴 */
       const jfrm = document.f;
        let length = jfrm.length - 5; // length에 버튼 값까지 포함  인증번호전송, 중복확인, 취소, 확인 까지 포함이라서 -4를 함
        for (let i = 0; i < length; i++) {
           if (jfrm[i].value == "" || jfrm[i].value == null) {
              alert(jfrm[i].title + "을 입력해 주세요");
              jfrm[i].focus();
              return false;
           }
        }
        return true;
     }
    
</script>  
   
<div align="center" style="margin-top: 40px;">
   <form name="f" method="post" onsubmit="return check()" action="/login/pw_find_ok.do" class="form-container">
   <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
     <div align="center" style="margin-top: -5px; margin-bottom: 30px; border-radius: 8px;">

      <div class="form-row">
      <div class="label-lo">이름</div>
      <div class="input"><input type="text" title="이름" name="name" id="name" disabled></div>
      </div>
      
      <div class="form-row">
      <div class="label-lo">아이디</div>
      <div class="input"><input type="text" title="아이디" name="id" id="id" disabled></div>
      </div>
      
      
      <div class="form-row" >
         <div class="label-lo" >전화번호</div>
            <div class="input-lo">
         <input type="text" name="phone1" id="p1" title="전화번호" size="3" maxlength="3" disabled>
         -
         <input type="text" name="phone2" id="p2" title="전화번호" size="3" maxlength="4" disabled>
         -
         <input type="text" name="phone3" id="p3" title="전화번호" size="3" maxlength="4" disabled>
         </div>
      </div>
                     <!-- div값 나타나지 않게 하기 style="display: none; -->
      
      <table style="position:relative; left:30px;">
       <div class="form-row">
         <div class="label-lo" >인증번호</div>
         <div class="input"><input type="text" name="code"  placeholder="(필수)인증번호 입력" id="code"></div>
         <button type="button" onclick="out()" id="dupli">인증번호확인</button>
      </div>
        </table>
        <div id="message"></div> <!-- 인증이 완료됨, 인증실패 문구 출력 -->
        </div>
     
      
     <div class="buttons">
   
         <input type="submit" value="확인" id="ok" disabled>
         <button type="button" id="button-lo2" onclick="alert('로그인 페이지로 이동합니다.');
            window.location.href='login.do';">취소</button>
           <button type="button" id="button-lo2" onclick="sendToMe()" id="send">인증번호 전송</button>
                                                               <!-- btnclick(); -->
            <!-- 버튼을 눌러 sendToMe()가 활성화가되면 나에게 랜덤값 코드 번호 전송  -->
      
      </div>
      
      <div class="form-img">
      <a href="https://kauth.kakao.com/oauth/authorize?client_id=1892f5fb59d85cadf550e26ec6d0855a&redirect_uri=http://localhost:7080/login/pw_find.do&response_type=code&scope=talk_message" class="center-img">
         <img src="${pageContext.request.contextPath}/resources/img/kakao_login_medium_narrow.png" alt="카카오 로그인"></a>
         <!-- rest api와  redirect url을 request GET으로 보냄 -->
      </div>
      
      <div>
      <div class="delete">직접 가입하지 않은 아이디를 탈퇴(삭제)하고 싶으신가요?</div>
      <div class="open"><a onclick="show()" id="under">상세내용 펼치기</a></div>
      <div style="display: none;" id="con">
      <div class="help">신고를 하고 싶으시다면 도움말을 참고해 주세요
      <a href="/login/service_center.do" id="under_two">도움말</a></div>
      </div>
      </div>
      </form>
      </div>
       <div align="center" style="margin-bottom: 110px; border-radius: 8px;">
       </div>
<jsp:include page="../footer.jsp"/>