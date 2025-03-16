export function searchHistoryList(res) {
  var header = $("meta[name='_csrf_header']").attr("content");
  var token = $("meta[name='_csrf']").attr("content");
  $.each(res, function (idx, val) {
    $(".search-hist-content").append(
      $("<button>")
        .attr("data-keyword", val.searchHistoryKeyword)
        .addClass(
          "search-hist-btn trans-color border-none outline-none flex justify-between items-center w-100p px-8 py-8 mt-8 round-6"
        )
        .append(
          $("<span>")
            .text(val.searchHistoryKeyword)
            .addClass("text-14 title-font-color")
        )
        .append(
          $("<button>")
            .addClass(
              "search-hist-delete-btn w-24 h-24 p-0 trans-color border-none outline-none round-6"
            )
            .append($("<img>").attr("src", "/img/close.svg"))
            .click(function (e) {
              e.stopPropagation();
              $.ajax({
                url: "/rest/search/delete",
                beforeSend: function (xhr) {
                  xhr.setRequestHeader(header, token);
                },
                method: "POST",
                data: { keyword: val.searchHistoryKeyword },
                success: function (res) {
                  $('[data-keyword="' + res + '"]').remove();
                },
              });
            })
        )
        .click(function (e) {
          location.href = "/schedule/search?query=" + $(e.target).text();
        })
    );
  });
}