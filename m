From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: [PATCH V2 2/3] mmc: mmci: Provide option to configure bus signal direction
Date: Mon, 24 Oct 2011 15:28:47 +0200
Message-ID: <1319462928-14892-3-git-send-email-ulf.hansson@stericsson.com>
References: <1319462928-14892-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:40543 "EHLO
	eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932555Ab1JXN3r (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2011 09:29:47 -0400
In-Reply-To: <1319462928-14892-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Rasmussen <sebastian.rasmussen@stericsson.com>

The ST Micro variant supports bus signal direction indication. A new
member in the variant struct is added for this.

Moreover the actual signal direction configuration is board specific,
thus the amba mmci platform data is extended with a new member to be
able provide mmci with these specific board configurations.

This patch is based upon a patch from Sebastian Rasmussen.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Signed-off-by: Sebastian Rasmussen <sebastian.rasmussen@stericsson.com>
---
 drivers/mmc/host/mmci.c   |   21 +++++++++++++++++++++
 drivers/mmc/host/mmci.h   |   10 ----------
 include/linux/amba/mmci.h |   16 ++++++++++++++++
 3 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 1296719..55e460c 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -54,6 +54,7 @@ static unsigned int fmax = 515633;
  * @st_clkdiv: true if using a ST-specific clock divider algorithm
  * @blksz_datactrl16: true if Block size is at b16..b30 position in datactrl register
  * @pwrreg_powerup: power up value for MMCIPOWER register
+ * @signal_direction: input/out direction of bus signals can be indicated
  */
 struct variant_data {
 	unsigned int		clkreg;
@@ -65,6 +66,7 @@ struct variant_data {
 	bool			st_clkdiv;
 	bool			blksz_datactrl16;
 	u32			pwrreg_powerup;
+	bool			signal_direction;
 };
 
 static struct variant_data variant_arm = {
@@ -88,6 +90,7 @@ static struct variant_data variant_u300 = {
 	.datalength_bits	= 16,
 	.sdio			= true,
 	.pwrreg_powerup		= MCI_PWR_ON,
+	.signal_direction	= true,
 };
 
 static struct variant_data variant_ux500 = {
@@ -99,6 +102,7 @@ static struct variant_data variant_ux500 = {
 	.sdio			= true,
 	.st_clkdiv		= true,
 	.pwrreg_powerup		= MCI_PWR_ON,
+	.signal_direction	= true,
 };
 
 static struct variant_data variant_ux500v2 = {
@@ -111,6 +115,7 @@ static struct variant_data variant_ux500v2 = {
 	.st_clkdiv		= true,
 	.blksz_datactrl16	= true,
 	.pwrreg_powerup		= MCI_PWR_ON,
+	.signal_direction	= true,
 };
 
 /*
@@ -1054,6 +1059,22 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		break;
 	}
 
+	if (variant->signal_direction && ios->power_mode != MMC_POWER_OFF) {
+		/*
+		 * The ST Micro variant has some additional bits
+		 * indicating signal direction for the signals in
+		 * the SD/MMC bus and feedback-clock usage.
+		 */
+		pwr |= host->plat->sigdir;
+
+		if (ios->bus_width == MMC_BUS_WIDTH_4)
+			pwr &= ~MCI_ST_DATA74DIREN;
+		else if (ios->bus_width == MMC_BUS_WIDTH_1)
+			pwr &= (~MCI_ST_DATA74DIREN &
+				~MCI_ST_DATA31DIREN &
+				~MCI_ST_DATA2DIREN);
+	}
+
 	if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN) {
 		if (host->hw_designer != AMBA_VENDOR_ST)
 			pwr |= MCI_ROD;
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 79e4143..5600755 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -13,16 +13,6 @@
 #define MCI_PWR_ON		0x03
 #define MCI_OD			(1 << 6)
 #define MCI_ROD			(1 << 7)
-/*
- * The ST Micro version does not have ROD and reuse the voltage registers
- * for direction settings
- */
-#define MCI_ST_DATA2DIREN	(1 << 2)
-#define MCI_ST_CMDDIREN		(1 << 3)
-#define MCI_ST_DATA0DIREN	(1 << 4)
-#define MCI_ST_DATA31DIREN	(1 << 5)
-#define MCI_ST_FBCLKEN		(1 << 7)
-#define MCI_ST_DATA74DIREN	(1 << 8)
 
 #define MMCICLOCK		0x004
 #define MCI_CLK_ENABLE		(1 << 8)
diff --git a/include/linux/amba/mmci.h b/include/linux/amba/mmci.h
index 2111481..8ce34e8 100644
--- a/include/linux/amba/mmci.h
+++ b/include/linux/amba/mmci.h
@@ -6,6 +6,19 @@
 
 #include <linux/mmc/host.h>
 
+
+/*
+ * These defines is places here due to access is needed from machine
+ * configuration files. The ST Micro version does not have ROD and
+ * reuse the voltage registers for direction settings.
+ */
+#define MCI_ST_DATA2DIREN	(1 << 2)
+#define MCI_ST_CMDDIREN		(1 << 3)
+#define MCI_ST_DATA0DIREN	(1 << 4)
+#define MCI_ST_DATA31DIREN	(1 << 5)
+#define MCI_ST_FBCLKEN		(1 << 7)
+#define MCI_ST_DATA74DIREN	(1 << 8)
+
 /* Just some dummy forwarding */
 struct dma_chan;
 
@@ -30,6 +43,8 @@ struct dma_chan;
  * @cd_invert: true if the gpio_cd pin value is active low
  * @capabilities: the capabilities of the block as implemented in
  * this platform, signify anything MMC_CAP_* from mmc/host.h
+ * @sigdir: a bit field indicating for what bits in the MMC bus the host
+ * should enable signal direction indication.
  * @dma_filter: function used to select an appropriate RX and TX
  * DMA channel to be used for DMA, if and only if you're deploying the
  * generic DMA engine
@@ -52,6 +67,7 @@ struct mmci_platform_data {
 	int	gpio_cd;
 	bool	cd_invert;
 	unsigned long capabilities;
+	u32 sigdir;
 	bool (*dma_filter)(struct dma_chan *chan, void *filter_param);
 	void *dma_rx_param;
 	void *dma_tx_param;
-- 
1.7.5.4

