<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Register</title>
	<style>
		#title {
			background-color: white;
			width: 100%;
			height: 22%;
		}
		#topSearch {
			z-index: 150;
			position: fixed;
			top: 10%;
			left: 30%;
		}
		#searchCategory{
			color:grey;
			width:30%;
			position: fixed;
			top: 10%;
			left: 63%;
		}
		body{
			background-color: white;
		}
		h1 {
			font-size: 40px;
			top: 20%;
			left: 10%;
			margin-left:10%;
			color: dark grey;
			text-shadow: 2px 2px 5px grey;
		}
		
		div{
			margin-left: 10%;
			font-size: 20px;
		}
		p{
			color: grey;
			font-size: 22px;
		}
		
	</style>
</head>
	<%
	
	String username_error = (String)session.getAttribute("username_error");
	String password_error = (String)session.getAttribute("password_error");
	if(username_error == null){
		username_error = "";
	}
	if(password_error == null){
		password_error = "";
	}
	session.setAttribute("password_error", null);
	session.setAttribute("username_error", null);

	%>
	
<body>
	<div id="title">
	 	<a href="${pageContext.request.contextPath}/HomePage.jsp">
	    <img src="bookworm.png" width=13% id="logo" style="margin-top: 20px; margin-left:100px;"></a>
	</div>
	
	<div id="topSearch">
	
	<form name="myform" method="GET" action="SearchResult.jsp" onsubmit="searchDatabase()">
	      <input type="text" name="searchbook" class="searchBox" placeholder="What book is on your mind?" 
	style=" color: black; width: 300px; height: 35px;margin-left:-50px;  font-size: 100%">  
	
	      <button type="submit"><img src="magnifying_glass.png" alt="Submit" style="width: 32px "></button>
	      <table id="searchCategory">
	       <tr>
	      <td> <input type="radio" name="searchby" value="name"> Name </td>
	      <td> <input type="radio" name="searchby" value="isbn"> ISBN 
	      </tr>
	      <tr>
	      <td> <input type="radio" name="searchby" value="author"> Author  </td>
	      <td> <input type="radio" name="searchby" value="publisher"> Publisher </td>
	      </tr>
	      </table>
	    </form>
	    </div>
	    <br><hr>
	    
	   
	    <h1>Registration </h1>
	   	<div id="insertForm">
				<form class="form" name="registerForm" id="registerForm" method="POST" action="Register">
					<p>Username</p><input type="text" name="username" style=" color: black; width: 1200px; height: 30px; font-size: 100%"><br>
					<p>Password</p> <input type="password" name="password" style=" color: black; width: 1200px; height: 30px; font-size: 100%"><br>
					<p>Confirm Password</p> <input type="password" name="confirm_password" style=" color: black; width: 1200px; height: 30px; font-size: 100%"><br>
					<span id="usernameMessage"><%= username_error %></span>
					<span id="passwordMessage"><%= password_error %></span> <br><br>
					<button name="registerSubmit" onclick="submit" style="color: white; background-color: grey; width: 1200px; height: 38px; font-size: 100%">
					Register</button>
				</form> 
			</div>
</body>
</html>
