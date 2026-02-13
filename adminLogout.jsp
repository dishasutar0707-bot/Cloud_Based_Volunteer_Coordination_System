<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Invalidate the session to logout
    session.invalidate();

    // Redirect to admin login page
    response.sendRedirect("adminLogin.jsp");
%>
