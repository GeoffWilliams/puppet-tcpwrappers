# @PDQTest
class { "tcpwrappers":
  hosts_allow_content => "HOSTS_ALLOW_CONTENT",
  hosts_deny_content => "HOSTS_DENY_CONTENT",
  rules_allow => [
    { "sshd" => "1.1.1.1" },
    { "nrpe" => "2.2.2.2" },
    { "ALL"  => "localhost"},
  ],
  rules_deny => [
    { "sshd" => "1.1.1.1" },
    { "nrpe" => "2.2.2.2" },
    { "ALL"  => "localhost"},
  ],
}