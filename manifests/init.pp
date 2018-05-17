# Tcpwrappers
#
# Mange tcpwrappers by either taking ownership of specific directives with
# file_line or by replacing the entire file content.
#
# @example managing specific rules
#   class { "tcpwrappers":
#     rules_allow => [
#       { "sshd" => "1.1.1.1" },
#       { "nrpe" => "2.2.2.2" },
#       { "ALL"  => "localhost"},
#     ]
#     rules_deny  => [
#       { "ALL"  => "ALL"},
#     ]
#   }
#
# @example managing entire file content
#   class { "tcpwrappers":
#     hosts_allow_content => "sshd: ALL"
#     hosts_deny_content  =>
#       "# entire content of
#       the file will be replaced"
#   }
#
# @example hiera data equivalent
#   tcpwrappers::rules_allow:
#     - sshd: "1.1.1.1"
#     - nrpe: "2.2.2.2"
#     - ALL: "localhost"
#   tcpwrappers::rules_deny: |
#     # managed by puppet
#     ALL: ALL
#
#
# @param warning_message Header to place at the top of each file if managing
#   specific directives
# @param rules_allow List of rules to apply to /etc/hosts.allow (see above)
# @param rules_deny List of rules to apply to /etc/hosts.deny (see above)
# @param hosts_allow_content Replace the entire content of /etc/hosts.allow
#   with this string (overrides `rules_allow`)
# @param hosts_deny_content Replace the entire content of /etc/hosts.deny
#   with this string (overrides `rules_deny`)
class tcpwrappers(
  String $warning_message                  = "# managed by puppet",
  Array[Hash[String, String]] $rules_allow = [],
  Array[Hash[String, String]] $rules_deny  = [],
  Variant[String, Boolean] $hosts_allow_content = false,
  Variant[String, Boolean] $hosts_deny_content = false,
) {


  # hosts.allow
  if $hosts_allow_content {
    $_hosts_allow_content = $hosts_allow_content
  } else {
    $_hosts_allow_content = undef

    fm_prepend {"/etc/hosts.allow":
      ensure => present,
      data   => $warning_message,
    }

    $rules_allow.each |$rule| {
      $rule.each |$key, $value| {
        # fixme needs to eliminate multi matches not replace them all with the same thing!
        file_line { "/etc/hosts.allow rule ${key}=>${value}":
          path     => "/etc/hosts.allow",
          line     => "${key}: ${value}",
          match    => "^${key}",
          multiple => true,
        }
      }
    }
  }

  # hosts.deny
  if $hosts_deny_content {
    $_hosts_deny_content = $hosts_deny_content
  } else {
    $_hosts_deny_content = undef


    fm_prepend {"/etc/hosts.deny":
      ensure => present,
      data   => $warning_message,
    }

    $rules_deny.each |$rule| {
      $rule.each |$key, $value| {
        # fixme needs to eliminate multi matches not replace them all with the same thing!
        file_line { "/etc/hosts.deny rule ${key}=>${value}":
          path     => "/etc/hosts.deny",
          line     => "${key}: ${value}",
          match    => "^${key}",
          multiple => true,
        }
      }
    }
  }

  file { "/etc/hosts.allow":
    ensure  => file,
    owner   => "root",
    group   => "root",
    mode    => "0644",
    content => $_hosts_allow_content,
  }

  file { "/etc/hosts.deny":
    ensure  => file,
    owner   => "root",
    group   => "root",
    mode    => "0644",
    content => $_hosts_deny_content,
  }


}
