package me.zhenchuan.druid;

import com.yahoo.sql4d.sql4ddriver.Mapper4All;
import org.json.JSONArray;
import org.json.JSONException;
import org.slf4j.LoggerFactory;
import scala.util.Either;
import scala.util.Left;
import scala.util.Right;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.*;

/**
 * Created by liuzhenchuan@foxmail.com on 11/4/14.
 */
public class DruidConnection {
    
    private static final org.slf4j.Logger log = LoggerFactory.getLogger(DruidConnection.class);

    private String brokerHost;
    private int brokerPort = 8080;
    private String coordinatorHost;
    private int coordinatorPort = 8082;

    private final String brokerUrl = "http://%s:%d/druid/v2/?pretty";
    private final String coordinatorUrl = "http://%s:%d/";

    public DruidConnection(String bHost, int bPort) {
        this.brokerHost = bHost;
        this.brokerPort = bPort;
    }

    public DruidConnection(String bHost, int bPort, String cHost, int cPort) {
        this(bHost, bPort);
        this.coordinatorHost = cHost;
        this.coordinatorPort = cPort;
    }


    public Either<String, Mapper4All> query(String jsonQuery){
        Either<String, Either<Mapper4All,JSONArray>> result = fireQuery(jsonQuery, true);
        if (result.isLeft()) {
            return new Left<>(result.left().get());
        }
        return new Right<>(result.right().get().left().get());
    }

    public Either<String, Either<Mapper4All, JSONArray>> fireQuery(String jsonQuery, boolean requiresMapping) {
        StringBuilder buff = new StringBuilder();
        try {
            URL url = null;
            try {
                url = new URL(String.format(brokerUrl, brokerHost, brokerPort));
            } catch (MalformedURLException ex) {
                log.warn(null, ex);
                return new Left<>("Bad Url : " + ex);
            }

            HttpURLConnection httpConnection = (HttpURLConnection) url.openConnection(Proxy.NO_PROXY);
            httpConnection.setRequestMethod("POST");
            httpConnection.addRequestProperty("content-type", "application/json");
            httpConnection.setDoOutput(true);
            httpConnection.getOutputStream().write(jsonQuery.getBytes());
            if (httpConnection.getResponseCode() == 500 || httpConnection.getResponseCode() == 404) {
                return new Left<>(String.format("Http %d : %s \n", httpConnection.getResponseCode(), httpConnection.getResponseMessage()));
            }
            BufferedReader stdInput = new BufferedReader(new InputStreamReader(httpConnection.getInputStream()));
            String line = null;
            while ((line = stdInput.readLine()) != null) {
                buff.append(line);
            }
        } catch (IOException ex) {
            log.warn(null, ex);
        }
        JSONArray possibleResArray = null;
        try {
            possibleResArray = new JSONArray(buff.toString());
        } catch(JSONException je) {
            return new Left<>(String.format("Recieved data %s not in json format. \n", buff.toString()));
        }
        if (requiresMapping) {
            return new Right<String, Either<Mapper4All, JSONArray>>(new Left<Mapper4All, JSONArray>(new Mapper4All(possibleResArray)));
        }
        return new Right<String, Either<Mapper4All, JSONArray>>(new Right<Mapper4All, JSONArray>(possibleResArray));
    }


}
