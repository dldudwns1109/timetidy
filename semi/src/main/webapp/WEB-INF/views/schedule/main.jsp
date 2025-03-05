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
    <script type="text/javascript">
      $(function () {
        var isOpen = true;
        $(".sidebar-btn").click(function () {
          if (isOpen) {
            $(".sidebar").css("transform", "translateX(-236px)");
            $(".content").css("transform", "translateX(-236px)");
            $(".sidebar").removeClass("light-dark");
          } else {
            $(".sidebar").css("transform", "translateX(0)");
            $(".content").css("transform", "translateX(0)");
            $(".sidebar").addClass("light-dark");
          }
          isOpen = !isOpen;
        });
        
        $(".date-title-tab").hover(
          function () {
            $(".plus-btn").show();
          },
          function () {
            $(".plus-btn").hide();
          }
        );
        $(".date-title-tab").mouseout(function (e) {
          if (!$(e.target).closest(".date-title-tab").length) {
            $(".plus-btn").hide();
          }
        });
      });
    </script>
  </head>
  <body>
    <div class="flex items-start">
      <aside class="sidebar anim light-dark w-260 h-100v px-16">
        <div class="flex justify-between items-center pt-8">
          <button class="trans-color border-none outline-none flex items-center px-8 py-9 round-6">
            <img
              src="${picture}"
              class="mr-8 round-full"
              width="26"
              height="26"
            />
            <span class="title-font-color text-16">${name}</span>
          </button>
          <div class="flex items-center">
            <button
              class="bell-btn trans-color border-none outline-none w-24 h-24 p-0 mr-16 round-6"
            >
              <img src="img/bell.svg" class="w-100p h-100p" />
            </button>
            <button
              class="sidebar-btn trans-color border-none outline-none w-24 h-24 p-0 round-6"
            >
              <img src="img/sidebar.svg" class="w-100p h-100p" />
            </button>
          </div>
        </div>
        <div class="pt-12">
          <button
            class="trans-color border-none outline-none flex items-center w-100p px-8 py-9 round-6"
          >
            <img src="img/search.svg" class="mr-8" width="24" height="24" />
            <span class="title-font-color text-16">검색</span>
          </button>
          <button
            class="trans-color border-none outline-none flex items-center w-100p px-8 py-9 mt-6 round-6"
          >
            <img src="img/social.svg" class="mr-8" width="24" height="24" />
            <span class="title-font-color text-16">소셜</span>
          </button>
          <button
            class="trans-color border-none outline-none flex items-center w-100p px-8 py-9 mt-6 round-6"
          >
            <img src="img/calendar.svg" class="mr-8" width="24" height="24" />
            <span class="title-font-color text-16">달력</span>
          </button>
        </div>
        <div class="date-title-tab flex justify-between items-center px-8 py-11 mt-24 round-6">
          <span class="text-font-color text-14">일정 관리</span>
          <button
            class="plus-btn none trans-color border-none outline-none w-24 h-24 p-0 round-6"
          >
            <img src="img/plus.svg" class="w-100p h-100p" />
          </button>
        </div>
      </aside>
      <div class="content anim flex flex-1 justify-center w-100p h-100v">
        <div class="flex flex-col items-center mt-248">
          <img src="img/welcome.svg" width="240" height="202" />
          <span class="title-font-color text-16 mt-24"
            >환영합니다. 새 일정을 생성하세요!</span
          >
        </div>
      </div>
    </div>
  </body>
</html>

