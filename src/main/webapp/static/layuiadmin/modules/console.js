/** layuiAdmin.std-v1.0.0-beta9 LPPL License By http://www.layui.com/admin/ */
;layui.define(function (e) {
    layui.use(["admin", "carousel"], function () {
        var e = layui.$, t = (layui.admin, layui.carousel), a = layui.element, i = layui.device();
        e(".layadmin-carousel").each(function () {
            var a = e(this);
            t.render({
                elem: this,
                width: "100%",
                arrow: "none",
                interval: a.data("interval"),
                autoplay: a.data("autoplay") === !0,
                trigger: i.ios || i.android ? "click" : "hover",
                anim: a.data("anim")
            })
        }), a.render("progress")
    }),
    layui.use(["carousel", "echarts","jquery"], function () {
        var $ = jQuery = layui.$;
        $.ajax({
            url:"/admin/getEchartsData",
            type:'post',
            success:function(data){
                var e = layui.$, t = layui.carousel,
                    a = layui.echarts, i = [],
                    l = [
                        {
                            title: {text: "昨日流量趋势", x: "center", textStyle: {fontSize: 14}},
                            tooltip: {trigger: "axis"},
                            legend: {data: ["", ""]},
                            xAxis: [{
                                type: "category",
                                boundaryGap: !1,
                                data: ["00:00", "01:00", "02:00", "03:00", "04:00", "05:00", "06:00", "07:00", "08:00", "09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00", "20:00", "21:00", "22:00", "23:00", "24:00"]
                            }],
                            yAxis: [{type: "value"}],
                            series: [{
                                name: "PV",
                                type: "line",
                                smooth: !0,
                                itemStyle: {normal: {areaStyle: {type: "default"}}},
                                data:data.zData
                            }]},
                        {
                            title: {text: "访客浏览帖子类型", x: "center", textStyle: {fontSize: 14}},
                            tooltip: {trigger: "item", formatter: "{a} <br/>{b} : {c} ({d}%)"},
                            legend: {orient: "vertical", x: "left", data: ["公告", "提问", "分享", "建议"]},
                            series: [{
                                name: "帖子类型",
                                type: "pie",
                                radius: "55%",
                                center: ["50%", "50%"],
                                data: [{value: data.sData[0], name: "公告"}, {value: data.sData[1], name: "提问"},{value: data.sData[2], name: "分享"}, {value: data.sData[3], name: "建议"}]
                            }]
                        },
                        {
                            title: {text: "最近一周新增的用户量", x: "center", textStyle: {fontSize: 14}},
                            tooltip: {trigger: "axis", formatter: "{b}<br>新增用户：{c}"},
                            xAxis: [{type: "category", data: data.vDate}],
                            yAxis: [{type: "value"}],
                            series: [{type: "line", data:data.vData }]
                        }],
                    n = e("#LAY-index-dataview").children("div"), r = function (e) {
                        i[e] = a.init(n[e], layui.echartsTheme), i[e].setOption(l[e]), window.onresize = i[e].resize
                    };
                if (n[0]) {
                    r(0);
                    var o = 0;
                    t.on("change(LAY-index-dataview)", function (e) {
                        r(o = e.index)
                    }), layui.admin.on("side", function () {
                        setTimeout(function () {
                            r(o)
                        }, 300)
                    }), layui.admin.on("hash(tab)", function () {
                        layui.router().path.join("") || r(o)
                    })
                }
            },
        });


    }), layui.use("table", function () {
        var e = (layui.$, layui.table);
        e.render({
            elem: "#LAY-index-topCard",
            url:  "/admin/findhotPost",
            page: !0,
            cellMinWidth: 80,
            cols: [[{type: "numbers", fixed: "left"},
                {
                    field: "title",
                    title: "标题",
                    minWidth: 500,
                    templet: '<div><a href="/home/detail?id={{d.id}}" target="_blank" class="layui-table-link">{{ d.title }}</div>'
                },
                {
                    field: "username",
                    title: "发帖者",
                    width:120,
                    templet: '<div><a href="/home/user?id={{d.createBy.id}}" class="layui-table-link" target="_blank">{{ d.createBy.name }}</a></div>'
                },
                {field: "postType", title: "类别",width:120},
                {
                    field: "viewCount",
                    title: "点击量",
                    width:120,
                    sort: !0
                }
                ]],
            skin: "line"
        })
    }), e("console", {})
});