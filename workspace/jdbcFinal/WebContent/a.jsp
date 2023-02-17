<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>데이터 가져오기</title>
</head>
<body>
	<input type="text" name="name">
	<p id="result"></p>
	<button id="getData">데이터 가져오기</button>
</body>
<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<script>
	$("#getData").on("click", function(){
		$.ajax({
			url: "b.jsp",
			/* {} => 이게 없으니까 jsObject형식으로 보내준다. */
			data: {"name": $(this).prev().prev().val()},
			/* type : get => 생략하면 default 값은 get이다.*/
			success: function(result){
				$("#result").text(result);
			}
		});
	})
</script>
</html>

