From: Philip Rakity <prakity@marvell.com>
Subject: [PATCH ] mmc: sdhci: Support for SD/MMC Dual Data Rate
Date: Fri, 21 Jan 2011 11:33:07 -0800
Message-ID: <D815F4FD-882A-44A3-8496-950A7808997D@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:48917 "HELO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754859Ab1AUTfs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 21 Jan 2011 14:35:48 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>


Sent again as this patch fits into the sequence for the other patches.

The patch sent yesterday will apply directly but this patch replies on the other patches in the set being sent.

** V4 Changes **
sdhci set_ddr does not change signaling voltage when core/
layer indicates this is not needed.  eMMC cards working at 3.3V
do not need to have their i/o signaling level changed since
they are obviously working and 3.3v or lower vccq is supported.
(we do not know if a 3.3V card supports 1.8V vccq).

Similarly eMMC cards working at 1.8V do not need their
signaling voltage changed.

The DDR value on the card only tells us it works at 1.8V or
3.3V or both.

eMMC
Voltage (vcc)  and i/o signaling (vccq) allowed
vcc
3.3V    3.3v vccq  -  1.8v vccq   -   1.2v vccq
1.8V               -  1.8v vccq   -   1.2v vccq
1.2V                              -   1.2v vccq

We have a single voltage eMMC (which is all we support since
dual voltage cards are not supported). We have no idea what
vccq it is operating at.  eMMC cards are usually mounted on the
board.  For a eMMC not operating at 1.2V vccq
we signal the host/ layer to leave
the signaling voltage alone since we are obviously working.
We have no idea if switching the card to 1.8V vccq is
supported by the card.

If the eMMC card indicates it supports 1.2V vccq we
notify the driver since 1.2V core voltage (vcc) is not
supported and a i/o signal voltage change will be needed.
Note:  SD Host Controller (sdhci.c) does not support 1.2V
vcc.

Rules for SD DDR are different.
vccq change occurs after a CMD11.

========
** V3 Changes **
caps_h renamed caps_spec30
ddr mode rather than voltage passed as parameter into
signaling callback

bit shifts used instead of values for bit definitions
for HOST_CAPABILITY_1

========

mmc->caps MMC_CAP_1_8V_DDR is set by looking at cabability_1
register if sd 3.0 controller.

Support for dual data rate (DDR50) with 1_8V signalling added
with optional call back to enable external control of signalling
voltage.

no support for 1.2V core voltage since SD 3.0 does not support
this.

**** QUESTION ****
should this be part of regulator framework ?

delay for signaling voltage to settle set to 5ms (per spec).

this code does not change the voltage supplied to the card.
It assumes that this is correctly handled in the core/ layer.

There is no requirement that the card voltage be at 1.8v
for DDR to work.  This violates DDR specification for
SD Host Controller 3.0 since explicitly states card voltage
is 3.3v while signalling voltage is set to 1.8v.

tested on mmp2 -- brownstone -- under linux-next.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/core/mmc.c    |   24 ++++++++++++++++++---
 drivers/mmc/host/sdhci.c  |   49 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/mmc/host/sdhci.h  |    5 ++++
 include/linux/mmc/host.h  |    3 +-
 include/linux/mmc/sdhci.h |    2 +
 5 files changed, 75 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 16006ef..c139a5e 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -522,10 +522,26 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	 */
 	if (mmc_card_highspeed(card)) {
 		if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_DDR_1_8V)
-			&& (host->caps & (MMC_CAP_1_8V_DDR)))
-				ddr = MMC_1_8V_DDR_MODE;
-		else if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_DDR_1_2V)
-			&& (host->caps & (MMC_CAP_1_2V_DDR)))
+			&& (host->caps & MMC_CAP_1_8V_DDR)) {
+			/*
+			 * eMMC cards can support 3.3V to 1.2V i/o (vccq)
+			 * signaling.
+			 *
+			 * EXT_CSD_CARD_TYPE_DDR_1_8V means 3.3V or 1.8V vccq.
+			 *
+			 * 3.3V vccq at 3.3V core voltage (vcc) is not required
+			 * in the JEDEC spec.  Normal usage is expected to be
+			 * 1.8V vccq and 3.3v vcc.
+			 *
+			 * Do not force change in vccq since we are obviously
+			 * working and no change to vccq is needed.
+			 *
+			 * WARNING: eMMC rules are NOT the same as SD DDR
+			 */
+			ddr = MMC_3_3V_TO_1_2V_DDR;
+		} else if ((card->ext_csd.card_type &
+				EXT_CSD_CARD_TYPE_DDR_1_2V)
+			&& (host->caps & MMC_CAP_1_2V_DDR))
 				ddr = MMC_1_2V_DDR_MODE;
 	}
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ff9d5f0..92be22d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -84,6 +84,8 @@ static void sdhci_dumpregs(struct sdhci_host *host)
 	printk(KERN_DEBUG DRIVER_NAME ": Cmd:      0x%08x | Max curr: 0x%08x\n",
 		sdhci_readw(host, SDHCI_COMMAND),
 		sdhci_readl(host, SDHCI_MAX_CURRENT));
+	printk(KERN_DEBUG DRIVER_NAME ": HostCtrl2:0x%08x\n",
+		sdhci_readw(host, SDHCI_HOST_CONTROL_2));
 
 	if (host->flags & SDHCI_USE_ADMA)
 		printk(KERN_DEBUG DRIVER_NAME ": ADMA Err: 0x%08x | ADMA Ptr: 0x%08x\n",
@@ -1000,6 +1002,35 @@ static void sdhci_finish_command(struct sdhci_host *host)
 	host->cmd = NULL;
 }
 
+/*
+ * Handle DDR signaling
+ * changing to  1.2V signaling vccq not supported.
+ */
+static void sdhci_set_ddr(struct sdhci_host *host, unsigned int ddr)
+{
+	u16 con;
+
+	if (ddr == MMC_SDR_MODE || host->ddr == ddr)
+		return;
+
+	host->ddr = ddr;
+
+	/* Change signaling voltage and wait for it to be stable */
+	if (host->ops->set_signaling_voltage)
+		host->ops->set_signaling_voltage(host, ddr);
+	else if (ddr == MMC_1_8V_DDR_MODE) {
+		con = sdhci_readw(host, SDHCI_HOST_CONTROL_2);
+		con |= SDCTRL_2_SDH_V18_EN;
+		sdhci_writew(host, con, SDHCI_HOST_CONTROL_2);
+		mdelay(5);
+	}
+
+	con = sdhci_readw(host, SDHCI_HOST_CONTROL_2);
+	con &= ~SDCTRL_2_UHS_MODE_MASK;
+	con |= SDCTRL_2_UHS_MODE_SEL_DDR50;
+	sdhci_writew(host, con, SDHCI_HOST_CONTROL_2);
+}
+
 static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 {
 	int div;
@@ -1194,6 +1225,7 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	}
 
 	sdhci_set_clock(host, ios->clock);
+	sdhci_set_ddr(host, ios->ddr);
 
 	if (ios->power_mode == MMC_POWER_OFF)
 		sdhci_set_power(host, -1);
@@ -1758,7 +1790,7 @@ EXPORT_SYMBOL_GPL(sdhci_alloc_host);
 int sdhci_add_host(struct sdhci_host *host)
 {
 	struct mmc_host *mmc;
-	unsigned int caps, ocr_avail;
+	unsigned int caps, caps_spec3, ocr_avail;
 	int ret;
 
 	WARN_ON(host == NULL);
@@ -1781,8 +1813,19 @@ int sdhci_add_host(struct sdhci_host *host)
 			host->version);
 	}
 
-	caps = (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? host->caps :
-		sdhci_readl(host, SDHCI_CAPABILITIES);
+	if (host->quirks & SDHCI_QUIRK_MISSING_CAPS) {
+		caps = host->caps;
+		caps_spec3 = 0;
+	} else {
+		caps = sdhci_readl(host, SDHCI_CAPABILITIES);
+		if (host->version >= SDHCI_SPEC_300)
+			caps_spec3 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
+		else
+			caps_spec3 = 0;
+	}
+
+	if (caps_spec3 & SDHCI_CAN_DDR50)
+		mmc->caps |= MMC_CAP_1_8V_DDR;
 
 	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
 		host->flags |= SDHCI_USE_SDMA;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d0d5a7a..580a8ff 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -182,6 +182,9 @@
 #define  SDHCI_CAN_64BIT	0x10000000
 
 #define SDHCI_CAPABILITIES_1	0x44
+#define  SDHCI_CAN_SDR50	(1<<0)
+#define  SDHCI_CAN_SDR104	(1<<1)
+#define  SDHCI_CAN_DDR50	(1<<2)
 
 #define SDHCI_MAX_CURRENT	0x48
 
@@ -241,6 +244,8 @@ struct sdhci_ops {
 	void	(*platform_reset_exit)(struct sdhci_host *host, u8 mask);
 	unsigned int	(*get_f_max_clock)(struct sdhci_host *host);
 	void	(*platform_specific_delay)(struct sdhci_host *host);
+	unsigned int    (*set_signaling_voltage)(struct sdhci_host *host,
+				unsigned int ddr);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index bcb793e..359924c 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -56,6 +56,7 @@ struct mmc_ios {
 #define MMC_SDR_MODE		0
 #define MMC_1_2V_DDR_MODE	1
 #define MMC_1_8V_DDR_MODE	2
+#define MMC_3_3V_TO_1_2V_DDR	3
 };
 
 struct mmc_host_ops {
@@ -168,7 +169,7 @@ struct mmc_host {
 #define MMC_CAP_WAIT_WHILE_BUSY	(1 << 9)	/* Waits while card is busy */
 #define MMC_CAP_ERASE		(1 << 10)	/* Allow erase/trim commands */
 #define MMC_CAP_1_8V_DDR	(1 << 11)	/* can support */
-						/* DDR mode at 1.8V */
+						/* DDR mode at 1.8V or 3.3V */
 #define MMC_CAP_1_2V_DDR	(1 << 12)	/* can support */
 						/* DDR mode at 1.2V */
 #define MMC_CAP_POWER_OFF_CARD	(1 << 13)	/* Can power off after boot */
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 0d953f5..0ab8627 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -143,6 +143,8 @@ struct sdhci_host {
 	unsigned int            ocr_avail_sd;
 	unsigned int            ocr_avail_mmc;
 
+	int			ddr;	/* current dual data rate */
+
 	unsigned long private[0] ____cacheline_aligned;
 };
 #endif /* __SDHCI_H */
-- 
1.7.0.4


