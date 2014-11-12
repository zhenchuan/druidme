



<div class="fieldcontain ${hasErrors(bean: druidSourceInstance, field: 'tableName', 'error')} required">
	<label for="tableName">
		<g:message code="druidSource.tableName.label" default="Table Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="tableName" required="" value="${druidSourceInstance?.tableName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: druidSourceInstance, field: 'brokerHost', 'error')} required">
	<label for="brokerHost">
		<g:message code="druidSource.brokerHost.label" default="Broker Host" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="brokerHost" required="" value="${druidSourceInstance?.brokerHost}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: druidSourceInstance, field: 'brokerPort', 'error')} required">
	<label for="brokerPort">
		<g:message code="druidSource.brokerPort.label" default="Broker Port" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="brokerPort" type="number" value="${druidSourceInstance.brokerPort}" required=""/>
</div>

<div class="fieldcontain ${hasErrors(bean: druidSourceInstance, field: 'timeZone', 'error')} required">
	<label for="timeZone">
		<g:message code="druidSource.timeZone.label" default="Time Zone" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="timeZone" required="" value="${druidSourceInstance?.timeZone}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: druidSourceInstance, field: 'dimensionList', 'error')} required">
	<label for="dimensionList">
		<g:message code="druidSource.dimensionList.label" default="Dimension List" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="dimensionList" cols="40" rows="5" maxlength="256" required="" value="${druidSourceInstance?.dimensionList}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: druidSourceInstance, field: 'metricList', 'error')} required">
	<label for="metricList">
		<g:message code="druidSource.metricList.label" default="Metric List" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="metricList" cols="40" rows="5" maxlength="256" required="" value="${druidSourceInstance?.metricList}"/>
</div>

