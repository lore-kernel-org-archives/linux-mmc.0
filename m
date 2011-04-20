From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH v3 01/11] mmc: sd: add support for signal voltage switch procedure
Date: Wed, 20 Apr 2011 15:00:51 +0530
Message-ID: <1303291861-1788-2-git-send-email-arindam.nath@amd.com>
References: <1303291861-1788-1-git-send-email-arindam.nath@amd.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.212.179]:46142 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871Ab1DTJbl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Apr 2011 05:31:41 -0400
Received: by mail-px0-f179.google.com with SMTP id 2so445901pxi.10
        for <linux-mmc@vger.kernel.org>; Wed, 20 Apr 2011 02:31:40 -0700 (PDT)
In-Reply-To: <1303291861-1788-1-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, prakity@marvell.com, subhashj@codeaurora.org, zhangfei.gao@gmail.com, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com, Arindam Nath <arindam.nath@amd.com>

Host Controller v3.00 adds another Capabilities register. Apart
from other things, this new register indicates whether the Host
Controller supports SDR50, SDR104, and DDR50 UHS-I modes. The spec
doesn't mention about explicit support for SDR12 and SDR25 UHS-I
modes, so the Host Controller v3.00 should support them by default.
Also if the controller supports SDR104 mode, it will also support
SDR50 mode as well. So depending on the host support, we set the
corresponding MMC_CAP_* flags. One more new register. Host Control2
is added in v3.00, which is used during Signal Voltage Switch
procedure described below.

Since as per v3.00 spec, UHS-I supported hosts should set S18R
to 1, we set S18R (bit 24) of OCR before sending ACMD41. We also
need to set XPC (bit 28) of OCR in case the host can supply >150mA.
This support is indicated by the Maximum Current Capabilities
register of the Host Controller.

If the response of ACMD41 has both CCS and S18A set, we start the
signal voltage switch procedure, which if successfull, will switch
the card from 3.3V signalling to 1.8V signalling. Signal voltage
switch procedure adds support for a new command CMD11 in the
Physical Layer Spec v3.01. As part of this procedure, we need to
set 1.8V Signalling Enable (bit 3) of Host Control2 register, which
if remains set after 5ms, means the switch to 1.8V signalling is
successfull. Otherwise, we clear bit 24 of OCR and retry the
initialization sequence. When we remove the card, and insert the
same or another card, we need to make sure that we start with 3.3V
signalling voltage. So we call mmc_set_signal_voltage() with
MMC_SIGNAL_VOLTAGE_330 set so that we are back to 3.3V signalling
voltage before we actually start initializing the card.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/mmc/core/sd.c     |   34 ++++++++-
 drivers/mmc/core/sd_ops.c |   34 ++++++++
 drivers/mmc/core/sd_ops.h |    1 +
 drivers/mmc/host/sdhci.c  |  194 ++++++++++++++++++++++++++++++++++++++++++---
 drivers/mmc/host/sdhci.h  |   18 ++++-
 include/linux/mmc/host.h  |   15 ++++
 include/linux/mmc/sd.h    |    1 +
 7 files changed, 281 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 6dac89f..98aed60 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -403,6 +403,7 @@ struct device_type sd_type = {
 int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid)
 {
 	int err;
+	u32 rocr;
 
 	/*
 	 * Since we're changing the OCR value, we seem to
@@ -422,10 +423,36 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, u32 *cid)
 	if (!err)
 		ocr |= 1 << 30;
 
-	err = mmc_send_app_op_cond(host, ocr, NULL);
+	/*
+	 * If the host supports one of UHS-I modes, request the card
+	 * to switch to 1.8V signaling level.
+	 */
+	if (host->caps & (MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 |
+	    MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 | MMC_CAP_UHS_DDR50))
+		ocr |= 1 << 24;
+
+	/* If the host can supply more than 150mA, XPC should be set to 1. */
+	if (host->caps & (MMC_CAP_SET_XPC_330 | MMC_CAP_SET_XPC_300 |
+	    MMC_CAP_SET_XPC_180))
+		ocr |= 1 << 28;
+
+try_again:
+	err = mmc_send_app_op_cond(host, ocr, &rocr);
 	if (err)
 		return err;
 
+	/*
+	 * In case CCS and S18A in the response is set, start Signal Voltage
+	 * Switch procedure. SPI mode doesn't support CMD11.
+	 */
+	if (!mmc_host_is_spi(host) && ((rocr & 0x41000000) == 0x41000000)) {
+		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180);
+		if (err) {
+			ocr &= ~(1 << 24);
+			goto try_again;
+		}
+	}
+
 	if (mmc_host_is_spi(host))
 		err = mmc_send_cid(host, cid);
 	else
@@ -781,6 +808,11 @@ int mmc_attach_sd(struct mmc_host *host)
 	if (host->ocr_avail_sd)
 		host->ocr_avail = host->ocr_avail_sd;
 
+	/* Make sure we are at 3.3V signalling voltage */
+	err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330);
+	if (err)
+		return err;
+
 	/*
 	 * We need to get OCR a different way for SPI.
 	 */
diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
index a206aea..9be0d4c 100644
--- a/drivers/mmc/core/sd_ops.c
+++ b/drivers/mmc/core/sd_ops.c
@@ -145,6 +145,40 @@ int mmc_app_set_bus_width(struct mmc_card *card, int width)
 	return 0;
 }
 
+int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
+{
+	struct mmc_command cmd;
+	int err = 0;
+
+	BUG_ON(!host);
+
+	/*
+	 * Send CMD11 only if the request is to switch the card to
+	 * 1.8V signalling.
+	 */
+	if (signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
+		memset(&cmd, 0, sizeof(struct mmc_command));
+
+		cmd.opcode = SD_SWITCH_VOLTAGE;
+		cmd.arg = 0;
+		cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+
+		err = mmc_wait_for_cmd(host, &cmd, 0);
+		if (err)
+			return err;
+
+		if (!mmc_host_is_spi(host) && (cmd.resp[0] & R1_ERROR))
+			return -EIO;
+	}
+
+	host->ios.signal_voltage = signal_voltage;
+
+	if (host->ops->start_signal_voltage_switch)
+		err = host->ops->start_signal_voltage_switch(host, &host->ios);
+
+	return err;
+}
+
 int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
 {
 	struct mmc_command cmd = {0};
diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
index ffc2305..d5bdda5 100644
--- a/drivers/mmc/core/sd_ops.h
+++ b/drivers/mmc/core/sd_ops.h
@@ -20,6 +20,7 @@ int mmc_app_send_scr(struct mmc_card *card, u32 *scr);
 int mmc_sd_switch(struct mmc_card *card, int mode, int group,
 	u8 value, u8 *resp);
 int mmc_app_sd_status(struct mmc_card *card, void *ssr);
+int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage);
 
 #endif
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f31077d..56efd94 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -83,6 +83,8 @@ static void sdhci_dumpregs(struct sdhci_host *host)
 	printk(KERN_DEBUG DRIVER_NAME ": Cmd:      0x%08x | Max curr: 0x%08x\n",
 		sdhci_readw(host, SDHCI_COMMAND),
 		sdhci_readl(host, SDHCI_MAX_CURRENT));
+	printk(KERN_DEBUG DRIVER_NAME ": Host ctl2: 0x%08x\n",
+		sdhci_readw(host, SDHCI_HOST_CONTROL2));
 
 	if (host->flags & SDHCI_USE_ADMA)
 		printk(KERN_DEBUG DRIVER_NAME ": ADMA Err: 0x%08x | ADMA Ptr: 0x%08x\n",
@@ -1297,11 +1299,116 @@ out:
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
+static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
+	struct mmc_ios *ios)
+{
+	struct sdhci_host *host;
+	u8 pwr;
+	u16 clk, ctrl;
+	u32 present_state;
+
+	host = mmc_priv(mmc);
+
+	/*
+	 * Signal Voltage Switching is only applicable for Host Controllers
+	 * v3.00 and above.
+	 */
+	if (host->version < SDHCI_SPEC_300)
+		return 0;
+
+	/*
+	 * We first check whether the request is to set signalling voltage
+	 * to 3.3V. If so, we change the voltage to 3.3V and return quickly.
+	 */
+	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	if ((ctrl & SDHCI_CTRL_VDD_180) &&
+	   (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330)) {
+		/* Set 1.8V Signal Enable in the Host Control2 register to 0 */
+		ctrl &= ~SDHCI_CTRL_VDD_180;
+		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
+
+		/* Wait for 5ms */
+		usleep_range(5000, 5500);
+
+		/* 3.3V regulator output should be stable within 5 ms */
+		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		if (!(ctrl & SDHCI_CTRL_VDD_180))
+			return 0;
+		else {
+			printk(KERN_INFO DRIVER_NAME ": Switching to 3.3V "
+				"signalling voltage failed\n");
+			return -EIO;
+		}
+	} else if (!(ctrl & SDHCI_CTRL_VDD_180) &&
+		  (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180)) {
+		/* Stop SDCLK */
+		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+		clk &= ~SDHCI_CLOCK_CARD_EN;
+		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+		/* Check whether DAT[3:0] is 0000 */
+		present_state = sdhci_readl(host, SDHCI_PRESENT_STATE);
+		if (!((present_state & SDHCI_DATA_LVL_MASK) >>
+		       SDHCI_DATA_LVL_SHIFT)) {
+			/*
+			 * Enable 1.8V Signal Enable in the Host Control2
+			 * register
+			 */
+			ctrl |= SDHCI_CTRL_VDD_180;
+			sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
+
+			/* Wait for 5ms */
+			usleep_range(5000, 5500);
+
+			ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+			if (ctrl & SDHCI_CTRL_VDD_180) {
+				/* Provide SDCLK again and wait for 1ms*/
+				clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+				clk |= SDHCI_CLOCK_CARD_EN;
+				sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+				usleep_range(1000, 1500);
+
+				/*
+				 * If DAT[3:0] level is 1111b, then the card
+				 * was successfully switched to 1.8V signaling.
+				 */
+				present_state = sdhci_readl(host,
+							SDHCI_PRESENT_STATE);
+				if ((present_state & SDHCI_DATA_LVL_MASK) ==
+				     SDHCI_DATA_LVL_MASK) {
+					return 0;
+				}
+			}
+		}
+
+		/*
+		 * If we are here, that means the switch to 1.8V signaling
+		 * failed. We power cycle the card, and retry initialization
+		 * sequence by setting S18R to 0.
+		 */
+		pwr = sdhci_readb(host, SDHCI_POWER_CONTROL);
+		pwr &= ~SDHCI_POWER_ON;
+		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
+
+		/* Wait for 1ms as per the spec */
+		usleep_range(1000, 1500);
+		pwr |= SDHCI_POWER_ON;
+		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
+
+		printk(KERN_INFO DRIVER_NAME ": Switching to 1.8V signalling "
+			"voltage failed, retrying with S18R set to 0\n");
+		return -EAGAIN;
+	} else
+		/* No signal voltage switch required */
+		return 0;
+}
+
 static const struct mmc_host_ops sdhci_ops = {
 	.request	= sdhci_request,
 	.set_ios	= sdhci_set_ios,
 	.get_ro		= sdhci_get_ro,
 	.enable_sdio_irq = sdhci_enable_sdio_irq,
+	.start_signal_voltage_switch	= sdhci_start_signal_voltage_switch,
 };
 
 /*****************************************************************************\
@@ -1775,7 +1882,9 @@ EXPORT_SYMBOL_GPL(sdhci_alloc_host);
 int sdhci_add_host(struct sdhci_host *host)
 {
 	struct mmc_host *mmc;
-	unsigned int caps, ocr_avail;
+	u32 caps[2];
+	u32 max_current_caps;
+	unsigned int ocr_avail;
 	int ret;
 
 	WARN_ON(host == NULL);
@@ -1798,12 +1907,15 @@ int sdhci_add_host(struct sdhci_host *host)
 			host->version);
 	}
 
-	caps = (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? host->caps :
+	caps[0] = (host->quirks & SDHCI_QUIRK_MISSING_CAPS) ? host->caps :
 		sdhci_readl(host, SDHCI_CAPABILITIES);
 
+	caps[1] = (host->version >= SDHCI_SPEC_300) ?
+		sdhci_readl(host, SDHCI_CAPABILITIES_1) : 0;
+
 	if (host->quirks & SDHCI_QUIRK_FORCE_DMA)
 		host->flags |= SDHCI_USE_SDMA;
-	else if (!(caps & SDHCI_CAN_DO_SDMA))
+	else if (!(caps[0] & SDHCI_CAN_DO_SDMA))
 		DBG("Controller doesn't have SDMA capability\n");
 	else
 		host->flags |= SDHCI_USE_SDMA;
@@ -1814,7 +1926,8 @@ int sdhci_add_host(struct sdhci_host *host)
 		host->flags &= ~SDHCI_USE_SDMA;
 	}
 
-	if ((host->version >= SDHCI_SPEC_200) && (caps & SDHCI_CAN_DO_ADMA2))
+	if ((host->version >= SDHCI_SPEC_200) &&
+		(caps[0] & SDHCI_CAN_DO_ADMA2))
 		host->flags |= SDHCI_USE_ADMA;
 
 	if ((host->quirks & SDHCI_QUIRK_BROKEN_ADMA) &&
@@ -1864,10 +1977,10 @@ int sdhci_add_host(struct sdhci_host *host)
 	}
 
 	if (host->version >= SDHCI_SPEC_300)
-		host->max_clk = (caps & SDHCI_CLOCK_V3_BASE_MASK)
+		host->max_clk = (caps[0] & SDHCI_CLOCK_V3_BASE_MASK)
 			>> SDHCI_CLOCK_BASE_SHIFT;
 	else
-		host->max_clk = (caps & SDHCI_CLOCK_BASE_MASK)
+		host->max_clk = (caps[0] & SDHCI_CLOCK_BASE_MASK)
 			>> SDHCI_CLOCK_BASE_SHIFT;
 
 	host->max_clk *= 1000000;
@@ -1883,7 +1996,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	}
 
 	host->timeout_clk =
-		(caps & SDHCI_TIMEOUT_CLK_MASK) >> SDHCI_TIMEOUT_CLK_SHIFT;
+		(caps[0] & SDHCI_TIMEOUT_CLK_MASK) >> SDHCI_TIMEOUT_CLK_SHIFT;
 	if (host->timeout_clk == 0) {
 		if (host->ops->get_timeout_clock) {
 			host->timeout_clk = host->ops->get_timeout_clock(host);
@@ -1895,7 +2008,7 @@ int sdhci_add_host(struct sdhci_host *host)
 			return -ENODEV;
 		}
 	}
-	if (caps & SDHCI_TIMEOUT_CLK_UNIT)
+	if (caps[0] & SDHCI_TIMEOUT_CLK_UNIT)
 		host->timeout_clk *= 1000;
 
 	/*
@@ -1922,21 +2035,76 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (!(host->quirks & SDHCI_QUIRK_FORCE_1_BIT_DATA))
 		mmc->caps |= MMC_CAP_4_BIT_DATA;
 
-	if (caps & SDHCI_CAN_DO_HISPD)
+	if (caps[0] & SDHCI_CAN_DO_HISPD)
 		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
 
 	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
 	    mmc_card_is_removable(mmc))
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
 
+	/* UHS-I mode(s) supported by the host controller. */
+	if (host->version >= SDHCI_SPEC_300)
+		mmc->caps |= MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25;
+
+	/* SDR104 supports also implies SDR50 support */
+	if (caps[1] & SDHCI_SUPPORT_SDR104)
+		mmc->caps |= MMC_CAP_UHS_SDR104 | MMC_CAP_UHS_SDR50;
+	else if (caps[1] & SDHCI_SUPPORT_SDR50)
+		mmc->caps |= MMC_CAP_UHS_SDR50;
+
+	if (caps[1] & SDHCI_SUPPORT_DDR50)
+		mmc->caps |= MMC_CAP_UHS_DDR50;
+
 	ocr_avail = 0;
-	if (caps & SDHCI_CAN_VDD_330)
+	/*
+	 * According to SD Host Controller spec v3.00, if the Host System
+	 * can afford more than 150mA, Host Driver should set XPC to 1. Also
+	 * the value is meaningful only if Voltage Support in the Capabilities
+	 * register is set. The actual current value is 4 times the register
+	 * value.
+	 */
+	max_current_caps = sdhci_readl(host, SDHCI_MAX_CURRENT);
+
+	if (caps[0] & SDHCI_CAN_VDD_330) {
+		int max_current_330;
+
 		ocr_avail |= MMC_VDD_32_33 | MMC_VDD_33_34;
-	if (caps & SDHCI_CAN_VDD_300)
+
+		max_current_330 = ((max_current_caps &
+				   SDHCI_MAX_CURRENT_330_MASK) >>
+				   SDHCI_MAX_CURRENT_330_SHIFT) *
+				   SDHCI_MAX_CURRENT_MULTIPLIER;
+
+		if (max_current_330 > 150)
+			mmc->caps |= MMC_CAP_SET_XPC_330;
+	}
+	if (caps[0] & SDHCI_CAN_VDD_300) {
+		int max_current_300;
+
 		ocr_avail |= MMC_VDD_29_30 | MMC_VDD_30_31;
-	if (caps & SDHCI_CAN_VDD_180)
+
+		max_current_300 = ((max_current_caps &
+				   SDHCI_MAX_CURRENT_300_MASK) >>
+				   SDHCI_MAX_CURRENT_300_SHIFT) *
+				   SDHCI_MAX_CURRENT_MULTIPLIER;
+
+		if (max_current_300 > 150)
+			mmc->caps |= MMC_CAP_SET_XPC_300;
+	}
+	if (caps[0] & SDHCI_CAN_VDD_180) {
+		int max_current_180;
+
 		ocr_avail |= MMC_VDD_165_195;
 
+		max_current_180 = ((max_current_caps &
+				   SDHCI_MAX_CURRENT_180_MASK) >>
+				   SDHCI_MAX_CURRENT_180_SHIFT) *
+				   SDHCI_MAX_CURRENT_MULTIPLIER;
+
+		if (max_current_180 > 150)
+			mmc->caps |= MMC_CAP_SET_XPC_180;
+	}
+
 	mmc->ocr_avail = ocr_avail;
 	mmc->ocr_avail_sdio = ocr_avail;
 	if (host->ocr_avail_sdio)
@@ -1996,7 +2164,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (host->quirks & SDHCI_QUIRK_FORCE_BLK_SZ_2048) {
 		mmc->max_blk_size = 2;
 	} else {
-		mmc->max_blk_size = (caps & SDHCI_MAX_BLOCK_MASK) >>
+		mmc->max_blk_size = (caps[0] & SDHCI_MAX_BLOCK_MASK) >>
 				SDHCI_MAX_BLOCK_SHIFT;
 		if (mmc->max_blk_size >= 3) {
 			printk(KERN_WARNING "%s: Invalid maximum block size, "
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 85750a9..4f00b31 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -68,6 +68,8 @@
 #define  SDHCI_DATA_AVAILABLE	0x00000800
 #define  SDHCI_CARD_PRESENT	0x00010000
 #define  SDHCI_WRITE_PROTECT	0x00080000
+#define  SDHCI_DATA_LVL_MASK	0x00F00000
+#define   SDHCI_DATA_LVL_SHIFT	20
 
 #define SDHCI_HOST_CONTROL 	0x28
 #define  SDHCI_CTRL_LED		0x01
@@ -146,7 +148,8 @@
 
 #define SDHCI_ACMD12_ERR	0x3C
 
-/* 3E-3F reserved */
+#define SDHCI_HOST_CONTROL2		0x3E
+#define  SDHCI_CTRL_VDD_180		0x0008
 
 #define SDHCI_CAPABILITIES	0x40
 #define  SDHCI_TIMEOUT_CLK_MASK	0x0000003F
@@ -167,9 +170,20 @@
 #define  SDHCI_CAN_VDD_180	0x04000000
 #define  SDHCI_CAN_64BIT	0x10000000
 
+#define  SDHCI_SUPPORT_SDR50	0x00000001
+#define  SDHCI_SUPPORT_SDR104	0x00000002
+#define  SDHCI_SUPPORT_DDR50	0x00000004
+
 #define SDHCI_CAPABILITIES_1	0x44
 
-#define SDHCI_MAX_CURRENT	0x48
+#define SDHCI_MAX_CURRENT		0x48
+#define  SDHCI_MAX_CURRENT_330_MASK	0x0000FF
+#define  SDHCI_MAX_CURRENT_330_SHIFT	0
+#define  SDHCI_MAX_CURRENT_300_MASK	0x00FF00
+#define  SDHCI_MAX_CURRENT_300_SHIFT	8
+#define  SDHCI_MAX_CURRENT_180_MASK	0xFF0000
+#define  SDHCI_MAX_CURRENT_180_SHIFT	16
+#define   SDHCI_MAX_CURRENT_MULTIPLIER	4
 
 /* 4C-4F reserved for more max current */
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 0fffa5c..bde5a0b 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -56,6 +56,11 @@ struct mmc_ios {
 #define MMC_SDR_MODE		0
 #define MMC_1_2V_DDR_MODE	1
 #define MMC_1_8V_DDR_MODE	2
+
+	unsigned char	signal_voltage;		/* signalling voltage (1.8V or 3.3V) */
+
+#define MMC_SIGNAL_VOLTAGE_330	0
+#define MMC_SIGNAL_VOLTAGE_180	1
 };
 
 struct mmc_host_ops {
@@ -117,6 +122,8 @@ struct mmc_host_ops {
 
 	/* optional callback for HC quirks */
 	void	(*init_card)(struct mmc_host *host, struct mmc_card *card);
+
+	int	(*start_signal_voltage_switch)(struct mmc_host *host, struct mmc_ios *ios);
 };
 
 struct mmc_card;
@@ -173,6 +180,14 @@ struct mmc_host {
 						/* DDR mode at 1.2V */
 #define MMC_CAP_POWER_OFF_CARD	(1 << 13)	/* Can power off after boot */
 #define MMC_CAP_BUS_WIDTH_TEST	(1 << 14)	/* CMD14/CMD19 bus width ok */
+#define MMC_CAP_UHS_SDR12	(1 << 15)	/* Host supports UHS SDR12 mode */
+#define MMC_CAP_UHS_SDR25	(1 << 16)	/* Host supports UHS SDR25 mode */
+#define MMC_CAP_UHS_SDR50	(1 << 17)	/* Host supports UHS SDR50 mode */
+#define MMC_CAP_UHS_SDR104	(1 << 18)	/* Host supports UHS SDR104 mode */
+#define MMC_CAP_UHS_DDR50	(1 << 19)	/* Host supports UHS DDR50 mode */
+#define MMC_CAP_SET_XPC_330	(1 << 20)	/* Host supports >150mA current at 3.3V */
+#define MMC_CAP_SET_XPC_300	(1 << 21)	/* Host supports >150mA current at 3.0V */
+#define MMC_CAP_SET_XPC_180	(1 << 22)	/* Host supports >150mA current at 1.8V */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 
diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
index 3fd85e0..835b715 100644
--- a/include/linux/mmc/sd.h
+++ b/include/linux/mmc/sd.h
@@ -17,6 +17,7 @@
 /* This is basically the same command as for MMC with some quirks. */
 #define SD_SEND_RELATIVE_ADDR     3   /* bcr                     R6  */
 #define SD_SEND_IF_COND           8   /* bcr  [11:0] See below   R7  */
+#define SD_SWITCH_VOLTAGE         11  /* ac                      R1  */
 
   /* class 10 */
 #define SD_SWITCH                 6   /* adtc [31:0] See below   R1  */
-- 
1.7.1

