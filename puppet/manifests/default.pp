node default {
    include jenkins

    jenkins::plugin {
        'git' :
            version => '2.2.1';
    }

    jenkins::plugin {
        'credentials' :
            version => '1.10';
    }

    jenkins::plugin {
        'scm-api' :
            version => '0.2';
    }

    jenkins::plugin {
        'git-client' :
            version => '1.8.0';
    }

    jenkins::plugin {
        'ssh-credentials' :
            version => '1.6.1';
    }
}
