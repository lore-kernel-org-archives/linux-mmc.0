From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 0/3] mmc: host: tmio: sdio irq improvements
Date: Thu, 19 Jan 2017 21:07:15 +0100
Message-ID: <20170119200718.8115-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:49377 "EHLO pokefinder.org"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1754494AbdASUPo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 19 Jan 2017 15:15:44 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>

Here is a small series with two minor improvements (patches 1+2) and one bigger
change (patch 3) for SDIO handling with TMIO/SDHI. Since RFC, I addressed all
comments (Thanks Simon!) and since it is needed for the WLAN cards, I think it
should go in now.


Wolfram Sang (3):
  mmc: host: tmio: refactor calls to sdio irq
  mmc: host: tmio: SDIO_STATUS_QUIRK is rather SDIO_STATUS_SETBITS
  mmc: tmio: discard obsolete SDIO irqs before enabling irqs

 drivers/mmc/host/sh_mobile_sdhi.c |  6 ++----
 drivers/mmc/host/tmio_mmc.h       |  2 ++
 drivers/mmc/host/tmio_mmc_pio.c   | 20 ++++++++++++++------
 include/linux/mfd/tmio.h          |  6 ++----
 4 files changed, 20 insertions(+), 14 deletions(-)

-- 
2.11.0

