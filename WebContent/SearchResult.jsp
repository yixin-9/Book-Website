<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Results</title>
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
			width:20%;
			position: fixed;
			top: 10%;
			left: 63%;
			color:grey;
			height:6%;
			font-size:115%;
			
		}
		body{
			background-color: white;
		}
		h1 {
			font-size: 45px;
			top: 20%;
			left: 10%;
			margin-left:10%;
			color: dark grey;
			text-shadow: 2px 2px 5px grey;
		}
		.info{
			font-size: 15px;
			position: relative;
			top:-150px;
			left:300px;
			margin-bottom: -100px;
			width:45%;
			color: grey;
		}
		div{
			margin-left: 8%;
		
		}
		#signOut {
			position: relative;
    		text-decoration: none;
    		font-size: 20px; 
		}
		a:hover {
	     	color:grey; 
	     	text-decoration:none; 
	     	cursor:pointer;  
		}
		.title{
			font-size:25px;
		}
		.author{
			font-size: 15px;
		}
		.summary{
			font-size: 15px;
		}
	</style>
</head>
	<script>
		//Search function
		function searchDatabase() {
			var search = "<%= request.getParameter("searchbook") %>"
			var searchby = "<%= request.getParameter("searchby") %>"
			
			//search by either name, isbn, author or publisher.
				if(searchby == "name") {
				}else if(searchby == "author") {
					search = "+author:" + search;
				}else if(searchby == "isbn"){
					search = "+isbn:" + search;
				}else if(searchby == "publisher") {
					search = "+publisher:" + search;
				}
			
			// search history variable
			localStorage.setItem("hist", search);
			//Ajax and JSON
		    var xmlhttp = new XMLHttpRequest();
		    xmlhttp.onreadystatechange = function() {
		        if (xmlhttp.readyState == XMLHttpRequest.DONE)  {
		              var data = JSON.parse(xmlhttp.responseText);
		           	  sessionStorage.setItem("results", xmlhttp.responseText);
		              if(search != "null") {
		            	  print(data);
		            	  console.log(data);
		              }
		        }
		    };
		    
		    //Get data from google book api
		    xmlhttp.open("GET", "https://www.googleapis.com/books/v1/volumes?q=" + search, true);
		    xmlhttp.send();
		    
		}
		
		searchDatabase();
		
		//print 10 search books data
		
		function print(data) {
			var i;
			for(i = 0; i < data.items.length; i++){
				var books = data.items[i].volumeInfo;
				document.getElementById("results").innerHTML += "<table class=\"info\">"+"<hr><div><br>" + "<img onclick=\"clickME(" + i + ")\" src=" + books.imageLinks.thumbnail + "\" >"
					 +"<tr><td span class=\"title\">" +books.title + "</td><tr>"+"<tr><td span class=\"author\">" + books.authors + "</td><tr>"
					+"<tr><td span class=\"summary\">" + "<strong>Summary:</strong> " +books.description + "</td><tr>"+"<br>"+"</table>"+ "</div>";
			}
		}
		
		//function when user click on images
		function clickME(index) {
			sessionStorage.setItem("index", index);
			window.location.assign("Details.jsp");
		}
	</script>
	
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
	    <div id="status">
			<% 
				if(session.getAttribute("loggedIn") != null){
			%>
					<a href="${pageContext.request.contextPath}/profile.jsp">
					<img src="profile_icon.png" width=10% style="margin-top:-50px; margin-left:600px;"></a>
					<a href="${pageContext.request.contextPath}/SignOut" id="signOut" >Sign Out</a>
			<%
				}
			%>
		</div>
	    </div>
	    <br><hr>
	    
	   
	    <h1>Results for "<%= request.getParameter("searchbook") %>" </h1>
	   
	    <div id="results"></div>
</body>
</html>
