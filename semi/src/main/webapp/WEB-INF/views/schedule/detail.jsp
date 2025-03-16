<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="_csrf_header" content="${_csrf.headerName}" />
    <meta name="_csrf" content="${_csrf.token}" />
    <title>timetidy</title>
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
      rel="stylesheet"
    />
    <link rel="stylesheet" href="/css/commons.css" />
    <link rel="stylesheet" href="/css/colors.css" />
    <link rel="stylesheet" href="/css/fonts.css" />
    <jsp:include page="/WEB-INF/views/template/aside-script.jsp" />
    <script
      type="text/javascript"
      src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${appkey}&autoload=false&libraries=services"
    ></script>
    <script type="module">
      import { jobList } from "/js/job-list.js";
	  import { jobAddInput } from "/js/job-add-input.js";
      $(function () {
        var header = $("meta[name='_csrf_header']").attr("content");
        var token = $("meta[name='_csrf']").attr("content");
		var pageId = ${pageDto.pageId}
        $.ajax({
          url: "/rest/job/list",
          beforeSend: function (xhr) {
            xhr.setRequestHeader(header, token);
          },
          method: "GET",
          data: { pageId: pageId },
          success: function (res) {
            jobList(res, pageId);
          },
        });

        $(".title-input").blur(function () {
          $.ajax({
            url: "/rest/page/updateTitle",
            beforeSend: function (xhr) {
              xhr.setRequestHeader(header, token);
            },
            method: "POST",
            data: {
              pageId: pageId,
              pageTitle: $(this).val(),
            },
            success: function (res) {
              $("[data-id=" + pageId + "] .page-title").text(res);
            },
          });
        });

        $(".job-add-area").hover(
          function () {
            $(".job-add-btn").show();
          },
          function () {
            $(".job-add-btn").hide();
          }
        );

        $(".job-add-btn")
          .hover(
            function () {
              $(".job-add-btn img").attr("src", "/img/plus-hover.svg");
            },
            function () {
              $(".job-add-btn img").attr("src", "/img/plus.svg");
            }
          )
          .click(function () {
            $(".job-add-area").hide();
            jobAddInput(pageId);
          });
      });
    </script>
  </head>
  <body>
    <div class="flex items-start">
      <jsp:include page="/WEB-INF/views/template/aside.jsp" />
      <div
        class="content anim overflow-auto flex flex-1 justify-center w-100p h-100v mb-240"
      >
        <div class="page-content w-620 pt-64">
          <input
            value="${pageDto.pageTitle}"
            placeholder="빈 페이지"
            class="title-input w-100p border-none outline-brand px-14 py-9 title-32 title-font-color"
          />
          <div class="job-content mt-40"></div>
          <div class="job-add-area flex justify-center h-44 mt-40 pb-64">
            <button
              class="job-add-btn trans-color brand-medium-font border-1 brand-b outline-none flex items-center pl-8 pr-14 py-9 round-6"
            >
              <img src="/img/plus.svg" class="mr-8" />
              <span class="text-16">일정 추가</span>
            </button>
          </div>
        </div>
      </div>
    </div>
    <jsp:include page="/WEB-INF/views/template/account-modal.jsp" />
    <jsp:include page="/WEB-INF/views/template/search-modal.jsp" />
    <div
      class="social-dropdown none justify-center items-center fixed left-0 top-0 w-100p h-100p"
    >
      <div
        class="social-dropdown-content absolute light inline-block border-1 line-base round-6 p-6"
      ></div>
    </div>
    <div
      class="datetime-dropdown none justify-center items-center fixed left-0 top-0 w-100p h-100p"
    >
      <div
        class="datetime-dropdown-content absolute light flex flex-col border-1 line-base round-6 p-6"
      >
        <button
          data-id="1"
          class="datetime-tab-btn trans-color border-none outline-none text-16 title-font-color round-6 px-4 py-6"
        >
          시간
        </button>
        <button
          data-id="2"
          class="datetime-tab-btn trans-color border-none outline-none text-16 title-font-color round-6 px-4 py-6"
        >
          기간
        </button>
        <button
          data-id="3"
          class="datetime-tab-btn trans-color border-none outline-none text-16 title-font-color round-6 px-4 py-6"
        >
          시간 + 기간
        </button>
      </div>
    </div>
  </body>
</html>
