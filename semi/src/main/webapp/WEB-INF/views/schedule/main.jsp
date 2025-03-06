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
            $(".tab").hide();
          } else {
            $(".sidebar").css("transform", "translateX(0)");
            $(".content").css("transform", "translateX(0)");
            $(".sidebar").addClass("light-dark");
            $(".tab").show();
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

        $(".profile-btn").click(function () {
          $(".account-modal").removeClass("none").addClass("flex");
        });

        $(".modal-close-btn").click(function () {
          $(".account-modal").removeClass("flex").addClass("none");
        });

        $(window).click(function (e) {
          if ($(e.target).is(".account-modal")) {
            $(".account-modal").removeClass("flex").addClass("none");
          }
        });
      });
    </script>
  </head>
  <body>
    <div class="flex items-start">
      <aside class="sidebar anim light-dark w-260 h-100v px-16">
        <div class="flex justify-between items-center pt-8">
          <button
            class="profile-btn trans-color border-none outline-none flex items-center px-8 py-9 round-6"
          >
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
        <div class="tab pt-12">
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
        <div class="tab">
          <div
            class="date-title-tab flex justify-between items-center px-8 py-11 mt-24 round-6"
          >
            <span class="text-font-color text-14">일정 관리</span>
            <button
              class="plus-btn none trans-color border-none outline-none w-24 h-24 p-0 round-6"
            >
              <img src="img/plus.svg" class="w-100p h-100p" />
            </button>
          </div>
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
    <div
      class="account-modal none justify-center items-center fixed left-0 top-0 w-100p h-100p opacity-40"
    >
      <div class="light top-50 left-50 w-400 round-6">
        <div class="flex justify-between px-16 py-11 bb-1 line-base">
          <span class="title-font-color text-16">계정</span>
          <button
            class="modal-close-btn trans-color border-none outline-none w-24 h-24 p-0 round-6"
          >
            <img src="img/close.svg" class="w-100p h-100p" />
          </button>
        </div>
        <div class="content p-32">
          <div>
            <span class="subtitle-font-color text-14">프로필 정보</span>
            <div class="flex items-center mt-12">
              <img src="${picture}" width="86" height="86" class="mr-16 round-full" />
              <div class="flex flex-col">
                <span class="subtitle-font-color text-14">이름</span>
                <input
                  type="text"
                  value="${name}"
                  class="w-204 border-1 line-base outline-none mt-4 px-14 py-9 text-14 round-6"
                />
              </div>
            </div>
          </div>
          <div class="flex flex-col mt-32">
            <span class="subtitle-font-color text-14">이메일</span>
            <span class="subtext-font-color text-12 mt-4">${email}</span>
            <div class="mt-8">
              <button
                class="border-none outline-none px-14 py-9 text-14 subtitle-font-color netural round-6"
              >
                이메일 변경
              </button>
            </div>
          </div>
          <div class="flex flex-col mt-16">
            <span class="subtitle-font-color text-14">로그아웃</span>
            <div class="mt-8">
              <button
                class="border-none outline-none px-14 py-9 text-14 subtitle-font-color netural round-6"
              >
                로그아웃
              </button>
            </div>
          </div>
          <div class="flex flex-col mt-16">
            <span class="subtitle-font-color text-14">회원 탈퇴</span>
            <span class="subtext-font-color text-12 mt-4"
              >계정을 탈퇴하면 데이터들을 복구할 수 없습니다.</span
            >
            <div class="mt-8">
              <button
                class="border-1 negative-b trans-color outline-none px-14 py-9 text-14 btn-negative round-6"
              >
                계정 탈퇴
              </button>
            </div>
          </div>
          <div class="flex justify-end mt-32">
            <button
              class="border-none outline-none brand-dark light-font px-14 py-9 text-14 round-6"
            >
              저장
            </button>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>


