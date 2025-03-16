export function notificationList(res) {
  var header = $("meta[name='_csrf_header']").attr("content");
  var token = $("meta[name='_csrf']").attr("content");
  $.each(res, function (idx, val) {
    $.ajax({
      url: "/rest/member/find",
      beforeSend: function (xhr) {
        xhr.setRequestHeader(header, token);
      },
      method: "GET",
      data: { memberId: val.notificationSenderId },
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
                .append(
                  $("<button>")
                    .append($("<img>").attr("src", "/img/check-positive.svg"))
                    .append(
                      $("<span>")
                        .addClass("text-16 subtext-font-color")
                        .text("수락")
                    )
                    .addClass(
                      "accept-btn flex trans-color border-1 positive-b outline-none mr-8 round-6 pl-4 pr-8 py-6"
                    )
                    .hover(
                      function () {
                        $(this).find("img").attr("src", "/img/check-hover.svg");
                      },
                      function () {
                        $(this)
                          .find("img")
                          .attr("src", "/img/check-positive.svg");
                      }
                    )
                    .click(function () {
                      var notificationTab =
                        $(this).closest(".notification-tab");
                      if (notificationTab.data("job-id") == undefined) {
                        $.ajax({
                          url: "/rest/notification/accept",
                          beforeSend: function (xhr) {
                            xhr.setRequestHeader(header, token);
                          },
                          method: "POST",
                          data: {
                            senderId: notificationTab.data("id"),
                          },
                          success: function () {
                            notificationTab.remove();
                          },
                        });
                      } else {
                        $.ajax({
                          url: "/rest/notification/accept-date",
                          beforeSend: function (xhr) {
                            xhr.setRequestHeader(header, token);
                          },
                          method: "POST",
                          data: {
                            senderId: notificationTab.data("id"),
                            jobId: notificationTab.data("job-id"),
                          },
                          success: function () {
                            notificationTab.remove();
                          },
                        });
                      }
                    })
                )
                .append(
                  $("<button>")
                    .append($("<img>").attr("src", "/img/close-negative.svg"))
                    .append(
                      $("<span>")
                        .addClass("text-16 subtext-font-color")
                        .text("거절")
                    )
                    .addClass(
                      "reject-btn flex trans-color border-1 negative-b outline-none round-6 pl-4 pr-8 py-6"
                    )
                    .hover(
                      function () {
                        $(this).find("img").attr("src", "/img/close-hover.svg");
                      },
                      function () {
                        $(this)
                          .find("img")
                          .attr("src", "/img/close-negative.svg");
                      }
                    )
                    .click(function () {
                      var notificationTab =
                        $(this).closest(".notification-tab");
                      if (notificationTab.data("job-id") == undefined) {
                        $.ajax({
                          url: "/rest/notification/reject",
                          beforeSend: function (xhr) {
                            xhr.setRequestHeader(header, token);
                          },
                          method: "POST",
                          data: {
                            senderId: notificationTab.data("id"),
                          },
                          success: function () {
                            notificationTab.remove();
                          },
                        });
                      }
                    })
                )
            )
        );
      },
    });
  });
}