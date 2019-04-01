layui.use(['carousel', 'form'], function () {
    var carousel = layui.carousel;
    carousel.render({
        elem: '#itemImg'
        , interval: 5000
        , width: '480px'
        , height: '320px'
        , indicator: 'none'

    });
    $(document).on("click","#weekly",function (e) {
        window.location.href=ctx+"caixin/index?reqtype=weekly"
    });
});

