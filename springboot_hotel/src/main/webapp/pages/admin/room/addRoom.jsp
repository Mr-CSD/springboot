<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
					+ request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<base href="<%=basePath%>">
<link href="<%=basePath%>/static/css/style.css" rel="stylesheet"
	type="text/css" />
<link href="<%=basePath%>/static/css/select.css" rel="stylesheet"
	type="text/css" />
<script type="text/javascript" src="<%=basePath%>/static/js/jquery.js"></script>
<script type="text/javascript"
	src="<%=basePath%>/static/js/jquery.idTabs.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>/static/js/select-ui.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>/static/js/editor/kindeditor.js"></script>

<script type="text/javascript">
	KE.show({
		id : 'content7',
		cssPath : './index.css'
	});
</script>

<script type="text/javascript">
	$(document).ready(function(e) {
		$(".select1").uedSelect({
			width : 345
		});
		$(".select2").uedSelect({
			width : 167
		});
		$(".select3").uedSelect({
			width : 100
		});

		/* $("#name").focus(function() {
			$(this).css("background-color", "#0FF")
			var text = $(this).val();
			if (text == "请填写姓名") {
				$(this).val("");
			}
		}); */
 
		$("#name").blur(function() {
			//首先获取房间号
			var rn = $(this).val();
			//判断房间号是否存在
			$.ajax({
				url:"<%=basePath%>/isRoomNumExist.do",
				type:"post",
				dataType:"json",
				data:{
					roomNum:rn
				},
				success:function(result){
					if(result){//房间号存在
						$("#roomNumError").html("*此房间号已经存在");
						$("#name").focus();
					}else{//房间号不存在
						$("#roomNumError").html("");
					}
				}
			});
		}); 

	});
</script>
</head>

<body>

	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">客房管理</a></li>
			<li><a href="#">添加客房</a></li>
		</ul>
	</div>

	<div class="formbody">


		<div id="usual1" class="usual">

			<div class="itab">
				<ul>
					<li><a href="#tab1" class="selected">添加客房</a></li>

				</ul>
			</div>

			<div id="tab1" class="tabson">

				<div class="formtext">
					Hi，<b>${sessionScope.username }</b>，请填写要添加的客房信息
				</div>

				<form id="fm1" action="<%=basePath%>/addRoom.do" method="POST">
					<ul class="forminfo">
						<li>
							<label>房间号<b>*</b></label>
							<input style="float:left;margin-bottom:10px" required="required"  name="roomNum" type="text" class="dfinput" id="name"/>
							<label id="roomNumError" style="width:150px;color:red;float:left;margin-left:20px"></label>
						</li>
						<li>
							<label>房间类型<b>*</b></label> 
							<div class="vocation">
								<select id="roomType" class="select1" name="roomId">
								</select>
							</div>
							<div id="notice2"
								style="font-size: 14px; color: red; position: absolute; z-index: 1000; margin-top: -30px; margin-left: 450px">
							</div>
						</li>
						<li>
							<label>房间状态<b>*</b></label> 
							<div class="vocation">
								<select class="select1" name="roomStatus">
									<option value="0" selected="selected">空闲</option>
									<option value="1">已入住</option>
									<option value="2">打扫</option>
								</select>
							</div>
							<div id="notice3"
								style="font-size: 14px; color: red; position: absolute; z-index: 1000; margin-top: -30px; margin-left: 450px">
							</div>

						</li>
						<li><label>&nbsp;</label><input  type="submit"
							class="btn" value="确认"/></li>
					</ul>
				</form>

			</div>
<script type="text/javascript">
	$(function(){
		/* 防止表单重复提交 */
		$("#fm1").submit(function(){
			$("input[type=submit]").attr("disabled","disabled");
			$("input[type=submit]").css({
				background:'#ccc'
			});
		});
		
		/* 动态获取房间类型 */
		$("#roomType").mouseenter(function(){
			//触发ajax事件，动态获取数据
			$.ajax({
				url:"<%=basePath %>/getRoomType.do",
				type:"POST",
				dataType:"json",
				success:function(result){
					var content="";
					for(var i in result){
						content+="<option value='"+result[i].id+"'>"+result[i].room_type_name+"</option>";
					}
					$("#roomType>option").remove();
					$("#roomType").append(content);
				}
			});
		});
	});
</script>
</body>

</html>
