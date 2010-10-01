From: Philip Rakity <prakity@marvell.com>
Subject: [RFC] sdhci: add support for dual data rate cards sd host v3
Date: Fri, 1 Oct 2010 16:14:55 -0700
Message-ID: <1449F667-34BA-47E8-9912-A5999E726F43@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:42184 "HELO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751963Ab0JAXQc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 1 Oct 2010 19:16:32 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


Code is present for review to see if the approach of using the platform specific code to handle 
Dual Data Rate is an acceptable way to go forward.   Feedback welcome.

Philip


>From b0c26193dfd354d3d1e4d1542432052094782830 Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Fri, 1 Oct 2010 16:09:47 -0700
Subject: [RFC] sdhci: add support for dual data rate cards sd host v3

Provide infrastructure for dual data rate support for sd v3 controller

The parsing of v3 data rates support is provided.  Configuring chip
registers is passed to the platform adaption layer since tuning
may be required and some register values will depend on the specific
board design.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/host/sdhci.c |   39 ++++++++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.h |   43 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ec103c3..d06e770 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -77,8 +77,10 @@ static void sdhci_dumpregs(struct sdhci_host *host)
 	printk(KERN_DEBUG DRIVER_NAME ": AC12 err: 0x%08x | Slot int: 0x%08x\n",
 		sdhci_readw(host, SDHCI_ACMD12_ERR),
 		sdhci_readw(host, SDHCI_SLOT_INT_STATUS));
-	printk(KERN_DEBUG DRIVER_NAME ": Caps:     0x%08x | Max curr: 0x%08x\n",
+	printk(KERN_DEBUG DRIVER_NAME ": Caps:     0x%08x | Caps1:    0x%08x\n",
 		sdhci_readl(host, SDHCI_CAPABILITIES),
+		sdhci_readl(host, SDHCI_CAPABILITIES_1));
+	printk(KERN_DEBUG DRIVER_NAME ": Max curr: 0x%08x\n",
 		sdhci_readl(host, SDHCI_MAX_CURRENT));
 
 	if (host->flags & SDHCI_USE_ADMA)
@@ -1217,6 +1219,14 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 
 	/*
+	 * Higher speed data rates may need tuning - board specific.
+	 * punt handling these speeds to the adoption layer
+	 */
+	if ((host->flags & SDHCI_DATA_RATES_300) &&
+		host->ops->program_v3_rate)
+		host->ops->program_v3_rate(host, ios);
+
+	/*
 	 * Some (ENE) controllers go apeshit on some ios operation,
 	 * signalling timeout and CRC errors even on CMD0. Resetting
 	 * it on each ios seems to solve the problem.
@@ -1720,6 +1730,7 @@ int sdhci_add_host(struct sdhci_host *host)
 {
 	struct mmc_host *mmc;
 	unsigned int caps;
+	unsigned int caps_1;
 	int ret;
 
 	WARN_ON(host == NULL);
@@ -1745,6 +1756,13 @@ int sdhci_add_host(struct sdhci_host *host)
 	caps = (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? host->caps :
 		sdhci_readl(host, SDHCI_CAPABILITIES);
 
+	if (host->version >= SDHCI_SPEC_300) {
+		caps_1 = (host->quirks & SDHCI_QUIRK_MISSING_CAPS_1) ?
+			host->caps_1 : sdhci_readl(host, SDHCI_CAPABILITIES_1);
+	}
+	else
+		caps_1 = 0;
+
 	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
 		host->flags |= SDHCI_USE_SDMA;
 	else if (!(caps & SDHCI_CAN_DO_SDMA))
@@ -1873,6 +1891,25 @@ int sdhci_add_host(struct sdhci_host *host)
 	    mmc_card_is_removable(mmc))
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
 
+	/* require platform code to handle v3 speeds */
+	if (host->version >= SDHCI_SPEC_300 && host->ops->program_v3_rate) {
+		if (host->ops->support_v3_data_rates &&
+			host->ops->support_v3_data_rates(host, caps_1)) {
+				mmc->caps |= MMC_CAP_1_8V_DDR;
+				mmc->caps |= MMC_CAP_1_2V_DDR;
+				host->flags |= SDHCI_DATA_RATES_300;
+		}
+		else if (caps_1 & (	SDHCI_CAN_DO_SDR50 |
+					SDHCI_CAN_DO_SDR104 |
+					SDHCI_CAN_DO_DDR50)) {
+				host->flags |= SDHCI_DATA_RATES_300;
+			if (caps_1 & SDHCI_CAN_DO_DDR50) {
+				mmc->caps |= MMC_CAP_1_8V_DDR;
+				mmc->caps |= MMC_CAP_1_2V_DDR;
+			}
+		}
+	}
+
 	mmc->ocr_avail = 0;
 	if (caps & SDHCI_CAN_VDD_330)
 		mmc->ocr_avail |= MMC_VDD_32_33|MMC_VDD_33_34;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index b3288fd..e86e690 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -137,7 +137,25 @@
 
 #define SDHCI_ACMD12_ERR	0x3C
 
-/* 3E-3F reserved */
+#define HOST_CONTROL_2		0x3E
+#define  SDHCI_CTL2_UHS_MODE_SEL_SDR12		0
+#define  SDHCI_CTL2_UHS_MODE_SEL_SDR25		1
+#define  SDHCI_CTL2_UHS_MODE_SEL_SDR50		2
+#define  SDHCI_CTL2_UHS_MODE_SEL_SDR104		3
+#define  SDHCI_CTL2_UHS_MODE_SEL_DDR50		4
+#define  SDHCI_CTL2_UHS_MODE_MASK		0x7
+#define  SDHCI_CTL2_UHS_MODE_SHIFT		0
+#define  SDHCI_CTL2_SDH_V18_EN			0x00000008
+#define  SDHCI_CTL2_DRV_STRENGTH_SEL_B		0
+#define  SDHCI_CTL2_DRV_STRENGTH_SEL_A		1
+#define  SDHCI_CTL2_DRV_STRENGTH_SEL_C		2
+#define  SDHCI_CTL2_DRV_STRENGTH_SEL_D		3
+#define  SDHCI_CTL2_DRV_STRENGTH_MASK		0x3
+#define  SDHCI_CTL2_DRV_STRENGTH_SHIFT		4
+#define  SDHCI_CTL2_EXE_TUNING			0x00000040
+#define  SDHCI_CTL2_SAMPLING_CLK_SEL		0x00000080
+#define  SDHCI_CTL2_ASYNC_INT_EN		0x00004000
+#define  SDHCI_CTL2_PRE_VAL_EN			0x00008000
 
 #define SDHCI_CAPABILITIES	0x40
 #define  SDHCI_TIMEOUT_CLK_MASK	0x0000003F
@@ -158,7 +176,20 @@
 #define  SDHCI_CAN_VDD_180	0x04000000
 #define  SDHCI_CAN_64BIT	0x10000000
 
-/* 44-47 reserved for more caps */
+#define SDHCI_CAPABILITIES_1	0x44
+#define  SDHCI_CAN_DO_SDR50	0x00000001
+#define  SDHCI_CAN_DO_SDR104	0x00000002
+#define  SDHCI_CAN_DO_DDR50	0x00000004
+#define  SDHCI_DRIVER_TYPE_A	0x00000010
+#define  SDHCI_DRIVER_TYPE_C	0x00000020
+#define  SDHCI_DRIVER_TYPE_D	0x00000040
+#define  SDHCI_RETUNING_TIME_COUNT_MASK	0x00000F00
+#define  SDHCI_RETUNING_TIME_COUNT_SHIFT	8
+#define  SDHCI_USE_TUNING_DDR50	0x00002000
+#define  SDHCI_RETUNING_MODE_MASK	0x0000C000
+#define  SDHCI_RETUNING_MODE_SHIFT	14
+#define  SDHCI_CLOCK_MULTIPLIER_MASK	0x00FF0000
+#define  SDHCI_CLOCK_MULTIPLIER_SHIFT	16
 
 #define SDHCI_MAX_CURRENT	0x48
 
@@ -263,6 +294,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_NO_HISPD_BIT			(1<<29)
 /* slot has 8 data pins going to eMMC/mmc card		*/
 #define SDHCI_QUIRK_SLOT_CAN_DO_8_BITS			(1<<30)
+/* Controller is missing capability register 1 (sd 3.0)	*/
+#define SDHCI_QUIRK_MISSING_CAPS_1			(1<<31)
 
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
@@ -287,6 +320,7 @@ struct sdhci_host {
 #define SDHCI_USE_ADMA		(1<<1)		/* Host is ADMA capable */
 #define SDHCI_REQ_USE_DMA	(1<<2)		/* Use DMA for this req. */
 #define SDHCI_DEVICE_DEAD	(1<<3)		/* Device unresponsive */
+#define SDHCI_DATA_RATES_300	(1<<4)		/* Host can do V3 data rates */
 
 	unsigned int		version;	/* SDHCI spec. version */
 
@@ -318,6 +352,7 @@ struct sdhci_host {
 	struct timer_list	timer;		/* Timer for timeouts */
 
 	unsigned int		caps;		/* Alternative capabilities */
+	unsigned int		caps_1;		/* Alternative capabilities */
 
 	unsigned long		private[0] ____cacheline_aligned;
 };
@@ -341,6 +376,10 @@ struct sdhci_ops {
 	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
 	int 		(*platform_8bit_width)(struct sdhci_host *host,
 				int width);
+	int		(*support_v3_data_rates)(struct sdhci_host *host,
+				unsigned int caps_1);
+	int		(*program_v3_rate)(struct sdhci_host *host,
+				struct mmc_ios *ios);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
1.6.0.4

