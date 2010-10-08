From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH] sdhci: 8 bit widths - allow new QUIRK for 8 bit and v3 sd
 controller
Date: Fri, 8 Oct 2010 12:31:34 -0700
Message-ID: <74C0C915-257F-41CC-AEA8-C6F5B839586B@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:60244 "HELO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759493Ab0JHTbh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 8 Oct 2010 15:31:37 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


8 bit width is a new feature in the sd 3.0 spec.  Add checks to
ensure HOST_CONTROL register set 8 bit mode only if sd 3.0

add quirk to indicate that board design supports 8 data lines.
The controller can support 8 data bits but the board design may
only bring out 4 data bits.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci.c  |   24 ++++++++++++++++++++++--
 drivers/mmc/host/sdhci.h  |    3 ++-
 include/linux/mmc/sdhci.h |    2 ++
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ea8472b..90cfdfb 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1189,6 +1189,18 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		host->ops->platform_send_init_74_clocks(host, ios->power_mode);
 
 	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
+	if (ios->bus_width == MMC_BUS_WIDTH_8) {
+		ctrl &= ~SDHCI_CTRL_4BITBUS;
+		if (host->version >= SDHCI_SPEC_300)
+			ctrl |= SDHCI_CTRL_8BITBUS;
+	} else {
+		if (host->version >= SDHCI_SPEC_300)
+			ctrl &= ~SDHCI_CTRL_8BITBUS;
+		if (ios->bus_width == MMC_BUS_WIDTH_4)
+			ctrl |= SDHCI_CTRL_4BITBUS;
+		else
+			ctrl &= ~SDHCI_CTRL_4BITBUS;
+	}
 
 	if (ios->bus_width == MMC_BUS_WIDTH_8)
 		ctrl |= SDHCI_CTRL_8BITBUS;
@@ -1848,8 +1860,16 @@ int sdhci_add_host(struct sdhci_host *host)
 	mmc->f_max = host->max_clk;
 	mmc->caps |= MMC_CAP_SDIO_IRQ;
 
-	if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
-		mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
+	/*
+	 * 8 bit width may be supported by v3 controller but not board.
+	 * so the safest thing is to let the adaptation layer decide
+	 * what to do by using the quirk
+	 */
+	if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA)) {
+		mmc->caps |= MMC_CAP_4_BIT_DATA;
+		if (host->quirks & SDHCI_QUIRK_SLOT_CAN_DO_8_BITS)
+			mmc->caps |= MMC_CAP_8_BIT_DATA;
+	}
 
 	if (caps & SDHCI_CAN_DO_HISPD)
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 38ae340..c87e3c4 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -76,7 +76,7 @@
 #define   SDHCI_CTRL_ADMA1	0x08
 #define   SDHCI_CTRL_ADMA32	0x10
 #define   SDHCI_CTRL_ADMA64	0x18
-#define  SDHCI_CTRL_8BITBUS	0x20
+#define   SDHCI_CTRL_8BITBUS	0x20
 
 #define SDHCI_POWER_CONTROL	0x29
 #define  SDHCI_POWER_ON		0x01
@@ -152,6 +152,7 @@
 #define  SDHCI_CLOCK_BASE_SHIFT	8
 #define  SDHCI_MAX_BLOCK_MASK	0x00030000
 #define  SDHCI_MAX_BLOCK_SHIFT  16
+#define  SDHCI_CAN_DO_8BIT	0x00040000
 #define  SDHCI_CAN_DO_ADMA2	0x00080000
 #define  SDHCI_CAN_DO_ADMA1	0x00100000
 #define  SDHCI_CAN_DO_HISPD	0x00200000
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 1fdc673..5be1cfc 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -83,6 +83,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		(1<<28)
 /* Controller doesn't have HISPD bit field in HI-SPEED SD card */
 #define SDHCI_QUIRK_NO_HISPD_BIT			(1<<29)
+/* slot has 8 data pins going to eMMC/mmc card		*/
+#define SDHCI_QUIRK_SLOT_CAN_DO_8_BITS			(1<<30)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
1.6.0.4

