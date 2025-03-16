export function noSearch(keyword) {
  $(".page-result")
    .append(
      $("<div>")
        .addClass("flex flex-col items-center")
        .append($("<img>").addClass("w-260").attr("src", "/img/no-search.svg"))
        .append(
          $("<span>")
            .addClass("mt-24 text-16 title-font-color")
            .text('"' + keyword + '"과(와) 일치하는 일정이 없습니다.')
        )
    )
    .removeClass("mt-32")
    .addClass("flex justify-center mt-154");
}