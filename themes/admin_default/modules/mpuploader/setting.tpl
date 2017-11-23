<!-- BEGIN: main -->
<div id="content">
	<!-- BEGIN: success -->
		<div class="alert alert-success"><i class="fa fa-check-circle"></i>&nbsp;{SUCCESS}</div>
	<!-- END: success -->
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title" style="float:left"><i class="fa fa-pencil"></i>&nbsp;{LANG.setting}</h3>
            <div class="pull-right">
                <button type="submit" form="form-stock" data-toggle="tooltip" id="photos-setting-save" name="photos-setting-save" class="btn btn-primary" title="{LANG.save}"><i class="fa fa-save"></i></button>
				&nbsp;<a href="{CANCEL}" data-toggle="tooltip" class="btn btn-default" title="{LANG.cancel}"><i class="fa fa-reply"></i></a>
            </div>
            <div style="clear:both"></div>
        </div>
		<div class="panel-body">
			<form action="" method="post" enctype="multipart/form-data" id="setting-form" class="form-horizontal">
				<input type="hidden" value="1" name="savesetting" />				
				<input type="hidden" name="{NV_NAME_VARIABLE}" value="{MODULE_NAME}" />
				<input type="hidden" name="{NV_OP_VARIABLE}" value="{OP}" />

				<div class="form-group">
					<label class="col-sm-6 control-label">{LANG.setting_structure_upload}:</label>
					<div class="col-sm-18">
						<select class="form-control w500" name="structure_upload">
							<!-- BEGIN: structure_upload -->
							<option value="{STRUCTURE_UPLOAD.key}" {STRUCTURE_UPLOAD.selected}>{STRUCTURE_UPLOAD.title}</option>
							<!-- END: structure_upload -->
						</select>		
					</div>
				</div>
				<div class="form-group">
					<label class="col-sm-6 control-label">{LANG.setting_max_size_upload}:</label>
					<div class="col-sm-18">
						<select class="form-control w250" name="maxupload">
								<!-- BEGIN: size1 -->
								<option value="{SIZE1.key}" {SIZE1.selected}>{SIZE1.title}</option>
								<!-- END: size1 -->
						</select>
						({LANG.setting_sys_max_size}: {SYS_MAX_SIZE})
					</div>
				</div>
			</form>
            <div class="text-center">
                <button type="submit" form="form-stock" data-toggle="tooltip" id="photos-setting-save" name="photos-setting-save" class="btn btn-primary" title="{LANG.save}"><i class="fa fa-save"></i></button>
				&nbsp;<a href="{CANCEL}" data-toggle="tooltip" class="btn btn-default" title="{LANG.cancel}"><i class="fa fa-reply"></i></a>
            </div>
		</div>
    </div>
</div>
<script type="text/javascript" src="{NV_BASE_SITEURL}themes/admin_default/js/photos_footer.js"></script>
<script type="text/javascript">
$("button[id*='photos-setting-']").on('click', function() 
{
	$("form[id*='setting-']").submit();
});
$("input[name=selectimg]").click(function(){
	var area = "module_logo";
	var type= "image";
	var path= "{PATH}";
	var currentpath= "{CURRENTPATH}";
	nv_open_browse("{NV_BASE_ADMINURL}index.php?" + nv_name_variable + "=upload&popup=1&area=" + area + "&path=" + path + "&type=" + type + "&currentpath=" + currentpath, "NVImg", "850", "420","resizable=no,scrollbars=no,toolbar=no,location=no,status=no");
	return false;
});
</script>

<!-- END: main -->