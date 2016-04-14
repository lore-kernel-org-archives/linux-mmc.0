From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 0/5] mmc: tmio: make CTL_STATUS handling consistent
Date: Thu, 14 Apr 2016 18:16:44 +0200
Message-ID: <1460650609-2105-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

It took me a little to discover that CTL_STATUS has a different handling than
the other registers. CTL_STATUS and CTL_STATUS2, both u16, are merged into a
virtual u32. However, CTL_STATUS2 was also directly accessed.

Clean this up, make this consistent, and document this. Making the driver less
complex and easier to work with.

Tested on Renesas R-Car Gen2 and Gen3. It is on top of my not-yet applied
series "[PATCH 0/6] mmc: tmio/sdhi: clean up cruft". A complete branch is here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sdhi-uhs

   Wolfram

Wolfram Sang (5):
  mmc: tmio: give read32/write32 functions more descriptive names
  mmc: tmio: use BIT() within defines
  mmc: tmio: use CTL_STATUS consistently
  mmc: tmio/sdhi: distinguish between SCLKDIVEN and ILL_FUNC
  mmc: tmio: document CTL_STATUS handling

 drivers/mmc/host/sh_mobile_sdhi.c |  3 ++-
 drivers/mmc/host/tmio_mmc.h       | 56 ++++++++++++++++++++-------------------
 drivers/mmc/host/tmio_mmc_pio.c   | 24 ++++++++---------
 3 files changed, 43 insertions(+), 40 deletions(-)

-- 
2.7.0
