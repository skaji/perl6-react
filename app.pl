#!/usr/bin/env perl
use 5.24.0;
use experimental 'signatures';
use React;
use Mojo::SlackRTM;

my $slack = Mojo::SlackRTM->new(token => $ENV{SLACK_TOKEN});
$slack->connect;

react {
    whenever $slack->subscribe("message") => sub ($message) {
        my $user = $slack->find_user_name($message->{user});
        my $channel = $message->{channel};
        $slack->send_message($channel => "hello, $user!");
    };
};
