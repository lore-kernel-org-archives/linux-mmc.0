From: Philip Rakity <prakity@marvell.com>
Subject: [RFC]  sdhci: 8 bit bus width changes
Date: Fri, 1 Oct 2010 15:45:50 -0700
Message-ID: <B76798A1-FA3F-4D7D-A22A-52289A4062FB@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:42974 "HELO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751466Ab0JAWqt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 1 Oct 2010 18:46:49 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

>From 80c581d354df180a4c2d6aa50c21788e6c7593b9 Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Fri, 1 Oct 2010 13:42:58 -0700
Subject: [RFC] sdhci: 8 bit bus width changes

Check for v3 controller controller when doing 8 bit bus width
add support for adaption layer to set 8 bit width.
	controller may support 8 bit bus but NOT board design
allow non v3 controllers to support 8 bit bus

non v3 controller (platform_8bit_width)
=======================================
platform_8bit_width is used to support 8 bit mode using our v2
sd controller.  We have private registers that are used for 8 bit support

v2 - v3 controller and 8 bit support (SDHCI_QUIRK_SLOT_CAN_DO_8_BITS)
=====================================================================
The quirk is needed since we support multiple SD controllers and
on the board sometimes 8 data lines are brought out and sometimes only 4. 
The SD controller indicates it can support 8 bit (v3 controller) via the
capability field but has no knowledge of how the pins were configured
in the board design. There are only so many pins and the pins are multiplexed.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci.c |   44 +++++++++++++++++++++++++++++++++-----------
 drivers/mmc/host/sdhci.h |    7 ++++++-
 2 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 73a94fe..ec103c3 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1182,17 +1182,31 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		sdhci_set_power(host, ios->vdd);
 
-	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
 
-	if (ios->bus_width == MMC_BUS_WIDTH_8)
-		ctrl |= SDHCI_CTRL_8BITBUS;
-	else
-		ctrl &= ~SDHCI_CTRL_8BITBUS;
+	/*
+	 * use platform_8_bit_width if not v3 controller
+	 * or if special hw/board specific processing is needed
+	 */
+	if (host->ops->platform_8bit_width)
+		host->ops->platform_8bit_width(host, ios->bus_width);
+	else {
+		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
+		if (ios->bus_width == MMC_BUS_WIDTH_8) {
+			ctrl &= ~SDHCI_CTRL_4BITBUS;
+			if (host->version >= SDHCI_SPEC_300)
+				ctrl |= SDHCI_CTRL_8BITBUS;
+		} else {
+			if (host->version >= SDHCI_SPEC_300)
+				ctrl &= ~SDHCI_CTRL_8BITBUS;
+			if (ios->bus_width == MMC_BUS_WIDTH_4)
+				ctrl |= SDHCI_CTRL_4BITBUS;
+			else
+				ctrl &= ~SDHCI_CTRL_4BITBUS;
+		}
+		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+	}
 
-	if (ios->bus_width == MMC_BUS_WIDTH_4)
-		ctrl |= SDHCI_CTRL_4BITBUS;
-	else
-		ctrl &= ~SDHCI_CTRL_4BITBUS;
+	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
 
 	if (ios->timing == MMC_TIMING_SD_HS &&
 	    !(host->quirks & SDHCI_QUIRK_NO_HISPD_BIT))
@@ -1838,11 +1852,19 @@ int sdhci_add_host(struct sdhci_host *host)
 		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_300;
 	else
 		mmc->f_min = host->max_clk / SDHCI_MAX_DIV_SPEC_200;
+
 	mmc->f_max = host->max_clk;
 	mmc->caps |= MMC_CAP_SDIO_IRQ;
 
-	if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
-		mmc->caps |= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA;
+	/* 8 bit width may be supported by v3 controller but not board
+	 * so the safest thing is to let the adaption layer decide
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
index 112543a..b3288fd 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -72,7 +72,7 @@
 #define   SDHCI_CTRL_ADMA1	0x08
 #define   SDHCI_CTRL_ADMA32	0x10
 #define   SDHCI_CTRL_ADMA64	0x18
-#define  SDHCI_CTRL_8BITBUS	0x20
+#define   SDHCI_CTRL_8BITBUS	0x20
 
 #define SDHCI_POWER_CONTROL	0x29
 #define  SDHCI_POWER_ON		0x01
@@ -148,6 +148,7 @@
 #define  SDHCI_CLOCK_BASE_SHIFT	8
 #define  SDHCI_MAX_BLOCK_MASK	0x00030000
 #define  SDHCI_MAX_BLOCK_SHIFT  16
+#define  SDHCI_CAN_DO_8BIT	0x00040000
 #define  SDHCI_CAN_DO_ADMA2	0x00080000
 #define  SDHCI_CAN_DO_ADMA1	0x00100000
 #define  SDHCI_CAN_DO_HISPD	0x00200000
@@ -260,6 +261,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		(1<<28)
 /* Controller doesn't have HISPD bit field in HI-SPEED SD card */
 #define SDHCI_QUIRK_NO_HISPD_BIT			(1<<29)
+/* slot has 8 data pins going to eMMC/mmc card		*/
+#define SDHCI_QUIRK_SLOT_CAN_DO_8_BITS			(1<<30)
 
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
@@ -336,6 +339,8 @@ struct sdhci_ops {
 	unsigned int	(*get_max_clock)(struct sdhci_host *host);
 	unsigned int	(*get_min_clock)(struct sdhci_host *host);
 	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
+	int 		(*platform_8bit_width)(struct sdhci_host *host,
+				int width);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.6.0.4

