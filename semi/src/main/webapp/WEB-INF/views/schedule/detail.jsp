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
      src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${appkey}&libraries=services"
    ></script>
    <script type="text/javascript">
      $(function() {
    	  var header = $("meta[name='_csrf_header']").attr("content");
    	  var token = $("meta[name='_csrf']").attr("content");
    	  var pageId = ${pageDto.pageId}
    	  $.ajax({
    		  url: "/rest/job/list",
    		  beforeSend: function (xhr) {
    		    xhr.setRequestHeader(header, token);
    		  },
    		  method: "GET",
    		  data: {pageId: pageId},
    		  success: function(res) {
    		    $.each(res, function(idx, val) {
    		    	$(".job-content").append(
				    			$("<div>")
				    				.attr("data-id", val.jobId)
		     						.addClass("job-tab flex flex-col p-16 mb-16 line-base border-1 round-6")
		     						.append($("<span>")
		     									.text(val.jobTitle)
		     									.addClass("text-20 title-font-color"))
		     						.append($("<div>")
		     									.append($("<div>").addClass("job-participants-tab"))
						     					).append($("<div>")
				     									.addClass("flex flex-col mt-16")
				     									.append(
				     											$("<span>")
						     									.text("날짜")
						     									.addClass("text-12 subtitle-font-color"))
				     									.append(
				     											$("<div>")
				     												.addClass("datetime-tab mt-8")
				     												.append($("<span>")
									     									.text(new Date(val.jobStartTime).toLocaleString())
									     									.addClass("text-12 text-font-color"))))
		     						.append($("<div>").addClass("job-place-tab"))
		     						.append($("<div>").addClass("job-description-tab"))
				    		)
				    		
				    		if (val.jobParticipant1Id != null || val.jobParticipant2Id != null || val.jobParticipant3Id != null) {
				    			var participantsTab = $("<div>")
									.addClass("flex flex-col mt-16")
 									.append(
 											$("<span>")
	     									.text("참여자")
	     									.addClass("text-12 subtitle-font-color"))
 									.append($("<div>").addClass("participants-tab"));
				    			$(".job-participants-tab").append(participantsTab);
				    			
				    			var participantsId = [
			    		    		val.jobParticipant1Id,
			    		    		val.jobParticipant2Id,
			    		    		val.jobParticipant3Id
			    		    	]
			    		    	$.each(participantsId, function (idx, val2) {
			    		    		$.ajax({
			    		    			url: "/rest/social/find",
			    		    			beforeSend: function (xhr) {
			    		        		  xhr.setRequestHeader(header, token);
			    		        		},
			    		        		method: "GET",
			    		        		data: {socialId: val2},
			    		        		success: function(res) {
			    		        			var participantTab = $("<div>")
			    		        				.addClass("flex items-center mr-8 mt-8")
												.append($("<img>").attr("src", res.socialProfile)
													.addClass("w-26 h-26 round-full inline-block mr-8"))
													.append($("<span>").text(res.socialName).addClass("text-16 title-font-color"));
			    		        			$(".participants-tab").append(participantTab);
			    		        		},
			    		    		})
			    		    	})
				    		}
				    		
				    		if (val.jobEndTime != null) {
        		    		var endTimeTab = $("<span>")
    							.text("~ " + new Date(val.jobEndTime).toLocaleString())
    								.addClass("text-12 text-font-color mt-8 ml-8");
        		    		$('[data-id="' + val.jobId + '"] .datetime-tab').append(endTimeTab);
        		    	}
    		    	
    		    		if (val.jobPlace != null) {
    		    			var place = $("<div>")
								.addClass("flex flex-col mt-8")
									.append(
											$("<span>")
     									.text("장소")
     									.addClass("text-12 subtitle-font-color"))
									.append(
											$("<span>")
     									.text(val.jobPlace)
     									.addClass("job-place-address text-12 text-font-color mt-8"))
									.append(
											$("<div>")
     									.addClass("map mt-8 round-6"));
    		    			
    		    			$(".job-place-tab").append(place);
    		    			var container = $('[data-id="' + val.jobId + '"] .map')[0];
    						
    						var options = {
    				          center: new kakao.maps.LatLng(37.566395, 126.987778),
    				          level: 3,
    				        };
    						
    						var map = new kakao.maps.Map(container, options);
    						
    						var address = $('[data-id="' + val.jobId + '"] .job-place-address').text();
    						
    						var geocoder = new kakao.maps.services.Geocoder();
    						
    						geocoder.addressSearch(address, function (res, status) {
    							if (status === kakao.maps.services.Status.OK) {
    								var location = new kakao.maps.LatLng(res[0].y, res[0].x);
    					            var marker = new kakao.maps.Marker({
    					              map: map,
    					              position: location,
    					            });
    					            
    					            map.setCenter(location);
    							}
    						})
    		    		}
    		    		
    		    		if (val.jobDescription != null) {
    		    			var jobDescription = $("<p>")
								.text(val.jobDescription)
									.addClass("text-14 text-font-color mt-8");
    		    			$(".job-description-tab").append(jobDescription);
    		    		}
    		    })
    		  },
    	  })
    	  
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
     						.append($("<div>")
     									.addClass("job-participant"))
     						.append($("<div>")
     									.addClass("job-datetime"))
     						.append($("<div>")
 									.addClass("job-place flex flex-col"))
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
     															.addClass("text-14 subtext-font-color"))
     													.click(function () {
     														var buttonOffset = $(this).offset();
												    	    var buttonHeight = $(this).outerHeight();
     														$.ajax({
     															url: "/rest/social/list",
     															beforeSend: function (xhr) {
     												    		  xhr.setRequestHeader(header, token);
     												    		},
     												    		method: "GET",
     												    		success: function (res) {
     												    		  $(".social-dropdown").show();
     												    		  $(".social-dropdown-content").empty();
     												    		  
     												    		  var currParticipants = [];
     												    		  $.each($(".job-participant").children(), function(idx, val) {
  												    			    currParticipants.push($(val).data("id"))
 		  												    	  });
     												    		  
     												    		  if (currParticipants.length) {
     												    			 $.each(res, function(idx, val) {
     												    			   var isExist = false;
     												    			   $.each(currParticipants, function (idx, val2) {
     												    				  if (val.socialRelativeId == val2) {
     												    					  isExist = true;
     												    				  }
     												    			   })
     												    			   if (!isExist) {
     												    				  $(".social-dropdown-content").append(
	          												    					$("<button>").append(
	     		        			       	     											$("<img>")
	     		        			       	     												.attr("src", val.socialProfile)
	     		        			       	     												.addClass("w-26 h-26 round-full mr-8")
	     		        			       	     										  ).append(
	     		        			       	     											$("<span>").text(val.socialName)
	     		        			       	     										  ).addClass("social-tab-btn trans-color border-none outline-none flex items-center w-100p px-8 py-9 round-6"
	     		        			       	     										  ).attr("data-id", val.socialRelativeId
	     		        			       	     										  ).click(function () {
	     		        			       	     											if (currParticipants.length < 3) {
		     		        			       	     											$(".social-dropdown").hide();
		     		        			       	     											$(".job-participant").append(
		     		        			       	     												$("<div>")
		     		        			       	     													.attr("data-id", val.socialRelativeId)
		     		        			       	     													.addClass("participant-tab px-8 py-9 mr-8 light-dark inline-block round-6")
		     		        			       	     													.append($("<img>")
		     		        			       	     															.attr("src", val.socialProfile)
		     		        			       	     															.addClass("w-26 h-26 round-full mr-8 vertical-center"))
		     		        			       	     													.append($("<span>")
		     		        			       	     															.text(val.socialName)
		     		        			       	     															.addClass("text-16 title-font-color vertical-center mr-4"))
		     		        			       	     													.append($("<button>")
		     		        			       	     															.addClass("trans-color border-none outline-none vertical-center w-24 h-24 p-0")
		     		        			       	     															.append($("<img>")
		     		        			       	     																		.attr("src", "/img/close.svg"))
		     		        			       	     															.click(function () {
		     		        			       	     																$(this).closest(".participant-tab").remove();
		     		        			       	     															}))
		     		        			       	     											).addClass("mt-8")	
	     		        			       	     											} else {
	     		        			       	     												alert("최대 3명까지만 일정 공유가 가능합니다");
	     		        			       	     											}
	     		        			       	     										  })
	          												    			  
	             												    		).css({
	            												    	          top: buttonOffset.top + buttonHeight - 2,
	            												    	          left: buttonOffset.left,
	            												    	        })
     												    			   }
       	     												   	  	 })
     												    		  } else {
     												    			 $.each(res, function(idx, val) {
     												    				$(".social-dropdown-content").append(
          												    					$("<button>").append(
     		        			       	     											$("<img>")
     		        			       	     												.attr("src", val.socialProfile)
     		        			       	     												.addClass("w-26 h-26 round-full mr-8")
     		        			       	     										  ).append(
     		        			       	     											$("<span>").text(val.socialName)
     		        			       	     										  ).addClass("social-tab-btn trans-color border-none outline-none flex items-center w-100p px-8 py-9 round-6"
     		        			       	     										  ).attr("data-id", val.socialRelativeId
     		        			       	     										  ).click(function () {
     		        			       	     											$(".social-dropdown").hide();
     		        			       	     											$(".job-participant").append(
     		        			       	     												$("<div>")
     		        			       	     													.attr("data-id", val.socialRelativeId)
     		        			       	     													.addClass("participant-tab px-8 py-9 mr-8 light-dark inline-block round-6")
     		        			       	     													.append($("<img>")
     		        			       	     															.attr("src", val.socialProfile)
     		        			       	     															.addClass("w-26 h-26 round-full mr-8 vertical-center"))
     		        			       	     													.append($("<span>")
     		        			       	     															.text(val.socialName)
     		        			       	     															.addClass("text-16 title-font-color vertical-center mr-4"))
     		        			       	     													.append($("<button>")
     		        			       	     															.addClass("trans-color border-none outline-none vertical-center w-24 h-24 p-0")
     		        			       	     															.append($("<img>")
     		        			       	     																		.attr("src", "/img/close.svg"))
     		        			       	     															.click(function () {
    	     		        			       	     														$(this).closest(".participant-tab").remove();
    	     		        			       	     													}))
     		        			       	     											).addClass("mt-8")
     		        			       	     										  })
          												    			  
             												    		).css({
            												    	          top: buttonOffset.top + buttonHeight - 2,
            												    	          left: buttonOffset.left,
            												    	        })
         	     												   	 })
     												    		  }
     												    		  
     												    		  if (!res.length || currParticipants.length == res.length) {
     												    			 $(".social-dropdown-content").append(
     												    					 $("<span>").addClass("text-14 subtext-font-color").text("추가할 소셜 목록이 없습니다."))
     												    		  }
       	     												   	  
	       	     												  $(window).click(function (e) {
		       	     											    if ($(e.target).is(".social-dropdown")) {
		       	     											      $(".social-dropdown").hide();
		       	     											    }
		       	     											  });
     												    		},
     														})
     													}))
     										.append($("<button>")
     													.addClass("flex items-center border-1 line-base round-6 trans-color outline-none py-4 pl-6 pr-8 mr-8")
 														.append($("<img>")
 																.attr("src", "/img/s-date.svg")
 																.addClass("mr-4"))
 														.append($("<span>")
 																.text("날짜")
 																.addClass("text-14 subtext-font-color"))
 														.click(function () {
 															var buttonOffset = $(this).offset();
												    	    var buttonHeight = $(this).outerHeight();
												    	    $(".datetime-dropdown").show();
												    	    $(".datetime-dropdown-content")
												    	    	.css({
											    	          		top: buttonOffset.top + buttonHeight - 2,
											    	          		left: buttonOffset.left,
											    	        	})
											    	        	
											    	        $(window).click(function (e) {
		       	     											if ($(e.target).is(".datetime-dropdown")) {
		       	     											  $(".datetime-dropdown").hide();
		       	     											}
		       	     										});
												    	    
												    	    $(".datetime-tab-btn").click(function (e) {
												    	    	$(".datetime-dropdown").hide();
												    	    	$(".job-datetime").empty();
												    	    	$(".job-datetime").addClass("mt-16");
												    	    	if ($(e.target).data("id") == 1) {
												    	    		$(".job-datetime").append(
												    	    				$("<span>").text("날짜 입력").addClass("text-12 text2-font-color")
												    	    				).append(
												    	    					$("<div>")
												    	    						.append($("<input>").attr("type", "time").addClass("start-time-input mr-8"))
												    	    						.append($("<span>").text("~").addClass("mr-8"))
												    	    						.append($("<input>").attr("type", "time").addClass("end-time-input"))
												    	    						.addClass("mt-8"))
												    	    	} else if ($(e.target).data("id") == 2) {
												    	    		$(".job-datetime").append(
												    	    				$("<span>").text("날짜 입력").addClass("text-12 text2-font-color")
												    	    				).append(
												    	    					$("<div>")
												    	    						.append($("<input>").attr("type", "date").addClass("start-time-input mr-8"))
												    	    						.append($("<span>").text("~").addClass("mr-8"))
												    	    						.append($("<input>").attr("type", "date").addClass("end-time-input"))
												    	    						.addClass("mt-8"))
												    	    	} else {
												    	    		$(".job-datetime").append(
												    	    				$("<span>").text("날짜 입력").addClass("text-12 text2-font-color")
												    	    				).append(
												    	    					$("<div>")
												    	    						.append($("<input>").attr("type", "datetime-local").addClass("start-time-input mr-8"))
												    	    						.append($("<span>").text("~").addClass("mr-8"))
												    	    						.append($("<input>").attr("type", "datetime-local").addClass("end-time-input"))
												    	    						.addClass("mt-8"))
												    	    	}
												    	    })
 														}))
     										.append($("<button>")
     													.addClass("flex items-center border-1 line-base round-6 trans-color outline-none py-4 pl-6 pr-8")
														.append($("<img>")
																.attr("src", "/img/location.svg")
																.addClass("mr-4"))
														.append($("<span>")
																.text("장소")
																.addClass("text-14 subtext-font-color"))
														.click(function () {
															$(".job-place").empty();
															$(".job-place").addClass("mt-16");
															$(".job-place").append(
																	$("<span>").text("장소 입력").addClass("text-12 text2-font-color")
										    	    				).append(
										    	    					$("<input>").addClass("place-input mt-8 line-base border-1 outline-none round-6 px-8 py-4")
										    	    				).append($("<div>").addClass("map none round-6 mt-8"))
										    	    		var container = $(".job-input .map")[0];
															
															var options = {
													          center: new kakao.maps.LatLng(37.566395, 126.987778),
													          level: 3,
													        };
															
															var map = new kakao.maps.Map(container, options);
															
															$(".place-input").on("blur", function() {
																var address = $(this).val();
																
																var geocoder = new kakao.maps.services.Geocoder();
																
																geocoder.addressSearch(address, function (res, status) {
																	if (status === kakao.maps.services.Status.OK) {
																		var location = new kakao.maps.LatLng(res[0].y, res[0].x);
															            var marker = new kakao.maps.Marker({
															              map: map,
															              position: location,
															            });
															            
															            map.setCenter(location);
															            $(".map").show();
																	}
																})
															})
														})))
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
     													.addClass("flex items-center border-1 brand-b round-6 trans-color outline-none py-6 pl-6 pr-8")
														.append($("<img>")
																.attr("src", "/img/plus.svg")
																.addClass("mr-4"))
														.append($("<span>")
																.text("추가")
																.addClass("text-16 subtext-font-color"))
														.click(function(e) {
															e.stopPropagation();
															if ($(".job-title-input").val() == "") {
																alert("제목을 추가해주세요");
																return;
															} else if ($(".start-time-input").val() == "" || 
																	$(".start-time-input").val() == undefined) {
																alert("시작 시간을 추가해주세요");
																return;
															}
															var participantsId = []; 
															$.each($(".job-participant").children(), function (idx, val) {
																participantsId.push($(val).data("id"))
															})
															var datetimeType = $(".start-time-input").attr("type");
															var starttimeVal = $(".start-time-input").val();
															var endtimeVal = $(".end-time-input").val();
															var startTimestamp = null;
															var endTimestamp = null;
															function timeToTimestamp(timeVal) {
																var currDate = new Date();
																
																return currDate.getFullYear() + "-" +
																		String(currDate.getMonth() + 1).padStart(2, '0') + "-" +
																		String(currDate.getDate()).padStart(2, '0') + " " +
																		timeVal.split(":")[0] + ":" +
																		timeVal.split(":")[1] + ":00.000";
															}
															function dateToTimestamp(timeVal, isStart) {
																return timeVal + (isStart ? " 00:00:00.000" : " 23:59:59.000");
															}
															function datetimeToTimestamp(timeVal) {
																var [date, time] = timeVal.split("T");
																return date + " " + time + ":00.000";
															}
															if (datetimeType == "date" || endtimeVal != "") {
																if (datetimeType == "time") {
																	startTimestamp = timeToTimestamp(starttimeVal);
																	endTimestamp = timeToTimestamp(endtimeVal);
																} else if (datetimeType == "datetime-local") {
																	startTimestamp = datetimeToTimestamp(starttimeVal);
																	endTimestamp = datetimeToTimestamp(endtimeVal);
																} else if (endtimeVal == "") {
																	startTimestamp = dateToTimestamp(starttimeVal, true);
																	endTimestamp = dateToTimestamp(starttimeVal, false);
																	console.log(startTimestamp)
																	console.log(endTimestamp)
																} else {
																	startTimestamp = dateToTimestamp(starttimeVal, true);
																	endTimestamp = dateToTimestamp(endtimeVal, false);
																}
																$.ajax({
																	url: "/rest/job/add",
																	beforeSend: function (xhr) {
		     												    	  xhr.setRequestHeader(header, token);
		     												    	},
		     												    	method: "POST",
		     												    	data: {
		     												    		jobPageId: pageId,
		     												    		jobTitle: $(".job-title-input").val(),
		     												    		jobParticipant1Id: participantsId[0],
		     												    		jobParticipant2Id: participantsId[1],
		     												    		jobParticipant3Id: participantsId[2],
		     												    		jobStartTime: startTimestamp,
		     												    		jobEndTime: endTimestamp,
		     												    		jobPlace: $(".place-input").val(),
		     												    		jobDescription: $(".job-content-input").val(),
		     												    	},
		     												    	success: function (res) {
		     												    		$(".job-input").remove();
		     												    		$(".job-add-area").show();
		     												    		$(".job-content").append(
		     												    			$("<div>")
		     												    				.attr("data-id", res.jobId)
		     										     						.addClass("job-tab flex flex-col p-16 mb-16 line-base border-1 round-6")
		     										     						.append($("<span>")
		     										     									.text(res.jobTitle)
		     										     									.addClass("text-20 title-font-color"))
		     										     						.append($("<div>")
		     										     									.addClass("flex flex-col mt-16")
		     										     									.append(
		     										     											$("<span>")
				     										     									.text("날짜")
				     										     									.addClass("text-12 subtitle-font-color"))
		     										     									.append(
		     										     											$("<div>")
		     										     												.addClass("mt-8")
		     										     												.append($("<span>")
		    				     										     									.text(new Date(res.jobStartTime).toLocaleString())
		    				     										     									.addClass("text-12 text-font-color mr-8"))
		    				     										     							.append($("<span>")
		    				     										     									.text("~")
		    				     										     									.addClass("text-12 text-font-color mr-8"))
		    				     										     							.append($("<span>")
		    				     										     									.text(new Date(res.jobEndTime).toLocaleString())
		    				     										     									.addClass("text-12 text-font-color"))))
		     										     						.append($("<div>")
	     										     									.addClass("flex flex-col mt-8")
	     										     									.append(
	     										     											$("<span>")
			     										     									.text("장소")
			     										     									.addClass("text-12 subtitle-font-color"))
	     										     									.append(
	     										     											$("<span>")
			     										     									.text(res.jobPlace)
			     										     									.addClass("job-place-address text-12 text-font-color mt-8"))
	     										     									.append(
	     										     											$("<div>")
			     										     									.addClass("map mt-8 round-6")))
		     										     						.append($("<p>")
		     										     									.text(res.jobDescription)
		     										     									.addClass("text-14 text-font-color mt-8"))
		     												    		)
		     												    		var container = $('[data-id="' + res.jobId + '"] .map')[0];
		     												    		console.log(container);
		    															
																		var options = {
																          center: new kakao.maps.LatLng(37.566395, 126.987778),
																          level: 3,
																        };
																		
																		var map = new kakao.maps.Map(container, options);
																		
																		var address = $('[data-id="' + res.jobId + '"] .job-place-address').text();
																		
																		var geocoder = new kakao.maps.services.Geocoder();
																		
																		geocoder.addressSearch(address, function (res, status) {
																			if (status === kakao.maps.services.Status.OK) {
																				var location = new kakao.maps.LatLng(res[0].y, res[0].x);
																	            var marker = new kakao.maps.Marker({
																	              map: map,
																	              position: location,
																	            });
																	            
																	            map.setCenter(location);
																			}
																		})
		     												    	},
																})
															} else {
																if (datetimeType == "time") {
																	startTimestamp = timeToTimestamp(starttimeVal);
																} else {
																	startTimestamp = datetimeToTimestamp(starttimeVal);
																}
																$.ajax({
																	url: "/rest/job/add",
																	beforeSend: function (xhr) {
		     												    	  xhr.setRequestHeader(header, token);
		     												    	},
		     												    	method: "POST",
		     												    	data: {
		     												    		jobPageId: pageId,
		     												    		jobTitle: $(".job-title-input").val(),
		     												    		jobParticipant1Id: participantsId[0],
		     												    		jobParticipant2Id: participantsId[1],
		     												    		jobParticipant3Id: participantsId[2],
		     												    		jobStartTime: startTimestamp,
		     												    		jobPlace: $(".place-input").val(),
		     												    		jobDescription: $(".job-content-input").val(),
		     												    	},
		     												    	success: function (res) {
		     												    		$(".job-input").remove();
		     												    		$(".job-add-area").show();
		     												    		$(".job-content").append(
		     												    			$("<div>")
		     												    				.attr("data-id", res.jobId)
		     										     						.addClass("job-tab flex flex-col p-16 mb-16 line-base border-1 round-6")
		     										     						.append($("<span>")
		     										     									.text(res.jobTitle)
		     										     									.addClass("text-20 title-font-color"))
		     										     						.append($("<div>")
		     										     									.addClass("flex flex-col mt-16")
		     										     									.append(
		     										     											$("<span>")
				     										     									.text("날짜")
				     										     									.addClass("text-12 subtitle-font-color"))
		     										     									.append(
		     										     											$("<span>")
				     										     									.text(new Date(res.jobStartTime).toLocaleString())
				     										     									.addClass("text-12 text-font-color mt-8")))
		     										     						.append($("<div>")
	     										     									.addClass("flex flex-col mt-8")
	     										     									.append(
	     										     											$("<span>")
			     										     									.text("장소")
			     										     									.addClass("text-12 subtitle-font-color"))
	     										     									.append(
	     										     											$("<span>")
			     										     									.text(res.jobPlace)
			     										     									.addClass("job-place-address text-12 text-font-color mt-8"))
	     										     									.append(
	     										     											$("<div>")
			     										     									.addClass("map mt-8 round-6")))
		     										     						.append($("<p>")
		     										     									.text(res.jobDescription)
		     										     									.addClass("text-14 text-font-color mt-8"))
		     												    		)
		     												    		var container = $('[data-id="' + res.jobId + '"] .map')[0];
		    															
																		var options = {
																          center: new kakao.maps.LatLng(37.566395, 126.987778),
																          level: 3,
																        };
																		
																		var map = new kakao.maps.Map(container, options);
																		
																		var address = $('[data-id="' + res.jobId + '"] .job-place-address').text();
																		
																		var geocoder = new kakao.maps.services.Geocoder();
																		
																		geocoder.addressSearch(address, function (res, status) {
																			if (status === kakao.maps.services.Status.OK) {
																				var location = new kakao.maps.LatLng(res[0].y, res[0].x);
																	            var marker = new kakao.maps.Marker({
																	              map: map,
																	              position: location,
																	            });
																	            
																	            map.setCenter(location);
																			}
																		})
		     												    	},
																})
															}
															
														})))))
		    })
      });
    </script>
  </head>
  <body>
    <div class="flex items-start">
      <jsp:include page="/WEB-INF/views/template/aside.jsp" />
      <div class="content anim overflow-auto flex flex-1 justify-center w-100p h-100v">
        <div class="page-content w-620 py-64">
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
    <div
	   class="social-dropdown none justify-center items-center fixed left-0 top-0 w-100p h-100p"
	 >
	   <div class="social-dropdown-content absolute light inline-block border-1 line-base round-6 p-6">
	     
	   </div>
	 </div>
	 <div
	   class="datetime-dropdown none justify-center items-center fixed left-0 top-0 w-100p h-100p"
	 >
	   <div class="datetime-dropdown-content absolute light flex flex-col border-1 line-base round-6 p-6">
	     <button data-id="1" class="datetime-tab-btn trans-color border-none outline-none text-16 title-font-color round-6 px-4 py-6">시간</button>
	     <button data-id="2" class="datetime-tab-btn trans-color border-none outline-none text-16 title-font-color round-6 px-4 py-6">기간</button>
	     <button data-id="3" class="datetime-tab-btn trans-color border-none outline-none text-16 title-font-color round-6 px-4 py-6">시간 + 기간</button>
	   </div>
	 </div>
  </body>
</html>


