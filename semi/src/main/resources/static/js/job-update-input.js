export function jobUpdateInput(jobTab, res, pageId) {
  var header = $("meta[name='_csrf_header']").attr("content");
  var token = $("meta[name='_csrf']").attr("content");
  function calcDate(originalDateString) {
    var date = new Date(originalDateString);

    var year = date.getFullYear();
    var month = ("0" + (date.getMonth() + 1)).slice(-2);
    var day = ("0" + date.getDate()).slice(-2);
    var hour = ("0" + date.getHours()).slice(-2);
    var minute = ("0" + date.getMinutes()).slice(-2);

    return year + "-" + month + "-" + day + "T" + hour + ":" + minute;
  }
  jobTab.after(
    $("<div>")
      .attr("data-id", res.jobId)
      .addClass("job-input flex flex-col p-16 mb-32 line-base border-1 round-6 mb-16")
      .append(
        $("<input>")
          .attr("placeholder", "제목")
          .attr("value", res.jobTitle)
          .addClass(
            "job-title-input border-none outline-none text-16 title-font-color"
          )
      )
      .append($("<div>").addClass("job-participant"))
      .append(
        $("<div>")
          .addClass("job-datetime")
          .append(
            $("<span>").text("날짜 입력").addClass("text-12 text2-font-color")
          )
          .append(
            $("<div>")
              .append(
                $("<input>")
                  .attr("value", calcDate(res.jobStartTime))
                  .attr("type", "datetime-local")
                  .addClass("start-time-input mr-8")
              )
              .append($("<span>").text("~").addClass("mr-8"))
              .append(
                $("<input>")
                  .attr("value", calcDate(res.jobEndTime))
                  .attr("type", "datetime-local")
                  .addClass("end-time-input")
              )
              .addClass("mt-8")
          )
      )
      .append($("<div>").addClass("job-place flex flex-col"))
      .append(
        $("<textarea>")
          .attr("placeholder", "내용을 작성하세요...")
          .attr("rows", 2)
          .text(res.jobDescription)
          .addClass(
            "job-content-input border-none outline-none text-14 subtitle-font-color mt-8"
          )
      )
      .append(
        $("<div>")
          .addClass("flex justify-between")
          .append(
            $("<div>")
              .addClass("flex")
              .append(
                $("<button>")
                  .addClass(
                    "flex items-center border-1 line-base round-6 trans-color outline-none py-4 pl-6 pr-8 mr-8"
                  )
                  .append(
                    $("<img>").attr("src", "/img/user.svg").addClass("mr-4")
                  )
                  .append(
                    $("<span>")
                      .text("소셜")
                      .addClass("text-14 subtext-font-color")
                  )
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
                        $.each(
                          $(".job-participant").children(),
                          function (idx, val) {
                            currParticipants.push($(val).data("id"));
                          }
                        );

                        if (currParticipants.length) {
                          $.each(res, function (idx, val) {
                            var isExist = false;
                            $.each(currParticipants, function (idx, val2) {
                              if (val.socialRelativeId == val2) {
                                isExist = true;
                              }
                            });
                            if (!isExist) {
                              $(".social-dropdown-content")
                                .append(
                                  $("<button>")
                                    .append(
                                      $("<img>")
                                        .attr("src", val.socialProfile)
                                        .addClass("w-26 h-26 round-full mr-8")
                                    )
                                    .append($("<span>").text(val.socialName))
                                    .addClass(
                                      "social-tab-btn trans-color border-none outline-none flex items-center w-100p px-8 py-9 round-6"
                                    )
                                    .attr("data-id", val.socialRelativeId)
                                    .click(function () {
                                      if (currParticipants.length < 3) {
                                        $(".social-dropdown").hide();
                                        $(".job-participant")
                                          .append(
                                            $("<div>")
                                              .attr(
                                                "data-id",
                                                val.socialRelativeId
                                              )
                                              .addClass(
                                                "participant-tab px-8 py-9 mr-8 light-dark inline-block round-6"
                                              )
                                              .append(
                                                $("<img>")
                                                  .attr(
                                                    "src",
                                                    val.socialProfile
                                                  )
                                                  .addClass(
                                                    "w-26 h-26 round-full mr-8 vertical-center"
                                                  )
                                              )
                                              .append(
                                                $("<span>")
                                                  .text(val.socialName)
                                                  .addClass(
                                                    "text-16 title-font-color vertical-center mr-4"
                                                  )
                                              )
                                              .append(
                                                $("<button>")
                                                  .addClass(
                                                    "trans-color border-none outline-none vertical-center w-24 h-24 p-0"
                                                  )
                                                  .append(
                                                    $("<img>").attr(
                                                      "src",
                                                      "/img/close.svg"
                                                    )
                                                  )
                                                  .click(function () {
                                                    $(this)
                                                      .closest(
                                                        ".participant-tab"
                                                      )
                                                      .remove();
                                                  })
                                              )
                                          )
                                          .addClass("mt-8");
                                      } else {
                                        alert(
                                          "최대 3명까지만 일정 공유가 가능합니다"
                                        );
                                      }
                                    })
                                )
                                .css({
                                  top: buttonOffset.top + buttonHeight - 2,
                                  left: buttonOffset.left,
                                });
                            }
                          });
                        } else {
                          $.each(res, function (idx, val) {
                            $(".social-dropdown-content")
                              .append(
                                $("<button>")
                                  .append(
                                    $("<img>")
                                      .attr("src", val.socialProfile)
                                      .addClass("w-26 h-26 round-full mr-8")
                                  )
                                  .append($("<span>").text(val.socialName))
                                  .addClass(
                                    "social-tab-btn trans-color border-none outline-none flex items-center w-100p px-8 py-9 round-6"
                                  )
                                  .attr("data-id", val.socialRelativeId)
                                  .click(function () {
                                    $(".social-dropdown").hide();
                                    $(".job-participant")
                                      .append(
                                        $("<div>")
                                          .attr("data-id", val.socialRelativeId)
                                          .addClass(
                                            "participant-tab px-8 py-9 mr-8 light-dark inline-block round-6"
                                          )
                                          .append(
                                            $("<img>")
                                              .attr("src", val.socialProfile)
                                              .addClass(
                                                "w-26 h-26 round-full mr-8 vertical-center"
                                              )
                                          )
                                          .append(
                                            $("<span>")
                                              .text(val.socialName)
                                              .addClass(
                                                "text-16 title-font-color vertical-center mr-4"
                                              )
                                          )
                                          .append(
                                            $("<button>")
                                              .addClass(
                                                "trans-color border-none outline-none vertical-center w-24 h-24 p-0"
                                              )
                                              .append(
                                                $("<img>").attr(
                                                  "src",
                                                  "/img/close.svg"
                                                )
                                              )
                                              .click(function () {
                                                $(this)
                                                  .closest(".participant-tab")
                                                  .remove();
                                              })
                                          )
                                      )
                                      .addClass("mt-8");
                                  })
                              )
                              .css({
                                top: buttonOffset.top + buttonHeight - 2,
                                left: buttonOffset.left,
                              });
                          });
                        }

                        if (
                          !res.length ||
                          currParticipants.length == res.length
                        ) {
                          $(".social-dropdown-content").append(
                            $("<span>")
                              .addClass("text-14 subtext-font-color")
                              .text("추가할 소셜 목록이 없습니다.")
                          );
                        }

                        $(window).click(function (e) {
                          if ($(e.target).is(".social-dropdown")) {
                            $(".social-dropdown").hide();
                          }
                        });
                      },
                    });
                  })
              )
              .append(
                $("<button>")
                  .addClass(
                    "flex items-center border-1 line-base round-6 trans-color outline-none py-4 pl-6 pr-8 mr-8"
                  )
                  .append(
                    $("<img>").attr("src", "/img/s-date.svg").addClass("mr-4")
                  )
                  .append(
                    $("<span>")
                      .text("날짜")
                      .addClass("text-14 subtext-font-color")
                  )
                  .click(function () {
                    var buttonOffset = $(this).offset();
                    var buttonHeight = $(this).outerHeight();
                    $(".datetime-dropdown").show();
                    $(".datetime-dropdown-content").css({
                      top: buttonOffset.top + buttonHeight - 2,
                      left: buttonOffset.left,
                    });

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
                        $(".job-datetime")
                          .append(
                            $("<span>")
                              .text("날짜 입력")
                              .addClass("text-12 text2-font-color")
                          )
                          .append(
                            $("<div>")
                              .append(
                                $("<input>")
                                  .attr("type", "time")
                                  .addClass("start-time-input mr-8")
                              )
                              .append($("<span>").text("~").addClass("mr-8"))
                              .append(
                                $("<input>")
                                  .attr("type", "time")
                                  .addClass("end-time-input")
                              )
                              .addClass("mt-8")
                          );
                      } else if ($(e.target).data("id") == 2) {
                        $(".job-datetime")
                          .append(
                            $("<span>")
                              .text("날짜 입력")
                              .addClass("text-12 text2-font-color")
                          )
                          .append(
                            $("<div>")
                              .append(
                                $("<input>")
                                  .attr("type", "date")
                                  .addClass("start-time-input mr-8")
                              )
                              .append($("<span>").text("~").addClass("mr-8"))
                              .append(
                                $("<input>")
                                  .attr("type", "date")
                                  .addClass("end-time-input")
                              )
                              .addClass("mt-8")
                          );
                      } else {
                        $(".job-datetime")
                          .append(
                            $("<span>")
                              .text("날짜 입력")
                              .addClass("text-12 text2-font-color")
                          )
                          .append(
                            $("<div>")
                              .append(
                                $("<input>")
                                  .attr("type", "datetime-local")
                                  .addClass("start-time-input mr-8")
                              )
                              .append($("<span>").text("~").addClass("mr-8"))
                              .append(
                                $("<input>")
                                  .attr("type", "datetime-local")
                                  .addClass("end-time-input")
                              )
                              .addClass("mt-8")
                          );
                      }
                    });
                  })
              )
              .append(
                $("<button>")
                  .addClass(
                    "flex items-center border-1 line-base round-6 trans-color outline-none py-4 pl-6 pr-8"
                  )
                  .append(
                    $("<img>").attr("src", "/img/location.svg").addClass("mr-4")
                  )
                  .append(
                    $("<span>")
                      .text("장소")
                      .addClass("text-14 subtext-font-color")
                  )
                  .click(function () {
                    $(".job-place").empty();
                    $(".job-place").addClass("mt-16");
                    $(".job-place")
                      .append(
                        $("<span>")
                          .text("장소 입력")
                          .addClass("text-12 text2-font-color")
                      )
                      .append(
                        $("<input>").addClass(
                          "place-input mt-8 line-base border-1 outline-none round-6 px-8 py-4"
                        )
                      )
                      .append($("<div>").addClass("map none round-6 mt-8"));
                    kakao.maps.load(() => {
                      var container = $(".job-input .map")[0];

                      var options = {
                        center: new kakao.maps.LatLng(37.566395, 126.987778),
                        level: 3,
                      };

                      var map = new kakao.maps.Map(container, options);

                      $(".place-input").on("blur", function () {
                        var address = $(this).val();

                        var geocoder = new kakao.maps.services.Geocoder();

                        geocoder.addressSearch(address, function (res, status) {
                          if (status === kakao.maps.services.Status.OK) {
                            var location = new kakao.maps.LatLng(
                              res[0].y,
                              res[0].x
                            );
                            var marker = new kakao.maps.Marker({
                              map: map,
                              position: location,
                            });

                            map.setCenter(location);
                            $(".map").show();
                          }
                        });
                      });
                    });
                  })
              )
          )
          .append(
            $("<div>")
              .addClass("flex")
              .append(
                $("<button>")
				  .text("취소")
                  .addClass(
                    "cancel-btn flex items-center border-1 negative-b round-6 trans-color outline-none px-8 py-6 mr-8 text-16 subtext-font-color"
                  )
              )
              .click(function () {
                jobTab.show();
                $('[data-id="' + res.jobId + '"].job-input').hide();
              })
              .append(
                $("<button>")
				  .text("저장")
                  .addClass(
                    "save-btn flex items-center border-1 brand-b round-6 trans-color outline-none px-8 py-6 text-16 subtext-font-color"
                  )
                  .click(function (e) {
                    e.stopPropagation();
                    if ($(".job-title-input").val() == "") {
                      alert("제목을 추가해주세요");
                      return;
                    } else if (
                      $(".start-time-input").val() == "" ||
                      $(".start-time-input").val() == undefined
                    ) {
                      alert("시작 시간을 추가해주세요");
                      return;
                    }
                    var participantsId = [];
                    $.each(
                      $(".job-participant").children(),
                      function (idx, val) {
                        participantsId.push($(val).data("id"));
                      }
                    );
                    var datetimeType = $(".start-time-input").attr("type");
                    var starttimeVal = $(".start-time-input").val();
                    var endtimeVal = $(".end-time-input").val();
                    var startTimestamp = null;
                    var endTimestamp = null;
                    function timeToTimestamp(timeVal) {
                      var currDate = new Date();

                      return (
                        currDate.getFullYear() +
                        "-" +
                        String(currDate.getMonth() + 1).padStart(2, "0") +
                        "-" +
                        String(currDate.getDate()).padStart(2, "0") +
                        " " +
                        timeVal.split(":")[0] +
                        ":" +
                        timeVal.split(":")[1] +
                        ":00.000"
                      );
                    }
                    function dateToTimestamp(timeVal, isStart) {
                      return (
                        timeVal + (isStart ? " 00:00:00.000" : " 23:59:59.000")
                      );
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
                      } else {
                        startTimestamp = dateToTimestamp(starttimeVal, true);
                        endTimestamp = dateToTimestamp(endtimeVal, false);
                      }
                      $.ajax({
                        url: "/rest/job/update",
                        beforeSend: function (xhr) {
                          xhr.setRequestHeader(header, token);
                        },
                        method: "POST",
                        data: {
                          jobId: $(".job-input").data("id"),
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
                          jobTab.after(
                            $("<div>")
                              .attr("data-id", res.jobId)
                              .addClass(
                                "job-tab flex flex-col p-16 mb-16 line-base border-1 round-6"
                              )
                              .append(
                                $("<span>")
                                  .text(res.jobTitle)
                                  .addClass("text-20 title-font-color")
                              )
                              .append(
                                $("<div>")
                                  .addClass("flex flex-col mt-16")
                                  .append(
                                    $("<span>")
                                      .text("날짜")
                                      .addClass("text-12 subtitle-font-color")
                                  )
                                  .append(
                                    $("<div>")
                                      .addClass("mt-8")
                                      .append(
                                        $("<span>")
                                          .text(
                                            new Date(
                                              res.jobStartTime
                                            ).toLocaleString()
                                          )
                                          .addClass(
                                            "text-12 text-font-color mr-8"
                                          )
                                      )
                                      .append(
                                        $("<span>")
                                          .text("~")
                                          .addClass(
                                            "text-12 text-font-color mr-8"
                                          )
                                      )
                                      .append(
                                        $("<span>")
                                          .text(
                                            new Date(
                                              res.jobEndTime
                                            ).toLocaleString()
                                          )
                                          .addClass("text-12 text-font-color")
                                      )
                                  )
                              )
                              .append(
                                $("<div>")
                                  .addClass("job-place-tab flex flex-col mt-8")
                                  .append(
                                    $("<span>")
                                      .text("장소")
                                      .addClass("text-12 subtitle-font-color")
                                  )
                                  .append(
                                    $("<span>")
                                      .text(res.jobPlace)
                                      .addClass(
                                        "job-place-address text-12 text-font-color mt-8"
                                      )
                                  )
                                  .append(
                                    $("<div>").addClass("map mt-8 round-6")
                                  )
                              )
                              .append(
                                $("<p>")
                                  .text(res.jobDescription)
                                  .addClass("text-14 text-font-color mt-8")
                              )
                          );

                          jobTab.remove();

                          if (res.jobPlace != null) {
                            kakao.maps.load(() => {
                              var container = $(
                                '[data-id="' + res.jobId + '"] .map'
                              )[0];

                              var options = {
                                center: new kakao.maps.LatLng(
                                  37.566395,
                                  126.987778
                                ),
                                level: 3,
                              };

                              var map = new kakao.maps.Map(container, options);

                              var address = $(
                                '[data-id="' +
                                  res.jobId +
                                  '"] .job-place-address'
                              ).text();

                              var geocoder = new kakao.maps.services.Geocoder();

                              geocoder.addressSearch(
                                address,
                                function (res, status) {
                                  if (
                                    status === kakao.maps.services.Status.OK
                                  ) {
                                    var location = new kakao.maps.LatLng(
                                      res[0].y,
                                      res[0].x
                                    );
                                    var marker = new kakao.maps.Marker({
                                      map: map,
                                      position: location,
                                    });

                                    map.setCenter(location);
                                  }
                                }
                              );
                            });
                          } else {
                            $(
                              '[data-id="' + res.jobId + '"] .job-place-tab'
                            ).remove();
                          }
                        },
                      });
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
                              .addClass(
                                "job-tab flex flex-col p-16 mb-16 line-base border-1 round-6"
                              )
                              .append(
                                $("<span>")
                                  .text(res.jobTitle)
                                  .addClass("text-20 title-font-color")
                              )
                              .append(
                                $("<div>")
                                  .addClass("flex flex-col mt-16")
                                  .append(
                                    $("<span>")
                                      .text("날짜")
                                      .addClass("text-12 subtitle-font-color")
                                  )
                                  .append(
                                    $("<span>")
                                      .text(
                                        new Date(
                                          res.jobStartTime
                                        ).toLocaleString()
                                      )
                                      .addClass("text-12 text-font-color mt-8")
                                  )
                              )
                              .append(
                                $("<div>")
                                  .addClass("job-place-tab flex flex-col mt-8")
                                  .append(
                                    $("<span>")
                                      .text("장소")
                                      .addClass("text-12 subtitle-font-color")
                                  )
                                  .append(
                                    $("<span>")
                                      .text(res.jobPlace)
                                      .addClass(
                                        "job-place-address text-12 text-font-color mt-8"
                                      )
                                  )
                                  .append(
                                    $("<div>").addClass("map mt-8 round-6")
                                  )
                              )
                              .append(
                                $("<p>")
                                  .text(res.jobDescription)
                                  .addClass("text-14 text-font-color mt-8")
                              )
                          );

                          if (res.jobPlace != null) {
                            kakao.maps.load(() => {
                              var container = $(
                                '[data-id="' + res.jobId + '"] .map'
                              )[0];

                              var options = {
                                center: new kakao.maps.LatLng(
                                  37.566395,
                                  126.987778
                                ),
                                level: 3,
                              };

                              var map = new kakao.maps.Map(container, options);

                              var address = $(
                                '[data-id="' +
                                  res.jobId +
                                  '"] .job-place-address'
                              ).text();

                              var geocoder = new kakao.maps.services.Geocoder();

                              geocoder.addressSearch(
                                address,
                                function (res, status) {
                                  if (
                                    status === kakao.maps.services.Status.OK
                                  ) {
                                    var location = new kakao.maps.LatLng(
                                      res[0].y,
                                      res[0].x
                                    );
                                    var marker = new kakao.maps.Marker({
                                      map: map,
                                      position: location,
                                    });

                                    map.setCenter(location);
                                  }
                                }
                              );
                            });
                          } else {
                            $(
                              '[data-id="' + res.jobId + '"] .job-place-tab'
                            ).remove();
                          }
                        },
                      });
                    }
                  })
              )
          )
      )
  );
}
