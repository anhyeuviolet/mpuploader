<?php

/**
 * @Project PHOTOS 4.x
 * @Author KENNY NGUYEN (nguyentiendat713@gmail.com)
 * @Copyright (C) 2015 tradacongnghe.com. All rights reserved
 * @Based on NukeViet CMS
 * @License GNU/GPL version 2 or any later version
 * @Createdate  Fri, 18 Sep 2015 11:52:59 GMT
 */

if( !defined( 'NV_IS_FILE_ADMIN' ) )
	die( 'Stop!!!' );
//show list files
$per_page = 50;
$page = $nv_Request->get_int( 'page', 'get', 1 );
$album_id = $nv_Request->get_int( 'album_id', 'get', 0 );

$data['filter_status'] = $nv_Request->get_string( 'filter_status', 'get', '' );
$data['filter_rows_name'] = strip_tags( $nv_Request->get_string( 'filter_rows_name', 'get', '' ) );
$data['filter_date_added'] = $nv_Request->get_string( 'filter_date_added', 'get', '' );
$data['filter_album'] = $nv_Request->get_int( 'filter_album', 'get', 0 );

$sort = $nv_Request->get_string( 'sort', 'get', '' );
$order = $nv_Request->get_string( 'order', 'get' ) == 'desc' ? 'desc' : 'asc';

// Truy van SQL
$sql = TABLE_PHOTO_NAME . '_rows WHERE 1';

$url_add = NV_BASE_ADMINURL . "index.php?" . NV_LANG_VARIABLE . "=" . NV_LANG_DATA . "&" . NV_NAME_VARIABLE . "=" . $module_name . "&" . NV_OP_VARIABLE . "=main&action=add";
if( $album_id > 0 ){
    $sql .= ' AND album_id=' . $album_id;
    $album_name = $global_photo_album[$album_id]['name'];
    $url_add = NV_BASE_ADMINURL . "index.php?" . NV_LANG_VARIABLE . "=" . NV_LANG_DATA . "&" . NV_NAME_VARIABLE . "=" . $module_name . "&" . NV_OP_VARIABLE . "=main&action=edit&token=" . md5( $global_config['sitekey'] . session_id( ) . $album_id ) . "&album_id=" . $album_id;
}

if( !empty( $data['filter_album'] ) )
{
	$sql .= " AND album_id = " . $data['filter_album'];
}

if( !empty( $data['filter_rows_name'] ) )
{
	$sql .= " AND name LIKE '%" . $db->dblikeescape( $data['filter_rows_name'] ) . "%'";
}

$num_items = $db->query( 'SELECT COUNT(*) FROM ' . $sql )->fetchColumn( );

$base_url = NV_BASE_ADMINURL . 'index.php?' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=viewalbum&amp;sort=' . $sort . '&amp;order=' . $order . '&amp;per_page=' . $per_page;

$db->sqlreset( )->select( '*' )->from( $sql )->limit( $per_page )->offset( ($page - 1) * $per_page );

$result = $db->query( $db->sql( ) );

$array = array( );
while( $rows = $result->fetch( ) )
{
	$array[] = $rows;
}

$page_title = '';

$xtpl = new XTemplate( 'viewalbum.tpl', NV_ROOTDIR . '/themes/' . $global_config['module_theme'] . '/modules/' . $module_file );
$xtpl->assign( 'LANG', $lang_module );
$xtpl->assign( 'NV_LANG_VARIABLE', NV_LANG_VARIABLE );
$xtpl->assign( 'NV_LANG_DATA', NV_LANG_DATA );
$xtpl->assign( 'NV_BASE_SITEURL', NV_BASE_SITEURL );
$xtpl->assign( 'THEME', $global_config['site_theme'] );
$xtpl->assign( 'NV_BASE_ADMINURL', NV_BASE_ADMINURL );
$xtpl->assign( 'NV_NAME_VARIABLE', NV_NAME_VARIABLE );
$xtpl->assign( 'NV_OP_VARIABLE', NV_OP_VARIABLE );
$xtpl->assign( 'OP', $op );
$xtpl->assign( 'MODULE_FILE', $module_file );
$xtpl->assign( 'MODULE_NAME', $module_name );
$xtpl->assign( 'DATA', $data );
if( isset ( $album_name ) and ! empty ( $album_name ) ) {
    $xtpl->assign( 'ALBUM_NAME', $album_name );
}
$xtpl->assign( 'MAXUPLOAD', $module_config[$module_name]['maxupload'] );
$xtpl->assign( 'TOKEN', md5( $global_config['sitekey'] . session_id( ) ) );
$xtpl->assign( 'URL_SEARCH', NV_BASE_ADMINURL . 'index.php?' . NV_NAME_VARIABLE . '=' . $module_name . '&' . NV_OP_VARIABLE . '=' . $op . '&action=get_album' );

$order2 = ($order == 'asc') ? 'desc' : 'asc';
$xtpl->assign( 'URL_NAME', NV_BASE_ADMINURL . 'index.php?' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=' . $op . '&amp;sort=name&amp;order=' . $order2 . '&amp;per_page=' . $per_page );
$xtpl->assign( 'URL_WEIGHT', NV_BASE_ADMINURL . 'index.php?' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=' . $op . '&amp;sort=weight&amp;order=' . $order2 . '&amp;per_page=' . $per_page );
$xtpl->assign( 'URL_category', NV_BASE_ADMINURL . 'index.php?' . NV_NAME_VARIABLE . '=' . $module_name . '&amp;' . NV_OP_VARIABLE . '=' . $op . '&amp;sort=category_id&amp;order=' . $order2 . '&amp;per_page=' . $per_page );

$xtpl->assign( 'ADD_NEW', $url_add );

foreach( $global_photo_album as $key => $value )
{
	$xtitle_i = $value['name'];
	$xtpl->assign( 'category', array(
		'key' => $key,
		'name' => $xtitle_i,
		'selected' => ($key == $data['filter_album']) ? 'selected="selected"' : ''
	) );
	$xtpl->parse( 'main.filter_album' );

}


if( !empty( $array ) )
{
	foreach( $array as $item )
	{
        // var_dump($item);die;
		$item['date_added'] = nv_date( 'd/m/Y', $item['date_added'] );
		$item['token'] = md5( $global_config['sitekey'] . session_id( ) . $item['row_id'] );
        $item['file_url'] = NV_MY_DOMAIN . NV_BASE_SITEURL . NV_UPLOADS_DIR . '/' . $module_file . '/files/' . $item['file'];
		$item['edit'] = NV_BASE_ADMINURL . "index.php?" . NV_LANG_VARIABLE . "=" . NV_LANG_DATA . "&" . NV_NAME_VARIABLE . "=" . $module_name . "&" . NV_OP_VARIABLE . "=viewalbum&action=edit&token=" . $item['token'] . "&row_id=" . $item['row_id'];
		$xtpl->assign( 'LOOP', $item );

		foreach( $array_status as $key => $name )
		{
			$xtpl->assign( 'STATUS', array(
				'key' => $key,
				'name' => $name,
				'selected' => ($key == $item['status']) ? 'selected="selected"' : ''
			) );
			$xtpl->parse( 'main.loop.status' );
		}
		$xtpl->parse( 'main.loop' );
	}
}

$generate_page = nv_generate_page( $base_url, $num_items, $per_page, $page );
if( !empty( $generate_page ) )
{
	$xtpl->assign( 'GENERATE_PAGE', $generate_page );
	$xtpl->parse( 'main.generate_page' );
}

$xtpl->parse( 'main' );
$contents = $xtpl->text( 'main' );

include NV_ROOTDIR . '/includes/header.php';
echo nv_admin_theme( $contents );
include NV_ROOTDIR . '/includes/footer.php';
