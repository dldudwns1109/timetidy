export function memberSocialList(res) {
  var header = $("meta[name='_csrf_header']").attr("content");
  var token = $("meta[name='_csrf']").attr("content");
  $.each(res, function (idx, val) {
    $(".social-list-content").append(
      $("<div>")
        .addClass("flex justify-between items-center mb-8")
        .append(
          $("<div>")
            .addClass("flex items-center px-8 py-9")
            .append(
              $("<img>")
                .attr("src", val.memberProfile)
                .addClass("w-26 h-26 mr-8 round-full")
            )
            .append(
              $("<span>")
                .text(val.memberName)
                .addClass("text-16 title-font-color")
            )
        )
        .append(
          $("<div>").append(
            $("<button>")
              .attr("data-id", val.memberId)
              .attr("data-state", val.socialPendingState == null ? false : true)
              .addClass(
                "trans-color border-1 px-12 py-6 round-6 text-16 subtext-font-color " +
                  (val.socialPendingState == null
                    ? "brand-b social-add-btn"
                    : "line-base")
              )
              .text(val.socialPendingState == null ? "추가" : "대기중")
              .click(function () {
                if (!$(this).data("state")) {
                  $.ajax({
                    url: "/rest/notification/add",
                    beforeSend: function (xhr) {
                      xhr.setRequestHeader(header, token);
                    },
                    method: "POST",
                    data: { receiverId: $(this).data("id") },
                    success: function () {
                      location.reload();
                    },
                  });
                }
              })
          )
        )
    );
  });
}
