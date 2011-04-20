From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH v3 05/11] mmc: sd: add support for uhs bus speed mode selection
Date: Wed, 20 Apr 2011 15:00:55 +0530
Message-ID: <1303291861-1788-6-git-send-email-arindam.nath@amd.com>
References: <1303291861-1788-1-git-send-email-arindam.nath@amd.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.212.179]:46142 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753593Ab1DTJca (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Apr 2011 05:32:30 -0400
Received: by mail-px0-f179.google.com with SMTP id 2so445901pxi.10
        for <linux-mmc@vger.kernel.org>; Wed, 20 Apr 2011 02:32:30 -0700 (PDT)
In-Reply-To: <1303291861-1788-1-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, prakity@marvell.com, subhashj@codeaurora.org, zhangfei.gao@gmail.com, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com, Arindam Nath <arindam.nath@amd.com>

This patch adds support for setting UHS-I bus speed mode during UHS-I
initialization procedure. Since both the host and card can support
more than one bus speed, we select the highest speed based on both of
their capabilities. First we set the bus speed mode for the card using
CMD6 mode 1, and then we program the host controller to support the
required speed mode. We also set High Speed Enable in case one of the
UHS-I modes is selected. We take care to reset SD clock before setting
UHS mode in the Host Control2 register, and then re-enable it as per
the Host Controller spec v3.00. We then set the clock frequency for
the UHS-I mode selected.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/mmc/core/sd.c    |   65 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.c |   40 ++++++++++++++++++++++++++--
 drivers/mmc/host/sdhci.h |    6 ++++
 include/linux/mmc/card.h |   19 +++++++++++++
 include/linux/mmc/host.h |    5 +++
 5 files changed, 132 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 08f5011..ba71654 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -457,6 +457,66 @@ static int sd_select_driver_type(struct mmc_card *card, u8 *status)
 	return 0;
 }
 
+static int sd_set_bus_speed_mode(struct mmc_card *card, u8 *status)
+{
+	unsigned int bus_speed = 0, timing = 0;
+	int err;
+
+	/*
+	 * If the host doesn't support any of the UHS-I modes, fallback on
+	 * default speed.
+	 */
+	if (!(card->host->caps & (MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25 |
+	    MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR104 | MMC_CAP_UHS_DDR50)))
+		return 0;
+
+	if ((card->host->caps & MMC_CAP_UHS_SDR104) &&
+	    (card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR104)) {
+			bus_speed = UHS_SDR104_BUS_SPEED;
+			timing = MMC_TIMING_UHS_SDR104;
+			card->sw_caps.uhs_max_dtr = UHS_SDR104_MAX_DTR;
+	} else if ((card->host->caps & MMC_CAP_UHS_DDR50) &&
+		   (card->sw_caps.sd3_bus_mode & SD_MODE_UHS_DDR50)) {
+			bus_speed = UHS_DDR50_BUS_SPEED;
+			timing = MMC_TIMING_UHS_DDR50;
+			card->sw_caps.uhs_max_dtr = UHS_DDR50_MAX_DTR;
+	} else if ((card->host->caps & (MMC_CAP_UHS_SDR104 |
+		    MMC_CAP_UHS_SDR50)) && (card->sw_caps.sd3_bus_mode &
+		    SD_MODE_UHS_SDR50)) {
+			bus_speed = UHS_SDR50_BUS_SPEED;
+			timing = MMC_TIMING_UHS_SDR50;
+			card->sw_caps.uhs_max_dtr = UHS_SDR50_MAX_DTR;
+	} else if ((card->host->caps & (MMC_CAP_UHS_SDR104 |
+		    MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR25)) &&
+		   (card->sw_caps.sd3_bus_mode & SD_MODE_UHS_SDR25)) {
+			bus_speed = UHS_SDR25_BUS_SPEED;
+			timing = MMC_TIMING_UHS_SDR25;
+			card->sw_caps.uhs_max_dtr = UHS_SDR25_MAX_DTR;
+	} else if ((card->host->caps & (MMC_CAP_UHS_SDR104 |
+		    MMC_CAP_UHS_SDR50 | MMC_CAP_UHS_SDR25 |
+		    MMC_CAP_UHS_SDR12)) && (card->sw_caps.sd3_bus_mode &
+		    SD_MODE_UHS_SDR12)) {
+			bus_speed = UHS_SDR12_BUS_SPEED;
+			timing = MMC_TIMING_UHS_SDR12;
+			card->sw_caps.uhs_max_dtr = UHS_SDR12_MAX_DTR;
+	}
+
+	card->sd_bus_speed = bus_speed;
+	err = mmc_sd_switch(card, 1, 0, bus_speed, status);
+	if (err)
+		return err;
+
+	if ((status[16] & 0xF) != bus_speed)
+		printk(KERN_WARNING "%s: Problem setting bus speed mode!\n",
+			mmc_hostname(card->host));
+	else {
+		mmc_set_timing(card->host, timing);
+		mmc_set_clock(card->host, card->sw_caps.uhs_max_dtr);
+	}
+
+	return 0;
+}
+
 /*
  * UHS-I specific initialization procedure
  */
@@ -490,6 +550,11 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
 
 	/* Set the driver strength for the card */
 	err = sd_select_driver_type(card, status);
+	if (err)
+		goto out;
+
+	/* Set bus speed mode of the card */
+	err = sd_set_bus_speed_mode(card, status);
 
 out:
 	kfree(status);
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 175f858..758c9f1 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1238,7 +1238,16 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		ctrl &= ~SDHCI_CTRL_HISPD;
 
 	if (host->version >= SDHCI_SPEC_300) {
-		u16 ctrl_2;
+		u16 clk, ctrl_2;
+		unsigned int clock;
+
+		/* In case of UHS-I modes, set High Speed Enable */
+		if ((ios->timing == MMC_TIMING_UHS_SDR50) ||
+		    (ios->timing == MMC_TIMING_UHS_SDR104) ||
+		    (ios->timing == MMC_TIMING_UHS_DDR50) ||
+		    (ios->timing == MMC_TIMING_UHS_SDR25) ||
+		    (ios->timing == MMC_TIMING_UHS_SDR12))
+			ctrl |= SDHCI_CTRL_HISPD;
 
 		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 		if (!(ctrl_2 & SDHCI_CTRL_PRESET_VAL_ENABLE)) {
@@ -1261,8 +1270,6 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			 * need to reset SD Clock Enable before changing High
 			 * Speed Enable to avoid generating clock gliches.
 			 */
-			u16 clk;
-			unsigned int clock;
 
 			/* Reset SD Clock Enable */
 			clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
@@ -1276,6 +1283,33 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			host->clock = 0;
 			sdhci_set_clock(host, clock);
 		}
+
+		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+
+		/* Select Bus Speed Mode for host */
+		ctrl_2 &= ~SDHCI_CTRL_UHS_MASK;
+		if (ios->timing == MMC_TIMING_UHS_SDR12)
+			ctrl_2 |= SDHCI_CTRL_UHS_SDR12;
+		else if (ios->timing == MMC_TIMING_UHS_SDR25)
+			ctrl_2 |= SDHCI_CTRL_UHS_SDR25;
+		else if (ios->timing == MMC_TIMING_UHS_SDR50)
+			ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
+		else if (ios->timing == MMC_TIMING_UHS_SDR104)
+			ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
+		else if (ios->timing == MMC_TIMING_UHS_DDR50)
+			ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
+
+		/* Reset SD Clock Enable */
+		clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+		clk &= ~SDHCI_CLOCK_CARD_EN;
+		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
+
+		sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
+
+		/* Re-enable SD Clock */
+		clock = host->clock;
+		host->clock = 0;
+		sdhci_set_clock(host, clock);
 	} else
 		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL1);
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 03c1df9..aed1203 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -149,6 +149,12 @@
 #define SDHCI_ACMD12_ERR	0x3C
 
 #define SDHCI_HOST_CONTROL2		0x3E
+#define  SDHCI_CTRL_UHS_MASK		0x0007
+#define   SDHCI_CTRL_UHS_SDR12		0x0000
+#define   SDHCI_CTRL_UHS_SDR25		0x0001
+#define   SDHCI_CTRL_UHS_SDR50		0x0002
+#define   SDHCI_CTRL_UHS_SDR104		0x0003
+#define   SDHCI_CTRL_UHS_DDR50		0x0004
 #define  SDHCI_CTRL_VDD_180		0x0008
 #define  SDHCI_CTRL_DRV_TYPE_MASK	0x0030
 #define   SDHCI_CTRL_DRV_TYPE_B		0x0000
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 5393272..4ef6ded 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -81,7 +81,24 @@ struct sd_ssr {
 
 struct sd_switch_caps {
 	unsigned int		hs_max_dtr;
+	unsigned int		uhs_max_dtr;
+#define UHS_SDR104_MAX_DTR	208000000
+#define UHS_SDR50_MAX_DTR	100000000
+#define UHS_DDR50_MAX_DTR	50000000
+#define UHS_SDR25_MAX_DTR	UHS_DDR50_MAX_DTR
+#define UHS_SDR12_MAX_DTR	25000000
 	unsigned int		sd3_bus_mode;
+#define UHS_SDR12_BUS_SPEED	0
+#define UHS_SDR25_BUS_SPEED	1
+#define UHS_SDR50_BUS_SPEED	2
+#define UHS_SDR104_BUS_SPEED	3
+#define UHS_DDR50_BUS_SPEED	4
+
+#define SD_MODE_UHS_SDR12	(1 << UHS_SDR12_BUS_SPEED)
+#define SD_MODE_UHS_SDR25	(1 << UHS_SDR25_BUS_SPEED)
+#define SD_MODE_UHS_SDR50	(1 << UHS_SDR50_BUS_SPEED)
+#define SD_MODE_UHS_SDR104	(1 << UHS_SDR104_BUS_SPEED)
+#define SD_MODE_UHS_DDR50	(1 << UHS_DDR50_BUS_SPEED)
 	unsigned int		sd3_drv_type;
 #define SD_DRIVER_TYPE_B	0x01
 #define SD_DRIVER_TYPE_A	0x02
@@ -166,6 +183,8 @@ struct mmc_card {
 	const char		**info;		/* info strings */
 	struct sdio_func_tuple	*tuples;	/* unknown common tuples */
 
+	unsigned int		sd_bus_speed;	/* Bus Speed Mode set for the card */
+
 	struct dentry		*debugfs_root;
 };
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 949e4d5..6237599 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -50,6 +50,11 @@ struct mmc_ios {
 #define MMC_TIMING_LEGACY	0
 #define MMC_TIMING_MMC_HS	1
 #define MMC_TIMING_SD_HS	2
+#define MMC_TIMING_UHS_SDR12	MMC_TIMING_LEGACY
+#define MMC_TIMING_UHS_SDR25	MMC_TIMING_SD_HS
+#define MMC_TIMING_UHS_SDR50	3
+#define MMC_TIMING_UHS_SDR104	4
+#define MMC_TIMING_UHS_DDR50	5
 
 	unsigned char	ddr;			/* dual data rate used */
 
-- 
1.7.1

