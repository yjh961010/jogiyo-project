<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="../header.jsp" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f4f4;
        margin: 0;
        padding: 0;
    }

    .contain {
        width: 80%;
        margin: 20px auto;
        padding: 20px;
        background-color: #fff;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        border-radius: 8px;
    }

    .table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
        text-align: center;
    }

    .table, .table th, .table td {
        border: 1px solid #ddd;
    }

    .table th, .table td {
        padding: 12px;
        text-align: left;
    }

    .table th {
        background-color: #f2f2f2;
    }

    .table tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    .table tr:hover {
        background-color: #f1f1f1;
    }

       .link {
        color: #fa0050;
        text-decoration: none;
        position: relative;
    }

    .link::after {
        content: '';
        position: absolute;
        width: 100%;
        transform: scaleX(0);
        height: 2px;
        bottom: 0;
        left: 0;
        background-color: #007bff;
        transform-origin: bottom right;
        transition: transform 0.25s ease-out;
    }

    .link:hover::after {
        transform: scaleX(1);
        transform-origin: bottom left;
    }

    .link:hover {
        color: #d50032;
    }
    .title {
        margin-top: 0;
    }
</style>

<div class="contain">
    <table class="table">
        <tr>
            <th>가게이름</th>
            <th>메뉴이름</th>
            <th>주문상태</th>
        </tr>
        <c:forEach items="${dlist}" var="de">
        <tr>
            <td><a class="link" href="${pageContext.request.contextPath}/customer/viewDelivery.do?deliveryid=${de.deliveryid}">${de.storename}</a></td>
            <td>${de.menuname}</td>
            <td>
                <c:choose>
                    <c:when test="${de.run eq 0}">
                        음식조리중
                    </c:when>
                    <c:when test="${de.run eq 1}">
                        음식배달중
                    </c:when>
                    <c:when test="${de.run eq 2}">
                        배달완료
                    </c:when>
                </c:choose>
            </td>
        </tr>
        </c:forEach>
    </table>
</div>

<jsp:include page="../footer.jsp" />
