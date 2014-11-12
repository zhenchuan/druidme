import com.google.common.collect.Lists
import com.google.common.collect.Maps
import com.yahoo.sql4d.query.Pair
import com.yahoo.sql4d.query.QueryMeta
import com.yahoo.sql4d.query.groupby.GroupByQueryMeta
import com.yahoo.sql4d.query.groupby.LimitSpec
import com.yahoo.sql4d.query.nodes.AggItem
import com.yahoo.sql4d.query.nodes.Filter
import com.yahoo.sql4d.query.nodes.Granularity
import com.yahoo.sql4d.query.nodes.Interval
import com.yahoo.sql4d.query.timeseries.TimeSeriesQueryMeta
import com.yahoo.sql4d.query.topn.TopNQueryMeta
import com.yahoo.sql4d.sql4ddriver.Mapper4All
import me.zhenchuan.druid.DruidConnection
import scala.util.Either

class DruidController {

    def index() {
        long id = params.long("id",-1l)
        DruidSource druidSource = DruidSource.get(id)
        if(druidSource==null){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'druidSource.label', default: 'DruidSource'), id])
            return
        }
        [druidSource:druidSource]
    }

    def query(){
        long id = params.long("id",-1l)
        DruidSource druidSource = DruidSource.get(id)
        if(druidSource==null){
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'druidSource.label', default: 'DruidSource'), id])
            render(view: "index")
            return;
        }

        String dataSource = druidSource.tableName;
        String timeZone = druidSource.timeZone
        DruidConnection connection = new DruidConnection(druidSource.brokerHost,druidSource.brokerPort);

        String gran = params.granularity
        Granularity granularity = null
        if(gran.startsWith("P")){
            granularity = new Granularity("period",gran,timeZone);
        }else{
            granularity = new Granularity(gran)
        }

        Filter filter = null;
        if(params.filterValue){
            filter = new Filter("selector");
            filter.dimension = params.filterName;
            filter.value = params.filterValue;
        }



        List<Interval> intervals = Lists.newArrayList(new Interval(String.valueOf(params.start),String.valueOf(params.end)));
        List<Pair<Integer>> microIntervals = Lists.newArrayList();

        QueryMeta queryMeta = new QueryMeta(dataSource,granularity,filter,intervals,microIntervals);

        String queryType = params.queryType

        def tuple = []
        switch (queryType){
            case "GroupBy":
                tuple = groupBy(queryMeta)
                break
            case "TopN":
                tuple = topN(queryMeta)
                break;
            case "Timeseries":
                tuple = timeSeries(queryMeta)
                break;
        }

        String queryJSON = tuple.get(0)
        println(queryJSON)

        List<String> columns = tuple.get(1)

        long s = System.currentTimeMillis();
        Either<String, Mapper4All> either = connection.query(queryJSON);
        long timeUsed = System.currentTimeMillis() -s

        flash.timeUsed = timeUsed;

        if(either.isLeft()){
            flash.message = either.left().get();
        }
        List<Map<String,Object>> results = []

        if(either.isRight()){
            results = either.right().get().toMap(columns)
        }
        render(view: "index",model: [results:results,columns:columns,druidSource: druidSource])
    }

    private List timeSeries(QueryMeta queryMeta){
        def columns = Lists.newArrayList("timestamp")
        TimeSeriesQueryMeta timeSeriesQueryMeta = new TimeSeriesQueryMeta(queryMeta)

        timeSeriesQueryMeta.aggregations = Lists.newArrayList()
        String aggregationType = params.aggregationType
        String aggregationColumn = params.aggregationColumn
        if (aggregationColumn && aggregationType) {
            aggregationColumn.split(",").each {
                timeSeriesQueryMeta.aggregations.add(new AggItem(aggregationType, it, it));
                columns.add(it);
            }
        }
        [timeSeriesQueryMeta.getJson().toString(),columns]
    }

    private List topN(QueryMeta queryMeta){
        TopNQueryMeta topNQueryMeta = new TopNQueryMeta(queryMeta);
        def columns = Lists.newArrayList("timestamp")

        String dimensionColumn = params.dimensions
        if (dimensionColumn) {
            def dim = dimensionColumn.split(",")[0]
            topNQueryMeta.dimension = dim
            columns.add(dim)
        }

        topNQueryMeta.aggregations = Lists.newArrayList()
        String aggregationType = params.aggregationType
        String aggregationColumn = params.aggregationColumn
        if (aggregationColumn && aggregationType) {
            aggregationColumn.split(",").each {
                topNQueryMeta.aggregations.add(new AggItem(aggregationType, it, it));
                columns.add(it);
            }
        }

        long limit = params.long("limit",5000);
        topNQueryMeta.threshold = limit

        if(params.orderByColumn){
            topNQueryMeta.metric = params.orderByColumn.toString()
        }


        [topNQueryMeta.getJson().toString(),columns]
    }

    private List groupBy(QueryMeta queryMeta) {
        GroupByQueryMeta groupByQueryMeta = new GroupByQueryMeta(queryMeta);

        long limit = params.long("limit",5000);
        LimitSpec limitSpec = new LimitSpec("default",limit)

        if(params.orderByColumn && params.orderByDirection){
            limitSpec.addColumn(params.orderByColumn.toString(),params.orderByDirection.toString())
        }
        groupByQueryMeta.limitSpec = limitSpec;

        def columns = Lists.newArrayList("timestamp")

        groupByQueryMeta.fetchDimensions = Maps.newLinkedHashMap();
        String dimensionColumn = params.dimensions
        if (dimensionColumn) {
            dimensionColumn.split(",").each {
                groupByQueryMeta.fetchDimensions.put(it, it);
                columns.add(it)
            }
        }

        groupByQueryMeta.aggregations = Lists.newArrayList();

        String aggregationType = params.aggregationType
        String aggregationColumn = params.aggregationColumn
        if (aggregationColumn && aggregationType) {
            aggregationColumn.split(",").each {
                groupByQueryMeta.aggregations.add(new AggItem(aggregationType, it, it));
                columns.add(it);
            }
        }
        [groupByQueryMeta.getJson().toString(), columns]
    }
}
