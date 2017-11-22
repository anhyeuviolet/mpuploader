<!-- BEGIN: main -->
<link type="text/css" href="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.css" rel="stylesheet" />
<div id="content"> 
	<!-- BEGIN: success -->
		<div class="alert alert-success">
			<i class="fa fa-check-circle"></i> {SUCCESS}
		</div>
	<!-- END: success -->
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title" style="float:left"><i class="fa fa-list"></i> Danh sách File: {ALBUM_NAME}</h3> 
			<div style="clear:both"></div>
		</div>
		<div class="panel-body">
			<form action="" method="post" enctype="multipart/form-data" id="form-album">
				<div class="table-responsive">
					<table class="table table-bordered table-hover">
						<thead>
							<tr>
								<td class="col-md-1 text-center" ><input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);"></td>
                                <td class="col-md-12 text-left"><strong>Tên File</strong></td>
								<td class="col-md-3 text-center"><strong>{LANG.album_date_added}</strong></td>
								<td class="col-md-3 text-center"><strong>{LANG.action} </strong></td>
							</tr>
						</thead>
						<tbody>
							<!-- BEGIN: loop --> 
							<tr id="group_{LOOP.album_id}">
								<td class="text-center"><input type="checkbox" name="selected[]" value="{LOOP.row_id}"></td>
								<td class="text-left">
								<a href="{LOOP.file_url}"><span><strong>{LOOP.name}</strong></span></a>&nbsp;<span id="copy_botton_{LOOP.row_id}" class="btn btn-primary">Copy link</span>
                                <span><input id="copy_link_{LOOP.row_id}" type="text" value="{LOOP.file_url}" class="form-control" style="width:80%" readonly="readonly"></span>
								</td>
								<td class="text-center">
									{LOOP.date_added}
								</td>
								<td class="text-center">
                                Đang phát triển
								</td>
                                
                                <script type="text/javascript">
                                    document.getElementById("copy_botton_{LOOP.row_id}").addEventListener("click", function() {
                                        copyToClipboard(document.getElementById("copy_link_{LOOP.row_id}"));
                                    });                                
                                </script>

                            </tr>
							<!-- END: loop -->
						</tbody>
					</table>
				</div>
			</form>
			<!-- BEGIN: generate_page -->
			<div class="row">
				<div class="col-sm-12 text-left">
					<div style="clear:both"></div>
					{GENERATE_PAGE}
				</div>
			</div>
			<!-- END: generate_page -->
		</div>
		<div id="cat-delete-area">&nbsp;</div>
	</div>
</div>

<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/jquery-ui/jquery-ui.min.js"></script>
<script type="text/javascript" src="{NV_BASE_SITEURL}{NV_ASSETS_DIR}/js/language/jquery.ui.datepicker-{NV_LANG_INTERFACE}.js"></script>

<script type="text/javascript">
var url_search = '{URL_SEARCH}';
var lang_del_confirm = '{LANG.confirm}';
var lang_please_select_one = '{LANG.please_select_one}';
var del_token = '{TOKEN}';
// Calendar */
$('#input-date-album').datepicker({
	showOn : "both",
	dateFormat : "dd/mm/yy",
	changeMonth : true,
	changeYear : true,
	showOtherMonths : true,
	buttonImage : nv_base_siteurl + "assets/images/calendar.gif",
	buttonImageOnly : true
    });
    
$("input[type='text']").on("click", function () {
   $(this).select();
   document.execCommand('copy');
});

</script>

<!-- END: main -->