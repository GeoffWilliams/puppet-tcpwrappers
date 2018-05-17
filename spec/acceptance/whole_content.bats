@test "hosts.allow whole content replaced" {
  grep "HOSTS_ALLOW_CONTENT" /etc/hosts.allow
}

@test "hosts.deny whole content replaced" {
  grep "HOSTS_DENY_CONTENT" /etc/hosts.deny
}