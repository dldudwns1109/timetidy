export function searchPageList(res) {
  $.each(res, function (idx, val) {
    $(".page-result").append(
      $("<button>")
        .addClass(
          "page-result-btn trans-color border-none outline-none flex items-center w-100p mt-8 px-14 py-11 round-6"
        )
        .append($("<img>").addClass("mr-8").attr("src", "/img/doc.svg"))
        .append(
          $("<span>").addClass("text-16 title-font-color").text(val.pageTitle)
        )
        .click(function () {
          location.href = "/schedule/" + val.pageId;
        })
    );
  });
}