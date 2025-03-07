<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="/js/page.js"></script>

<!-- jQuery cdn -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script type="module">
  import { page } from "/js/page.js";
  $(function () {
    var header = $("meta[name='_csrf_header']").attr("content");
    var token = $("meta[name='_csrf']").attr("content");
    $.ajax({
      url: "/rest/page/list",
      beforeSend: function (xhr) {
        xhr.setRequestHeader(header, token);
      },
      method: "GET",
      success: function (res) {
        $.each(res, function (idx, val) {
          page(val);
        });
      },
    });

    var isOpen = true;
    $(".sidebar-btn").click(function () {
      if (isOpen) {
        $(".sidebar").removeClass("light-dark");
		$(".profile-btn").hide();
		$(".bell-btn").hide();
		$(".title-tab").hide();
        $(".tab").hide();
		$(".sidebar").width(24);
      } else {
		$(".sidebar").width(260);
        $(".sidebar").addClass("light-dark");
        setTimeout(function() {
			$(".profile-btn").show();
			$(".bell-btn").show();
			$(".title-tab").show();
        	$(".tab").show();
		}, 100);
      }
      isOpen = !isOpen;
    });

    $(".date-title-tab").hover(
      function () {
        $(".plus-btn").show();
      },
      function () {
        $(".plus-btn").hide();
      }
    );
    $(".date-title-tab").mouseout(function (e) {
      if (!$(e.target).closest(".date-title-tab").length) {
        $(".plus-btn").hide();
      }
    });

    $(".profile-btn").click(function () {
      $(".account-modal").removeClass("none").addClass("flex");
    });
    $(".modal-close-btn").click(function () {
      $(".account-modal").removeClass("flex").addClass("none");
    });
    $(window).click(function (e) {
      if ($(e.target).is(".account-modal")) {
        $(".account-modal").removeClass("flex").addClass("none");
      }
    });

    var nameValid = true;
    $("[name=memberName]").blur(function () {
      if (/^[가-힣][가-힣0-9]{1,9}$/.test($(this).val())) {
        nameValid = true;
        $(".err-msg").hide();
      } else {
        nameValid = false;
        $(".err-msg").show();
      }
    });

    $(".logout-btn").click(function () {
      $.ajax({
        url: "/rest/member/logout",
        beforeSend: function (xhr) {
          xhr.setRequestHeader(header, token);
        },
        method: "GET",
        success: function (res) {
          location.replace("https://accounts.google.com/logout");
          location.replace("/loading");
        },
      });
    });
    $(".member-delete-btn").click(function () {
      $.ajax({
        url: "/rest/member/delete",
        beforeSend: function (xhr) {
          xhr.setRequestHeader(header, token);
        },
        method: "GET",
        success: function (res) {
          location.replace("https://accounts.google.com/logout");
          location.replace("/loading");
        },
      });
    });
    $(".save-btn").click(function () {
      if (nameValid) {
        $.ajax({
          url: "/rest/member/edit",
          beforeSend: function (xhr) {
            xhr.setRequestHeader(header, token);
          },
          method: "POST",
          data: { memberName: $("[name=memberName]").val() },
          success: function (res) {
            $(".profile-membername").text(res);
            $(".account-modal").removeClass("flex").addClass("none");
          },
        });
      }
    });

    $(".plus-btn").click(function () {
      $.ajax({
        url: "/rest/page/add",
        beforeSend: function (xhr) {
          xhr.setRequestHeader(header, token);
        },
        method: "POST",
        success: function (res) {
          page(res);
        },
      });
    });
  });
</script>