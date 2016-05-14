use 5.24.0;

package React {
    use experimental 'signatures';
    sub import {
        my $caller = caller;
        {
            no strict 'refs';
            *{ $caller . "::whenever" } = \&whenever;
            *{ $caller . "::react" }    = \&react;
        }
        require feature;
        feature->import(":5.24");
    }
    sub whenever ($supply, $callback) {
        $supply->($callback);
    }
    sub react ($callback) :prototype(&) {
        $callback->();
        Mojo::IOLoop->start unless Mojo::IOLoop->is_running;
    }
}

package Mojo::SlackRTM {
    use experimental 'signatures';
    sub subscribe ($self, $event) {
        sub ($callback) {
            $self->on($event, sub ($self, $message) {
                $callback->($message);
            });
        };
    }
}

1;
