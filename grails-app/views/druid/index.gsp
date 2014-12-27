<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="zh-cn" style="background: none">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Druid">
    <title>search</title>

    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <link href="${resource(dir: "asset/css", file: "bootstrap.css")}" rel="stylesheet">
    <link href="${resource(dir: "asset/css", file: "carousel.css")}" rel="stylesheet">
    <link href="${resource(dir: "asset/css", file: "echartsHome.css")}" rel="stylesheet">
    <link rel="stylesheet" href="http://cdn.jsdelivr.net/select2/3.2/select2.css">

    <script src="http://echarts.baidu.com/doc/asset/js/jquery.min.js"></script>

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
    <style>
    ul li {
        list-style-type: none;
    }
    </style>
</head>

<body>
<!-- Fixed navbar -->
<div class="navbar navbar-default navbar-fixed-top" role="navigation" id="head">
    <div class="container">
        <div class="navbar-header"><a class="navbar-brand" href="${createLink(uri: '/')}" target="">&nbsp;</a></div>
        <div class="navbar-collapse collapse" id="nav-wrap">
            <ul class="nav navbar-nav navbar-right" id="nav" style="max-width:100%;"></ul>
        </div><!--/.nav-collapse -->
    </div>
</div>

<div class="container-fluid">
    <div class="row-fluid">
        <div class="col-md-3" >
            <g:form action="query" method="post" class="form-search" role="search">
                <g:hiddenField name="id" value="${druidSource?.id}"/>
                <div class=" panel" id="accordion" style="float:left;">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <div class="accordion-toggle" data-toggle="" data-parent="#accordion"
                                 href="#collapse-description">
                                <strong>Type</strong>
                            </div>
                        </div>

                        <div id="collapse-description" class="panel-collapse">
                            <div class="panel-body">
                                <div id="toc">
                                    <select name="queryType" class="form-control" id="queryType">
                                        <option value="TopN">TopN</option>
                                        <option value="GroupBy">GroupBy</option>
                                        <option value="Timeseries">Timeseries</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <div class="accordion-toggle" data-toggle="" data-parent="#accordion"
                                 href="#collapse-config">
                                <strong>Options</strong>
                            </div>
                        </div>

                        <div id="collapse-config" class="panel-collapse">
                            <div class="panel-body">
                                <div id="config">
                                    <ul>
                                        <li>
                                            Interval :
                                            <ul>
                                                <li>
                                                    <input type="text" class="" name="start" value="${params.start}" style="width: 96px" onFocus="WdatePicker({startDate:'%y-%MM-%dd 00:00:00',dateFmt:'yyyy-MM-ddTHH:mm',alwaysUseStartDate:true})">
                                                    --
                                                    <input type="text" class="" name="end" value="${params.end}" style="width: 96px;" onFocus="WdatePicker({startDate:'%y-%MM-%dd 00:00:00',dateFmt:'yyyy-MM-ddTHH:mm',alwaysUseStartDate:true})">
                                                </li>
                                            </ul>
                                        </li>
                                        <li>
                                            Granularity
                                            <ul>
                                                <li>
                                                    <div class="input-append">
                                                        <select name="granularity" class="" id="granularity">
                                                            <option value='hour'>hour</option>
                                                            <option value='P1D'>day</option>
                                                            <option value="minute">minute</option>
                                                            <option value='all'>all</option>
                                                        </select>
                                                    </div>
                                                </li>
                                            </ul>
                                        </li>

                                        <li>
                                            Filter
                                            <ul>
                                                <li>
                                                    <g:select name="filterName" from="${druidSource?.dimensionList?.split(",")}" value="${params.filterName}">
                                                    </g:select>
                                                    <select name="filterOperation">
                                                        <option value="eq">eq</option>
                                                    </select>
                                                    <input name="filterValue" value="${params.filterValue}" style="width: 88px"/>
                                                </li>
                                            </ul>
                                        </li>
                                        <li>
                                            Dimension
                                            <ul>
                                                <li>
                                                    <input type="text" style="width:200px" class="" name="dimensions" value="${params.dimensions}" id="dimension">
                                                </li>
                                            </ul>
                                        </li>
                                        <li>
                                            Aggregation
                                            <ul>
                                                <li>
                                                    <ul>
                                                        <li>
                                                            <select name="aggregationType" class="">
                                                                <option value="longSum">longSum</option>
                                                                <option value="count">count</option>
                                                                <option value="doubleSum">doubleSum</option>
                                                                <option value="min">min</option>
                                                                <option value="max">max</option>
                                                            </select>
                                                        </li>
                                                        <li>
                                                            <input type="text" class="metrics"  style="width: 160px"
                                                                   name="aggregationColumn" value="${params.aggregationColumn}">
                                                        </li>
                                                    </ul>
                                                </li>
                                            </ul>
                                        </li>
                                        <li style="display: none;">
                                            PostAggregation
                                        </li>

                                        <li style="display: none;">
                                            Having
                                        </li>
                                        <li>
                                            Order By
                                            <ul>
                                                <li>
                                                    <input type="text" style="width:100px" class="" name="orderByColumn" value="${params.orderByColumn}">
                                                    <g:select name="orderByDirection" from="['ASC','DESC']" value="${params.orderByDirection}"/>
                                                </li>
                                            </ul>
                                        </li>
                                        <li style="">
                                            Limit
                                            <ul>
                                                <li>
                                                    <input type="text" style="width:100px" class="" name="limit" value="${params.limit}">
                                                </li>
                                            </ul>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>


                    <div id="operation">
                        <button type="submit" class="btn btn-info" style="float: right">Search</button>
                    </div>
                </div><!--/.well -->
            </g:form>

        </div>

        <div class="col-md-9">
            <p style="margin:20px">
                Time Used : ${flash.timeUsed} ms.
            </p>

            <div id="doc">

                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th>#</th>
                        <g:each in="${columns}" var="item">
                            <th>${item}</th>
                        </g:each>
                    </tr>
                    </thead>
                    <tbody>
                        <g:each in="${results}" var="item" status="var">
                            <tr>
                            <td>${var+1}</td>
                                <g:each in="${columns}" var="col">
                                    <g:set var="val" value="${item.get(col)}"/>
                                    <g:if test="${col == 'timestamp'}">
                                       <td>${new org.joda.time.DateTime(val)}</td>
                                    </g:if>
                                    <g:else>
                                        <td>${val}</td>
                                    </g:else>
                                </g:each>
                            </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>


            <g:if test="${flash.message}">
                <div class="alert alert-danger" role="alert">
                    ${flash.message}
                </div>
            </g:if>


        </div>
    </div><!--/.fluid-container-->
</div>
<!-- FOOTER -->
<footer id="footer"></footer>

<script src="http://echarts.baidu.com/doc/asset/js/bootstrap.min.js"></script>

<script language="javascript" type="text/javascript" src="${resource(dir: "js/My97DatePicker", file: "WdatePicker.js")}"></script>
<script type="text/javascript" src="${resource(dir: "asset/js", file: "echartsHome.js")}"></script>
<script src="http://cdn.jsdelivr.net/select2/3.2/select2.min.js"></script>

<script type="text/javascript">
    $("#granularity").val("${params.granularity?params.granularity:'hour'}");
    $("#queryType").val("${params.queryType?params.queryType:'TopN'}");
</script>

<script type="text/javascript">
    var str = "${druidSource?.dimensionList}" ;
    var list = str.split(",");
    $("#dimension").select2({
        tags:list,
        tokenSeparators: [",", " "]
    });

    var metrics = "${druidSource?.metricList}";
    var metricList = metrics.split(",");
    $(".metrics").select2({
        tags:metricList,
        tokenSeparators: [",", " "]
    });
</script>
</body>
</html>

