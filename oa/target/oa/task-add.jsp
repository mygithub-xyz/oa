<%@ page language="java"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>创建任务</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/skin/css/base.css">
	<script type="application/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
     <script type="text/javascript" src="${pageContext.request.contextPath}/js/main.js"></script>
</head>
<body leftmargin="8" topmargin="8" background='skin/images/allbg.gif'>

<!--  快速转换位置按钮  -->
<table width="98%" border="0" cellpadding="0" cellspacing="1" bgcolor="#D1DDAA" align="center">
<tr>
 <td height="26" background="${pageContext.request.contextPath}/skin/images/newlinebg3.gif">
  <table width="58%" border="0" cellspacing="0" cellpadding="0">
  <tr>
  <td >
    当前位置:任务管理>>创建任务
 </td>
 </tr>
</table>
</td>
</tr>
</table>

<form name="form2" id="form7" action="${pageContext.request.contextPath}/task/task-addInfo" method="post">

<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px">
<tr bgcolor="#E7E7E7">
	<td height="24" colspan="2" background="skin/images/tbg.gif">&nbsp;创建任务&nbsp;</td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">参考位置：</td>
	<td  align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<select id="pro" onchange="addayalisys(this.value)">
			<option value=1>请选择项目</option>
		</select>-
		<select id="anid"><option value=1>请选择需求</option></select>
		-<select id="mod" onchange="addfunc(this.value)"><option value=1>请选择模块</option></select>-
		<select id="fun" name="funFk"><option value=1>请选择功能</option></select>
	</td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">任务标题：</td>
	<td  align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22"><input name="tasktitle"/></td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">开始时间：</td>
	<td  align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22"><input name="starttime"/></td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">结束时间：</td>
	<td  align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22"><input name="endtime"/></td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">执行者：</td>
	<td  align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<select id="emp" name="empFk2">
			<option value=1>任务的执行者</option>
		</select>
	</td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">优先级：</td>
	<td  align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<select name="level"><option value="高">高</option><option value="中">中</option><option value="低">低</option></select></td>
</tr>

<tr >
	<td align="right" bgcolor="#FAFAF1" >详细说明：</td>
	<td colspan=3 align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" >
		<textarea rows=10 cols=130 name="remark"></textarea>
	</td>
</tr>


<tr bgcolor="#FAFAF1">
<td height="28" colspan=4 align=center>
	&nbsp;
	<a href="javascript:commit()" class="coolbg">保存</a>
</td>
</tr>
</table>

</form>
<script type="application/javascript">
        $(function () {
            //预加载项目列表数据
          showProject();
            //项目经理
            showEmployee();
        })
        addayalisys(pid);
        //显示某个模块的功能信息
        function addfunc(mid) {
            $.ajax({
                url:"task/task-add-function-show",
                data:"mid="+mid,
                dataType:"json",
                success:function (obj) {
                     console.log(obj);
                    $("#fun").empty();
                    $("#fun").append("<option value=-1>--请选择功能--</option>");
                    $.each(obj,function (i, fun) {
                        $("<option></option>").val(fun.id).text(fun.functionname).appendTo($("#fun"))
                    })
                }
            });
        }

        //项目经理显示
        function showEmployee() {
            $.ajax({
                url:"employee/project-add-employee-show",
                dataType:"json",
                statusCode:{
                    200:function (obj) {
                        // console.log(obj);
                        $("#emp").empty();
                        $("#emp").append("<option value='-1'>任务执行人</option>");
                        $.each(obj,function (i, employee) {
                            $("<option></option>").val(employee.eid).text(employee.ename).appendTo($("#emp"));
                        });
                    },
                    404:function () {
                        alert("请求有误");
                    },
                    500:function () {
                        alert("请求失败");
                    }
                }
            });
        }
        //提交功能
        function commit() {
            $("#form7").submit();
        }
</script>
</body>
</html>