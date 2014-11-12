class DruidSource {

    String tableName
    String brokerHost
    int brokerPort = 8080
    String timeZone
    String dimensionList
    String metricList

    static constraints = {
        tableName(blank: false)
        brokerHost(blank: false)
        brokerPort(blank:false)
        timeZone(blank: false)
        dimensionList(blank: false,maxSize: 256)
        metricList(blank: false,maxSize: 256)
    }

    static mapping = {
        cache(true)
    }
}
