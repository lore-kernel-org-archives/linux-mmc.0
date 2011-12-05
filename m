From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH 07/14] mmc: mmci: Change vdd_handler to a generic ios_handler
Date: Mon, 5 Dec 2011 18:35:53 +0100
Message-ID: <1323106560-5218-8-git-send-email-ulf.hansson@stericsson.com>
References: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141]:40438 "EHLO
	eu1sys200aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932624Ab1LERge (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Dec 2011 12:36:34 -0500
In-Reply-To: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Rasmussen <sebastian.rasmussen@stericsson.com>

The purpose of the vdd_handler does not make sense. We remove it
and use a generic approach instead. A new ios_handler is added, the
purpose of which e.g. can be to control GPIO pins to a levelshifter.

Previously the vdd_handler was also used for making additional
changes to the power register bits. This option is superfluous and is
therefore removed.

Adaptaptions from the old vdd_handler to the new ios_handler is done for
mach-ux500 board, which was the only one using the vdd_handler.

This patch is based upon a patch from Sebastian Rasmussen.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Signed-off-by: Sebastian Rasmussen <sebastian.rasmussen@stericsson.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-sdi.c |   21 ++++++++-------------
 drivers/mmc/host/mmci.c                |    8 ++++----
 include/linux/amba/mmci.h              |    6 +++---
 3 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500-sdi.c b/arch/arm/mach-ux500/board-mop500-sdi.c
index 6826fae..3578c51 100644
--- a/arch/arm/mach-ux500/board-mop500-sdi.c
+++ b/arch/arm/mach-ux500/board-mop500-sdi.c
@@ -25,21 +25,13 @@
  * SDI 0 (MicroSD slot)
  */
 
-/* MMCIPOWER bits */
-#define MCI_DATA2DIREN		(1 << 2)
-#define MCI_CMDDIREN		(1 << 3)
-#define MCI_DATA0DIREN		(1 << 4)
-#define MCI_DATA31DIREN		(1 << 5)
-#define MCI_FBCLKEN		(1 << 7)
-
 /* GPIO pins used by the sdi0 level shifter */
 static int sdi0_en = -1;
 static int sdi0_vsel = -1;
 
-static u32 mop500_sdi0_vdd_handler(struct device *dev, unsigned int vdd,
-				   unsigned char power_mode)
+static int mop500_sdi0_ios_handler(struct device *dev, struct mmc_ios *ios)
 {
-	switch (power_mode) {
+	switch (ios->power_mode) {
 	case MMC_POWER_UP:
 	case MMC_POWER_ON:
 		/*
@@ -59,8 +51,7 @@ static u32 mop500_sdi0_vdd_handler(struct device *dev, unsigned int vdd,
 		break;
 	}
 
-	return MCI_FBCLKEN | MCI_CMDDIREN | MCI_DATA0DIREN |
-	       MCI_DATA2DIREN | MCI_DATA31DIREN;
+	return 0;
 }
 
 #ifdef CONFIG_STE_DMA40
@@ -84,13 +75,17 @@ static struct stedma40_chan_cfg mop500_sdi0_dma_cfg_tx = {
 #endif
 
 static struct mmci_platform_data mop500_sdi0_data = {
-	.vdd_handler	= mop500_sdi0_vdd_handler,
+	.ios_handler	= mop500_sdi0_ios_handler,
 	.ocr_mask	= MMC_VDD_29_30,
 	.f_max		= 50000000,
 	.capabilities	= MMC_CAP_4_BIT_DATA |
 				MMC_CAP_SD_HIGHSPEED |
 				MMC_CAP_MMC_HIGHSPEED,
 	.gpio_wp	= -1,
+	.sigdir		= MCI_ST_FBCLKEN |
+				MCI_ST_CMDDIREN |
+				MCI_ST_DATA0DIREN |
+				MCI_ST_DATA2DIREN,
 #ifdef CONFIG_STE_DMA40
 	.dma_filter	= stedma40_filter,
 	.dma_rx_param	= &mop500_sdi0_dma_cfg_rx,
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index d95555e..e900f51 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1019,6 +1019,10 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	unsigned long flags;
 	int ret;
 
+	if (host->plat->ios_handler &&
+		host->plat->ios_handler(mmc_dev(mmc), ios))
+			dev_err(mmc_dev(mmc), "platform ios_handler failed\n");
+
 	switch (ios->power_mode) {
 	case MMC_POWER_OFF:
 		if (host->vcc)
@@ -1038,10 +1042,6 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 				return;
 			}
 		}
-		if (host->plat->vdd_handler)
-			pwr |= host->plat->vdd_handler(mmc_dev(mmc), ios->vdd,
-						       ios->power_mode);
-
 		/*
 		 * The ST Micro variant doesn't have the PL180s MCI_PWR_UP
 		 * and instead uses MCI_PWR_ON so apply whatever value is
diff --git a/include/linux/amba/mmci.h b/include/linux/amba/mmci.h
index 8ce34e8..84766fd 100644
--- a/include/linux/amba/mmci.h
+++ b/include/linux/amba/mmci.h
@@ -31,7 +31,8 @@ struct dma_chan;
  * @ocr_mask: available voltages on the 4 pins from the block, this
  * is ignored if a regulator is used, see the MMC_VDD_* masks in
  * mmc/host.h
- * @vdd_handler: a callback function to translate a MMC_VDD_*
+ * @ios_handler: a callback function to act on specfic ios changes,
+ * used for example to control a levelshifter
  * mask into a value to be binary (or set some other custom bits
  * in MMCIPWR) or:ed and written into the MMCIPWR register of the
  * block.  May also control external power based on the power_mode.
@@ -60,8 +61,7 @@ struct dma_chan;
 struct mmci_platform_data {
 	unsigned int f_max;
 	unsigned int ocr_mask;
-	u32 (*vdd_handler)(struct device *, unsigned int vdd,
-			   unsigned char power_mode);
+	int (*ios_handler)(struct device *, struct mmc_ios *);
 	unsigned int (*status)(struct device *);
 	int	gpio_wp;
 	int	gpio_cd;
-- 
1.7.5.4

