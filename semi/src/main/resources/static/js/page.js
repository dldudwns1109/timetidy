export function page (res) {
	var header = $("meta[name='_csrf_header']").attr('content');
    var token = $("meta[name='_csrf']").attr('content');
	$(".date-page-tab").append(
		$("<button>")
		  .attr("data-id", res.pageId)
		  .addClass(
		    "date-tab trans-color border-none outline-none flex justify-between w-100p px-8 py-9 mt-8 brand-light round-6"
		  )
		  .append(
		    $("<div>")
		      .addClass("flex items-center")
		      .append(
		        $("<img>")
		          .attr("src", "/img/doc.svg")
		          .addClass("w-24 h-24 mr-8")
		      )
		      .append(
		        $("<span>")
		          .addClass("page-title brand-medium-font text-16")
		          .text(res.pageTitle)
		      )
		  )
		  .append(
		    $("<button>")
		      .addClass(
		        "date-delete-btn none trans-color border-none outline-none w-24 h-24 p-0 round-6"
		      )
		      .append(
		        $("<img>")
		          .attr("src", "/img/trash.svg")
		          .addClass("w-100p h-100p")
		      )
			  .click(function (e) {
				e.stopPropagation();
	  			$.ajax({
	  				url: "/rest/page/delete",
	  				beforeSend: function(xhr) {
	  					xhr.setRequestHeader(header, token);
	  				},
	  				method: "POST",
	  				data: { 
	  					pageId: $(this)
	  								.closest(".date-tab")
	  								.data("id") 
	  				},
	  				success: function(res) {
	              		$("[data-id=" + res + "]").remove();
	  				}
	  			});
            })
		  )
		  .hover(
		    function () {
		      $(this).children(".date-delete-btn").show();
		    },
		    function () {
		      $(this).children(".date-delete-btn").hide();
		    }
		  )
		  .click(function () {
            location.replace("/schedule/" + 
				$(this).closest(".date-tab").data("id"));
          })
	  );
}