maintainer       "Joakim Kolsjö"
maintainer_email "joakim.kolsjo;AT;gmail;DOT;com"
license          "Apache 2.0"
description      "Setup development environment (project specific)"
version          "0.1.0"

%w{ ubuntu }.each do |os|
  supports os
end
