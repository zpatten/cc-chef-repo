@quirkafleeg @apps @www
Feature: GDS apps
  In order to run Quirkafleeg
  I need to run the www frontend

  Background:
    * I ssh to "frontend-quirkafleeg-01" with the following credentials:
      | username | keyfile |
      | $lxc$    | $lxc$   |

  Scenario: www exists
    * directory "/var/www/www" should exist
    And directory "/var/www/www/shared" should exist
    And directory "/var/www/www/shared/log" should exist
    And directory "/var/www/www/shared/log" should be owned by "quirkafleeg:quirkafleeg"

  Scenario: Assets have been compiled
    * directory "/var/www/www/current/public/assets/" should exist

  Scenario: env is all good
    * file "/home/quirkafleeg/env" should exist
    And symlink "/var/www/www/current/.env" should exist
    When I run "cat /var/www/www/current/.env"
    Then I should see "RACKSPACE_USERNAME: rax" in the output
    And I should see "RACKSPACE_DIRECTORY_ASSET_HOST: http://3c1" in the output
    And I should see "JENKINS_URL: http://jenkins.theodi.org" in the output
    And I should see "GOVUK_ASSET_ROOT: static.theodi.org" in the output
    And I should see "DEV_DOMAIN: theodi.org" in the output
    And I should see "GOVUK_APP_DOMAIN: theodi.org" in the output
    And I should see "GDS_SSO_STRATEGY: real" in the output
    And I should see "GOVUK_WEBSITE_ROOT: theodi.org" in the output

  Scenario: startup scripts be all up in it
    * file "/etc/init/www.conf" should exist
    And file "/etc/init/www-thin.conf" should exist
    And file "/etc/init/www-thin-1.conf" should exist
    When I run "cat /etc/init/www-thin-1.conf"
    Then I should see "exec su - quirkafleeg -c 'cd /var/www/www/releases/" in the output
    And I should see "export PORT=3020" in the output
    And I should see "bundle exec thin start -p \$PORT >> /var/log/quirkafleeg/www/thin-1.log 2>&1" in the output

  Scenario: www vhost exists
    * file "/var/www/www/current/vhost" should exist

  Scenario: www vhost is correct
    * file "/var/www/www/current/vhost" should contain
  """
upstream www {
  server 127.0.0.1:3020;
}

server {
  listen 8080 default;
  server_name theodi.org;
  access_log /var/log/nginx/www.log;
  error_log /var/log/nginx/www.err;
  root /var/www/www/current/public/;

  location / {
    try_files $uri @backend;
  }

  location ~ ^/(assets)/ {
    gzip_static on; # to serve pre-gzipped version
    expires max;
    add_header Cache-Control public;
  }

  location @backend {
    proxy_set_header X-Forwarded-Proto 'http';
    proxy_set_header Host $server_name;
    proxy_pass http://www;
  }
  """

  Scenario: vhost rewrites are correct
    And file "/var/www/www/current/vhost" should contain
  """
  rewrite ^/about/space$ http://theodi.org/space permanent;
  rewrite ^/people$ http://theodi.org/team permanent;
  rewrite ^/people/nrs$ http://theodi.org/team/nigel-shadbolt permanent;
  rewrite ^/people/(.*)$ http://theodi.org/team/$1 permanent;
  rewrite ^/team/board$ http://theodi.org/team permanent;
  rewrite ^/team/executive$ http://theodi.org/team permanent;
  rewrite ^/team/commercial$ http://theodi.org/team permanent;
  rewrite ^/team/technical$ http://theodi.org/team permanent;
  rewrite ^/team/operations-team$ http://theodi.org/team permanent;
  rewrite ^/join-us$ http://theodi.org/membership permanent;
  rewrite ^/start-up$ http://theodi.org/start-ups permanent;
  rewrite ^/start-up/(.*)$ http://theodi.org/start-ups/$1 permanent;
  rewrite ^/events/OpenDataChallengeSeries$ http://theodi.org/challenge-series permanent;
  rewrite ^/content/ODChallengeSeriesDates$ http://theodi.org/challenge-series/dates permanent;
  rewrite ^/content/crime-and-justice-series$ http://theodi.org/challenge-series/crime-and-justice permanent;
  rewrite ^/content/energy-and-environment-programme$ http://theodi.org/challenge-series/energy-and-environment permanent;
  rewrite ^/events/gallery$ http://theodi.org/events permanent;
  rewrite ^/training$ http://theodi.org/learning permanent;
  rewrite ^/excellence/pg_certificate$ http://theodi.org/pg-certificate permanent;
  rewrite ^/library$ http://theodi.org/ permanent;
  rewrite ^/guide$ http://theodi.org/guides permanent;
  rewrite ^/guide/(.*)$ http://theodi.org/guides/$1 permanent;
  rewrite ^/case-study$ http://theodi.org/case-studies permanent;
  rewrite ^/case-study/(.*)$ http://theodi.org/case-studies/$1-case-study permanent;
  rewrite ^/consultation-response$ http://theodi.org/consultation-responses permanent;
  rewrite ^/consultation-response/(.*)$ http://theodi.org/consultation-responses/$1 permanent;
  rewrite ^/odi-in-the-news$ http://theodi.org/news permanent;
  rewrite ^/feedback$ http://theodi.org/contact permanent;
  rewrite ^/calendar$ http://theodi.org/events permanent;
  rewrite ^/past-events$ http://theodi.org/events permanent;
  rewrite ^/content/news-open-data-institute$ http://theodi.org/newsletters permanent;
  rewrite ^/news/assets$ http://theodi.org/newsroom permanent;
  rewrite ^/media-release$ http://theodi.org/media-releases permanent;
  rewrite ^/media-release/(.*)$ http://theodi.org/media-releases/$1 permanent;
  rewrite ^/sites/default/files/360s/(.*)$ http://theodi.org/360s/$1 permanent;
  rewrite ^/news/bigger-and-better-us.*introducing-our-two-newest-members$ http://theodi.org/news/bigger-and-better-us-introducing-our-two-newest-members permanent;
  rewrite ^/news/odi-startup-demand-logic-saves-king.s-college-london-.390000-year-energy-costs$ http://theodi.org/news/odi-startup-demand-logic-saves-king-s-college-london-390000-year-energy-costs permanent;
  rewrite ^/news/odi-telef.nica-and-mit-set-data-challenge-campus-party-2013$ http://theodi.org/news/odi-telef-nica-and-mit-set-data-challenge-campus-party-2013 permanent;
  rewrite ^/blog/.knowledge-everyone.*my-first-few-months-odi-training-team$ http://theodi.org/blog/knowledge-everyone-my-first-few-months-odi-training-team permanent;
  rewrite ^/blog/guest-blog-innovating-drive-new-economic-insight-new-zealand.s-open-transport-data$ http://theodi.org/blog/guest-blog-innovating-drive-new-economic-insight-new-zealand-s-open-transport-data permanent;
  rewrite ^/news/odi-chairman-nigel-shadbolt-knighted-queen.s-birthday-honours$ http://theodi.org/news/odi-chairman-nigel-shadbolt-knighted-queen-s-birthday-honours permanent;
  rewrite ^/news/odi-welcomes-information-economy-strategy.*launched-g8-innovation-conference$ http://theodi.org/news/odi-welcomes-information-economy-strategy-launched-g8-innovation-conference permanent;
  rewrite ^/blog/training-odi-it.s-date$ http://theodi.org/blog/training-odi-it-s-date permanent;
  rewrite ^/news/odi.s-jeni-tennison-appointed-government.s-new-open-standards-board$ http://theodi.org/news/odi-s-jeni-tennison-appointed-government-s-new-open-standards-board permanent;
  rewrite ^/news/odi-ceo-joins-mayor.s-smart-london-board$ http://theodi.org/news/odi-ceo-joins-mayor-s-smart-london-board permanent;
  rewrite ^/news/odi-based-company-helps-londoners-understand-mayor.s-policing-plans$ http://theodi.org/news/odi-based-company-helps-londoners-understand-mayor-s-policing-plans permanent;
  rewrite ^/news/odi-launches-.850k-scheme-create-businesses-open-data$ http://theodi.org/news/odi-launches-850k-scheme-create-businesses-open-data permanent;
  rewrite ^/news/glasgow-wins-.24m-boost-after-recognising-.revolutionary-impact.-open-data$ http://theodi.org/news/glasgow-wins-24m-boost-after-recognising-revolutionary-impact-open-data permanent;
  rewrite ^/news/gains-opening-supermarket-pricing-information-.should-not-be-under-estimated.-says-odi$ http://theodi.org/news/gains-opening-supermarket-pricing-information-should-not-be-under-estimated-says-odi permanent;
  rewrite ^/blog/guest-blog-.great-prize.-offer-embracing-open-data$ http://theodi.org/blog/guest-blog-great-prize-offer-embracing-open-data permanent;
  rewrite ^/news/.11m-boost-open-data-innovation$ http://theodi.org/news/11m-boost-open-data-innovation permanent;
  rewrite ^/news/inspiration-personal-data-odi.s-midata-hackathon$ http://theodi.org/news/inspiration-personal-data-odi-s-midata-hackathon permanent;
  rewrite ^/blog/guest-blog-odi.s-first-incubator-business-pioneering-open-data$ http://theodi.org/blog/guest-blog-odi-s-first-incubator-business-pioneering-open-data permanent;
}
  """

  Scenario: vhost redirects are correct
    And file "/var/www/www/current/vhost" should contain
  """
  server {
  listen 8080;
  server_name www.theodi.org;
  rewrite ^/(.*) http://theodi.org/$1 permanent;
}
  """
