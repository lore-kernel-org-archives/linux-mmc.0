From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 0/3] Use devm_* managed functions to ease slot-gpio users
Date: Tue, 11 Dec 2012 22:32:17 +0800
Message-ID: <1355236340-21304-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:33798
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753114Ab2LKOc0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Dec 2012 09:32:26 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>

Changes since v1:
 * Add kernel doc for mmc_gpio_request/free_ro/cd() to document the
   use cases.
 * Add a patch to remove unncessary mmc_gpio_free_cd() call from
   existing slot-gpio users.

Shawn Guo (3):
  mmc: slot-gpio: use devm_* managed functions to ease users
  mmc: remove unncessary mmc_gpio_free_cd() call from slot-gpio users
  mmc: sdhci-esdhc-imx: use slot-gpio helpers for CD and WP

 drivers/mmc/core/slot-gpio.c       |   57 ++++++++++++++++++++++++++++++++----
 drivers/mmc/host/sdhci-esdhc-imx.c |   56 ++++++++++-------------------------
 drivers/mmc/host/sdhci-pxav3.c     |    5 ----
 drivers/mmc/host/sh_mmcif.c        |    6 ----
 drivers/mmc/host/tmio_mmc_pio.c    |    8 -----
 5 files changed, 67 insertions(+), 65 deletions(-)

-- 
1.7.9.5


