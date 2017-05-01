From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 0/6] tmio/sdhi: add cmd23 support
Date: Mon,  1 May 2017 11:03:40 +0200
Message-ID: <20170501090346.10801-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

This series adds CMD23 support to SDHI. It was tested on H2 (Gen2, Lager) and
M3W (Gen3, Salvator-X). The test procedure can be found here:

http://elinux.org/Tests:SDHI-CMD23

Patches are based on mmc/next from today. A branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/topic/sdhi-cmd23

The reason these patches are RFC is that they should not be applied right now.
We also have some heavier refactoring going on and it is likely to be better to
apply these patches after the refactoring. However, I send them out now to
encourage review and testing. They do work as expected in my tests.

Thanks and kind regards,

   Wolfram


Wolfram Sang (6):
  mmc: tmio: make tmio_mmc_request function more readable
  mmc: tmio: refactor handling mrq
  mmc: tmio: remove outdated comment
  mmc: tmio: move finish_request function further down
  mmc: tmio: add CMD23 support
  mmc: sdhi: add CMD23 support to R-Car Gen2 & Gen3

 drivers/mmc/host/sh_mobile_sdhi.c |   4 +-
 drivers/mmc/host/tmio_mmc_pio.c   | 135 ++++++++++++++++++++++----------------
 2 files changed, 80 insertions(+), 59 deletions(-)

-- 
2.11.0
