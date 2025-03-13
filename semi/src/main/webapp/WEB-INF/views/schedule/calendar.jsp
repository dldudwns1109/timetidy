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
    <link
      href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.2.0/fullcalendar.min.css"
      rel="stylesheet"
    />
    <style>
      .calendar {
        margin: 50px auto;
      }

      .event-modal {
        display: none;
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        background-color: white;
        padding: 20px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        z-index: 9999;
        width: 400px;
      }

      .event-modal h3 {
        margin-top: 0;
      }

      .event-modal button {
        margin-top: 10px;
      }
    </style>
    <jsp:include page="/WEB-INF/views/template/aside-script.jsp" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.2.0/fullcalendar.min.js"></script>
    <script type="text/javascript">
    	$(function () {
    		var header = $("meta[name='_csrf_header']").attr("content");
      	  	var token = $("meta[name='_csrf']").attr("content");
      	  var calendar = $(".calendar").fullCalendar({
  	          events: [
  	            {
  	              title: "Meeting with John",
  	              start: "2025-01-28T10:00:00",
  	              end: "2025-01-29T12:00:00",
  	              description: "Discuss project details",
  	              location: "제주도 푸른 곳",
  	              extendedProps: {
  	                participants1: 1,
  	                participants2: 2,
  	                participants3: 3,
  	              },
  	            },
  	            {
  	              title: "Meeting with John",
  	              start: "2025-02-28T10:00:00",
  	              end: "2025-02-28T12:00:00",
  	              description: "Discuss project details",
  	            },
  	            {
  	              title: "Lunch with Sarah",
  	              start: "2025-03-01T13:00:00",
  	              end: "2025-03-01T14:00:00",
  	              description: "Casual lunch",
  	            },
  	            {
  	              title: "Conference Call",
  	              start: "2025-03-02T09:00:00",
  	              end: "2025-03-02T10:00:00",
  	              description: "Monthly conference call",
  	            },
  	          ],
  	          dayClick: function (date, jsEvent, view) {
  	        	  
  	          },

  	          eventClick: function (event) {
  	            $(".event-modal").show();
  	            
  	            $(".event-title").text(event.title);
  	            $(".event-description").text(event.description);
  	            $(".event-location").text(event.location);
  	            $(".event-participants1").text(event.extendedProps.participants1);
  	          },
  	        });

  	        $(".close-btn").click(function () {
  	          $(".event-modal").hide();
  	        });
    		
    	})
    </script>
  </head>
  <body>
    <div class="flex items-start">
      <jsp:include page="/WEB-INF/views/template/aside.jsp" />
      <div class="content anim flex flex-1 justify-center items-center w-100p h-100v">
	    <div class="calendar w-1000"></div>
	
	    <div class="event-modal">
	      <h3>Event Details</h3>
	      <p>Title: <span class="event-title"></span></p>
	      <p>Description: <span class="event-description"></span></p>
	      <p>Location: <span class="event-location"></span></p>
	      <p>participants1: <span class="event-participants1"></span></p>
	      <button type="button" class="close-btn">Close</button>
	    </div>
      </div>
    </div>
    <jsp:include page="/WEB-INF/views/template/account-modal.jsp" />
    <jsp:include page="/WEB-INF/views/template/search-modal.jsp" />
  </body>
</html>


