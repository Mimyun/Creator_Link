<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.sub_image {
    transition: transform 0.2s; /* Animation */
}

.sub_image:hover {
    transform: scale(1.1); /* 이미지를 약간 확대 */
}
#mainImage {
    opacity: 1; /* 기본적으로 완전히 불투명 */
    transition: opacity 0.5s ease-in-out; /* 페이드 효과에 대한 전환 효과 설정 */
}
#image_container {
    display: flex;
    overflow-x: hidden;
    width: 250px; /* 예시 너비, 필요에 따라 조절 */
}
.sub_image {
    flex: 0 0 auto; /* 이미지가 컨테이너 너비를 넘어가면 스크롤되지 않고 나란히 배열됨 */
}
</style>
</head>
<body>
	<form action="">
		<table>
			<tr>
				<th><img id="main_image" src="./resources/store/item_cover/${dto.pd_photo}"	width="500"></th>
				<td>
				<div id="image_slider">
				<button type="button" id="prev">◀</button>
				<div id="image_container">
				<c:forEach items="${list}" var="s" varStatus="status">
				<img id="sub_image" class="sub_image" src="./resources/store/item_cover/${s.os_photo}" width="100" onmouseover="chang_image(this.src)" onmouseout="reset_image()">
				</c:forEach>
				</div>
				<button type="button" id="next">▶</button>
				</div>
				</td>
			</tr>
		</table>
	</form>
	<form action="shoping_buy" method="post" name="shoping_buy_form">
		<table border="1">
			<tr>
				<th>상품명</th>
				<td>${dto.pd_name}
				<input type="hidden" name="pd_number" id="pd_number" value="${dto.pd_number}">
				</td>
			</tr>
			<tr>
				<th>가격</th>
				<td>${dto.pd_price}원</td>
			</tr>
			<tr>
				<th>재고</th>
				<td>${dto.pd_stock}</td>
			</tr>
			<tr>
				<th>배송 예상일</th>
				<td>${today}</td>
			</tr>
			<c:choose>
			    <c:when test="${not empty os1name and os1name[0] ne null}">
			        <tr>
			            <th>옵션1</th>
			            <td>
			                <select name="os_1" id="os_1" onchange="os_1check()">
			                    <c:forEach items="${os1name}" var="s">
			                        <option value="${s}">${s}</option>
			                    </c:forEach>
			                </select>
			            </td>
			        </tr>
			    </c:when>
			</c:choose>
			<c:choose>
			    <c:when test="${not empty os2name and os2name[0] ne null}">
			        <tr>
			            <th>옵션2</th>
			            <td>
			                <select name="os_2" id="os_2" onchange="os_1check()">
			                    <c:forEach items="${os2name}" var="s">
			                        <option value="${s}">${s}</option>
			                    </c:forEach>
			                </select>
			            </td>
			        </tr>
			    </c:when>
			</c:choose>
			<c:choose>
			    <c:when test="${not empty os3name and os3name[0] ne null}">
			        <tr>
			            <th>옵션3</th>
			            <td>
			                <select name="os_3" id="os_3" onchange="os_1check()">
			                    <c:forEach items="${os3name}" var="s">
			                        <option value="${s}">${s}</option>
			                    </c:forEach>
			                </select>
			            </td>
			        </tr>
			    </c:when>
			</c:choose>
			<tr>
				<th>구매수량</th>
				<td>
				<c:choose>
					<c:when test="${dto.pd_stock < 1}">
						품절
					</c:when>
					<c:otherwise>
						<select name="buy_quantity">
							<c:forEach begin="1" end="${dto.pd_stock}" var="i">
								<option value="${i}">${i}</option>
							</c:forEach>
						</select>
					</c:otherwise>
				</c:choose>
				</td>
			</tr>
			<tr>
				<td><input type="button" value="구매" onclick="login_check()"
					<c:if test="${dto.pd_stock < 1}">disabled</c:if>></td>
			</tr>
		</table>
	</form>
	<form action="shopping_cart" name="cart_form">
	<div>선택된 옵션</div>
			<div id="os_items"></div>
			<input type="hidden" name="pd_number" id="pd_number" value="${dto.pd_number}">
			<input type="button" value="장바구니" 	onclick="cart()" <c:if test="${dto.pd_stock < 1}">disabled</c:if>>
	</form>
	<form action="">
		<table border="1">
			<tr>
				<th>상세정보</th>
				<td><div>${dto.pd_content}</div></td>
			</tr>
			<tr>
				<th>리뷰</th>
				<td>내용</td>
			</tr>
		</table>
	</form>
</body>
<script type="text/javascript">
function login_check() {
	var login = "${loginState}";
	if(login == "true"){
		var f = document.shoping_buy_form;
		f.submit();
	}else{
		alert("로그인이 필요합니다.");
		window.location.href="login";
	}
}
let os_check = 1;
function os_1check() {
	var os_1 = document.getElementById('os_1')? document.getElementById('os_1').value : '';
	var os_2 = document.getElementById('os_2')? document.getElementById('os_2').value : '';
	var os_3 = document.getElementById('os_3')? document.getElementById('os_3').value : '';
	var os_items = document.getElementById('os_items');
	var pd_number = document.getElementById('pd_number').value;
	
	const os_div = document.createElement('div');
	var currentid = "os_choice_"+os_check;
	os_div.id = currentid;
	os_div.innerHTML = 	'<ul><li name="os_choice" value="'+os_1+os_2+os_3+'">'+os_1+os_2+os_3+''+
						'<input type="button" onclick="os_choice_delete('+os_check+')" value="X">'+
						'<input type="hidden" name="os_number" id="os_number'+os_check+'" ></li></ul>';
	os_items.appendChild(os_div);
	var os_names = os_1+","+os_2+","+os_3;
	os_number_select(os_names,os_check,pd_number);
	os_check++; //삭제하기 위한 함수 증가
}
function os_number_select(os_names,os_check,pd_number) {
	$.ajax({
		type:"post",
		async:true,
		url:"os_number_get",
		dataType:"text",
		data:{"os_names":os_names,"pd_number":pd_number},
		success:function(check) {
			if (check != null) {
				document.getElementById("os_number" + os_check).value = check; // 여기에서 값을 설정합니다.
			}else {
				alert("옵션 추가 실패");
			}
		}
	});
}
function os_choice_delete(check) {
    var os_choice_div = document.getElementById("os_choice_"+check);
    if (os_choice_div) {
        os_choice_div.parentNode.removeChild(os_choice_div);
    }
}
function cart() {
	var login = "${loginState}";
	if(login == "true"){
		var f = document.cart_form;
		if(f.os_number!=null){
			f.submit();
		};
	}else{
		alert("로그인이 필요합니다.");
		window.location.href="login";
	}
}
</script>
<script type="text/javascript">
function chang_image(src) {
    document.getElementById('main_image').src = src;
}
function reset_image() {
    // 원래 큰 이미지의 소스로 변경. 원래의 큰 이미지 소스를 변수에 저장하거나 다른 방법을 사용해 관리해야 합니다.
    document.getElementById('main_image').src = './resources/store/item_cover/${dto.pd_photo}';
}
document.getElementById('next').addEventListener('click', function() {
    // 오른쪽으로 슬라이드
    document.getElementById('image_container').scrollLeft += 100; // 100px을 오른쪽으로 슬라이드
});

document.getElementById('prev').addEventListener('click', function() {
    // 왼쪽으로 슬라이드
    document.getElementById('image_container').scrollLeft -= 100; // 100px을 왼쪽으로 슬라이드
});
</script>
</html>