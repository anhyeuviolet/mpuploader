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
			<h3 class="panel-title" style="float:left"><i class="fa fa-list"></i> Danh sách File</h3> 
			 <div class="pull-right">
				<a href="{ADD_NEW}" data-toggle="tooltip" data-placement="top" title="{LANG.add_new}" class="btn btn-success"><i class="fa fa-plus"></i></a>
				<button type="button" data-toggle="tooltip" data-placement="top" title="{LANG.delete}" class="btn btn-danger" id="button-delete">
					<i class="fa fa-trash-o"></i>
				</button>
			</div>
			<div style="clear:both"></div>
		</div>
		<div class="panel-body">
			<div class="well">
				<div class="row">	
					<form action="{NV_BASE_ADMINURL}index.php" method="get">
                        <input type="hidden" name ="{NV_NAME_VARIABLE}"value="{MODULE_NAME}" />
                        <input type="hidden" name ="{NV_OP_VARIABLE}"value="{OP}" />
                        <div class="col-md-12">
                            <div class="form-group col-md-12">
                                <input type="text" name="filter_rows_name" value="{DATA.filter_rows_name}" placeholder="Tên File" id="input-album-name" class="form-control">
                            </div>
                            <div class="form-group col-md-12">
                                <select name="filter_album" id="input-album" class="form-control">
                                    <option value="">Tất cả Album</option>
                                    <!-- BEGIN: filter_album -->
                                    <option value="{category.key}" {category.selected}>{category.name}</option>
                                    <!-- END: filter_album -->
                                </select>
                            </div>
                        </div>
                        <div class="col-md-12">                            
                            <div class="form-group col-md-8">
                                <input type="text" name="filter_date_added" value="{DATA.filter_date_added}" placeholder="{LANG.album_date_added}" id="input-date-album" class="form-control">
                            </div>
                            <input type="hidden" name ="checkss" value="{TOKEN}" />
                            <div class="form-group col-md-8">
                                <button type="submit" id="button-filter" class="btn btn-primary pull-right" data-toggle="tooltip" title="{LANG.search}"><i class="fa fa-search"></i> {LANG.search}</button>
                            </div>
                        </div>
					</form>
				</div>
			</div>
		
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
                                    <label class="labelradio deleterows_album" data-toggle="tooltip" title="{LANG.delete}" data-row="{LOOP.row_id}" data-album_id="{LOOP.album_id}" data-token="{LOOP.token}" data-token-image="{LOOP.token_image}" data-token-thumb="{LOOP.token_thumb}" data-key="{LOOP.key}" >
                                        <i class="fa fa-spinner fa-lg  fa-spin"></i>
                                        <i class="fa fa-trash-o fa-lg fixtrash"></i>
                                    </label>	
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

<script type="text/javascript" src="{NV_BASE_SITEURL}themes/admin_default/js/mpuploader_footer.js"></script>
<script type="text/javascript">
var url_search = '{URL_SEARCH}';
var lang_del_confirm = '{LANG.confirm}';
var lang_please_select_one = '{LANG.please_select_one}';
var del_token = '{TOKEN}';
var album_error_name = '{LANG.album_error_name}';
var album_error_folder = '{LANG.album_error_folder}';
var album_error_category = '{LANG.album_error_category}';

var lang_confirm = '{LANG.confirm}';
var lang_check_form = '{LANG.check_form}';
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
</script>

<!-- END: main -->