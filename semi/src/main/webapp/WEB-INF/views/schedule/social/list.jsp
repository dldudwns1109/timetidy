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
    		  url: "/rest/social/list",
    		  beforeSend: function (xhr) {
        		xhr.setRequestHeader(header, token);
        	  },
        	  method: "GET",
        	  success: function (res) {
        		$(".social-list-content").empty();
        		if (res.length == 0) {
        			$(".social-list-content").append(
    						$("<div>")
    							.addClass("flex flex-col items-center mt-40")
    							.append($("<img>")
    										.attr("src", "/img/no-friend.svg"))
    							.append($("<span>")
    										.addClass("text-16 title-font-color mt-24")
    										.text("친구 목록이 없습니다.")))
        		}
        		$.each(res, function(idx, val) {
    				$(".social-list-content").append(
    					$("<div>")
    						.addClass("social-tab flex justify-between items-center mb-8")
    						.append(
    							$("<div>")
            						.addClass("flex items-center px-8 py-9")
            						.append(
            							$("<img>")
            								.attr("src", val.socialProfile)
            								.addClass("w-26 h-26 mr-8 round-full"))
         							.append(
            							$("<span>")
            								.text(val.socialName)
            								.addClass("text-16 title-font-color")))
            				.append(
            					$("<div>")
            						.append($("<button>")
            									.attr("data-id", val.socialRelativeId)
            									.addClass("social-delete-btn trans-color border-1 negative-b px-12 py-6 round-6 text-16 subtext-font-color")
            									.text("삭제")
            									.click(function() {
            										$.ajax({
            											url: "/rest/social/delete",
            											beforeSend: function (xhr) {
            								        	  xhr.setRequestHeader(header, token);
            								        	},
            								        	method: "GET",
            								        	data: {relativeId: $(this).data("id")},
            								        	success: function (res) {
            								        		$('[data-id="' + res + '"]').closest(".social-tab").remove();
            								        	}
            										})
            									})
            						)
            				)
    				)
    			})
        	  }
    	  })
    	  
    	  $(".social-add-tab-btn").click(function() {
    		location.href = "/schedule/social/add";
    	  });
    	  
    	  $(".social-input").on("input", function(e) {
    		  $.ajax({
    			  url: "/rest/social/search-list",
    			  beforeSend: function (xhr) {
          		    xhr.setRequestHeader(header, token);
          		  },
          		  method: "GET",
          		  data: {keyword : $(e.target).val()},
          		  success: function (res) {
          			$(".social-list-content").empty();
          			if (res.length == 0) {
          				$(".social-list-content").append(
        						$("<div>")
        							.addClass("flex flex-col items-center mt-40")
        							.append($("<img>")
        										.attr("src", "/img/no-friend.svg"))
        							.append($("<span>")
        										.addClass("text-16 title-font-color mt-24")
        										.text("찾는 친구 목록이 없습니다.")))
          			}
            		$.each(res, function(idx, val) {
        				$(".social-list-content").append(
        					$("<div>")
        						.addClass("social-tab flex justify-between items-center mb-8")
        						.append(
        							$("<div>")
                						.addClass("flex items-center px-8 py-9")
                						.append(
                							$("<img>")
                								.attr("src", val.socialProfile)
                								.addClass("w-26 h-26 mr-8 round-full"))
             							.append(
                							$("<span>")
                								.text(val.socialName)
                								.addClass("text-16 title-font-color")))
                				.append(
                					$("<div>")
                						.append($("<button>")
                									.attr("data-id", val.socialRelativeId)
                									.addClass("social-delete-btn trans-color border-1 negative-b px-12 py-6 round-6 text-16 subtext-font-color")
                									.text("삭제")
                									.click(function() {
                										$.ajax({
                											url: "/rest/social/delete",
                											beforeSend: function (xhr) {
                								        	  xhr.setRequestHeader(header, token);
                								        	},
                								        	method: "GET",
                								        	data: {relativeId: $(this).data("id")},
                								        	success: function (res) {
                								        		$('[data-id="' + res + '"]').closest(".social-tab").remove();
                								        	}
                										})
                									})
                						)
                				)
        				)
        			})
          		  }
    		  })
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
	      	<span class="title-24 title-font-color">소셜</span>
	      </div>
	      <div class="inline-block light-dark mt-24 px-4 py-4 round-full">
	      	<button class="social-list-tab-btn light border-none outline-none px-12 py-10 round-full text-14 title-font-color">목록</button>
	      	<button class="social-add-tab-btn trans-color border-none outline-none px-12 py-10 round-full text-14 title-font-color">추가</button>
	      </div>
	      
	      <div class="flex items-center light-dark px-14 py-9 mt-24 round-6">
	      	<img src="/img/search.svg" class="mr-8">
	      	<input 
	      		class="social-input trans-color border-none outline-none p-0 text-16 title-font-color"
	      		placeholder="유저 닉네임 검색" >
	      </div>
	      <div class="social-list-content mt-16">
	      	
	      </div>
        </div>
      </div>
    </div>
    <jsp:include page="/WEB-INF/views/template/account-modal.jsp" />
    <jsp:include page="/WEB-INF/views/template/search-modal.jsp" />
  </body>
</html>


