
<%@page import="java.util.List"%>
<%@page import="sun.security.krb5.internal.PAEncTSEnc"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="exam.jdbc.ClubVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="exam.jdbc.JDBC_clubDAO"%>
<%@page import="Student.StudentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.sql.DriverManager,
                   java.sql.Connection,
                   java.sql.Statement,
                   java.sql.ResultSet,
                   java.sql.SQLException,
                   java.util.Arrays"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=1200">
<title>한림대학교 동아리 조회</title>
<link rel="stylesheet" type="text/css" href="css/common.css">
<link rel="stylesheet" type="text/css" href="css/search.css">
</head>

<body>

	<%
		String username = null;
		if (session.getAttribute("username") != null) {
			username = (String) session.getAttribute("username");
		}
	%>

	<%
		request.setCharacterEncoding("UTF-8");
		String club_gb_cd = ""; //클럽 구분(중앙,과)
		String club_at_cd = ""; //클럽 속성(학술,운동)
		String search = "";
		int pageNumber = 1; //현재 페이지 번호

		if (request.getParameter("club_gb_cd") != null) {
			club_gb_cd = request.getParameter("club_gb_cd");
		}
		if (request.getParameter("club_at_cd") != null) {
			club_at_cd = request.getParameter("club_at_cd");
		}
		if (request.getParameter("search") != null) {
			search = request.getParameter("search");
		}
		if (request.getParameter("pageNumber") != null) {
			try {
				pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
			} catch (Exception e) {
				System.out.println("검색 페이지 번호 오류");
			}
		}
	%>

	<%
		String title = "";
		if (club_at_cd.equals("002001")) {
			title = "학술 동아리";
		} else if (club_at_cd.equals("002002")) {
			title = "운동 동아리";
		} else if (club_at_cd.equals("002003")) {
			title = "봉사 동아리";
		} else if (club_at_cd.equals("002004")) {
			title = "문화 동아리";
		} else if (club_at_cd.equals("002005")) {
			title = "종교 동아리";
		} else if (club_at_cd.equals("002006")) {
			title = "기타 동아리";
		} else {
			title = "전체 동아리";
		}
	%>
	<div id="wrap">
		<div id="header">
			<h1>
				<a href="index.jsp"><img src="image/logo.gif" alt="한림대학교 동아리"></a>
			</h1>
			<a href="#content" class="skip">본문 바로가기</a>

			<ul id="snb">
				<li><a href="index.html">로그인</a></li>
				<li><a href="index.html">회원가입</a></li>
			</ul>

			<ul id="gnb">
				<li><a href="club_search.jsp">동아리조회</a></li>
				<li><a href="top_club.jsp">우수동아리</a></li>
				<li><a href="board.jsp">공지사항</a></li>
				<li><a href="jido.jsp">주변음식점</a></li>
			</ul>
		</div>

		<div class="category">
			<form method="get" action="club_search.jsp">

				<ul>
					<li class="title"><%=title%></li>
					<li><select class="club_gb" name="club_gb_cd"
						onchange="this.form.submit();">
							<option value="">전체</option>
							<option value="001001"
								<%if (club_gb_cd.equals("001001"))
				out.println("selected");%>>중앙
								동아리</option>
							<option value="001002"
								<%if (club_gb_cd.equals("001002"))
				out.println("selected");%>>과
								동아리</option>
					</select></li>
					<li><input type="text" id="search" name="search" size="30"
						value="<%=search%>" onfocus="this.select()">
						<button type="submit" class="category-btn">검색</button></li>

				</ul>

				<ul>
					<li><button name="club_at_cd" onclick="this.form.submit()"
							value="">전체</button></li>
					<li><button name="club_at_cd" onclick="this.form.submit()"
							value="002001">학술</button></li>
					<li><button name="club_at_cd" onclick="this.form.submit()"
							value="002002">운동</button></li>
					<li><button name="club_at_cd" onclick="this.form.submit()"
							value="002003">봉사</button></li>
					<li><button name="club_at_cd" onclick="this.form.submit()"
							value="002004">문화</button></li>
					<li><button name="club_at_cd" onclick="this.form.submit()"
							value="002005">종교</button></li>
					<li><button name="club_at_cd" onclick="this.form.submit()"
							value="002006">기타</button></li>
				</ul>
			</form>
		</div>
		<hr>

		<div id="content">
			<div class="result">
				<h4>검색결과가 없습니다.</h4>
			</div>

			<%
				for (int i = 0; i < 2; i++) {
			%>
			<div class="latest">
				<div class="logo">
					<img class="img" src="image/poster/c8.jpg"
						onerror="this.src='image/error.png'"></img>
				</div>
				<div class="tbl-info">
					<h3>동아리 이름</h3>
					<div class="star">
						<input name="submit" type="image" src="image/star0.png" width="23"
							height="23"> &nbsp; 3
					</div>
					<table class="tbl">
						<tr>
							<th>회원수</th>
							<td>46명</td>
							<th>결성년도</th>
							<td>2011.04.09</td>
						</tr>
						<tr>
							<th>회장</th>
							<td>박태언</td>
							<th>지도교수</th>
							<td>이원철</td>
						</tr>
						<tr>
							<th>설립 목적</th>
							<td colspan="3">창업, 특허출원과 공모전참여를 통한
								목표달성33333333333333333333333333333333333333333333333333333333333333333333333333</td>
						</tr>
						<tr>
							<th>주요 활동</th>
							<td colspan="3">창업 동아리</td>
						</tr>
					</table>
				</div>
				<ul>
					<li><button class="tbl-btn">가입신청</button></li>
					<li><button class="tbl-btn">더보기</button></li>
					<li><button class="tbl-btn">동아리 포스터</button></li>
				</ul>
			</div>
			<%
				}
			%>
			<div id="page">
				<a href="#">1</a> 
				<a href="#">2</a> 
				<a href="#">3</a>
			</div>
		</div>
		<hr>
		<div id="footer">
			<div class="copyright">
				<address>Copyright 2019. 김정인, 김진섭. All Rights Reserved.</address>
			</div>
		</div>
		
	</div>
</body>
</html>