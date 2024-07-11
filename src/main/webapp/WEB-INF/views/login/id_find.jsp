<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp"/>
    
<!-- 아이디 찾기 페이지 -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/idFind.css">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- 카카오 인증번호 코드를 받기위한 jquery  -->



<div align="center" style="margin-top: 20px; margin-bottom: 20px;">
   <h1><span style="font-weight: bold; color:#fa0050; font-family: 'Gothic A1', sans-serif;">아이디 찾기</span></h1>
   <h4><span style="font-weight: bold; color:#black; font-family: 'Gothic A1', sans-serif;">이름과 전화번호를 입력해주세요.</span></h4>
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
              redirect_url: 'http://localhost:7080/login/id_find.do', // 카카오에 등록한 redirect_url
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
                document.getElementById("name").disabled = true;
                document.getElementById("p1").disabled = true;
                document.getElementById("p2").disabled = true;
                document.getElementById("p3").disabled = true;
     
            }
       }
    
    /* 인증번호 전송 버튼을 눌렀을때 click_div에 대한 값 사라짐, 나타남 */
    function btnclick(){
       const click_div = document.getElementById('click_div');
       if(click_div.style.display === 'none'){ /* click_div에 대한 요소 사라지게함 */
          click_div.style.display = 'block';  /* 함수가 호출 되었을때 click_div에 대한 값 나타내지게하고 block */
       }
    }
   
    function show(){
       const con = document.getElementById('con');
       if(con.style.display ==='none'){       
            con.style.display = 'block';    
        }else{       
            con.style.display = 'none';    
        } 
       } 
    
</script>  
   
<div align="center" style="margin-top: 60px;">
   <form name="f" method="post" action="/login/id_find_result.do" class="form-container">
   <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
     <div align="center" style="margin-top: -5px; margin-bottom: 30px; border-radius: 8px;">

      <table>
      <tr class="form-row">
         <td>이름</td><td><input type="text" name="name" id="name" disabled></td>
      </tr>
      </table>
      
      <table style="position:relative; right:5px;">
      <tr class="form-row">
         <td>전화번호</td>
            <td><input type="text" name="phone1" id="p1" size="3" maxlength="3" disabled></td>
            <td>-</td>
            <td><input type="text" name="phone2" id="p2" size="3" maxlength="4" disabled></td>
            <td>-</td>
            <td><input type="text" name="phone3" id="p3" size="3" maxlength="4" disabled></td>
      </tr>
      </table>
                     <!-- div값 나타나지 않게 하기 -->
      <div id="click_div" style="display: none;">
      <table style="position:relative; left:30px;">
      <tr>
         <td>인증번호</td>
         <td><input type="text" name="code" style="width: 135px;" placeholder="(필수)인증번호 입력" id="code"></td>
         <td style="position:relative; left:10px;"><button type="button" onclick="out()">인증번호 확인</button></td>
      </tr>
      </table>
      <div id="message"></div>
      </div>
      
     <table style="position:relative; top:15px;">
      <tr>
         <td style="position:relative; right:15px;"><input type="submit" value="확인" id="ok" disabled></td>
         <td style="position:relative; left:35px;"><button type="button" style="width: 50px;" onclick="alert('로그인 페이지로 이동합니다.');
            window.location.href='login.do';">취소</button></td>
            <td style="position:relative; left:65px;"><button type="button" onclick="sendToMe(); btnclick();" >인증번호 전송</button></td>
            <!-- 버튼을 눌러 sendToMe()가 활성화가되면 나에게 랜덤값 코드 번호 전송  -->
      </tr>
      </table>
      
      <table style="position:relative; top:30px;">
      <tr>
      <td><a href="https://kauth.kakao.com/oauth/authorize?client_id=1892f5fb59d85cadf550e26ec6d0855a&redirect_uri=http://localhost:7080/login/id_find.do&response_type=code&scope=talk_message">
         <img src="${pageContext.request.contextPath}/resources/img/kakao_login_medium_narrow.png" alt="카카오 로그인"></a></td>
         <!-- rest api와  redirect url을 request GET으로 보냄 -->
      </tr>
      </table>
      </div>
      
      <p style="position:relative; top:40px; right:60px;">직접 가입하지 않은 아이디를 탈퇴(삭제)하고 싶으신가요?</p>
      <a onclick="show()" id="under" style="position:relative; top:35px; right:178px;">상세내용 펼치기</a>
      <div id="con" style="display: none;">
      <p style="position:relative; top:40px; right:67px;">신고를 하고 싶으시다면 도움말을 참고해 주세요
      <a href="/login/service_center.do" id="under_two">도움말</a></p>
      </div>
      </div>
       <div align="center" style="margin-bottom: 110px; border-radius: 8px;">
       </div>
      </form>
<jsp:include page="../footer.jsp"/>