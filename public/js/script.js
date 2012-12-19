$(function(){
	$.ajax({
		url : '/get_lists/WEB',
		dataType : 'json',
		success : function(res){
			var lists = Object.keys(res),
				i = 0,
				len = lists.length,
				src = '<dl>',
				t,d,j;
			for(;i < len;i++){
				t = lists[i];
				d = res[t];
				console.log(d);
				src+='<dt>'+t+'</dt>';
				for(j = 0, jLen = d.length;j < jLen;j++){
					src+='<dd><a href="'+d[j].event_url+'">'+d[j].title+'</a></dd>';
				}
			}
			src+='</dl>';
			$('body').html(src);
		},
		error : function(){
			// alert();
		}
	});
});