From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH v4 03/15] mmc: sd: add support for driver type selection
Date: Thu,  5 May 2011 12:18:59 +0530
Message-ID: <1304578151-1775-4-git-send-email-arindam.nath@amd.com>
References: <1304578151-1775-1-git-send-email-arindam.nath@amd.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:46341 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002Ab1EEGuk (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 May 2011 02:50:40 -0400
Received: by pzk9 with SMTP id 9so837464pzk.19
        for <linux-mmc@vger.kernel.org>; Wed, 04 May 2011 23:50:40 -0700 (PDT)
In-Reply-To: <1304578151-1775-1-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: prakity@marvell.com, zhangfei.gao@gmail.com, subhashj@codeaurora.org, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com, Arindam Nath <arindam.nath@amd.com>

This patch adds support for setting driver strength during UHS-I
initialization prcedure. Since UHS-I cards set S18A (bit 24) in
response to ACMD41, we use this as a base for UHS-I initialization.
We modify the parameter list of mmc_sd_get_cid() so that we can
save the ROCR from ACMD41 to check whether bit 24 is set.

We decide whether the Host Controller supports A, C, or D driver
type depending on the Capabilities register. Driver type B is
suported by default. We then set the appropriate driver type for
the card using CMD6 mode 1. As per Host Controller spec v3.00, we
set driver type for the host only if Preset Value Enable in the
Host Control2 register is not set. SDHCI_HOST_CONTROL has been
renamed to SDHCI_HOST_CONTROL1 to conform to the spec.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
Reviewed-by: Philip Rakity <prakity@marvell.com>
Tested-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/core/core.c  |    9 +++
 drivers/mmc/core/core.h  |    1 +
 drivers/mmc/core/sd.c    |  153 ++++++++++++++++++++++++++++++++++++++--------
 drivers/mmc/core/sd.h    |    3 +-
 drivers/mmc/core/sdio.c  |    3 +-
 drivers/mmc/host/sdhci.c |   49 +++++++++++---
 drivers/mmc/host/sdhci.h |   11 +++-
 include/linux/mmc/card.h |    4 +
 include/linux/mmc/host.h |   10 +++
 9 files changed, 203 insertions(+), 40 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index ea5c28d..78a9b51 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -986,6 +986,15 @@ void mmc_set_timing(struct mmc_host *host, unsigned int timing)
 }
 
 /*
+ * Select appropriate driver type for host.
+ */
+void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type)
+{
+	host->ios.drv_type = drv_type;
+	mmc_set_ios(host);
+}
+
+/*
  * Apply power to the MMC stack.  This is a two-stage process.
  * First, we enable power to the card without the clock running.
  * We then wait a bit for the power to stabilise.  Finally,
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index 7745dea..93f3397 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -43,6 +43,7 @@ void mmc_set_bus_width_ddr(struct mmc_host *host, unsigned int width,
 u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
 int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage);
 void mmc_set_timing(struct mmc_host *host, unsigned int timing);
+void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type);
 
 static inline void mmc_delay(unsigned int ms)
 {
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index d4410c9..a6fa52f 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -405,6 +405,98 @@ out:
 	return err;
 }
 
+static int sd_select_driver_type(struct mmc_card *card, u8 *status)
+{
+	int host_drv_type = 0, card_drv_type = 0;
+	int err;
+
+	/*
+	 * If the host doesn't support any of the Driver Types A,C or D,
+	 * default Driver Type B is used.
+	 */
+	if (!(card->host->caps & (MMC_CAP_DRIVER_TYPE_A | MMC_CAP_DRIVER_TYPE_C
+	    | MMC_CAP_DRIVER_TYPE_D)))
+		return 0;
+
+	if (card->host->caps & MMC_CAP_DRIVER_TYPE_A) {
+		host_drv_type = MMC_SET_DRIVER_TYPE_A;
+		if (card->sw_caps.sd3_drv_type & SD_DRIVER_TYPE_A)
+			card_drv_type = MMC_SET_DRIVER_TYPE_A;
+		else if (card->sw_caps.sd3_drv_type & SD_DRIVER_TYPE_B)
+			card_drv_type = MMC_SET_DRIVER_TYPE_B;
+		else if (card->sw_caps.sd3_drv_type & SD_DRIVER_TYPE_C)
+			card_drv_type = MMC_SET_DRIVER_TYPE_C;
+	} else if (card->host->caps & MMC_CAP_DRIVER_TYPE_C) {
+		host_drv_type = MMC_SET_DRIVER_TYPE_C;
+		if (card->sw_caps.sd3_drv_type & SD_DRIVER_TYPE_C)
+			card_drv_type = MMC_SET_DRIVER_TYPE_C;
+	} else if (!(card->host->caps & MMC_CAP_DRIVER_TYPE_D)) {
+		/*
+		 * If we are here, that means only the default driver type
+		 * B is supported by the host.
+		 */
+		host_drv_type = MMC_SET_DRIVER_TYPE_B;
+		if (card->sw_caps.sd3_drv_type & SD_DRIVER_TYPE_B)
+			card_drv_type = MMC_SET_DRIVER_TYPE_B;
+		else if (card->sw_caps.sd3_drv_type & SD_DRIVER_TYPE_C)
+			card_drv_type = MMC_SET_DRIVER_TYPE_C;
+	}
+
+	err = mmc_sd_switch(card, 1, 2, card_drv_type, status);
+	if (err)
+		return err;
+
+	if ((status[15] & 0xF) != card_drv_type) {
+		printk(KERN_WARNING "%s: Problem setting driver strength!\n",
+			mmc_hostname(card->host));
+		return 0;
+	}
+
+	mmc_set_driver_type(card->host, host_drv_type);
+
+	return 0;
+}
+
+/*
+ * UHS-I specific initialization procedure
+ */
+static int mmc_sd_init_uhs_card(struct mmc_card *card)
+{
+	int err;
+	u8 *status;
+
+	if (!card->scr.sda_spec3)
+		return 0;
+
+	if (!(card->csd.cmdclass & CCC_SWITCH))
+		return 0;
+
+	status = kmalloc(64, GFP_KERNEL);
+	if (!status) {
+		printk(KERN_ERR "%s: could not allocate a buffer for "
+			"switch capabilities.\n", mmc_hostname(card->host));
+		return -ENOMEM;
+	}
+
+	/* Set 4-bit bus width */
+	if ((card->host->caps & MMC_CAP_4_BIT_DATA) &&
+	    (card->scr.bus_widths & SD_SCR_BUS_WIDTH_4)) {
+		err = mmc_app_set_bus_width(card, MMC_BUS_WIDTH_4);
+		if (err)
+			goto out;
+
+		mmc_set_bus_width(card->host, MMC_BUS_WIDTH_4);
+	}
+
+	/* Set the driver strength for the card */
+	err = sd_select_driver_type(card, status);
+
+out:
+	kfree(status);
+
+	return err;
+}
+
 MMC_DEV_ATTR(cid, "%08x%08x%08x%08x\n", card->raw_cid[0], card->raw_cid[1],
 	card->raw_cid[2], card->raw_cid[3]);
 MMC_DEV_ATTR(csd, "%08x%08x%08x%08x\n", card->raw_csd[0], card->raw_csd[1],
@@ -453,10 +545,10 @@ struct device_type sd_type = {
 /*
  * Fetch CID from card.
  */
-int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid)
+int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid,
+	u32 *rocr)
 {
 	int err;
-	u32 rocr;
 
 	/*
 	 * Since we're changing the OCR value, we seem to
@@ -490,7 +582,7 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid)
 		ocr |= SD_OCR_XPC;
 
 try_again:
-	err = mmc_send_app_op_cond(host, ocr, &rocr);
+	err = mmc_send_app_op_cond(host, ocr, rocr);
 	if (err)
 		return err;
 
@@ -498,7 +590,8 @@ try_again:
 	 * In case CCS and S18A in the response is set, start Signal Voltage
 	 * Switch procedure. SPI mode doesn't support CMD11.
 	 */
-	if (!mmc_host_is_spi(host) && ((rocr & 0x41000000) == 0x41000000)) {
+	if (!mmc_host_is_spi(host) && rocr &&
+	   ((*rocr & 0x41000000) == 0x41000000)) {
 		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
 		if (err) {
 			ocr &= ~SD_OCR_S18R;
@@ -633,11 +726,12 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 	struct mmc_card *card;
 	int err;
 	u32 cid[4];
+	u32 rocr = 0;
 
 	BUG_ON(!host);
 	WARN_ON(!host->claimed);
 
-	err = mmc_sd_get_cid(host, ocr, cid);
+	err = mmc_sd_get_cid(host, ocr, cid, &rocr);
 	if (err)
 		return err;
 
@@ -690,30 +784,37 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 	if (err)
 		goto free_card;
 
-	/*
-	 * Attempt to change to high-speed (if supported)
-	 */
-	err = mmc_sd_switch_hs(card);
-	if (err > 0)
-		mmc_sd_go_highspeed(card);
-	else if (err)
-		goto free_card;
-
-	/*
-	 * Set bus speed.
-	 */
-	mmc_set_clock(host, mmc_sd_get_max_clock(card));
-
-	/*
-	 * Switch to wider bus (if supported).
-	 */
-	if ((host->caps & MMC_CAP_4_BIT_DATA) &&
-		(card->scr.bus_widths & SD_SCR_BUS_WIDTH_4)) {
-		err = mmc_app_set_bus_width(card, MMC_BUS_WIDTH_4);
+	/* Initialization sequence for UHS-I cards */
+	if (rocr & SD_ROCR_S18A) {
+		err = mmc_sd_init_uhs_card(card);
 		if (err)
 			goto free_card;
+	} else {
+		/*
+		 * Attempt to change to high-speed (if supported)
+		 */
+		err = mmc_sd_switch_hs(card);
+		if (err > 0)
+			mmc_sd_go_highspeed(card);
+		else if (err)
+			goto free_card;
+
+		/*
+		 * Set bus speed.
+		 */
+		mmc_set_clock(host, mmc_sd_get_max_clock(card));
 
-		mmc_set_bus_width(host, MMC_BUS_WIDTH_4);
+		/*
+		 * Switch to wider bus (if supported).
+		 */
+		if ((host->caps & MMC_CAP_4_BIT_DATA) &&
+			(card->scr.bus_widths & SD_SCR_BUS_WIDTH_4)) {
+			err = mmc_app_set_bus_width(card, MMC_BUS_WIDTH_4);
+			if (err)
+				goto free_card;
+
+			mmc_set_bus_width(host, MMC_BUS_WIDTH_4);
+		}
 	}
 
 	host->card = card;
diff --git a/drivers/mmc/core/sd.h b/drivers/mmc/core/sd.h
index 3d8800f..5106b44 100644
--- a/drivers/mmc/core/sd.h
+++ b/drivers/mmc/core/sd.h
@@ -5,7 +5,8 @@
 
 extern struct device_type sd_type;
 
-int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid);
+int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid,
+	u32 *rocr);
 int mmc_sd_get_csd(struct mmc_host *host, struct mmc_card *card);
 void mmc_decode_cid(struct mmc_card *card);
 int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 1e60959..c4a6614 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -370,7 +370,8 @@ static int mmc_sdio_init_card(struct mmc_host *host, u32 ocr,
 	}
 
 	if (ocr & R4_MEMORY_PRESENT
-	    && mmc_sd_get_cid(host, host->ocr & ocr, card->raw_cid) == 0) {
+	    && mmc_sd_get_cid(host, host->ocr & ocr, card->raw_cid,
+	    NULL) == 0) {
 		card->type = MMC_TYPE_SD_COMBO;
 
 		if (oldcard && (oldcard->type != MMC_TYPE_SD_COMBO ||
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 52faa50..9f38317 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -61,7 +61,7 @@ static void sdhci_dumpregs(struct sdhci_host *host)
 		sdhci_readw(host, SDHCI_TRANSFER_MODE));
 	printk(KERN_DEBUG DRIVER_NAME ": Present:  0x%08x | Host ctl: 0x%08x\n",
 		sdhci_readl(host, SDHCI_PRESENT_STATE),
-		sdhci_readb(host, SDHCI_HOST_CONTROL));
+		sdhci_readb(host, SDHCI_HOST_CONTROL1));
 	printk(KERN_DEBUG DRIVER_NAME ": Power:    0x%08x | Blk gap:  0x%08x\n",
 		sdhci_readb(host, SDHCI_POWER_CONTROL),
 		sdhci_readb(host, SDHCI_BLOCK_GAP_CONTROL));
@@ -220,18 +220,18 @@ static void sdhci_activate_led(struct sdhci_host *host)
 {
 	u8 ctrl;
 
-	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
+	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL1);
 	ctrl |= SDHCI_CTRL_LED;
-	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL1);
 }
 
 static void sdhci_deactivate_led(struct sdhci_host *host)
 {
 	u8 ctrl;
 
-	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
+	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL1);
 	ctrl &= ~SDHCI_CTRL_LED;
-	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL1);
 }
 
 #ifdef SDHCI_USE_LEDS_CLASS
@@ -803,14 +803,14 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 	 * is ADMA.
 	 */
 	if (host->version >= SDHCI_SPEC_200) {
-		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
+		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL1);
 		ctrl &= ~SDHCI_CTRL_DMA_MASK;
 		if ((host->flags & SDHCI_REQ_USE_DMA) &&
 			(host->flags & SDHCI_USE_ADMA))
 			ctrl |= SDHCI_CTRL_ADMA32;
 		else
 			ctrl |= SDHCI_CTRL_SDMA;
-		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL1);
 	}
 
 	if (!(host->flags & SDHCI_REQ_USE_DMA)) {
@@ -1218,7 +1218,7 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	if (host->ops->platform_8bit_width)
 		host->ops->platform_8bit_width(host, ios->bus_width);
 	else {
-		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
+		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL1);
 		if (ios->bus_width == MMC_BUS_WIDTH_8) {
 			ctrl &= ~SDHCI_CTRL_4BITBUS;
 			if (host->version >= SDHCI_SPEC_300)
@@ -1231,10 +1231,10 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			else
 				ctrl &= ~SDHCI_CTRL_4BITBUS;
 		}
-		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL1);
 	}
 
-	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
+	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL1);
 
 	if ((ios->timing == MMC_TIMING_SD_HS ||
 	     ios->timing == MMC_TIMING_MMC_HS)
@@ -1243,7 +1243,26 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	else
 		ctrl &= ~SDHCI_CTRL_HISPD;
 
-	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL1);
+
+	if (host->version >= SDHCI_SPEC_300) {
+		u16 ctrl_2;
+
+		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		if (!(ctrl_2 & SDHCI_CTRL_PRESET_VAL_ENABLE)) {
+			/*
+			 * We only need to set Driver Strength if the
+			 * preset value enable is not set.
+			 */
+			ctrl_2 &= ~SDHCI_CTRL_DRV_TYPE_MASK;
+			if (ios->drv_type == MMC_SET_DRIVER_TYPE_A)
+				ctrl_2 |= SDHCI_CTRL_DRV_TYPE_A;
+			else if (ios->drv_type == MMC_SET_DRIVER_TYPE_C)
+				ctrl_2 |= SDHCI_CTRL_DRV_TYPE_C;
+
+			sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+		}
+	}
 
 	/*
 	 * Some (ENE) controllers go apeshit on some ios operation,
@@ -2087,6 +2106,14 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (caps[1] & SDHCI_SUPPORT_DDR50)
 		mmc->caps |= MMC_CAP_UHS_DDR50;
 
+	/* Driver Type(s) (A, C, D) supported by the host */
+	if (caps[1] & SDHCI_DRIVER_TYPE_A)
+		mmc->caps |= MMC_CAP_DRIVER_TYPE_A;
+	if (caps[1] & SDHCI_DRIVER_TYPE_C)
+		mmc->caps |= MMC_CAP_DRIVER_TYPE_C;
+	if (caps[1] & SDHCI_DRIVER_TYPE_D)
+		mmc->caps |= MMC_CAP_DRIVER_TYPE_D;
+
 	ocr_avail = 0;
 	/*
 	 * According to SD Host Controller spec v3.00, if the Host System
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 5cba2fe..04c41a4 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -71,7 +71,7 @@
 #define  SDHCI_DATA_LVL_MASK	0x00F00000
 #define   SDHCI_DATA_LVL_SHIFT	20
 
-#define SDHCI_HOST_CONTROL 	0x28
+#define SDHCI_HOST_CONTROL1	0x28
 #define  SDHCI_CTRL_LED		0x01
 #define  SDHCI_CTRL_4BITBUS	0x02
 #define  SDHCI_CTRL_HISPD	0x04
@@ -150,6 +150,12 @@
 
 #define SDHCI_HOST_CONTROL2		0x3E
 #define  SDHCI_CTRL_VDD_180		0x0008
+#define  SDHCI_CTRL_DRV_TYPE_MASK	0x0030
+#define   SDHCI_CTRL_DRV_TYPE_B		0x0000
+#define   SDHCI_CTRL_DRV_TYPE_A		0x0010
+#define   SDHCI_CTRL_DRV_TYPE_C		0x0020
+#define   SDHCI_CTRL_DRV_TYPE_D		0x0030
+#define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
 
 #define SDHCI_CAPABILITIES	0x40
 #define  SDHCI_TIMEOUT_CLK_MASK	0x0000003F
@@ -173,6 +179,9 @@
 #define  SDHCI_SUPPORT_SDR50	0x00000001
 #define  SDHCI_SUPPORT_SDR104	0x00000002
 #define  SDHCI_SUPPORT_DDR50	0x00000004
+#define  SDHCI_DRIVER_TYPE_A	0x00000010
+#define  SDHCI_DRIVER_TYPE_C	0x00000020
+#define  SDHCI_DRIVER_TYPE_D	0x00000040
 
 #define SDHCI_CAPABILITIES_1	0x44
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 56f4d92..5393272 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -83,6 +83,10 @@ struct sd_switch_caps {
 	unsigned int		hs_max_dtr;
 	unsigned int		sd3_bus_mode;
 	unsigned int		sd3_drv_type;
+#define SD_DRIVER_TYPE_B	0x01
+#define SD_DRIVER_TYPE_A	0x02
+#define SD_DRIVER_TYPE_C	0x04
+#define SD_DRIVER_TYPE_D	0x08
 	unsigned int		sd3_curr_limit;
 };
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index bde5a0b..949e4d5 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -61,6 +61,13 @@ struct mmc_ios {
 
 #define MMC_SIGNAL_VOLTAGE_330	0
 #define MMC_SIGNAL_VOLTAGE_180	1
+
+	unsigned char	drv_type;		/* driver type (A, B, C, D) */
+
+#define MMC_SET_DRIVER_TYPE_B	0
+#define MMC_SET_DRIVER_TYPE_A	1
+#define MMC_SET_DRIVER_TYPE_C	2
+#define MMC_SET_DRIVER_TYPE_D	3
 };
 
 struct mmc_host_ops {
@@ -188,6 +195,9 @@ struct mmc_host {
 #define MMC_CAP_SET_XPC_330	(1 << 20)	/* Host supports >150mA current at 3.3V */
 #define MMC_CAP_SET_XPC_300	(1 << 21)	/* Host supports >150mA current at 3.0V */
 #define MMC_CAP_SET_XPC_180	(1 << 22)	/* Host supports >150mA current at 1.8V */
+#define MMC_CAP_DRIVER_TYPE_A	(1 << 23)	/* Host supports Driver Type A */
+#define MMC_CAP_DRIVER_TYPE_C	(1 << 24)	/* Host supports Driver Type C */
+#define MMC_CAP_DRIVER_TYPE_D	(1 << 25)	/* Host supports Driver Type D */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
-- 
1.7.1

