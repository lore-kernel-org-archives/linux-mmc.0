From: Sonic Zhang <sonic.adi@gmail.com>
Subject: [PATCH 3/4] mmc: bfin_sdh: Remove redundent suspend and resume setting.
Date: Tue, 7 Aug 2012 11:10:14 +0800
Message-ID: <1344309015-13248-3-git-send-email-sonic.adi@gmail.com>
References: <1344309015-13248-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:25617
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932610Ab2HGDBJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Aug 2012 23:01:09 -0400
In-Reply-To: <1344309015-13248-1-git-send-email-sonic.adi@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Bob Liu <liubbo@gmail.com>, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>, Bob Liu <lliubbo@gmail.com>

From: Sonic Zhang <sonic.zhang@analog.com>

mmc core suspend and resume functions had already called sdh_set_ios with proper flags.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
Signed-off-by: Bob Liu <lliubbo@gmail.com>
---
 drivers/mmc/host/bfin_sdh.c |   15 ---------------
 1 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/bfin_sdh.c b/drivers/mmc/host/bfin_sdh.c
index fa085a0..57b7548 100644
--- a/drivers/mmc/host/bfin_sdh.c
+++ b/drivers/mmc/host/bfin_sdh.c
@@ -650,11 +650,6 @@ static int sdh_suspend(struct platform_device *dev, pm_message_t state)
 	if (mmc)
 		ret = mmc_suspend_host(mmc);
 
-#ifndef RSI_BLKSZ
-	bfin_write_SDH_PWR_CTL(bfin_read_SDH_PWR_CTL() & ~PWR_ON);
-#else
-	bfin_write_SDH_CFG(bfin_read_SDH_CFG() & ~PWR_ON);
-#endif
 	peripheral_free_list(drv_data->pin_req);
 
 	return ret;
@@ -676,16 +671,6 @@ static int sdh_resume(struct platform_device *dev)
 	/* Secure Digital Host shares DMA with Nand controller */
 	bfin_write_DMAC1_PERIMUX(bfin_read_DMAC1_PERIMUX() | 0x1);
 #endif
-#ifndef RSI_BLKSZ
-	bfin_write_SDH_PWR_CTL(bfin_read_SDH_PWR_CTL() | PWR_ON);
-	bfin_write_SDH_CFG(bfin_read_SDH_CFG() | CLKS_EN);
-#else
-	bfin_write_SDH_CFG(bfin_read_SDH_CFG() | CLKS_EN | PWR_ON);
-#endif
-	SSYNC();
-
-	bfin_write_SDH_CFG((bfin_read_SDH_CFG() & 0x1F) | (PUP_SDDAT | PUP_SDDAT3));
-	SSYNC();
 
 	if (mmc)
 		ret = mmc_resume_host(mmc);
-- 
1.7.0.4


