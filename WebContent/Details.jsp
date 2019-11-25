<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Details</title>
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
			height:6%;
			font-size:115%;
			position: fixed;
			top: 25%;
			left: 63%;
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
			top:-270px;
			left:350px;
			margin-bottom: -100px;
			width:50%;
			color: grey;
		}
		div{
			margin-left: 8%;
		}
		table{
			margin-top:-8%;
		}
		.bookimage{
			width:15%;
		}
		.title{
			font-size:30px;
			text-align: left;
		}
		.rating{
			font-size:20px;
			font-style: italic;
		}
		.author{
			font-size: 25px;
		}
		.publisher{
			font-size: 15px;
			font-weight: bold;
			font-style: italic;
		}
		.publishedDate{
			font-size: 15px;
			font-weight: bold;
			font-style: italic;
		}
		.isbn{
			font-size: 15px;
			font-weight: bold;
			font-style: italic;
		}
		.summary{
			font-size: 15px;
		}
		#signOut {
			position: relative;
    		text-decoration: none;
    		font-size: 20px; 
		}
		#Login {
			z-index: 150;
			position: fixed;
			top: 11%;
			left: 83%;
			font-size: 20px; 
			color:black;
		}
		#Register {
			z-index: 150;
			position: fixed;
			top: 15%;
			left: 83%;
			font-size: 20px; 
			color:black;
		}
		a:hover {
	     	color:grey; 
	     	text-decoration:none; 
	     	cursor:pointer;  
		}
		#type{
			font-size:20px;
			color: red;
			margin-left:10%;
		}
		#type:hover {
	     	color:gold; 
	     	text-decoration:none; 
	     	cursor:pointer;  
		}
		
	</style>
</head>

<body>
	<div id="title">
	 	<a href="${pageContext.request.contextPath}/HomePage.jsp">
	    <img src="bookworm.png" width=13% style="margin-top: 20px; margin-left:100px;"></a>
	</div>
	
	<div id="topSearch">
	
	<form name="myform" method="GET" action="SearchResult.jsp" onsubmit="searchDatabase()">
	      <input type="text" name="searchbook" class="searchBox" placeholder="What book is on your mind?" 
	style=" color: black; width: 300px; height: 35px;margin-left:-50px;  font-size: 100%">  
	
	      <button type="submit"><img src="magnifying_glass.png" alt="Submit" style="width: 32px "></button>
	      <table id="searchCategory">
	       <tr>
	      <td> <input type="radio" name="searchby" value="name"> Name </td>
	      <td> <input type="radio" name="searchby" value="isbn"> ISBN </td>
	      </tr>
	      <tr>
	      <td> <input type="radio" name="searchby" value="author"> Author  </td>
	      <td> <input type="radio" name="searchby" value="publisher"> Publisher </td>
	      </tr>
	      </table>
	    </form>
	    <div id="status">
			<% 
				if(session.getAttribute("loggedIn") == null){
			%>
					<a href="${pageContext.request.contextPath}/login.jsp" id="Login">Login </a>
					<a href="${pageContext.request.contextPath}/register.jsp" id="Register">Register</a>
			<%
				}else  {
			%>		
					<a href="${pageContext.request.contextPath}/profile.jsp">
					<img src="profile_icon.png" width=10% style="margin-top:-50px; margin-left:600px;"></a>
					<a href="${pageContext.request.contextPath}/SignOut" id="signOut" >Sign Out</a>
			<%
				}
			%>
		</div>
		
	    </div>
	    <br><br>
	   
	    <div id="results"></div>
	    
	<script>
	var bookISBN="a";
	var type = "Favorite";
	var added = false;

	function toFavorite(){
		var xhttp=new XMLHttpRequest();
		xhttp.open("GET", "Favourite?isbn_=" +bookISBN,true);
		xhttp.send(); 
		
	}
	function remove(){
		xhttp=new XMLHttpRequest();
		xhttp.open("GET", "Remove?isbn_=" +bookISBN,true);
		xhttp.send(); 
		console.log("4"+added);
	}
	function validate(){
		var login = <%= session.getAttribute("loggedIn") %>;
		if(login == null){
			document.getElementById("error").innerHTML = "You have to be logged in";
		}
		else{
			if(added == false){
				toFavorite();
				added = true;
				type = "Remove";
				document.getElementById('type').innerHTML = "&starf;Remove";
				
			}
			else{ 
				added = false;
				type = "Favorite";
				
				document.getElementById('type').innerHTML = "&starf;Favourite";
				remove();
			}
		}	
	}

	
	window.addEventListener('load', function() {
		var searchBook = "<%= request.getParameter("searchbook") %>";
			
		//index store from previous search
		var index = sessionStorage.getItem("index");
		console.log(index);
		//search history
		var his= localStorage.getItem("hist");
		
		var xmlhttp = new XMLHttpRequest();
		    
	    xmlhttp.onreadystatechange = function() {
			if (xmlhttp.readyState == XMLHttpRequest.DONE)  {
				/* var resultss = sessionStorage.getItem("results"); */
		        //print book
		     	var data = JSON.parse(xmlhttp.responseText);
				
		        console.log(data);
		        book = data.items[index].volumeInfo;
		  
		        bookISBN=book.industryIdentifiers[0].identifier;
		       
					document.getElementById("results").innerHTML += "<hr><div><br>" + "<img class=\"bookimage\" src=" + book.imageLinks.thumbnail + "\" >"
								 +"<p span class=\"rating\">"+"Rating: "+book.averageRating;
			
					document.getElementById("results").innerHTML +=	"<i div id=\"type\" onclick=\"validate()\" >&starf;" + type + "</>"+ "<div id=\"error\">"+"</p>"
							
					document.getElementById("results").innerHTML +="<table class=\"info\">" +"<th span class=\"title\">" +book.title + "</th>"
								 +"<tr><td span class=\"author\">" +"Author: " + book.authors + "</td><tr>"
								 +"<tr><td span class=\"publisher\">" +"Publisher: " + book.publisher + "</td><tr>"+"<tr><td span class=\"publishedDate\">" +"Published Date: " + book.publishedDate + "</td><tr>"
								 +"<tr><td span class=\"isbn\">" +"ISBN: " + book.industryIdentifiers[0].identifier + "</td><tr>"
								 +"<tr><td span class=\"summary\">" + "<strong>Summary:</strong> " +book.description + "</td><tr><br></table></div>"; 
		        
		    }
		};
				xmlhttp.open("GET", "https://www.googleapis.com/books/v1/volumes?q=" + his, true);
				xmlhttp.send();
				    
	},false);		
	
	</script>
			 
</body>
</html>
