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
    <script type="text/javascript">
      $(function() {
    	  var header = $("meta[name='_csrf_header']").attr("content");
    	  var token = $("meta[name='_csrf']").attr("content");
    	  var pageId = ${pageDto.pageId}
    	  $(".title-input").blur(function() {
    		$.ajax({
    			url: "/rest/page/updateTitle",
    			beforeSend: function (xhr) {
    		      xhr.setRequestHeader(header, token);
    		    },
    		    method: "POST",
    		    data: {
    		    	pageId: pageId,
    		    	pageTitle: $(this).val()
    		    },
    		    success: function(res) {
    		    	$("[data-id=" + pageId + "] .page-title")
    		    		.text(res);
    		    },
    		})
    	  });
    	  
    	  $(".job-add-area").hover(
   		    function() {
   	          $(".job-add-btn").show();
   	        },
   	       	function() {
 	          $(".job-add-btn").hide();
            },
    	  );
    	  
    	  $(".job-add-btn")
    	  	.hover(
   				function() {
   			  		$(".job-add-btn img").attr("src", "/img/plus-hover.svg");
   				},
   				function() {
     		 		 $(".job-add-btn img").attr("src", "/img/plus.svg");
     			},)
     		.click(function () {
     			$(".job-add-area").hide();
     			$(".job-content").append(
     					$("<div>")
     						.addClass("job-input flex flex-col p-16 line-base border-1 round-6")
     						.append($("<input>")
     									.attr("placeholder", "제목")
     									.addClass("job-title-input border-none outline-none text-16 title-font-color"))
     						.append($("<textarea>")
     									.attr("placeholder", "내용을 작성하세요...")
     									.attr("rows", 2)
     									.addClass("job-content-input border-none outline-none text-14 subtitle-font-color mt-8"))
     						.append($("<div>")
     								.addClass("flex justify-between")
     								.append($("<div>")
     										.addClass("flex")
     										.append($("<button>")
     													.addClass("flex items-center border-1 line-base round-6 trans-color outline-none py-4 pl-6 pr-8 mr-8")
     													.append($("<img>")
     															.attr("src", "/img/user.svg")
     															.addClass("mr-4"))
     													.append($("<span>")
     															.text("소셜")
     															.addClass("text-14 subtext-font-color")))
     										.append($("<button>")
     													.addClass("flex items-center border-1 line-base round-6 trans-color outline-none py-4 pl-6 pr-8 mr-8")
 														.append($("<img>")
 																.attr("src", "/img/s-date.svg")
 																.addClass("mr-4"))
 														.append($("<span>")
 																.text("날짜")
 																.addClass("text-14 subtext-font-color")))
     										.append($("<button>")
     													.addClass("flex items-center border-1 line-base round-6 trans-color outline-none py-4 pl-6 pr-8 mr-8")
														.append($("<img>")
																.attr("src", "/img/location.svg")
																.addClass("mr-4"))
														.append($("<span>")
																.text("장소")
																.addClass("text-14 subtext-font-color"))))
     								.append($("<div>")
     										.addClass("flex")
     										.append($("<button>")
     													.addClass("flex items-center border-1 negative-b round-6 trans-color outline-none py-6 pl-6 pr-8 mr-8")
														.append($("<img>")
																.attr("src", "/img/close.svg")
																.addClass("mr-4"))
														.append($("<span>")
																.text("취소")
																.addClass("text-16 subtext-font-color")))
														.click(function () {
															var isDelete = true;
															var jobInput = $(this).closest(".job-input");
															if (jobInput.children(".job-title-input").val().length ||
																	jobInput.children(".job-content-input").val().length) {
																isDelete = window.confirm("저장하지 않은 변경사항을 삭제하시겠습니까?");
															}
															
															if (isDelete) {
																jobInput.remove();
																$(".job-add-area").show();
															}
														})
     										.append($("<button>")
     													.addClass("flex items-center border-1 brand-b round-6 trans-color outline-none py-6 pl-6 pr-8 mr-8")
														.append($("<img>")
																.attr("src", "/img/plus.svg")
																.addClass("mr-4"))
														.append($("<span>")
																.text("추가")
																.addClass("text-16 subtext-font-color"))))))
		    })
      });
    </script>
  </head>
  <body>
    <div class="flex items-start">
      <jsp:include page="/WEB-INF/views/template/aside.jsp" />
      <div class="content anim overflow-auto flex flex-1 justify-center w-100p h-100v">
        <div class="page-content w-620 py-64">
	      pageId : ${pageDto.pageId} <br>
          <input value="${pageDto.pageTitle}"
          		 placeholder="${pageDto.pageTitle}" 
          		 class="title-input w-100p border-none outline-brand px-14 py-9 title-32 title-font-color" >
          <div class="job-content mt-40">
          	
          </div>
          <div class="job-add-area flex justify-center h-44 mt-40 pb-64">
          	<button class="job-add-btn trans-color brand-medium-font border-1 brand-b outline-none flex items-center pl-8 pr-14 py-9 round-6">
          		<img src="/img/plus.svg" class="mr-8" >
          		<span class="text-16">일정 추가</span>
          	</button>
          </div>
        </div>
      </div>
    </div>
    <jsp:include page="/WEB-INF/views/template/account-modal.jsp" />
    <jsp:include page="/WEB-INF/views/template/search-modal.jsp" />
  </body>
</html>


