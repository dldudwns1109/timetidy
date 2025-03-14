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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment-timezone/0.5.34/moment-timezone-with-data.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.2.0/fullcalendar.min.js"></script>
    <script type="text/javascript">
    	$(function () {
    	  var header = $("meta[name='_csrf_header']").attr("content");
      	  var token = $("meta[name='_csrf']").attr("content");
      	  var calendar = $(".calendar").fullCalendar({
  	          events: function (start, end, timezone, callback) {
  	        	$.ajax({
  	      	  		url: "/rest/job/calendar-list",
  	      	  		beforeSend: function (xhr) {
  	    		      xhr.setRequestHeader(header, token);
  	    		  	},
  	    		  	method: "GET",
  	    		  	success: function (res) {
  	    		  		console.log(res)
  	    		  		var events = res.map(function (event) {
  	    		  			return {
  	    		  				title: event.jobTitle,
  	    		  				start: moment(new Date(event.jobStartTime)).tz("Asia/Seoul", true).format(),
  	    		  				end: moment(new Date(event.jobEndTime)).tz("Asia/Seoul", true).format(),
  	    		  				location: event.jobPlace,
  	    		  				description: event.jobDescription,
  	    		  				extendedProps: {
  	    		  					host: event.jobHostId,
  	    		  					participant1: event.jobParticipant1Id,
  	    		  					participant2: event.jobParticipant2Id,
  	    		  					participant3: event.jobParticipant3Id,
  	    		  				},
  	    		  			};
  	    		  		})
  	    		  		callback(events);
  	    		  	},
  	      	  	})
  	          },
  	          dayClick: function (date, jsEvent, view) {
  	        	  
  	          },
  	          eventClick: function (event) {
  	            $(".event-modal").show();
  	            
  	            $(".event-title").text(event.title);
  	            $(".event-description").text(event.description);
  	            $(".event-location").text(event.location);
  	      		$(".event-host").text(event.extendedProps.host);
  	            $(".event-participant1").text(event.extendedProps.participant1);
  	          	$(".event-participant2").text(event.extendedProps.participant2);
  	        	$(".event-participant3").text(event.extendedProps.participant3);
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
	      <p>host: <span class="event-host"></span></p>
	      <p>participants1: <span class="event-participant1"></span></p>
	      <p>participants2: <span class="event-participant2"></span></p>
	      <p>participants3: <span class="event-participant3"></span></p>
	      <p>Description: <span class="event-description"></span></p>
	      <p>Location: <span class="event-location"></span></p>
	      <button type="button" class="close-btn">Close</button>
	    </div>
      </div>
    </div>
    <jsp:include page="/WEB-INF/views/template/account-modal.jsp" />
    <jsp:include page="/WEB-INF/views/template/search-modal.jsp" />
  </body>
</html>


