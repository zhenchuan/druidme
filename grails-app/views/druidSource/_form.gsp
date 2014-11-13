



<div class="fieldcontain ${hasErrors(bean: druidSourceInstance, field: 'tableName', 'error')} required">
	<label for="tableName">
		<g:message code="druidSource.tableName.label" default="Table Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="tableName" required="" value="${druidSourceInstance?.tableName}" placeholder="testDataSourcName"/>
</div>

<div class="fieldcontain ${hasErrors(bean: druidSourceInstance, field: 'brokerHost', 'error')} required">
	<label for="brokerHost">
		<g:message code="druidSource.brokerHost.label" default="Broker Host" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="brokerHost" required="" value="${druidSourceInstance?.brokerHost}" placeholder="192.168.144.119"/>
</div>

<div class="fieldcontain ${hasErrors(bean: druidSourceInstance, field: 'brokerPort', 'error')} required">
	<label for="brokerPort">
		<g:message code="druidSource.brokerPort.label" default="Broker Port" />
		<span class="required-indicator">*</span>
	</label>
	<g:field name="brokerPort" type="number" value="${druidSourceInstance.brokerPort}" required="" />
</div>

<div class="fieldcontain ${hasErrors(bean: druidSourceInstance, field: 'timeZone', 'error')} required">
	<label for="timeZone">
		<g:message code="druidSource.timeZone.label" default="Time Zone" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="timeZone" required="" value="${druidSourceInstance?.timeZone}" placeholder="Asia/Shanghai"/>
</div>

<div class="fieldcontain ${hasErrors(bean: druidSourceInstance, field: 'dimensionList', 'error')} required">
	<label for="dimensionList">
		<g:message code="druidSource.dimensionList.label" default="Dimension List" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="dimensionList" cols="40" rows="5" maxlength="256" required="" value="${druidSourceInstance?.dimensionList}" placeholder="dim1,dim2,dim3,dim4"/>
</div>

<div class="fieldcontain ${hasErrors(bean: druidSourceInstance, field: 'metricList', 'error')} required">
	<label for="metricList">
		<g:message code="druidSource.metricList.label" default="Metric List" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="metricList" cols="40" rows="5" maxlength="256" required="" value="${druidSourceInstance?.metricList}" placeholder="metric1,metric2,metric3"/>
</div>

