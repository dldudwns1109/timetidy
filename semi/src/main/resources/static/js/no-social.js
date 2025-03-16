export function noSocial(isSearch = false) {
  $(".social-list-content").append(
    $("<div>")
      .addClass("flex flex-col items-center mt-40")
      .append($("<img>").attr("src", "/img/no-social.svg"))
      .append(
        $("<span>")
          .addClass("text-16 title-font-color mt-24")
          .text((isSearch ? "찾는 " : "") + "친구 목록이 없습니다.")
      )
  );
}