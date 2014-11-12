

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'druidSource.label', default: 'DruidSource')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-druidSource" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-druidSource" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="tableName" title="${message(code: 'druidSource.tableName.label', default: 'Table Name')}" />
					
						<g:sortableColumn property="brokerHost" title="${message(code: 'druidSource.brokerHost.label', default: 'Broker Host')}" />
					
						<g:sortableColumn property="brokerPort" title="${message(code: 'druidSource.brokerPort.label', default: 'Broker Port')}" />
					
						<g:sortableColumn property="timeZone" title="${message(code: 'druidSource.timeZone.label', default: 'Time Zone')}" />
					
						<g:sortableColumn property="dimensionList" title="${message(code: 'druidSource.dimensionList.label', default: 'Dimension List')}" />
					
						<g:sortableColumn property="metricList" title="${message(code: 'druidSource.metricList.label', default: 'Metric List')}" />
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${druidSourceInstanceList}" status="i" var="druidSourceInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${druidSourceInstance.id}">${fieldValue(bean: druidSourceInstance, field: "tableName")}</g:link></td>
					
						<td>${fieldValue(bean: druidSourceInstance, field: "brokerHost")}</td>
					
						<td>${fieldValue(bean: druidSourceInstance, field: "brokerPort")}</td>
					
						<td>${fieldValue(bean: druidSourceInstance, field: "timeZone")}</td>
					
						<td>${fieldValue(bean: druidSourceInstance, field: "dimensionList")}</td>
					
						<td>${fieldValue(bean: druidSourceInstance, field: "metricList")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${druidSourceInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
