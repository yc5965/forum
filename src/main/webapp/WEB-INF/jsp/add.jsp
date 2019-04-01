<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/common/taglib.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>发布文章-乐瑞大家庭</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta http-equiv="Content-Type" content="multipart/form-data; charset=utf-8" />
    <meta name="keywords" content="乐瑞大家庭">
    <script type="text/javascript">var ctx = '${ctx}', ctxStatic = '${ctxStatic}';</script>
    <link rel="stylesheet" href="${ctxStatic}/layui/res/layui/css/layui.css">
    <link rel="stylesheet" href="${ctxStatic}/layui/res/css/global.css">
    <link rel="stylesheet" href="${ctxStatic}/jquery-tags/jquery.tagsinput.css"/>
    <!-- summernote -->
    <script src="${ctxStatic}/jquery/jquery-3.0.0.min.js" type="text/javascript"></script>
    <script src="${ctxStatic}/jquery/jquery-migrate-3.0.0.min.js" type="text/javascript"></script>
    <script src="${ctxStatic}/jquery/ajaxfileupload.js" type="text/javascript"></script>
    <link href="${ctxStatic}/bootstrap/3.3.7/css/bootstrap.css" type="text/css" rel="stylesheet"/>
    <script src="${ctxStatic}/bootstrap/3.3.7/js/bootstrap.min.js" type="text/javascript"></script>
    <link href="${ctxStatic}/summernote/summernote.css" rel="stylesheet">
    <link href="${ctxStatic}/summernote/summernote.css" rel="stylesheet">
    <script src="${ctxStatic}/summernote/summernote.min.js?v=20180423"></script>
    <script src="${ctxStatic}/summernote/lang/summernote-zh-CN.js"></script>
    <script src="${ctxStatic}/jquery-tags/jquery.tagsinput.js"></script>
    <style>
        .fly-link:hover {
            cursor: pointer;
        }

        body {
            background-color: #f2f2f2
        }

        ol, ul {
            margin-bottom: 0px;
        }

        .modal-dialog {
            margin-top: 60px !important;
        }

        #coverImgPreview {
            margin-left: 50px;
        }

        .modal-dialog input[type=checkbox] {
            display: block;
        }

        #tags_tagsinput {
            overflow-y: unset;
        }

        .prompt-tags {
            float: left;
        }

        .recTag {
            background-color: #FFFFFF;
            margin: 18px 8px;
            border: 1px solid #ffffff;
            padding: 5px 12px;
            color: black;
        }

        .recTag:hover {
            border: 1px solid blue
        }

        .tagList {
            background-color: #F5F5F6;
            width: 100%;
            height: auto;
            margin-top: 40px;
            padding: 10px;
        }

        .prompt-tags {
            font-size: 6px;
            color: #BFBFBF;
        }

    </style>
</head>
<body>

<%@include file="common/header.jsp" %>

<div class="layui-container fly-marginTop">
    <div class="fly-panel" pad20="" style="padding-top: 5px;">
        <div class="layui-form layui-form-pane">
            <div class="layui-tab layui-tab-brief" lay-filter="user">
                <ul class="layui-tab-title">
                    <li class="layui-this">发表新帖</li>
                </ul>
                <div class="layui-form layui-tab-content" id="LAY_ucm" style="padding: 20px 0;">
                    <div class="layui-tab-item layui-show">
                        <form method="post" enctype="multipart/form-data" id="bsPostItem">
                            <div class="layui-row layui-col-space15 layui-form-item">
                                <div class="layui-col-md3">
                                    <label class="layui-form-label">类型</label>
                                    <div class="layui-input-block">
                                        <select name="postType" id="postType" lay-filter="postType">
                                            <option value="0" <c:if test="${bsPost.postType=='0'}"> selected </c:if>>公告</option>
                                            <option value="1" <c:if test="${bsPost.postType=='1'}"> selected </c:if>>提问</option>
                                            <option value="2" <c:if test="${bsPost.postType=='2'}"> selected </c:if>>分享</option>
                                            <option value="3" <c:if test="${bsPost.postType=='3'}"> selected </c:if>>建议</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="layui-col-md9">
                                    <label for="L_title" class="layui-form-label">标题</label>
                                    <div class="layui-input-block">
                                        <input type="text" id="L_title" name="title" required="" value="${bsPost.title}"
                                               lay-verify="required" autocomplete="off" class="layui-input">
                                        <input type="hidden" name="id" value="${bsPost.id}" id="postId">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-form-item layui-form-text">
                                <div class="layui-input-block">
                                    <div class="summernote" id="commentContent">${bsPost.content}</div>
                                </div>
                            </div>
                            <div class="layui-col-md12" id="tags_div">
                                <label for="tags" class="layui-form-label">标签</label>
                                <div class="layui-input-block">
                                    <input name="postTags" id="tags" class="form-control" type="text"
                                           class="layui-input" value="${bsPost.postTags}"/>
                                    <p class="prompt-tags">请输入标签，每个标签至少两个字符，回车确认</p>
                                    <div class="tags">
                                        <div class="tagList">

                                        </div>
                                    </div>
                                </div>
                            </div>
                            <c:if test="${sessionScope.user.userType == '0'}">
                                <div class="layui-form-item" pane="">
                                    <label class="layui-form-label">文章位置</label>
                                    <div class="layui-input-block">
                                        <input type="radio" lay-filter="postStatus" name="postStatus"
                                               value="0" title="默认" <c:if test="${bsPost.postStatus=='0'|| empty bsPost.postStatus}"> checked </c:if>>
                                        <input type="radio" lay-filter="postStatus" name="postStatus"
                                               value="1" title="置顶" <c:if test="${bsPost.postStatus=='1'}"> checked </c:if>>
                                        <input type="radio" lay-filter="postStatus" name="postStatus"
                                               value="2" title="轮播" <c:if test="${bsPost.postStatus=='2'}"> checked </c:if>>
                                    </div>
                                </div>
                                <div class="layui-form-item ${bsPost.postStatus != '2' ? 'layui-hide':''} "
                                     id="coverImgContainer" style="text-align: center">
                                    <label class="layui-form-label">轮播图片</label>
                                    <div style="text-align: center">
                                        <input type="file" id="coverImg" name="file" value="${bsPost.coverImg}"
                                               htmlEscape="false" maxlength="2048" style="background-color: #FFFFFF;padding: 4px" accept=".jpg,.png,.gif"/>
                                    </div>
                                    <div class="layui-form-mid layui-word-aux" style="color:red !important;">
                                        *上传图片长宽比例为745*175
                                    </div>
                                </div>
                            </c:if>
                            <div class="layui-form-item">
                                <button class="layui-btn" id="addPost">立即发布</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="${ctxStatic}/layui/res/layui/layui.js"></script>
<script>
    layui.cache.page = 'jie';
    layui.cache.user = {
        uid: -1
    };
    layui.config({
        version: "3.0.0"
        , base: '${ctxStatic}/layui/res/mods/'
    }).extend({
        fly: 'index'
    }).use('fly');

    layui.use(['layer', 'laytpl', 'form'], function () {
        var laytpl = layui.laytpl;
        var form = layui.form;
        initTagArea();

        $(function () {
            $('.summernote').summernote({
                height: 400,
                minHeight: null,
                maxHeight: null,
                focus: true,
                lang: 'zh-CN'
            });
        });
        $("#addPost").click(function(){
            var id = $('#postId').val();
            var content = $('#commentContent').summernote('code');
            var tags = $("#tags").val();
            var postType = $('#postType').val();
            var title = $('#L_title').val();
            var postStatus = $('input[name="postStatus"]:checked').val();
            if ($('#commentContent').summernote('isEmpty')) {
                layer.msg("请输入帖子内容！", {icon: 5});
                $('#commentContent').summernote('focus');
                return false;
            }
            if ( postStatus  == '2' && !$("#coverImg").val()) {
                layer.msg("轮播图不能为空！", {icon: 5});
                return false;
            }
            var loadIndex = layer.load(0);
            $.ajaxFileUpload({
                url:"${ctx}/bs/bsPost/saveAjax",
                type:'post',
                fileElementId: 'coverImg',
                data:{'id':id,'postType':postType,'content':content,'tags':tags,'title':title,'postStatus': postStatus},
                dataType:'json',
                success:function(r){
                    layer.close(loadIndex);
                    if (r && r.status == 'ok') {
                        layer.msg("保存成功，自动跳转中!");
                        setTimeout(function () {
                            window.location.href = '${ctx}/home/detail?id='+r.id;
                        }, 1000);
                    } else {
                        layer.msg("服务器错误，请重试或联系管理员！", {icon: 5});
                    }
                }
            })
        })

        form.on('radio(postStatus)', function (data) {
            var val = data.value;
            if (val == '2') {
                $("#coverImgContainer").removeClass("layui-hide");
            } else {
                $("#coverImgContainer").addClass("layui-hide");
            }
        });
        form.on('select(postType)', function (data) {
            var val = data.value;
            getTags(val);
        });
        $(document).on("click", ".recTag", function (e) {
            var tags = $("#tags").val().split(",");
            if (tags.indexOf($(this).text()) != -1) {
                layer.msg("该标签已存在");
            } else {
                $('#tags').addTag($(this).text());
            }
        });
        function getTags(postType) {
            $(".tagList").html("");
            $(".tagList").hide();
            if (postType != '0'&&postType!=null) {
                $("#tags_div").show();
                $.ajax({
                    url: "${ctx}/bs/bsPost/findHotTagsBypostType",
                    type: "POST",
                    data: {"postType": postType},
                    success: function (r) {
                        if (r.data && r.data.length > 0) {
                            var data = r.data;
                            if (data.length > 5) {
                                for (var i = 0; i < 5; i++) {
                                    $(".tagList").append('<a href="javascrapt:;" class="recTag">' + data[i] + '</a>')
                                }
                            } else {
                                for (var i = 0; i < data.length; i++) {
                                    $(".tagList").append('<a href="javascrapt:;" class="recTag">' + data[i] + '</a>')
                                }
                            }
                            $(".tagList").show()
                        }
                    }
                })
            }else {
                $("#tags").val("");
                $(".tag").remove();
                $("#tags_div").hide()
            }
        }
        getTags(${bsPost.postType});
    });

    function fileSelectAction(fileUrl, data, allFiles) {
        var fileName = decodeURIComponent(fileUrl.substring(fileUrl.lastIndexOf("/") + 1));
        if (isImg(fileName)) {
            $('#commentContent').summernote("insertImage", fileUrl);
        } else {
            var linkNode = document.createElement("a");
            linkNode.href = fileUrl;
            linkNode.target = "_blank";
            linkNode.appendChild(document.createTextNode(fileName));
            $('#commentContent').summernote('insertNode', linkNode);
        }
    }

    function isImg(fileName) {
        var suffixIndex = fileName.lastIndexOf(".");
        var suffix = fileName.substring(suffixIndex + 1).toUpperCase();
        return suffix == "BMP" || suffix == "JPG" || suffix == "JPEG" || suffix == "PNG" || suffix == "GIF";
    }

    function setYDYContent(content, ele) {
        var noteRe = /^(http|https):\/\/note\.youdao\.com\/(noteshare|share\/)(index\.html|)\?id=.*$/;
        //有道云协作正则
        var groupRe = /^(http|https):\/\/note\.youdao\.com\/(groupshare|share\/)(index\.html|)\?token=.*$/;
        var layerIndex = 0;
        if (noteRe.test(content)) {
            $.ajax({
                url: "https://home.lowrisk.com.cn/lrtools/ydy/note",
                type: 'get',
                data: {url: encodeURI(content)},
                beforeSend: function (XMLHttpRequest) {
                    layerIndex = layer.load(0, {time: 20 * 1000, shade: 0.3});
                },
                success: function (res) {
                    $(ele).summernote('reset');
                    $(ele).summernote('code', res.data);
                    $(ele).summernote('keepLastIndex');
                    layer.close(layerIndex);
                },
                complete: function (XMLHttpRequest, textStatus) {
                    layer.close(layerIndex);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.close(layerIndex);
                }
            })
        }
        else if (groupRe.test(content)) {
            $.ajax({
                url: "https://home.lowrisk.com.cn/lrtools/ydy/group",
                type: 'get',
                data: {url: encodeURI(content)},
                beforeSend: function (XMLHttpRequest) {
                    layerIndex = layer.load(0, {time: 20 * 1000, shade: 0.3});
                },
                success: function (res) {
                    $(ele).summernote('reset');
                    $(ele).summernote('code', res.data);
                    layer.close(layerIndex);
                },
                complete: function (XMLHttpRequest, textStatus) {
                    layer.close(layerIndex);
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.close(layerIndex);
                }
            })
        }
    }

    function initTagArea(){
        $('#tags').tagsInput({
            'width': 'auto',
            'height': '38px',
            'defaultText': '',
            'minChars': 2
        });
    }
    // 打开一个窗体
    function windowOpen(url, name, width, height) {
        var top = parseInt((window.screen.height - height) / 2, 10),
            left = parseInt((window.screen.width - width) / 2, 10),
            options = "location=no,menubar=no,toolbar=no,dependent=yes,minimizable=no,modal=yes,alwaysRaised=yes," +
                "resizable=yes,scrollbars=yes," + "width=" + width + ",height=" + height + ",top=" + top + ",left=" + left;
        window.open(url, name, options);
    }

</script>
</body>
</html>