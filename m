From: Sonic Zhang <sonic.adi@gmail.com>
Subject: [PATCH] mmc: bfin_sdh: Forgot to write SDH_CFG register in function set_ios.
Date: Wed, 16 Oct 2013 13:42:05 +0800
Message-ID: <1381902125-23597-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co9ehsobe005.messaging.microsoft.com ([207.46.163.28]:52675
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750908Ab3JPF2u (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Oct 2013 01:28:50 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org
Cc: adi-buildroot-devel@lists.sourceforge.net, Sonic Zhang <sonic.zhang@analog.com>

From: Sonic Zhang <sonic.zhang@analog.com>

The DMA operation in SDIO CMD53 may fail because the 4 bit SDIO mode
is not set up correctly on BF548.
Remove 2 blank lines as well.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
---
 drivers/mmc/host/bfin_sdh.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/bfin_sdh.c b/drivers/mmc/host/bfin_sdh.c
index 94fae2f..e62c5bc 100644
--- a/drivers/mmc/host/bfin_sdh.c
+++ b/drivers/mmc/host/bfin_sdh.c
@@ -391,6 +391,7 @@ static void sdh_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		/* Disable 4 bit SDIO */
 		cfg &= ~SD4E;
 	}
+	bfin_write_SDH_CFG(cfg);
 
 	host->power_mode = ios->power_mode;
 #ifndef RSI_BLKSZ
@@ -415,7 +416,6 @@ static void sdh_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		cfg &= ~SD_CMD_OD;
 # endif
 
-
 	if (ios->power_mode != MMC_POWER_OFF)
 		cfg |= PWR_ON;
 	else
@@ -433,7 +433,6 @@ static void sdh_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		clk_ctl |= CLK_E;
 		host->clk_div = clk_div;
 		bfin_write_SDH_CLK_CTL(clk_ctl);
-
 	} else
 		sdh_stop_clock(host);
 
-- 
1.8.2.3


