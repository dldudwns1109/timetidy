export function socialList(res) {
  var header = $("meta[name='_csrf_header']").attr("content");
  var token = $("meta[name='_csrf']").attr("content");
  $.each(res, function (idx, val) {
    $(".social-list-content").append(
      $("<div>")
        .addClass("social-tab flex justify-between items-center mb-8")
        .append(
          $("<div>")
            .addClass("flex items-center px-8 py-9")
            .append(
              $("<img>")
                .attr("src", val.socialProfile)
                .addClass("w-26 h-26 mr-8 round-full")
            )
            .append(
              $("<span>")
                .text(val.socialName)
                .addClass("text-16 title-font-color")
            )
        )
        .append(
          $("<div>").append(
            $("<button>")
              .attr("data-id", val.socialRelativeId)
              .addClass(
                "social-delete-btn trans-color border-1 negative-b px-12 py-6 round-6 text-16 subtext-font-color"
              )
              .text("삭제")
              .click(function () {
                $.ajax({
                  url: "/rest/social/delete",
                  beforeSend: function (xhr) {
                    xhr.setRequestHeader(header, token);
                  },
                  method: "GET",
                  data: { relativeId: $(this).data("id") },
                  success: function (res) {
                    $('[data-id="' + res + '"]')
                      .closest(".social-tab")
                      .remove();
                  },
                });
              })
          )
        )
    );
  });
}
