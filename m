From: Sonic Zhang <sonic.adi@gmail.com>
Subject: [PATCH 4/4] mmc: bfin_sdh: Reset SD controller when resume from power saving mode.
Date: Tue, 7 Aug 2012 11:10:15 +0800
Message-ID: <1344309015-13248-4-git-send-email-sonic.adi@gmail.com>
References: <1344309015-13248-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe005.messaging.microsoft.com ([216.32.180.188]:29236
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932613Ab2HGDBJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Aug 2012 23:01:09 -0400
In-Reply-To: <1344309015-13248-1-git-send-email-sonic.adi@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Bob Liu <liubbo@gmail.com>, uclinux-dist-devel@blackfin.uclinux.org, Sonic Zhang <sonic.zhang@analog.com>

From: Sonic Zhang <sonic.zhang@analog.com>

Without reset, SD controller may stay in disable mode, SD card can't
be detected when resume from power saving mode.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
---
 drivers/mmc/host/bfin_sdh.c |   35 +++++++++++++++++++----------------
 1 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/bfin_sdh.c b/drivers/mmc/host/bfin_sdh.c
index 57b7548..a95a09a 100644
--- a/drivers/mmc/host/bfin_sdh.c
+++ b/drivers/mmc/host/bfin_sdh.c
@@ -512,6 +512,23 @@ static irqreturn_t sdh_stat_irq(int irq, void *devid)
 	return IRQ_RETVAL(handled);
 }
 
+static void sdh_reset(void)
+{
+#if defined(CONFIG_BF54x)
+	/* Secure Digital Host shares DMA with Nand controller */
+	bfin_write_DMAC1_PERIMUX(bfin_read_DMAC1_PERIMUX() | 0x1);
+#endif
+
+	bfin_write_SDH_CFG(bfin_read_SDH_CFG() | CLKS_EN);
+	SSYNC();
+
+	/* Disable card inserting detection pin. set MMC_CAP_NEEDS_POLL, and
+	 * mmc stack will do the detection.
+	 */
+	bfin_write_SDH_CFG((bfin_read_SDH_CFG() & 0x1F) | (PUP_SDDAT | PUP_SDDAT3));
+	SSYNC();
+}
+
 static int __devinit sdh_probe(struct platform_device *pdev)
 {
 	struct mmc_host *mmc;
@@ -588,19 +605,8 @@ static int __devinit sdh_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "unable to request peripheral pins\n");
 		goto out4;
 	}
-#if defined(CONFIG_BF54x)
-	/* Secure Digital Host shares DMA with Nand controller */
-	bfin_write_DMAC1_PERIMUX(bfin_read_DMAC1_PERIMUX() | 0x1);
-#endif
 
-	bfin_write_SDH_CFG(bfin_read_SDH_CFG() | CLKS_EN);
-	SSYNC();
-
-	/* Disable card inserting detection pin. set MMC_CAP_NEEDS_POLL, and
-	 * mmc stack will do the detection.
-	 */
-	bfin_write_SDH_CFG((bfin_read_SDH_CFG() & 0x1F) | (PUP_SDDAT | PUP_SDDAT3));
-	SSYNC();
+	sdh_reset();
 
 	mmc_add_host(mmc);
 	return 0;
@@ -667,10 +673,7 @@ static int sdh_resume(struct platform_device *dev)
 		return ret;
 	}
 
-#if defined(CONFIG_BF54x)
-	/* Secure Digital Host shares DMA with Nand controller */
-	bfin_write_DMAC1_PERIMUX(bfin_read_DMAC1_PERIMUX() | 0x1);
-#endif
+	sdh_reset();
 
 	if (mmc)
 		ret = mmc_resume_host(mmc);
-- 
1.7.0.4


