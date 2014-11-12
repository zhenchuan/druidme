package me.zhenchuan.druid.utils;

import com.google.common.collect.Lists;
import com.google.common.collect.Maps;
import com.yahoo.sql4d.query.Pair;
import com.yahoo.sql4d.query.QueryMeta;
import com.yahoo.sql4d.query.RequestType;
import com.yahoo.sql4d.query.groupby.GroupByQueryMeta;
import com.yahoo.sql4d.query.nodes.AggItem;
import com.yahoo.sql4d.query.nodes.Filter;
import com.yahoo.sql4d.query.nodes.Granularity;
import com.yahoo.sql4d.query.nodes.Interval;
import com.yahoo.sql4d.sql4ddriver.Mapper4All;
import me.zhenchuan.druid.DruidConnection;
import org.json.JSONArray;
import scala.util.Either;

import java.util.List;

/**
 * Created by liuzhenchuan@foxmail.com on 11/4/14.
 */
public class Main {

    public static void main(String[] args) {
        String dataSource = "ipinyou";

        Granularity granularity = new Granularity("period","P1D","Asia/Shanghai");

        Filter filter = new Filter("selector");
        filter.dimension = "platform";filter.value = "Adx";


        List<Interval> intervals = Lists.newArrayList(new Interval("2014-11-04","2014-11-05"));
        List<Pair<Integer>> microIntervals = Lists.newArrayList();

        QueryMeta queryMeta = new QueryMeta(dataSource,granularity,null,intervals,microIntervals);

        GroupByQueryMeta groupByQueryMeta = new GroupByQueryMeta(queryMeta);

        groupByQueryMeta.aggregations = Lists.newArrayList();
        groupByQueryMeta.aggregations.add(new AggItem("longSum","imp","imp"));
        groupByQueryMeta.aggregations.add(new AggItem("longSum","clk","clk"));

        groupByQueryMeta.fetchDimensions = Maps.newLinkedHashMap();
        groupByQueryMeta.fetchDimensions.put("hour","hour");
        groupByQueryMeta.fetchDimensions.put("platform","platform");

        DruidConnection connection = new DruidConnection("192.168.144.119",8080);
        Either<String, Mapper4All> either = connection.query(groupByQueryMeta.getJson().toString());
        System.out.println("========");
        System.out.println(either.right().get());
        System.out.println(either.isRight());
        if(either.isRight()){
            System.out.println(either.right().get().toMap(Lists.newArrayList("timestamp","hour","platform","imp","clk")));
        }

        System.out.println(groupByQueryMeta.getJson().toString());


    }

}
