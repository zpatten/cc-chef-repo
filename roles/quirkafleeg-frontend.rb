name "quirkafleeg-frontend"
description "quirkafleeg frontend wrapper role"

default_attributes(
    :apps => {
        'frontend-www' => {
            :deploy_name  => 'www',
            :port         => 3020,
            :is_default   => true,
            :naked_domain => true,
            :redirects    => {
                "^/about/space$"                                                                                     => "/space",
                "^/people$"                                                                                          => "/team",
                "^/people/nrs$"                                                                                      => "/team/nigel-shadbolt",
                "^/people/(.*)$"                                                                                     => "/team/$1",
                "^/team/board$"                                                                                      => "/team",
                "^/team/executive$"                                                                                  => "/team",
                "^/team/commercial$"                                                                                 => "/team",
                "^/team/technical$"                                                                                  => "/team",
                "^/team/operations-team$"                                                                            => "/team",
                "^/join-us$"                                                                                         => "/membership",
                "^/start-up$"                                                                                        => "/start-ups",
                "^/start-up/(.*)$"                                                                                   => "/start-ups/$1",
                "^/events/OpenDataChallengeSeries$"                                                                  => "/challenge-series",
                "^/content/ODChallengeSeriesDates$"                                                                  => "/challenge-series/dates",
                "^/content/crime-and-justice-series$"                                                                => "/challenge-series/crime-and-justice",
                "^/content/energy-and-environment-programme$"                                                        => "/challenge-series/energy-and-environment",
                "^/events/gallery$"                                                                                  => "/events",
                "^/training$"                                                                                        => "/learning",
                "^/excellence/pg_certificate$"                                                                       => "/pg-certificate",
                "^/library$"                                                                                         => "/",
                "^/guide$"                                                                                           => "/guides",
                "^/guide/(.*)$"                                                                                      => "/guides/$1",
                "^/case-study$"                                                                                      => "/case-studies",
                "^/case-study/(.*)$"                                                                                 => "/case-studies/$1-case-study",
                "^/consultation-response$"                                                                           => "/consultation-responses",
                "^/consultation-response/(.*)$"                                                                      => "/consultation-responses/$1",
                "^/odi-in-the-news$"                                                                                 => "/news",
                "^/feedback$"                                                                                        => "/contact",
                "^/calendar$"                                                                                        => "/events",
                "^/past-events$"                                                                                     => "/events",
                "^/content/news-open-data-institute$"                                                                => "/newsletters",
                "^/news/assets$"                                                                                     => "/newsroom",
                "^/media-release$"                                                                                   => "/media-releases",
                "^/media-release/(.*)$"                                                                              => "/media-releases/$1",
                "^/sites/default/files/360s/(.*)$"                                                                   => "/360s/$1",
                "^/blog/odi-summit-qa-kevin-merritt$"                                                                => "/blog/odi-summit-qa-with-kevin-merritt",
                "^/blog/odi-summit-qa-beth-simone-noveck$"                                                           => "/blog/odi-summit-qa-with-beth-simone-noveck",
                "^/news/bigger-and-better-us-[^-]*-introducing-our-two-newest-members$"                              => "/news/a-bigger-and-better-introducing-our-newest-members",
                "^/blog/odi-summit-qa-martin-tisne$"                                                                 => "/blog/odi-summit-qa-with-martin-tisne",
                "^/news/new-initiatives-combat-crime-open-data-0$"                                                   => "/news/new-initiatives-combat-crime-open-data",
                "^/news/odi-startup-demand-logic-saves-king[^-]*s-college-london-[^-]*390000-year-energy-costs$"     => "/news/odi-startup-demand-logic-saves-king-s-college-london-390000-year-energy-costs",
                "^/blog/odi-celebrates-first-birthday-announcing-university-southampton-honorary-partner$"           => "/news/odi-celebrates-first-birthday-announcing-university-southampton-honorary-partner",
                "^/blog/[^-]*knowledge-everyone[^-]*-[^-]*-my-first-few-months-odi-training-team$"                   => "/blog/knowledge-everyone-my-first-few-months-odi-training-team",
                "^/blog/guest-blog-innovating-drive-new-economic-insight-new-zealand[^-]*s-open-transport-data$"     => "/blog/guest-blog-innovating-drive-new-economic-insight-new-zealand-s-open-transport-data",
                "^/news/odi-chairman-nigel-shadbolt-knighted-queen[^-]*s-birthday-honours$"                          => "/news/odi-chairman-nigel-shadbolt-knighted-queen-s-birthday-honours",
                "^/news/odi-welcomes-information-economy-strategy-[^-]*-launched-g8-innovation-conference$"          => "/news/odi-welcomes-information-economy-strategy-launched-g8-innovation-conference",
                "^/blog/training-odi-it[^-]*s-date$"                                                                 => "/blog/training-odi-it-s-date",
                "^/news/odi[^-]*s-jeni-tennison-appointed-government[^-]*s-new-open-standards-board$"                => "/news/odi-s-jeni-tennison-appointed-government-s-new-open-standards-board",
                "^/news/odi-ceo-joins-mayor[^-]*s-smart-london-board$"                                               => "/news/odi-ceo-joins-mayor-s-smart-london-board",
                "^/news/odi-based-company-helps-londoners-understand-mayor[^-]*s-policing-plans$"                    => "/news/odi-based-company-helps-londoners-understand-mayor-s-policing-plans",
                "^/news/glasgow-wins-..24m-boost-after-recognising-[^-]*revolutionary-impact[^-]*-open-data$"        => "/news/glasgow-wins-24m-boost-after-recognising-revolutionary-impact-open-data",
                "^/news/gains-opening-supermarket-pricing-information-...should-not-be-under-estimated...-says-odi$" => "/news/gains-opening-supermarket-pricing-information-should-not-be-under-estimated-says-odi",
                "^/blog/guest-blog-...great-prize...-offer-embracing-open-data$"                                     => "/blog/guest-blog-great-prize-offer-embracing-open-data",
                "^/news/inspiration-personal-data-odi[^-]*s-midata-hackathon$"                                       => "/news/inspiration-personal-data-odi-s-midata-hackathon",
                "^/blog/guest-blog-odi[^-]*s-first-incubator-business-pioneering-open-data$"                         => "/blog/guest-blog-odi-s-first-incubator-business-pioneering-open-data",
                "^/news/odi-telef..nica-and-mit-set-data-challenge-campus-party-2013$"                               => "/news/odi-telef-nica-and-mit-set-data-challenge-campus-party-2013",
                "^/news/odi-launches-..850k-scheme-create-businesses-open-data$"                                     => "/news/odi-launches-850k-scheme-create-businesses-open-data",
                "^/news/..11m-boost-open-data-innovation$"                                                           => "/news/11m-boost-open-data-innovation",
                "^/news/branding$"                                                                                   => "/newsroom",
                "^/news/feed$"                                                                                       => "/news.atom",
                "^/jobs/feed$"                                                                                       => "/jobs.atom",
                "^/events/feed$"                                                                                     => "/events.atom"
            }
        },
        #        'people'           => {
        #            :port    => 3000
        #        },
        #        'frontend-news'    => {
        #            :deploy_name => 'news',
        #            :port        => 3010
        #        },
        #        'frontend-courses' => {
        #            :deploy_name => 'courses',
        #            :port        => 3030
        #        },
    }
)

override_attributes(
    :varnish => {
        :listen_port  => 80,
        :backend_host => '127.0.0.1'
    }
)

run_list(
    "role[quirkafleeg]",
    "recipe[varnish]"
)