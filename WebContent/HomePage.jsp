<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home Page</title>
	<style>
	#title {
		background-color: white;
		position: fixed;
		width: 100%;
		height: 22%;
	}
	
	#box {
		background-color: black;
		position: fixed;
		opacity: 0.5;
		width: 100%;
		height: 100%;
		margin-top: 12.5%;
	}
	
	#SearchButton {
		position: fixed;
		background-webkit-filter: blur(0.5px);
		opacity: 0.8;
		border-style: solid;
		border-width: thin;
		border-color: black;
		border-radius: 5px;
		margin-left: 85%;
	}
	
	body {
		background-image: url("background.jpg");
		background-repeat: no-repeat;
		background-size: cover;
		background-color: black;
		background-blend-mode: screen;
		position: fixed;
	}
	#error_msg{
		color: white;
		font-family: timesnewroman; 
		font-size: 100%; 
		margin-left:100px;
	}
	#status{
		z-index: 150;
		position: fixed;
		top: 10%;
		left: 70%;
		font-size: 30px; 
		color:black;
	}
	#Register {
		position: relative;
		left: 20%;
	}

	#signOut {
		position: relative;
		left: 20%;
	}
	
	a {
    	color: black;
    	text-decoration: none;
	}

	a:hover {
     	color:grey; 
     	text-decoration:none; 
     	cursor:pointer;  
	}
	</style>
</head>

<body>
	<div id="title">
	    <a href="${pageContext.request.contextPath}/HomePage.jsp">
	    <img src="bookworm.png" width=15% id="logo" style="margin-top: 20px; margin-left:100px;"></a><br />
	    <div id="status">
			<% 
				if(session.getAttribute("loggedIn") == null){
			%>
					<a href="${pageContext.request.contextPath}/login.jsp">Login</a>
					<a href="${pageContext.request.contextPath}/register.jsp" id="Register">Register</a>
			<%
				}else  {
			%>
					<a href="${pageContext.request.contextPath}/profile.jsp">Profile</a>
					<a href="${pageContext.request.contextPath}/SignOut" id="signOut" >Sign Out</a>
			<%
				}
			%>
		</div>
	</div>
	
	
	<h1 style="color: white; font-family: timesnewroman; font-size: 300%; margin-top: 18%; margin-left:100px">BookWorm: Just a Mini Program... Happy Days!</h1>
	
	<form name="myform" method="GET" action ="searchResult" >
	
	<div id="error_msg">
		<%=request.getAttribute("error")!=null? request.getAttribute("error"):"" %>
	</div>
		
	<input type="text" name="searchbook" placeholder="Search for your favorite book!" style=" color: black; width: 1300px; height: 35px;margin-left:100px; font-size: 150%"/>
	<table style="margin-left:100px; color:white;width:80%;padding:20px">
 	<tr>
 	<td style="height: 32px; "><input type="radio" name="searchby" value="name"> Name</td>
 	<td style="height: 32px;"><input type="radio" name="searchby" value = "isbn"/> ISBN</td>
 	<tr>
 	<td><input type="radio" name="searchby" value = "author"/> Author</td>
 	<td><input type="radio" name="searchby" value = "publisher"/> Publisher</td>
 	</table>
 	<div id="SearchButton">
		<input type="submit" name="searchButton" value=Search! style=" color: white; font-size: 24px; background-color: Black; "/>
	</div>
	</form>

</body>
</html>
