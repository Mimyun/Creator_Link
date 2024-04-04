<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<script src="https://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript" src="resources/js/board_view.js"></script>
	<script type="text/javascript">
		var write_id = "${post.bct_writer}";
		var login_id = "${member.mb_id}";
		var state = "${loginState}";
	    var bct_content_number = "${post.bct_content_number}";
	</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table border="1" style="margin: auto; width: 1000px;">
		<tr>
			<th align="left">${post.bct_title}</th>
		</tr>
		<tr>
			<td>${post.bct_writer}<br>
							${post.bct_write_date} &emsp; 
							${post.bct_view_cnt}</td>
		</tr>
		<tr>
			<td>${post.bct_content}</td>
		</tr>
		<tr>
			<td>댓글</td>
		</tr>
			<c:if test="${comment.size() != 0}">
				<c:forEach items="${comment}" var="c" varStatus="status">
					<c:if test="${c.cm_inheritance == 0}">
						<tr>
							<td>
							<div id="comment_area_${status.index}">
								${c.mb_nick_name} &emsp;&emsp;
								<a id="comment_${status.index}" style="color: black; text-decoration-line: none; cursor: pointer;">
									${c.cm_content}
								</a>
								<span style="float: right;">
									<a id="comment_del_${status.index}" data-mb_id="${c.mb_id}" data-cm_number="${c.cm_number}" style="cursor: pointer; font-size: small; display: none;">삭제</a>&emsp;
									${c.cm_write_date}
								</span>
							</div>
					    	<div id="re_comment_div_${status.index}" style="display: none; width: 95%; background-color: rgb(0,0,0,0.1); border: 1px solid white; float: right; text-align: center;">
					            <textarea id="re_content_${status.index}" name="re_content_${status.index}" style="width: 99%; height: 50px;" placeholder="댓글을 입력해주십시오"></textarea>
					            <span style="float: right;"><button id="re_submitButton_${status.index}" type="button" data-cm_number="${c.cm_number}">작성</button></span>
					        </div>
					        <c:forEach items="${comment}" var="rc">
					        	<c:if test="${rc.cm_inheritance == c.cm_number}">
							    	<div id="comment_area_${status.index}" style="width: 95%; background-color: rgb(0,0,0,0.1); border: 1px solid white; text-align: left; float: right;">
							    		${rc.mb_nick_name} &emsp;&emsp; ${rc.cm_content} 
							    		<span style="float: right;">
							    			<a id="comment_del_${status.index}" data-mb_id="${rc.mb_id}" data-cm_number="${rc.cm_number}" style="cursor: pointer; font-size: small; display: none;">삭제</a>&emsp;
							    			${rc.cm_write_date}
							    		</span>
							    	</div>
						    	</c:if>
					    	</c:forEach></td>
						</tr>
					</c:if>
				</c:forEach>
			</c:if>
		<tr>
			<td><span style="font-weight: bold;">댓글작성</span> &emsp;
			${member.mb_nick_name}</td>
		</tr>
		<tr>
		    <td align="center" style="position: relative;">
		        <textarea id="cm_content" name="cm_content" style="width: 99%; height: 50px;" placeholder="댓글을 입력해주십시오" onclick="toggleButtonVisibility()"></textarea>
		        <button id="submitButton" type="button" style="position: absolute; right: 10px; bottom: 10px; display: none;">작성</button>
		    </td>
		</tr>
		<tr>
			<td align="right">	<button type="button" onclick="post_modify()">수정</button>
								<button type="button" onclick="post_del()">삭제</button></td>
		</tr>
	</table>
</body>
</html>