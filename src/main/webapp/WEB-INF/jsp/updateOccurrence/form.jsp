<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib tagdir="/WEB-INF/tags" prefix="cejug"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title><fmt:message key="updateOccurrence.form" /></title>
</head>

<body>

	<div class="page-header">
		<h1>
			<small><fmt:message key='updateOccurrence.form' /></small>
		</h1>
	</div>

	<c:if test="${message != null}">
		<div class="alert alert-success">
			<c:out value="${message}" />
		</div>
	</c:if>
	<c:if test="${errorMessage != null}">
        <div class="alert alert-danger">
            <c:out value="${errorMessage}" />
        </div>
    </c:if>

	<div style="width: 100%;" class="container-fluid">
		<form class="form-horizontal" role="form"
			action="${linkTo[UpdateOccurrenceController].processForm( occurrence.id )}"
			method="post">
			<input type="hidden" name="occurrence.id" value="${occurrence.id}">
			<div class="row">
				<div class="col-md-6">
					<div
						class="form-group ${errors['occurrence.sector'] != null ? 'has-error' : ''}">
						<label for="occurrence.sector"> <fmt:message
								key="occurrence.sector" /> <cejug:errorMessage
								name="occurrence.sector" errorsMap="${errors}" />
						</label> <select name="occurrence.sector.id" id="occurrence.sector"
							class="form-control input-sm">
							<c:forEach items="${sectors}" var="sector">
								<option value="${sector.id}"
									${occurrence.sector == sector ? 'selected="selected"' : '' }>${sector.name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="col-md-6">
					<div
						class="form-group  ${errors['occurrence.problemType'] != null ? 'has-error' : ''}">
						<label for="occurrence.problemType"> <fmt:message
								key="occurrence.problemType" /> <cejug:errorMessage
								name="occurrence.problemType" errorsMap="${errors}" />
						</label>
						<select name="occurrence.problemType.id"
							id="occurrence.problemType" class="form-control input-sm">
							<c:forEach items="${problemTypes}" var="type">
								<option value="${type.id}"
									${occurrence.problemType == type ? 'selected="selected"' : '' }>${type.name}</option>
							</c:forEach>
						</select>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-md-6">
					<cejug:textFieldVertical name="occurrence.serialId" readonly="true"
						value="${occurrence.serialId}" errorsMap="${errors}" />
				</div>
				<div class="col-md-6">
					<div
						class="form-group ${errors['occurrence.occurrenceState'] != null ? 'has-error' : ''}">
						<label for="occurrence.occurrenceState"> <fmt:message
								key="occurrence.occurrenceState" /> <cejug:errorMessage
								name="occurrence.occurrenceState" errorsMap="${errors}" />
						</label> <select name="occurrence.occurrenceState.id"
							id="occurrence.occurrenceState" class="form-control input-sm">
							<c:forEach items="${occurrenceStates}" var="state">
								<option value="${state.id}"
									${occurrence.occurrenceState == state ? 'selected="selected"' : '' }>${state.name}</option>
							</c:forEach>
						</select>
					</div>

				</div>
			</div>

			<div class="row">
				<div class="col-md-12 ">
					<div
						class="form-group ${errors['occurrence.description'] != null ? 'has-error' : ''}">
						<label for="occurrence.description"> <fmt:message
								key="occurrence.description" /> <cejug:errorMessage
								name="occurrence.description" errorsMap="${errors}" />
						</label>
						<textarea class="form-control" rows="3" readonly="readonly"
							name="occurrence.description" id="occurrence.description">${occurrence.description}</textarea>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-md-12 ">
				    <h3><fmt:message key="updateOccurrence.updates" /></h3>
					<c:forEach items="${occurrence.updates}" var="occurrenceUpdate">
						<blockquote>
                            <c:forEach items="${occurrenceUpdate.updatedFields}" var="fieldUpdate">
                              <b><fmt:message key="occurrence.${fieldUpdate.fieldName}" />: ${fieldUpdate.oldValue} -> ${fieldUpdate.newValue}</b>
                            </c:forEach> 
                            <p>${occurrenceUpdate.updateNote}</p>
                            <footer><fmt:formatDate value="${occurrenceUpdate.updateDate}" type="both" />
                                 - <fmt:message key="occurrenceUpdate.madeBy" />: ${occurrenceUpdate.user.name}</footer>
                        </blockquote>
					</c:forEach>
				</div>
			</div>

			<div class="row">
				<div class="col-md-12 ">
					<div class="panel panel-default">
						<div class="panel-heading"><fmt:message key="occurrenceUpdate.updateNote" /></div>
						<div class="panel-body">
							<textarea class="form-control" rows="3" name="updateNote"
								id="updateNote"></textarea>
						</div>
					</div>
				</div>
			</div>

			<div class="form-group">
				<button type="submit" class="btn btn-default btn-sm">
					<fmt:message key="form.save" />
				</button>
				<a href="${linkTo[ListOccurrenceController].list()}" class="btn btn-danger btn-sm"> <fmt:message
						key="form.cancel" />
				</a>
			</div>
		</form>
	</div>

</body>
</html>