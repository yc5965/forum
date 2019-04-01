<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="fly-panel layui-hide" id="hotPostContainer">
    <h3 class="fly-panel-title">热门帖子</h3>
    <ul class="fly-panel-main fly-list-static" id="hot">
    </ul>
</div>
<div class="fly-panel fly-rank fly-rank-reply layui-hide" id="hotUserContainer">
    <h3 class="fly-panel-title">回贴达人</h3>
    <dl id="reply">

    </dl>
</div>

<script type="text/html" id="hotPostArea">
    {{#  layui.each(d, function(index, item){ }}
    <li>
        <a href="${ctx}/home/detail/?id={{item.id}}" target="_blank">{{item.title}}</a>
    </li>
    {{#  }); }}
</script>

<script type="text/html" id="replyItem">
    {{#  layui.each(d, function(index, item){ }}
    <dd>
        <a href="${ctx}/home/user/?id={{item.createBy.id}}" target="_blank">
            <img src="${ctxStatic}{{item.createBy.photo}}"><cite>{{item.createBy.name}}</cite><i>{{item.userCommentCount}}次回答</i>
        </a>
    </dd>
    {{#  }); }}
</script>

<script>
    layui.use(['table', 'layer', 'laytpl', 'jquery', 'laypage'], function () {
        var laytpl = layui.laytpl;
        var layer = layui.layer;
        var $ = jQuery = layui.$;
        function initHotPostArea() {
            $.ajax({
                url: "${ctx}/bs/bsPost/hotPost",
                type: "POST",
                success: function (r) {
                    if (r.data && r.data.length > 0) {
                        var data = r.data;
                        laytpl(hotPostArea.innerHTML).render(data, function (html) {
                            $("#hot").append(html);
                        })
                        $("#hotPostContainer").removeClass("layui-hide");
                    }
                }
            })
        }
        function initHotUserArea() {
            $.ajax({
                url: "${ctx}/bs/bsComment/replyItem",
                type: "POST",
                success: function (r) {
                    if (r.data && r.data.length > 0) {
                        var data = r.data;
                        laytpl(replyItem.innerHTML).render(data, function (html) {
                            $("#reply").append(html);
                        })
                        $("#hotUserContainer").removeClass("layui-hide");
                    }
                }
            })
        }
        initHotPostArea();
        initHotUserArea();
    })
</script>