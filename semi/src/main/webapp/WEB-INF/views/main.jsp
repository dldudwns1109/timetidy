<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <script type="text/javascript">
      $(function () {
        $(".nav-btn").click(function () {
          window.location.href = "/login";
        });

        let currIdx = 0;
        var itemCnt = $(".carousel-item").length;
        $(".prev-btn").click(function () {
          currIdx > 0 ? currIdx-- : (currIdx = itemCnt - 1);
          updateCarousel();
        });
        $(".next-btn").click(function () {
          currIdx < itemCnt - 1 ? currIdx++ : (currIdx = 0);
          updateCarousel();
        });

        function updateCarousel() {
          var transX = "translateX(" + (-100 / itemCnt) * currIdx + "%)";
          $(".carousel-inner").css("transform", transX);
        }
      });
    </script>
  </head>
  <body>
    <header class="w-100p left-0 top-0 fixed light">
      <div class="flex px-120 py-15 flex justify-between items-center">
        <img src="img/logo.png" width="165" height="44" />

        <div>
          <a href="#function" class="text-16 px-14 py-9">기능</a>
          <span class="line-base border-05 h-22 mx-8"></span>
          <c:choose>
        	<c:when test="${sessionScope.email == null || sessionScope.email == ''}">
	          <a href="/login" class="nav-btn brand-dark border-none outline-none px-14 py-9 ml-14 round-6 light-font text-16">로그인</a>
	        </c:when>
	          <c:otherwise>
	          <a href="/schedule" class="nav-btn brand-dark border-none outline-none px-14 py-9 ml-14 round-6 light-font text-16">일정 열기</a>
	        </c:otherwise>
          </c:choose>
        </div>
      </div>
    </header>
    <h1 class="title-48 title-font-color text-center mt-154">
      쉽고 빠른 일정 관리
    </h1>
    <p class="title-20 text2-font-color text-center mt-16">
      작업이나 프로젝트를 관리할 때 일정을 공유하거나 공유받을 수 있습니다!
    </p>

    <div class="flex flex-col items-center w-400 mx-auto mt-60">
      <img src="img/main-banner.svg" width="400" height="330" />
      <c:choose>
       	<c:when test="${sessionScope.email == null || sessionScope.email == ''}">
          <a href="/login" 
          	 class="nav-btn brand-dark border-none outline-none px-14 py-9 mx-auto mt-40 round-6 light-font title-18">로그인</a>
        </c:when>
        <c:otherwise>
          <a href="/schedule" 
             class="nav-btn brand-dark border-none outline-none px-14 py-9 mx-auto mt-40 round-6 light-font title-18">일정 열기</a>
        </c:otherwise>
       </c:choose>
    </div>

    <img
      src="img/wave.svg"
      class="w-100p mt-32"
    />

    <div class="relative overflow-hidden">
      <div class="carousel-inner anim flex w-500p">
        <div class="carousel-item flex justify-around items-center w-100p">
          <div class="flex flex-col">
            <h1 class="title-48 title-font-color text-center mt-16">
              누가 일정에 참여하나요?
            </h1>
            <p class="title-20 text2-font-color text-center mt-16">
              친구를 초대하여 일정을 공유하거나 공유받으세요!
            </p>
            <div class="flex flex-col items-center w-400 mx-auto my-80">
              <img src="img/banner1.svg" width="400" height="330" />
            </div>
          </div>
        </div>

        <div class="carousel-item flex justify-around items-center w-100p">
          <div class="flex flex-col">
            <h1 class="title-48 title-font-color text-center mt-80">
              언제 얼만큼 일정을 잡나요?
            </h1>
            <p class="title-20 text2-font-color text-center mt-16">
              편안한 시간에 일정을 잡으세요! 여러 기간동안 일정을 계획할 수
              있습니다!
            </p>
            <div class="flex flex-col items-center w-400 mx-auto my-80">
              <img src="img/banner2.svg" width="400" height="330" />
            </div>
          </div>
        </div>

        <div class="carousel-item flex justify-around items-center w-100p">
          <div class="flex flex-col">
            <h1 class="title-48 title-font-color text-center mt-80">
              일정 장소를 어디서 보나요?
            </h1>
            <p class="title-20 text2-font-color text-center mt-16">
              주소를 입력하여 일정을 계획하세요! 맵이 임베드되어 장소를 쉽게
              찾아볼 수 있습니다!
            </p>
            <div class="flex flex-col items-center w-400 mx-auto my-80">
              <img src="img/banner3.svg" width="400" height="330" />
            </div>
          </div>
        </div>

        <div class="carousel-item flex justify-around items-center w-100p">
          <div class="flex flex-col">
            <h1 class="title-48 title-font-color text-center mt-80">
              어떤 작업을 계획하나요?
            </h1>
            <p class="title-20 text2-font-color text-center mt-16">
              일정 안에서의 세부 계획을 세우세요! 많은 계획을 작성할수록 일정을
              계획하기 쉬워집니다!
            </p>
            <div class="flex flex-col items-center w-400 mx-auto my-80">
              <img src="img/banner4.svg" width="400" height="330" />
            </div>
          </div>
        </div>

        <div class="carousel-item flex justify-around items-center w-100p">
          <div class="flex flex-col">
            <h1 class="title-48 title-font-color text-center mt-80">
              무엇을 하시나요?
            </h1>
            <p class="title-20 text2-font-color text-center mt-16">
              일정에 대한 상세 글을 작성하세요! 어떠한 작업이든 이해하기
              쉽습니다!
            </p>
            <div class="flex flex-col items-center w-400 mx-auto my-80">
              <img src="img/banner5.svg" width="400" height="330" />
            </div>
          </div>
        </div>
      </div>
      <div
        class="absolute top-50 left-50 trans-center w-80p flex justify-between"
      >
        <button
          class="prev-btn border-none outline-none opacity-40 light-font round-full w-50 h-50"
        >
          &lt;
        </button>
        <button
          class="next-btn border-none outline-none opacity-40 light-font round-full w-50 h-50"
        >
          &gt;
        </button>
      </div>
    </div>

    <footer class="footer pb-26">
      <div class="h-44 px-120 flex items-end">
        <img src="img/logo.png" width="165" height="44" />
        <span class="text-14 title-font-color ml-14"
          >Copyright @ TimeTidy ALL RIGHTS RESERVED.</span
        >
      </div>
    </footer>
  </body>
</html>

