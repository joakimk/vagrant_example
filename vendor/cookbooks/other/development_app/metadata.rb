maintainer       "Joakim Kolsjö"
maintainer_email "joakim.kolsjo;AT;gmail;DOT;com"
license          "Apache 2.0"
description      "Setup an application for development using apache and passenger"
version          "0.2.0"

%w{ ubuntu }.each do |os|
  supports os
end
