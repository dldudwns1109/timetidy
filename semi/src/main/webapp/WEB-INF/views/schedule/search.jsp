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
    	  var urlParams = new URLSearchParams(window.location.search);
    	  var keyword = urlParams.get("query");
    	  $.ajax({
        	  url: "/rest/search/result?keyword=" + keyword,
        	  beforeSend: function (xhr) {
    		    xhr.setRequestHeader(header, token);
	   		  },
	   		  method: "GET",
	   		  success: function(res) {
	   			if (res.length == 0) {
	   				$(".page-result").append(
	   						$("<div>")
	   							.addClass("flex flex-col items-center")
	   							.append($("<img>")
	   										.addClass("w-260")
	   										.attr("src", "/img/no-result.svg")
	   							)
	   							.append($("<span>")
	   									.addClass("mt-24 text-16 title-font-color")
   										.text('"'+keyword+'"과(와) 일치하는 일정이 없습니다.')))
   							.removeClass("mt-32")
   							.addClass("flex justify-center mt-154")
	   			}
	   		    $.each(res, function(idx, val) {
	   		    	$(".page-result").append(
	   		    			$("<button>")
	   		    				.addClass("page-result-btn trans-color border-none outline-none flex items-center w-100p mt-8 px-14 py-11 round-6")
	   		    				.append(
	   		    					$("<img>")
	   		    						.addClass("mr-8")
	   		    						.attr("src", "/img/doc.svg"))
	   		    				.append(
	   		    					$("<span>")
	   		    						.addClass("text-16 title-font-color")
	   		    						.text(val.pageTitle))
		    					.click(function() {
		   		    				location.href = "/schedule/" + val.pageId;
		   		    			}));
	   		    })
	   		  },
          })
      })
    </script>
  </head>
  <body>
    <div class="flex items-start">
      <jsp:include page="/WEB-INF/views/template/aside.jsp" />
      <div class="content anim overflow-auto flex flex-1 justify-center w-100p h-100v">
      	<div class="page-content w-620 py-64">
	      <span class="title-24 title-font-color">검색 결과 : "${query}"</span>
	      <div class="page-result mt-32">
	      	
	      </div>
        </div>
      </div>
    </div>
    <jsp:include page="/WEB-INF/views/template/account-modal.jsp" />
    <jsp:include page="/WEB-INF/views/template/search-modal.jsp" />
  </body>
</html>


