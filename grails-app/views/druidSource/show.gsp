

<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'druidSource.label', default: 'DruidSource')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-druidSource" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-druidSource" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list druidSource">
			
				<g:if test="${druidSourceInstance?.tableName}">
				<li class="fieldcontain">
					<span id="tableName-label" class="property-label"><g:message code="druidSource.tableName.label" default="Table Name" /></span>
					
						<span class="property-value" aria-labelledby="tableName-label"><g:fieldValue bean="${druidSourceInstance}" field="tableName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${druidSourceInstance?.brokerHost}">
				<li class="fieldcontain">
					<span id="brokerHost-label" class="property-label"><g:message code="druidSource.brokerHost.label" default="Broker Host" /></span>
					
						<span class="property-value" aria-labelledby="brokerHost-label"><g:fieldValue bean="${druidSourceInstance}" field="brokerHost"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${druidSourceInstance?.brokerPort}">
				<li class="fieldcontain">
					<span id="brokerPort-label" class="property-label"><g:message code="druidSource.brokerPort.label" default="Broker Port" /></span>
					
						<span class="property-value" aria-labelledby="brokerPort-label"><g:fieldValue bean="${druidSourceInstance}" field="brokerPort"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${druidSourceInstance?.timeZone}">
				<li class="fieldcontain">
					<span id="timeZone-label" class="property-label"><g:message code="druidSource.timeZone.label" default="Time Zone" /></span>
					
						<span class="property-value" aria-labelledby="timeZone-label"><g:fieldValue bean="${druidSourceInstance}" field="timeZone"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${druidSourceInstance?.dimensionList}">
				<li class="fieldcontain">
					<span id="dimensionList-label" class="property-label"><g:message code="druidSource.dimensionList.label" default="Dimension List" /></span>
					
						<span class="property-value" aria-labelledby="dimensionList-label"><g:fieldValue bean="${druidSourceInstance}" field="dimensionList"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${druidSourceInstance?.metricList}">
				<li class="fieldcontain">
					<span id="metricList-label" class="property-label"><g:message code="druidSource.metricList.label" default="Metric List" /></span>
					
						<span class="property-value" aria-labelledby="metricList-label"><g:fieldValue bean="${druidSourceInstance}" field="metricList"/></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${druidSourceInstance?.id}" />
					<g:link class="edit" action="edit" id="${druidSourceInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
