<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.IOException, java.sql.Connection,
    java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet,
    java.sql.SQLException, java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile</title>
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
			text-align: center;
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
		table{
			margin-top:-8%;
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
		.bookimage{
			margin-top:8%;
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
		#type{
			font-size:20px;
			color: red;
			margin-left:2%;
		}
		#type:hover {
	     	color:gold; 
	     	text-decoration:none; 
	     	cursor:pointer;  
		}
		.info{
			font-size: 15px;
			position: relative;
			top:-180px;
			left:250px;
			margin-bottom: -100px;
			width:45%;
			color: grey;
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
			<a href="${pageContext.request.contextPath}/profile.jsp">
			<img src="profile_icon.png" width=10% style="margin-top:-50px; margin-left:600px;"></a>	
			<a href="${pageContext.request.contextPath}/SignOut" id="signOut" >Sign Out</a>
		</div>
		
	    </div>
	    <br><br>
	    <br><hr>
	    <%
			String username = (String)session.getAttribute("loggedInUser");
		%>
	   
	    <h1><%=username %> 's favorites:</h1><hr style="width:800px">
	     
	   	<table id="sqlresults">
				<%
					// get search history
					Connection conn = null;
					PreparedStatement ps = null;
					ResultSet rs = null;
					try {
						conn = DriverManager.getConnection("jdbc:mysql://google/);
						ps = conn.prepareStatement("SELECT f.isbn, f.timestamp FROM User u, Favorite f WHERE username=? AND u.userID=f.userID ORDER BY f.timestamp ASC;");
						ps.setString(1, username);
						rs = ps.executeQuery();
						
						ArrayList<String> isbn_data= new  ArrayList<String>();

						while(rs.next()){
							String book = rs.getString("isbn");
							isbn_data.add(book);
							
						}
						
						HttpSession session1=request.getSession();
						session1.setAttribute("isbn",isbn_data);
						
					} catch (SQLException sqle) {
						System.out.println("sqle: " + sqle.getMessage());
					} finally {
						try {
							if (rs!= null) {
								rs.close();
							}
							if (ps!= null) {
								ps.close();
							}
							if (conn!= null) {
								conn.close();
							}
						} catch (SQLException sqle) {
							System.out.println("sqle closing stuff: " + sqle.getMessage());
						}
					}
				%>
				
			</table>
			<div id="results"></div>
			
	<script>
		var bookISBN="a";
	
		//Search function
		function searchDatabase() {
			
			var search =<%=request.getSession().getAttribute("isbn")%>;
			var aisbn;
			console.log("test: " + aisbn);
			console.log(search.length);
			for(var i=0; i<1; i++){
				console.log(aisbn);
				aisbn = search[i];
				console.log("1");
				//Ajax and JSON
			    var xmlhttp1 = new XMLHttpRequest();
			    xmlhttp1.onreadystatechange = function() {
			        if (xmlhttp1.readyState == XMLHttpRequest.DONE)  {
			        	 console.log(xmlhttp1.responseURL);
			              var data1 = JSON.parse(xmlhttp1.responseText);
			           	  sessionStorage.setItem("results", xmlhttp1.responseText);
			              
			           	  if(search != "null") {
			            	  console.log(data1);
			            	  
			            	  for(i = 0; i < search.length; i++){
			      				var books = data1.items[i].volumeInfo;
			      				bookISBN=books.industryIdentifiers[0].identifier;
			      				document.getElementById("results").innerHTML += "<div><br>" + "<img span class=\"bookimage\" onclick=\"clickME(" + i + ")\" src=" + books.imageLinks.thumbnail + "\" >"
			      				+"<p span class=\"rating\">" + "<i div id=\"type\" onclick=\"remove()\" >&starf;Remove"  + "</>"+"</p>"
			      				+"<table class=\"info\">"+"<tr><td span class=\"title\">" +books.title + "</td><tr>"+"<tr><td span class=\"author\">" + books.authors + "</td><tr>"
			      					+"<tr><td span class=\"summary\">" + "<strong>Summary:</strong> " +books.description + "</td><tr>"+"<br>"+"</table>"+ "</div>";
			      					
			      			}  
			              }
			        }
			    };
			    
			    //Get data from google book api
			    xmlhttp1.open("GET", "https://www.googleapis.com/books/v1/volumes?q=+isbn:"+ aisbn, true);
			    xmlhttp1.send();
				console.log("the isbn " + i + " is " + aisbn);
			}	
		}
		
		searchDatabase();
		
		//function when user click on images
		function clickME(index) {
			sessionStorage.setItem("index", index);
			window.location.assign("Details.jsp");
		}
		
		function remove(){
			xhttp=new XMLHttpRequest();
			xhttp.open("GET", "Remove?isbn_=" +bookISBN,true);
			xhttp.send(); 
			location.reload();
			return true;
		}
	</script>			
</body>
</html>
