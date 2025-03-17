import { jobUpdateInput } from "./job-update-input.js";
export function jobList(res, pageId) {
  var header = $("meta[name='_csrf_header']").attr("content");
  var token = $("meta[name='_csrf']").attr("content");
  $.each(res, function (idx, val) {
    $(".job-content").append(
      $("<div>")
        .attr("data-id", val.jobId)
        .addClass("job-tab flex flex-col p-16 mb-32 line-base border-1 round-6")
        .append(
          $("<span>").text(val.jobTitle).addClass("text-20 title-font-color")
        )
        .append($("<div>").append($("<div>").addClass("job-participants-tab")))
        .append(
          $("<div>")
            .addClass("flex flex-col mt-16")
            .append(
              $("<span>").text("날짜").addClass("text-12 subtitle-font-color")
            )
            .append(
              $("<div>")
                .addClass("datetime-tab mt-8")
                .append(
                  $("<span>")
                    .text(new Date(val.jobStartTime).toLocaleString())
                    .addClass("text-12 text-font-color")
                )
            )
        )
        .append($("<div>").addClass("job-place-tab"))
        .append($("<div>").addClass("job-description-tab"))
        .hover(
          function () {
            $(this)
              .closest(".job-tab")
              .append(
                $("<div>")
                  .append(
                    $("<button>")
                      .text("수정")
                      .addClass(
                        "job-update-btn trans-color border-1 brand-b px-8 py-6 text-16 subtext-font-color round-6 mr-8"
                      )
                      .click(function () {
                        var jobTab = $(this).closest(".job-tab");
                        $.ajax({
                          url: "/rest/job/find",
                          beforeSend: function (xhr) {
                            xhr.setRequestHeader(header, token);
                          },
                          method: "GET",
                          data: { jobId: jobTab.data("id") },
                          success: function (res2) {
                            jobTab.hide();
                            jobUpdateInput(jobTab, res2, pageId);
                            if (res2.jobPlace != null) {
                              $('[data-id="' + res2.jobId + '"] .job-place')
                                .append(
                                  $("<span>")
                                    .text("장소")
                                    .addClass("text-12 subtitle-font-color")
                                )
                                .append(
                                  $("<input>")
                                    .val(res2.jobPlace)
                                    .addClass(
                                      "job-place-address border-1 line-base outline-none round-6 px-8 py-4 text-12 text-font-color mt-8"
                                    )
                                )
                                .append($("<div>").addClass("map mt-8 round-6"))
                                .addClass("mt-8");

                              var container = $(
                                '[data-id="' + res2.jobId + '"].job-input .map'
                              )[0];

                              var options = {
                                center: new kakao.maps.LatLng(
                                  37.566395,
                                  126.987778
                                ),
                                level: 3,
                              };

                              var map = new kakao.maps.Map(container, options);

                              var address = res2.jobPlace;

                              var geocoder = new kakao.maps.services.Geocoder();

                              geocoder.addressSearch(
                                address,
                                function (res3, status) {
                                  if (
                                    status === kakao.maps.services.Status.OK
                                  ) {
                                    var location = new kakao.maps.LatLng(
                                      res3[0].y,
                                      res3[0].x
                                    );
                                    var marker = new kakao.maps.Marker({
                                      map: map,
                                      position: location,
                                    });

                                    map.setCenter(location);
                                  } else {
                                    $('[data-id="' + res3.jobId + '"] .job-place').remove();
                                  }
                                }
                              );
                            }
                            var participants = [
                              res.jobParticipant1Id,
                              res.jobParticipant2Id,
                              res.jobParticipant3Id,
                            ];
                            $.each(participants, function (idx, val3) {
                              $.ajax({
                                url: "/rest/social/find",
                                beforeSend: function (xhr) {
                                  xhr.setRequestHeader(header, token);
                                },
                                method: "GET",
                                data: { socialId: val3 },
                                success: function (res) {
                                  $(".job-participant")
                                    .append(
                                      $("<div>")
                                        .attr("data-id", res.socialRelativeId)
                                        .addClass(
                                          "participant-tab px-8 py-9 mr-8 light-dark inline-block round-6"
                                        )
                                        .append(
                                          $("<img>")
                                            .attr("src", res.socialProfile)
                                            .addClass(
                                              "w-26 h-26 round-full mr-8 vertical-center"
                                            )
                                        )
                                        .append(
                                          $("<span>")
                                            .text(res.socialName)
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
                                },
                              });
                            });
                          },
                        });
                      })
                  )
                  .append(
                    $("<button>")
                      .text("삭제")
                      .addClass(
                        "job-delete-btn trans-color border-1 negative-b px-8 py-6 text-16 subtext-font-color round-6"
                      )
                      .click(function () {
                        var jobTab = $(this).closest(".job-tab");
                        $.ajax({
                          url: "/rest/job/delete",
                          beforeSend: function (xhr) {
                            xhr.setRequestHeader(header, token);
                          },
                          method: "POST",
                          data: { jobId: jobTab.data("id") },
                          success: function () {
                            jobTab.remove();
                          },
                        });
                      })
                  )
                  .addClass("update-delete-btn flex justify-end mt-16")
              );
          },
          function () {
            $(".update-delete-btn").remove();
          }
        )
    );

    if (
      val.jobParticipant1Id != null ||
      val.jobParticipant2Id != null ||
      val.jobParticipant3Id != null
    ) {
      var participantsTab = $("<div>")
        .addClass("flex flex-col mt-16")
        .append(
          $("<span>").text("참여자").addClass("text-12 subtitle-font-color")
        )
        .append($("<div>").addClass("participants-tab"));
      $(".job-participants-tab").append(participantsTab);

      var participantsId = [
        val.jobParticipant1Id,
        val.jobParticipant2Id,
        val.jobParticipant3Id,
      ];
      $.each(participantsId, function (idx, val2) {
        if (val2 != null) {
          $.ajax({
            url: "/rest/social/find",
            beforeSend: function (xhr) {
              xhr.setRequestHeader(header, token);
            },
            method: "GET",
            data: { socialId: val2 },
            success: function (res) {
              var participantTab = $("<div>")
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
                );
              $(".participants-tab").append(participantTab);
            },
          });
        }
      });
    }

    if (val.jobEndTime != null) {
      var endTimeTab = $("<span>")
        .text("~ " + new Date(val.jobEndTime).toLocaleString())
        .addClass("text-12 text-font-color mt-8 ml-8");
      $('[data-id="' + val.jobId + '"] .datetime-tab').append(endTimeTab);
    }

    if (val.jobPlace != null) {
      var place = $("<div>")
        .addClass("job-place-tab flex flex-col mt-8")
        .append(
          $("<span>").text("장소").addClass("text-12 subtitle-font-color")
        )
        .append(
          $("<span>")
            .text(val.jobPlace)
            .addClass("job-place-address text-12 text-font-color mt-8")
        )
        .append($("<div>").addClass("map mt-8 round-6"));

      $('[data-id="' + val.jobId + '"] .job-place-tab').append(place);
      kakao.maps.load(() => {
        var container = $('[data-id="' + val.jobId + '"] .map')[0];
        var options = {
          center: new kakao.maps.LatLng(37.566395, 126.987778),
          level: 3,
        };
        var map = new kakao.maps.Map(container, options);
        var address = $(
          '[data-id="' + val.jobId + '"] .job-place-address'
        ).text();
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
        });
      });
    }

    if (val.jobDescription != null) {
      var jobDescription = $("<p>")
        .text(val.jobDescription)
        .addClass("text-14 text-font-color mt-8");
      $('[data-id="' + val.jobId + '"] .job-description-tab').append(
        jobDescription
      );
    }
  });
}
