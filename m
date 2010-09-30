From: Philip Rakity <prakity@marvell.com>
Subject: [RFC] sdhci: add support for sd 3.0 host and hooks for dual data
 rate eMMC
Date: Wed, 29 Sep 2010 22:27:12 -0700
Message-ID: <6E692E1B-FB67-4FB0-9316-9E990CEB89ED@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:51571 "HELO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751577Ab0I3Fck convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 30 Sep 2010 01:32:40 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Zhangfei Gao <zgao6@marvell.com>, Mark Brown <markb@marvell.com>


This code has not been tested on mmc-test but has been patched against.  I have run it against 2.6.32 (with some minor changes).

I wanted to give folks a chance to comment before making it a formal patch.  The code add the hooks into the sdhci layer for 
version 3.0 of the controller, including mmc/eMMC dual data rate support (ddr).    The next RFC adds support for DDR at the mmc layer

The question is how to provide DDR support.  I punted this and added hooks to let the h/w adaption code handle this since
a) tuning may be required and it is unclear what values to set the registers to that will work in all cases
b) higher speed single data -- not sure how to handle this


Philip

>From 0b03d8838cc4a55f05f1bcad950843024a353d3d Mon Sep 17 00:00:00 2001
From: Philip Rakity <prakity@marvell.com>
Date: Wed, 29 Sep 2010 20:46:16 -0700
Subject: [RFC] sdhci: add support for sd 3.0 host and hooks for dual data rate eMMC
 Signed-off-by: Philip Rakity <prakity@marvell.com>

---
 drivers/mmc/host/sdhci.c |   81 +++++++++++++++++++++++++++++++++++++++-------
 drivers/mmc/host/sdhci.h |   51 +++++++++++++++++++++++++++--
 include/linux/mmc/host.h |    1 +
 3 files changed, 118 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 401527d..b17e438 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -76,8 +76,10 @@ static void sdhci_dumpregs(struct sdhci_host *host)
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
@@ -1001,9 +1003,19 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	if (clock == 0)
 		goto out;
 
-	for (div = 1;div < 256;div *= 2) {
-		if ((host->max_clk / div) <= clock)
-			break;
+	if (host->version >= SDHCI_SPEC_300) {
+		if (host->max_clk <= clock)
+			div = 1;
+		else {
+			div = host->max_clk/clock;
+			if (host->max_clk % clock)
+				div++;
+		}
+	} else {
+		for (div = 1;div < 256;div *= 2) {
+			if ((host->max_clk / div) <= clock)
+				break;
+		}
 	}
 	div >>= 1;
 
@@ -1025,6 +1037,9 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 		mdelay(1);
 	}
 
+	clk = (div & SDHCI_CLOCK_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
+	clk |= ((div & SDHCI_CLOCK_DIV_HI_MASK) >> SDHCI_CLOCK_DIV_MASK_LEN)
+			<< SDHCI_CLOCK_DIVIDER_HI_SHIFT;
 	clk |= SDHCI_CLOCK_CARD_EN;
 	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
 
@@ -1169,11 +1184,13 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		sdhci_set_power(host, ios->vdd);
 
 	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
-
-	if (ios->bus_width == MMC_BUS_WIDTH_8)
-		ctrl |= SDHCI_CTRL_8BITBUS;
-	else
-		ctrl &= ~SDHCI_CTRL_8BITBUS;
+	if (host->version >= SDHCI_SPEC_300) {
+		if (ios->bus_width == MMC_BUS_WIDTH_8) {
+			ctrl |= SDHCI_CTRL_8BITBUS;
+			ctrl &= ~SDHCI_CTRL_4BITBUS;
+		} else
+			ctrl &= ~SDHCI_CTRL_8BITBUS;
+	}
 
 	if (ios->bus_width == MMC_BUS_WIDTH_4)
 		ctrl |= SDHCI_CTRL_4BITBUS;
@@ -1189,6 +1206,14 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 
 	/*
+	 * higher speed data rates need tuning - board specific
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
@@ -1692,6 +1717,7 @@ int sdhci_add_host(struct sdhci_host *host)
 {
 	struct mmc_host *mmc;
 	unsigned int caps;
+	unsigned int caps_1;
 	int ret;
 
 	WARN_ON(host == NULL);
@@ -1708,7 +1734,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	host->version = sdhci_readw(host, SDHCI_HOST_VERSION);
 	host->version = (host->version & SDHCI_SPEC_VER_MASK)
 				>> SDHCI_SPEC_VER_SHIFT;
-	if (host->version > SDHCI_SPEC_200) {
+	if (host->version > SDHCI_SPEC_300) {
 		printk(KERN_ERR "%s: Unknown controller version (%d). "
 			"You may experience problems.\n", mmc_hostname(mmc),
 			host->version);
@@ -1717,6 +1743,13 @@ int sdhci_add_host(struct sdhci_host *host)
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
@@ -1779,8 +1812,14 @@ int sdhci_add_host(struct sdhci_host *host)
 		mmc_dev(host->mmc)->dma_mask = &host->dma_mask;
 	}
 
-	host->max_clk =
-		(caps & SDHCI_CLOCK_BASE_MASK) >> SDHCI_CLOCK_BASE_SHIFT;
+	if (host->version >= SDHCI_SPEC_300)
+		host->max_clk =
+			(caps & SDHCI_CLOCK_BASE_MASK_300) >>
+				SDHCI_CLOCK_BASE_SHIFT;
+	else
+		host->max_clk =
+			(caps & SDHCI_CLOCK_BASE_MASK) >>
+				SDHCI_CLOCK_BASE_SHIFT;
 	host->max_clk *= 1000000;
 	if (host->max_clk == 0 || host->quirks &
 			SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN) {
@@ -1815,6 +1854,8 @@ int sdhci_add_host(struct sdhci_host *host)
 	mmc->ops = &sdhci_ops;
 	if (host->ops->get_min_clock)
 		mmc->f_min = host->ops->get_min_clock(host);
+	else if (host->version >= SDHCI_SPEC_300)
+		mmc->f_min = host->max_clk / 2046;
 	else
 		mmc->f_min = host->max_clk / 256;
 	mmc->f_max = host->max_clk;
@@ -1829,6 +1870,22 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
 
+	/* require platform code to handle v3 speeds */
+	if (host->version >= SDHCI_SPEC_300 && host->ops->program_v3_rate) {
+		if (host->ops->support_v3_data_rates &&
+			host->ops->support_v3_data_rates(host, caps_1)) {
+				mmc->caps |= MMC_CAP_DUAL_DATA_RATE;
+				host->flags |= SDHCI_DATA_RATES_300;
+		}
+		else if (caps_1 & (	SDHCI_CAN_DO_SDR50 |
+					SDHCI_CAN_DO_SDR104 |
+					SDHCI_CAN_DO_DDR50)) {
+				host->flags |= SDHCI_DATA_RATES_300;
+			if (caps_1 & SDHCI_CAN_DO_DDR50)
+				mmc->caps |= MMC_CAP_DUAL_DATA_RATE;
+		}
+	}
+
 	mmc->ocr_avail = 0;
 	if (caps & SDHCI_CAN_VDD_330)
 		mmc->ocr_avail |= MMC_VDD_32_33|MMC_VDD_33_34;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d316bc7..1608151 100644
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
@@ -86,6 +86,10 @@
 
 #define SDHCI_CLOCK_CONTROL	0x2C
 #define  SDHCI_DIVIDER_SHIFT	8
+#define  SDHCI_CLOCK_DIV_MASK	0xFF
+#define  SDHCI_CLOCK_DIVIDER_HI_SHIFT	6
+#define  SDHCI_CLOCK_DIV_MASK_LEN	8
+#define  SDHCI_CLOCK_DIV_HI_MASK	0x300
 #define  SDHCI_CLOCK_CARD_EN	0x0004
 #define  SDHCI_CLOCK_INT_STABLE	0x0002
 #define  SDHCI_CLOCK_INT_EN	0x0001
@@ -133,13 +137,32 @@
 
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
 #define  SDHCI_TIMEOUT_CLK_SHIFT 0
 #define  SDHCI_TIMEOUT_CLK_UNIT	0x00000080
 #define  SDHCI_CLOCK_BASE_MASK	0x00003F00
+#define  SDHCI_CLOCK_BASE_MASK_300	0x0000FF00
 #define  SDHCI_CLOCK_BASE_SHIFT	8
 #define  SDHCI_MAX_BLOCK_MASK	0x00030000
 #define  SDHCI_MAX_BLOCK_SHIFT  16
@@ -152,7 +175,20 @@
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
 
@@ -178,6 +214,7 @@
 #define  SDHCI_SPEC_VER_SHIFT	0
 #define   SDHCI_SPEC_100	0
 #define   SDHCI_SPEC_200	1
+#define   SDHCI_SPEC_300	2
 
 struct sdhci_ops;
 
@@ -247,6 +284,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12		(1<<28)
 /* Controller doesn't have HISPD bit field in HI-SPEED SD card */
 #define SDHCI_QUIRK_NO_HISPD_BIT			(1<<29)
+/* Controller is missing capability register 1 (sd 3.0)	*/
+#define SDHCI_QUIRK_MISSING_CAPS_1			(1<<30)
 
 	int			irq;		/* Device IRQ */
 	void __iomem *		ioaddr;		/* Mapped address */
@@ -271,6 +310,7 @@ struct sdhci_host {
 #define SDHCI_USE_ADMA		(1<<1)		/* Host is ADMA capable */
 #define SDHCI_REQ_USE_DMA	(1<<2)		/* Use DMA for this req. */
 #define SDHCI_DEVICE_DEAD	(1<<3)		/* Device unresponsive */
+#define SDHCI_DATA_RATES_300	(1<<4)		/* Host can do V3 data rates */
 
 	unsigned int		version;	/* SDHCI spec. version */
 
@@ -302,6 +342,7 @@ struct sdhci_host {
 	struct timer_list	timer;		/* Timer for timeouts */
 
 	unsigned int		caps;		/* Alternative capabilities */
+	unsigned int		caps_1;		/* Alternative capabilities */
 
 	unsigned long		private[0] ____cacheline_aligned;
 };
@@ -323,6 +364,10 @@ struct sdhci_ops {
 	unsigned int	(*get_max_clock)(struct sdhci_host *host);
 	unsigned int	(*get_min_clock)(struct sdhci_host *host);
 	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
+	int	(*support_v3_data_rates)(struct sdhci_host *host,
+			unsigned int caps_1);
+	int	(*program_v3_rate)(struct sdhci_host *host,
+			struct mmc_ios *ios);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 1575b52..6e63b49 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -157,6 +157,7 @@ struct mmc_host {
 #define MMC_CAP_NONREMOVABLE	(1 << 8)	/* Nonremovable e.g. eMMC */
 #define MMC_CAP_WAIT_WHILE_BUSY	(1 << 9)	/* Waits while card is busy */
 #define MMC_CAP_ERASE		(1 << 10)	/* Allow erase/trim commands */
+#define MMC_CAP_DUAL_DATA_RATE	(1 << 11)	/* MMC can do dual data rate */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
-- 
1.6.0.4

