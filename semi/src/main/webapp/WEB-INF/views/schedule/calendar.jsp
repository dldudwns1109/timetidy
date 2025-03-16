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
    <jsp:include page="/WEB-INF/views/template/aside-script.jsp" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment-timezone/0.5.34/moment-timezone-with-data.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/3.2.0/fullcalendar.min.js"></script>
    <script
      type="text/javascript"
      src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${appkey}&autoload=false&libraries=services"
    ></script>
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
                var events = res.map(function (event) {
                  return {
                    title: event.jobTitle,
                    start: moment(new Date(event.jobStartTime))
                      .tz("Asia/Seoul", true)
                      .format(),
                    end: moment(new Date(event.jobEndTime))
                      .tz("Asia/Seoul", true)
                      .format(),
                    location: event.jobPlace,
                    description: event.jobDescription,
                    extendedProps: {
                      host: event.jobHostId,
                      participant1: event.jobParticipant1Id,
                      participant2: event.jobParticipant2Id,
                      participant3: event.jobParticipant3Id,
                    },
                  };
                });
                callback(events);
              },
            });
          },
          dayClick: function (date, jsEvent, view) {},
          eventClick: function (event) {
            $(".event-modal").removeClass("none").addClass("flex");

            $(".event-title").text(event.title);
            $(".event-host").text(event.extendedProps.host);
            $(".event-start").text(new Date(event.start).toLocaleString());
            $(".event-end").text(
              event.end != null
                ? "~ " + new Date(event.end).toLocaleString()
                : null
            );
            $(".event-location").text(event.location);
            $(".event-description").text(event.description);

            var address = $(".event-location").text();

            if (event.location != "" && event.location != null) {
              $(".job-place-tab").show();
              kakao.maps.load(() => {
                var container = $(".map")[0];

                var options = {
                  center: new kakao.maps.LatLng(37.566395, 126.987778),
                  level: 3,
                };

                var map = new kakao.maps.Map(container, options);

                var geocoder = new kakao.maps.services.Geocoder();

                geocoder.addressSearch(event.location, function (res, status) {
                  if (status === kakao.maps.services.Status.OK) {
                    var location = new kakao.maps.LatLng(res[0].y, res[0].x);
                    var marker = new kakao.maps.Marker({
                      map: map,
                      position: location,
                    });

                    map.setCenter(location);
                  }
                });
              });
            } else {
              $(".job-place-tab").hide();
            }

            $(".organizer").empty();
            $.ajax({
              url: "/rest/member/find",
              beforeSend: function (xhr) {
                xhr.setRequestHeader(header, token);
              },
              method: "GET",
              data: { memberId: event.extendedProps.host },
              success: function (res) {
                $(".organizer").append(
                  $("<div>")
                    .addClass("flex items-center mr-8 mt-8")
                    .append(
                      $("<img>")
                        .attr("src", res.memberProfile)
                        .addClass("w-26 h-26 round-full inline-block mr-8")
                    )
                    .append(
                      $("<span>")
                        .text(res.memberName)
                        .addClass("text-16 title-font-color")
                    )
                );
              },
            });

            var participantsId = [
              event.extendedProps.participant1,
              event.extendedProps.participant2,
              event.extendedProps.participant3,
            ];

            $(".participants").empty();
            $.each(participantsId, function (idx, val) {
              if (val != null) {
                $.ajax({
                  url: "/rest/social/find",
                  beforeSend: function (xhr) {
                    xhr.setRequestHeader(header, token);
                  },
                  method: "GET",
                  data: { socialId: val },
                  success: function (res) {
                    $(".participants").append(
                      $("<div>")
                        .addClass("flex items-center mr-8 mt-8")
                        .append(
                          $("<img>")
                            .attr("src", res.socialProfile)
                            .addClass("w-26 h-26 round-full inline-block mr-8")
                        )
                        .append(
                          $("<span>")
                            .text(res.socialName)
                            .addClass("text-16 title-font-color")
                        )
                    );
                  },
                });
              }
            });
          },
        });

        $(window).click(function (e) {
          if ($(e.target).is(".event-modal")) {
            $(".event-modal").removeClass("flex").addClass("none");
          }
        });
      });
    </script>
  </head>
  <body>
    <div class="flex items-start">
      <jsp:include page="/WEB-INF/views/template/aside.jsp" />
      <div
        class="content anim flex flex-1 justify-center items-center w-100p h-100v"
      >
        <div class="calendar w-1000 py-64"></div>

        <div
          class="event-modal none z-999 justify-center items-center fixed left-0 top-0 w-100p h-100p opacity-20"
        >
          <div class="light w-620 p-32 round-6 inline-block">
            <div>
              <span class="event-title title-20 title-font-color"></span>
              <div class="mt-16">
                <span class="text-12 subtitle-font-color">주최자</span>
                <div class="organizer"></div>
              </div>
              <div class="mt-8">
                <span class="text-12 subtitle-font-color">참여자</span>
                <div class="participants"></div>
              </div>
              <div class="mt-8">
                <span class="text-12 subtitle-font-color">날짜</span>
                <div>
                  <span class="event-start text-12 text-font-color"></span>
                  <span class="event-end text-12 text-font-color"></span>
                </div>
              </div>
              <div class="job-place-tab mt-8">
                <span class="text-12 subtitle-font-color">장소</span>
                <div>
                  <span class="event-location text-12 text-font-color"></span>
                </div>
                <div class="map mt-8 round-6"></div>
              </div>
              <div class="mt-16">
                <span class="event-description text-14 text-font-color"></span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <jsp:include page="/WEB-INF/views/template/account-modal.jsp" />
    <jsp:include page="/WEB-INF/views/template/search-modal.jsp" />
  </body>
</html>

    