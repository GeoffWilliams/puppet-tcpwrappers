@test "header for hosts.allow" {
    grep "by puppet" /etc/hosts.allow
}

@test "header for hosts.deny" {
    grep "by puppet" /etc/hosts.deny
}


@test "rule for sshd" {
    grep "sshd: 1.1.1.1" /etc/hosts.allow
}

@test "removes existing bad rules for sshd" {
    ! grep "sshd: 6.6.6" /etc/hosts.allow
}

@test "rule for nrpe" {
    grep "nrpe: 2.2.2.2" /etc/hosts.allow
}

@test "leaves unmanaged rules alone" {
    grep "foo: 6.6.6.6" /etc/hosts.allow
}