import Perl6 react syntax to Perl5

```perl
use React;
use Mojo::SlackRTM;
use experimental 'signatures';

my $slack = Mojo::SlackRTM->new(token => $ENV{SLACK_TOKEN});
$slack->connect;

react {
    whenever $slack->subscribe("message") => sub ($event) {
        my $user = $slack->find_user_name($event->{user});
        my $channel = $event->{channel};
        $slack->send_message($channel => "hello, $user!");
    };
    whenever $slack->subscribe("reaction_added") => sub ($event) {
        my $reaction = $event->{reaction};
        my $user = $slack->find_user_name($event->{user});
        my $channel = $event->{item}{channel};
        $slack->send_message($channel => "$user added $reaction!!");
    };
};
```
