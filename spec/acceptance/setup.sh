#!/bin/bash

cat > /etc/hosts.allow << EOF

# fake hosts allow file
sshd: 6.6.6.1
sshd: 6.6.6.2
foo: 6.6.6.6

EOF


cat > /etc/hosts.deny << EOF

# fake hosts deny file
ALL: ALL

EOF
