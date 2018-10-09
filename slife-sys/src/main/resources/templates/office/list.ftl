<html>
<head>
    <title>组织管理</title>
    <link rel="stylesheet" type="text/css" href="${rc.contextPath}/css/plugins/jsTree/style.min.css"/>
    <link href="${rc.contextPath}/css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="${rc.contextPath}/css/plugins/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
    <link href="${rc.contextPath}/css/animate.css" rel="stylesheet">
    <script>
        var url = "/sys/office/user/";
    </script>
    <style>
        #menu_edit_table .control-label {
            text-align: left !important;
        }

        #menu_edit_table input, #menu_edit_table select {
            margin-left: -45px;
        }

        #menu_edit_table .row {
            margin-top: 15px !important;
        }

    </style>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">

    <div class="row">

        <div class="col-md-3">
            <div class="portlet box green-haze" style="padding: 15px">
                <div class="portlet-body" id="resTree"></div>
            </div>
        </div>

        <div class="col-md-9">
            <div class="row" style="margin-right: 0!important;">
                <div class="col-md-12">

                    <div class="portlet box green-haze" style="padding: 15px">
                        <div class="portlet-title">

                            <button type="button" class="btn green btn-parent btn-info">
                                <i class="fa fa-plus-square" aria-hidden="true"></i>
                                <span class="hidden-480">新增父组织</span>
                            </button>

                            <button type="button" class="btn green btn-children btn-success" disabled="disabled">
                                <i class="fa fa-plus"></i>
                                <span class="hidden-480">新增子组织</span>
                            </button>

                            <button type="button" class="btn blue btn-edit btn-primary" disabled="disabled">
                                <i class="fa fa-edit"></i>
                                <span class="hidden-480">编辑此组织</span>
                            </button>

                            <button type="button" class="btn red btn-delete btn-danger" disabled="disabled">
                                <i class="fa fa-trash-o"></i>
                                <span class="hidden-480">禁用此组织</span>
                            </button>

                        </div>
                        <div class="portlet-body form" id="menu_edit_table">
                            <form id="officeForm" action="${rc.contextPath}/sys/office/insert" class="form-horizontal form-bordered"
                                  method="POST">
                                <input type="hidden" name="id"/>
                                <input type="hidden" name="parentId" value="0"/>
                                <input type="hidden" name="path"/>

                                <div class="form-body">

                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label class="col-md-2 control-label">组织名称<span
                                                        class="required">*</span></label>

                                                <div class="col-md-10">
                                                    <input type="text" class="form-control" name="name"
                                                           readonly="true"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label class="col-md-2 control-label">组织编码<span
                                                        class="required">*</span></label>

                                                <div class="col-md-10">
                                                    <input type="text" class="form-control" name="code"
                                                           readonly="true"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group" style="text-align:left">
                                                <label class="col-md-2 control-label">图标&nbsp;<span
                                                        class="required">*</span></label>
                                                <div class="col-md-8">
                                                    <input type="text" id="icon" name="icon"
                                                           class="form-control mess_text" placeholder="请选择系统图标">
                                                </div>
                                            <span class="input-group-btn">
                                                <button id="icon_add" disabled="disabled"  class="btn btn-default"
                                                        onclick="showIconModul()" type="button"><i
                                                        class="fa fa-check"></i>选择</button>
                                            </span>
                                            </div>
                                        </div>
                                    </div>


                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label class="col-md-2 control-label">排序&nbsp;<span
                                                        class="required">*</span></label>

                                                <div class="col-md-10">
                                                    <div class="input-icon right">
                                                        <input type="text" class="form-control" name="sort"
                                                               readonly="true"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="form-group">
                                                <label class="col-md-2 control-label">状态&nbsp;<span class="required">*</span></label>

                                                <div class="col-md-10">
                                                    <div class="input-icon right">
                                                        <select name="delFlag" class="form-control" disabled="disabled">
                                                            <option value="Y">启用</option>
                                                            <option value="N">不启用</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-actions fluid">
                                    <div class="row">
                                        <div class="col-md-offset-3 col-md-9">
                                            <button type="submit" class="btn green" disabled="disabled">保存</button>
                                            <button type="button" class="btn default btn-cancel" disabled="disabled">取消</button>
                                        </div>
                                    </div>
                                </div>

                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-9">
            <div id="exampleToolbar">
                <input type="text" class="form-filter input-sm _search" hidden="hidden" name="search_eq_sys_office_id">
            </div>
            <div class="row" >
                <div class="col-md-9">
                    <table id="exampleTable" data-mobile-responsive="true">
                    </table>
                </div>
            </div>
        </div>
    </div>



    <div id="icon_add_div" class="modal fade" tabindex="-1" aria-hidden="true" style="height: 1000px">
        <div class="modal-dialog" style="width:900px;">
            <div class="modal-content">
                <div class="modal-header" style="border-bottom:none;">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                </div>
                <div class="modal-body">
                    <div class="row" id="roletableDatas">
                        <div class="col-md-12">
                            <div class="portlet">
                                <div class="portlet-title">
                                    <div class="caption"><i class="fa fa-cogs"></i>图标列表</div>
                                    <div class="actions">
                                        <div class="btn-group">
                                            <select class="form-control  input-small select2me" id="_dlgCheckIcon"
                                                    onchange="checkIcon()">
                                                <option value="glyphiconsIcons">Glyphicons Icons</option>
                                                <option value="newIcons">10 New Icons in 4.0</option>
                                                <option value="webappIcons">Web Application Icons</option>
                                                <option value="formIcons">Form Control Icons</option>
                                                <option value="currencyIcons">Currency Icons</option>
                                                <option value="textIcons">Text Editor Icons</option>
                                                <option value="directIcons">Directional Icons</option>
                                                <option value="videoIcons">Video Player Icons</option>
                                                <option value="brandIcons">Brand Icons</option>
                                                <option value="medicalIcons">Medical Icons</option>
                                                <option value="simpleLineIcons">Simple Line Icons</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="portlet-body">
                                    <!-- 必须加上row样式,不然高度为1px,不能显示边框 -->
                                    <div id="tab_1_2" class="tab-pane glyphicons-demo active">
                                        <ul id="iconTable" class="bs-glyphicons bs-glyphicons-list">
                                        </ul>
                                    </div>
                                    <div class="row">
                                        <table id="iconPageBar" class="col-md-8"
                                               style="text-align: center; width: 100%;">
                                            <tr>
                                                <td class="form-inline">
                                                    <div class="pagination" id="iconPager"
                                                         style="font-size: 18px; text-align: center; vertical-align: middle;"></div>
                                                    <span style="margin-top: 0px; size: 12px; color: #8a8a8a">跳转到</span>
                                                    <input type="text" id="toMPage"
                                                           style="font-size: 18px; width: 50px; height: 30px;"
                                                           class="input-inline page_input"
                                                           onkeyup="if(isNaN(value))execCommand('undo');if(event.keyCode==32)execCommand('undo');"
                                                           onafterpaste="if(isNaN(value))execCommand('undo'));if(event.keyCode==32)execCommand('undo');">
                                                    <button style="width: 40px; height: 30px;" id="gotoMPage"
                                                            class="btn">
                                                        GO
                                                    </button>
                                                </td>
                                            </tr>
                                        </table>
                                        <div class="col-md-2"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="${rc.contextPath}/js/plugins/jsTree/jstree.min.js" type="text/javascript"></script>
<script src="${rc.contextPath}/js/plugins/validate/jquery.validate.min.js"></script>
<script src="${rc.contextPath}/js/plugins/validate/messages_zh.min.js"></script>
<script src="${rc.contextPath}/js/jquery.form.js"></script>

<!-- Bootstrap table -->
<script src="${rc.contextPath}/js/plugins/bootstrap-table/bootstrap-table.min.js"></script>
<script src="${rc.contextPath}/js/plugins/bootstrap-table/bootstrap-table-mobile.min.js"></script>
<script src="${rc.contextPath}/js/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>

<script src="${rc.contextPath}/js/slife/datatable.js"></script>
<script type="text/javascript">



    function getcolumns() {
        var c = [
            {
                checkbox: true
            },
            {
                title: '头像',
                field: 'photo',
                align: 'center',
                formatter: function (value, row, index) {

                    return '<img style="width:30px" src=${rc.contextPath}"'+value+'"/>';
                }
            },
            {
                field: 'name',
                title: '姓名'
            },
            {
                field: 'email',
                title: '邮箱'
            },
            {
                field: 'no',
                title: '工号'
            },
            {
                field: 'phone',
                title: '电话'
            },
            {
                field: 'mobile',
                title: '手机'
            },
            {
                field : 'loginFlag',
                title : '状态',
                align : 'center',
                formatter : function(value, row, index) {
                    if (value == 'Y') {
                        return '<span class="label label-primary">正常</span>';
                    } else if (value == 'N') {
                        return '<span class="label label-danger">禁用</span>';
                    }
                }
            },
            {
                title: '操作',
                field: 'id',
                align: 'center',
                formatter: function (value, row, index) {

                    return dt_edit_button(row)+dt_detail_button(row)+dt_delete_button(row);
                }
            }];

        return c;
    }

    load_data( getcolumns(), null);


    function dt_explort_buttont() {
        export_data( getcolumns(), null);
    }









    var form = $('#officeForm'), menuid, text;
    $("#resTree").jstree({
        "core": {
            "animation": 0,
            "themes": {
                theme: "classic",
                "dots": true,
                "icons": true
            },
            "check_callback": true,
            'data':${officeTree}
        },
        "types": {
            "default": {
                "valid_children": ["default", "file"]
            }
        },
        "plugins": ["wholerow"]
    }).on("select_node.jstree", function (node, selectd) {
        menuid = selectd.node.id;
        text = selectd.node.text;
        if (menuid) {
            $.ajax({
                url: '${rc.contextPath}/sys/office/select/' + menuid,
                type: 'GET',
                success: function (data) {
                    data=data.office;

                    $('input[name=id]').val(data.id);
                    $('input[name=parentId]').val(data.parentId);
                    $('input[name=name]').val(data.name);
                    $('input[name=code]').val(data.code);
                    $('input[name=icon]').val(data.icon);
                    $('#iconImg').attr("class", data.icon)

                    $('input[name=path]').val(data.path);
                    $('input[name=sort]').val(data.sort);

                    $("select[name=delFlag] option[value='" + data.delFlag + "']").attr("selected", "selected");
                    $("select[name=delFlag] option[value!='" + data.delFlag + "']").attr("selected", false);

                    $('#officeForm :input').each(function (a) {
                        $(this).attr('disabled', "disabled");
                        $(this).attr("readonly", "true");
                    });



                    $('.btn-children').enable();
                    $('.btn-edit').enable();
                    $('.btn-delete').enable();

                    $('input[name=search_eq_sys_office_id]').val(data.id);
                    re_load();


                }
            });
        }
    });



    var error=$('.alert-danger',form);
    form.validate({
        errorElement: 'span',
        errorClass: 'error',
        ignore: "",
        focusInvalid: false,
        rules: {
            name: {
                minlength: 1,
                maxlength: 30,
                required: true
            },
            code: {
                required: true
            },
            sort: {
                required: true,
                number: true
            },
            delFlag: {
                required: true
            },
            icon: {
                required: true
            }
        },
        invalidHandler:function(event,validator){
            error.show();
        },
        highlight:function(element){
            $(element).closest('.form-group').addClass('has-error');
        },
        unhighlight:function(element){
            $(element).closest('.form-group').removeClass('has-error');
        },
        success:function(label){
            label.closest('.form-group').removeClass('has-error');
        },
        submitHandler:function(form){
            error.hide();
            form.submit();
        }
    });

    $('.btn-parent').click(function () {
        form.resetForm();
        $('input[name=id]').val("");
        $('input[name=parentId]').val(0);
        $('#officeForm :input').each(function (a) {
            $(this).enable();
            $(this).attr("readonly", false);
        });
        $('.btn-edit').attr('disabled', "disabled");
        $('.btn-delete').attr('disabled', "disabled");

    });
    $('.btn-children').click(function () {
        form.resetForm();
        $('input[name=id]').val("");
        $('input[name=parentId]').val(menuid);
        $('#officeForm :input').each(function (a) {
            $(this).enable();
            $(this).attr("readonly", false);
        });
        $('.btn-edit').attr('disabled', "disabled");
        $('.btn-delete').attr('disabled', "disabled");
    });
    $('.btn-edit').click(function () {
        $('#officeForm :input').each(function (a) {
            $(this).enable();
            $(this).attr("readonly", false);

        });
    });
    $('.btn-cancel').click(function () {
        $('#officeForm :input').each(function (a) {
            $(this).attr('disabled', "disabled");
            $(this).attr("readonly", "true");
        });
        $('div.form-group ').removeClass('has-error');
        $('div.alert-danger').css('display', 'none');
    });
    $('.btn-delete').click(function () {
        if (menuid){
            layer.confirm('确认要禁用此菜单及其下级所有资源吗？', {
                btn: ['确定', '取消']
            }, function () {
                $.ajax({
                    url: '${rc.contextPath}/sys/office/disable/' + menuid,
                    type: "POST",

                    success: function (r) {
                        window.location.reload();
                    }
                });
            })
        }

    });






    /**获取所有的功能****/
    var currentPage = 1; //第几页
    var pageCount = 32; //每页显示多少条记录数据
    var totalPages = 0;
    //分页查询
    var queryByPage = function () {
        // start_request_load();
        $.ajax({
            dataType: "json",
            cache: true,
            type: "GET",
            url: "${rc.contextPath}/js/icon.json",
            traditional: true,
            success: function (data) {
                //  stop_request_load();
                var checkIcon = $("#_dlgCheckIcon").val();
                data = data[checkIcon];
                //删除所有子项
                $("#iconTable").empty();
                var total = 0, str = '';
                $.each(data, function (i, n) {
                    str += '<li onclick="addIconImage(\'' + n + '\');"><span class="' + n + '" style="font-size:24px;margin:5px auto 10px;display:block"></span><span>' + n + ' </span></li>';
                    total++;
                });
                if (data == null || data == undefined || total == 0) {
                    return;
                }
                if (total <= pageCount) {
                    $("#iconPageBar").css({visibility: "hidden"});
                } else {
                    $("#iconPageBar").css({visibility: "visible"});
                    str = '';
                    var start = (currentPage - 1) * pageCount;
                    var k = 0;
                    $.each(data, function (i, n) {
                        if (i >= start) {
                            str += '<li onclick="addIconImage(\'' + n + '\');"><span class="' + n + '" style="font-size:24px;margin:5px auto 10px;display:block"></span><span>' + n + ' </span></li>';
                            k++;
                        }
                        if (pageCount == k) {
                            return false;
                        }
                    });
                }
                $("#iconTable").append(str);
                //总页数
                if (total % pageCount != 0) {
                    totalPages = parseInt(total / pageCount) + 1;
                } else {
                    totalPages = total / pageCount;
                }
                var options = {
                    currentPage: currentPage,
                    totalPages: totalPages,
                    onPageClicked: function (event, originalEvent, type, page) {
                        currentPage = page;
                        queryByPage(currentPage, pageCount);
                    }
                }

            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                layer.msg("网络异常,数据不能成功返回");
            }
        });
    }
    //初始化列表
    queryByPage(currentPage, pageCount);
    //翻页
    $("#gotoMPage").bind("click", function () {
        if ($("#toMPage").val() == null || "" == $("#toMPage").val()) {
            layer.msg("请输入跳转页码");
            return;
        }
        var thisPage = parseInt($("#toMPage").val());
        if (!( thisPage > 0 && thisPage <= totalPages)) {
            layer.msg("请输入正确跳转页码");
            return;
        }
        //$('#iconPager').bootstrapPaginator("show", thisPage);
        currentPage = thisPage;
        queryByPage(currentPage, pageCount);
    });
    function showIconModul() {
        $('#icon_add_div').modal('show');
    }
    function checkIcon() {
        this.currentPage = 1; //第几页
        this.pageCount = 32; //每页显示多少条记录数据
        this.totalPages = 0;
        $('#toMPage').val('');
        queryByPage(1, 32);
    }
    function addIconImage(data) {
        $('#icon').val(data);
        $('#icon_add_div').modal('hide');
    }


</script>
</body>

</html>