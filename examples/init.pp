# @PDQTest
class { "tcpwrappers":
  rules_deny => [
    {"ALL" => "ALL"}
  ],
  rules_allow => [
    { "sshd" => "1.1.1.1" },
    { "nrpe" => "2.2.2.2" },
    { "ALL"  => "localhost"},
  ]
}
