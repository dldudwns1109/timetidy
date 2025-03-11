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
    	  var header = $("meta[name='_csrf_header']").attr('content');
    	  var token = $("meta[name='_csrf']").attr('content');
    	  $.ajax({
    		  url: "/rest/notification/list",
    		  beforeSend: function (xhr) {
    	        xhr.setRequestHeader(header, token);
    	      },
    	      method: "GET",
    	      success: function(res) {
    	    	  if (res.length == 0) $(".no-message").removeClass("none").addClass("flex");
    	    	  $.each(res, function(idx, val) {
    	    		  $.ajax({
    	    			  url: "/rest/member/find",
    	    			  beforeSend: function (xhr) {
    	    	    	    xhr.setRequestHeader(header, token);
    	    	    	  },
    	    	    	  method: "GET",
    	    	    	  data: {memberId: val.notificationSenderId},
    	    	    	  success: function (res2) {
    	    	    		  $(".notification-list-content").append(
    	    	    				  $("<div>")
    	    	    				  	.attr("data-id", val.notificationSenderId)
    	    	    				  	.attr("data-job-id", val.notificationJobId)
    	    	    				    .addClass("notification-tab flex justify-between items-center mb-8")
    	    	    				    .append(
    	    	    				      $("<div>")
    	    	    				      	.addClass("flex items-center")
    	    	    				        .append(
    	    	    				          $("<img>")
    	    	    				            .attr("src", res2.memberProfile)
    	    	    				            .addClass("w-26 h-26 mr-8 round-full")
    	    	    				        )
    	    	    				        .append(
    	    	    				          $("<span>")
    	    	    				            .text(res2.memberName + val.notificationMessage)
    	    	    				            .addClass("text-16 title-font-color")
    	    	    				        )
    	    	    				    )
    	    	    				    .append(
    	    	    				      $("<div>")
    	    	    				      	.addClass("flex")
    	    	    				        .append($("<button>")
    	    	    				        		.append(
    	    	    				        				$("<img>")
    	    	    				        					.attr("src", "/img/check-positive.svg"))
    	    	    				        		.append(
    	    	    				        				$("<span>")
    	    	    				        					.addClass("text-16 subtext-font-color")
    	    	    				        					.text("수락"))
    	    	    				        		.addClass("accept-btn flex trans-color border-1 positive-b outline-none mr-8 round-6 pl-4 pr-8 py-6")
    	    	    				        		.hover(function(e) {
    	    	    				        			$(this).find("img").attr("src", "/img/check-hover.svg");
    	    	    				        		}, function(e) {
    	    	    				        			$(this).find("img").attr("src", "/img/check-positive.svg");
    	    	    				        		})
    	    	    				        		.click(function() {
    	    	    				        			var notificationTab = $(this).closest(".notification-tab");
    	    	    				        			if (notificationTab.data("job-id") == undefined) {
    	    	    				        				$.ajax({
    	    	    				        					url: "/rest/notification/accept",
    	    	    				        					beforeSend: function (xhr) {
    	    	    				        	    	    	  xhr.setRequestHeader(header, token);
    	    	    				        	    	    	},
    	    	    				        	    	    	method: "POST",
    	    	    				        	    	    	data: {senderId: notificationTab.data("id")},
    	    	    				        	    	    	success: function(res) {
    	    	    				        	    	    		notificationTab.remove();
    	    	    				        	    	    	},
    	    	    				        				})
    	    	    				        			}
    	    	    				        		})
    	    	    				        		)
    	    	    				        .append($("<button>")
    	    	    				        		.append(
    	    	    				        				$("<img>")
    	    	    				        					.attr("src", "/img/close-negative.svg"))
    	    	    				        		.append(
    	    	    				        				$("<span>")
    	    	    				        					.addClass("text-16 subtext-font-color")
    	    	    				        					.text("거절"))
    	    	    				        		.addClass("reject-btn flex trans-color border-1 negative-b outline-none round-6 pl-4 pr-8 py-6")
    	    	    				        		.hover(function(e) {
    	    	    				        			$(this).find("img").attr("src", "/img/close-hover.svg");
    	    	    				        		}, function(e) {
    	    	    				        			$(this).find("img").attr("src", "/img/close-negative.svg");
    	    	    				        		})
    	    	    				        		.click(function() {
    	    	    				        			var notificationTab = $(this).closest(".notification-tab");
    	    	    				        			if (notificationTab.data("job-id") == undefined) {
    	    	    				        				$.ajax({
    	    	    				        					url: "/rest/notification/reject",
    	    	    				        					beforeSend: function (xhr) {
    	    	    				        	    	    	  xhr.setRequestHeader(header, token);
    	    	    				        	    	    	},
    	    	    				        	    	    	method: "POST",
    	    	    				        	    	    	data: {senderId: notificationTab.data("id")},
    	    	    				        	    	    	success: function(res) {
    	    	    				        	    	    		notificationTab.remove();
    	    	    				        	    	    	},
    	    	    				        				})
    	    	    				        			}
    	    	    				        		})
    	    	    				        		)
    	    	    				    )
    	    	    				);
    	    	    	  },
    	    		  })
    	    	  })
    	      }
    	  })
      })
    </script>
  </head>
  <body>
    <div class="flex items-start">
      <jsp:include page="/WEB-INF/views/template/aside.jsp" />
      <div class="content anim overflow-auto flex flex-1 justify-center w-100p h-100v">
      	<div class="page-content w-620 py-64">
	      <div>
	      	<span class="title-24 title-font-color">알림</span>
	      </div>
	      <div class="notification-list-content mt-24">
	      	<div class="no-message none flex-col items-center mt-154">
	      		<img src="/img/nomessage.svg">
	      		<span class="mt-24 text-16 title-font-color">받은 알림이 없습니다.</span>
	      	</div>
	      </div>
        </div>
      </div>
    </div>
    <jsp:include page="/WEB-INF/views/template/account-modal.jsp" />
    <jsp:include page="/WEB-INF/views/template/search-modal.jsp" />
  </body>
</html>


