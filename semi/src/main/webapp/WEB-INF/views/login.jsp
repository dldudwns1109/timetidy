<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>timetidy</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="css/commons.css" />
    <link rel="stylesheet" href="css/colors.css" />
    <link rel="stylesheet" href="css/fonts.css" />

    <!-- jQuery cdn -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script type="text/javascript"></script>
  </head>
  <body>
    <header class="w-100p left-0 top-0 fixed light">
      <div class="flex px-120 py-15 flex justify-between items-center">
        <img src="img/logo.png" width="165" height="44" />
      </div>
    </header>
    <div class="flex flex-col justify-between items-center h-100v">
      <div>
        <h1 class="title-32 title-font-color text-center mt-120">
          TimeTidy에 오신 것을 환영합니다
        </h1>
        <p class="title-20 subtext-font-color text-center mt-32">
          시작하려면 로그인하세요
        </p>
         <a href="${pageContext.request.contextPath}/oauth2/authorization/google"
		   class="flex justify-center items-center text-16 outline-none line-base border-1 light w-500 py-9 mt-40 title-font-color round-6">
		    <img src="img/google.svg" class="mr-16" width="18" height="18"/>
		    구글로 계속하기
		</a>
      </div>
      <img src="img/login-banner.svg" width="870" height="520" />
    </div>
  </body>
</html>
    