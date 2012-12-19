use Mojolicious::Lite;
plugin 'xslate_renderer';
use LWP::Simple ();
use XML::Simple;
use Encode;
use JSON;

# my $words = ['HTML5', 'WEB'];
sub trim {
		my $str = shift;
		$str =~ s/^\s*(.*?)\s*$/$1/;
		return $str;
	}
my $xml = XML::Simple->new;

get '/' => sub {
	my $self = shift;
	$self->render(country => 'Japan', age => 19, handler => 'tx');
} => 'index';

get '/get_lists/:word' => sub {
	my $self = shift;
	my $stash = $self->stash;
	my $word = decode('UTF-8', $stash->{word});
	my $area = decode('UTF-8', '東京');
	my $hash_total = {};
	my $url = "http://api.atnd.org/events/?keyword_or=$area&ym=201212&keyword=$word";
	my $response = LWP::Simple::get($url);
	my $data = $xml->XMLin($response);	
	my $array = [];
	foreach my $event (@{$data->{events}->{event}}) {
		print %{$event->{ended_at}},"\n";
		my $hash = {
			title => trim($event->{title}),
			event_url => trim($event->{event_url}),
			ended_at => trim($event->{ended_at}->{content})
		};
		push($array, $hash);
	}
	$hash_total->{$word} = $array;
	$self->render_json($hash_total);

	# 配列から取得するパターン
	# foreach my $word (@{$words}) {
	# 	my $url = "http://api.atnd.org/events/?keyword_or=東京&ym=201212&keyword=$word";
	# 	my $response = LWP::Simple::get($url);
	# 	my $data = $xml->XMLin($response);	
	# 	my $array = [];
	# 	foreach my $event (@{$data->{events}->{event}}) {
	# 		print %{$event->{ended_at}},"\n";
	# 		my $hash = {
	# 			title => trim($event->{title}),
	# 			event_url => trim($event->{event_url}),
	# 			ended_at => trim($event->{ended_at}->{content})
	# 		};
	# 		push($array, $hash);
	# 	}
	# 	$hash_total->{decode('UTF-8', $word)} = $array;
	# }
	# $self->render_json($hash_total);
	# print $file JSON->new->encode($hash_total), "\n";

};

app->start;