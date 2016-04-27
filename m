From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v3 0/5] mmc: tmio: make CTL_STATUS handling consistent
Date: Wed, 27 Apr 2016 18:51:22 +0200
Message-ID: <1461775887-12786-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:57105 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752992AbcD0Qvm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Apr 2016 12:51:42 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>

It took me a little to discover that CTL_STATUS has a different handling than
the other registers. CTL_STATUS and CTL_STATUS2, both u16, are merged into a
virtual u32. However, CTL_STATUS2 was also directly accessed.

Clean this up, make this consistent, and document this. Making the driver less
complex and easier to work with.

Tested on Renesas R-Car Gen2 and Gen3.

Changes since V2:

* rebased to mmc/next. Sorry Ulf, my branch had an older version of your next
  included and I missed the update :(


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

