From: Girish K S <girish.shivananjappa@linaro.org>
Subject: [RESEND PATCH V7 1/2] mmc: core: HS200 mode support for eMMC 4.5
Date: Wed, 21 Dec 2011 15:10:21 +0530
Message-ID: <1324460422-21986-2-git-send-email-girish.shivananjappa@linaro.org>
References: <1324460422-21986-1-git-send-email-girish.shivananjappa@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:37310 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495Ab1LUJfJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Dec 2011 04:35:09 -0500
In-Reply-To: <1324460422-21986-1-git-send-email-girish.shivananjappa@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: patches@linaro.org, linux-samsung-soc@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>, Chris Ball <cjb@laptop.org>

This patch adds the support of the HS200 bus speed for eMMC 4.5 devices.
The eMMC 4.5 devices have support for 200MHz bus speed. The function
prototype of the tuning function is modified to handle the tuning command
number which is different in sd and mmc case.

cc: Chris Ball <cjb@laptop.org>
Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
---
 drivers/mmc/core/bus.c     |    3 +-
 drivers/mmc/core/debugfs.c |    3 +
 drivers/mmc/core/mmc.c     |  148 +++++++++++++++++++++++++++++++++++++++++---
 drivers/mmc/core/sd.c      |    3 +-
 drivers/mmc/core/sdio.c    |    4 +-
 include/linux/mmc/card.h   |    3 +
 include/linux/mmc/host.h   |   11 +++-
 include/linux/mmc/mmc.h    |   66 +++++++++++++++++++-
 8 files changed, 227 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index f8a228a..5d011a3 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -303,10 +303,11 @@ int mmc_add_card(struct mmc_card *card)
 			mmc_card_ddr_mode(card) ? "DDR " : "",
 			type);
 	} else {
-		printk(KERN_INFO "%s: new %s%s%s card at address %04x\n",
+		pr_info("%s: new %s%s%s%s card at address %04x\n",
 			mmc_hostname(card->host),
 			mmc_card_uhs(card) ? "ultra high speed " :
 			(mmc_card_highspeed(card) ? "high speed " : ""),
+			(mmc_card_hs200(card) ? "HS200 " : ""),
 			mmc_card_ddr_mode(card) ? "DDR " : "",
 			type, card->rca);
 	}
diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 027615d..9ab5b17 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -135,6 +135,9 @@ static int mmc_ios_show(struct seq_file *s, void *data)
 	case MMC_TIMING_UHS_DDR50:
 		str = "sd uhs DDR50";
 		break;
+	case MMC_TIMING_MMC_HS200:
+		str = "mmc high-speed SDR200";
+		break;
 	default:
 		str = "invalid";
 		break;
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index f0a9f1f..acb0865 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -286,6 +286,27 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 	}
 	card->ext_csd.raw_card_type = ext_csd[EXT_CSD_CARD_TYPE];
 	switch (ext_csd[EXT_CSD_CARD_TYPE] & EXT_CSD_CARD_TYPE_MASK) {
+	case EXT_CSD_CARD_TYPE_SDR_ALL:
+	case EXT_CSD_CARD_TYPE_SDR_ALL_DDR_1_8V:
+	case EXT_CSD_CARD_TYPE_SDR_ALL_DDR_1_2V:
+	case EXT_CSD_CARD_TYPE_SDR_ALL_DDR_52:
+		card->ext_csd.hs_max_dtr = 200000000;
+		card->ext_csd.card_type = EXT_CSD_CARD_TYPE_SDR_200;
+		break;
+	case EXT_CSD_CARD_TYPE_SDR_1_2V_ALL:
+	case EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_1_8V:
+	case EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_1_2V:
+	case EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_52:
+		card->ext_csd.hs_max_dtr = 200000000;
+		card->ext_csd.card_type = EXT_CSD_CARD_TYPE_SDR_1_2V;
+		break;
+	case EXT_CSD_CARD_TYPE_SDR_1_8V_ALL:
+	case EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_1_8V:
+	case EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_1_2V:
+	case EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_52:
+		card->ext_csd.hs_max_dtr = 200000000;
+		card->ext_csd.card_type = EXT_CSD_CARD_TYPE_SDR_1_8V;
+		break;
 	case EXT_CSD_CARD_TYPE_DDR_52 | EXT_CSD_CARD_TYPE_52 |
 	     EXT_CSD_CARD_TYPE_26:
 		card->ext_csd.hs_max_dtr = 52000000;
@@ -700,6 +721,64 @@ static int mmc_select_powerclass(struct mmc_card *card,
 }
 
 /*
+ * Selects the desired buswidth and switch to the HS200 mode
+ * if bus width set without error
+ */
+static int mmc_select_hs200(struct mmc_card *card)
+{
+	int err = 0;
+	struct mmc_host *host;
+	u32 bus_width = MMC_BUS_WIDTH_4;
+
+	BUG_ON(!card);
+
+	host = card->host;
+
+	if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_SDR_1_2V)
+		&& (host->caps2 & MMC_CAP2_HS200_1_2V_SDR))
+		if (mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120, 0))
+			err = mmc_set_signal_voltage(host,
+						     MMC_SIGNAL_VOLTAGE_180,0);
+
+	/* If fails try again during next card power cycle */
+	if (err)
+		goto err;
+
+	/*
+	 * Host is capable of 8bit transfer, then switch
+	 * the device to work in 8bit transfer mode. If the
+	 * mmc switch command returns error then switch to
+	 * 4bit transfer mode. On success set the corresponding
+	 * bus width on the host.
+	 */
+	if (host->caps & MMC_CAP_8_BIT_DATA) {
+		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				 EXT_CSD_BUS_WIDTH,
+				 EXT_CSD_BUS_WIDTH_8,
+				 card->ext_csd.generic_cmd6_time);
+		bus_width = MMC_BUS_WIDTH_8;
+	}
+
+	/* If the 8bit mode fails switch to 4 bit mode */
+	if (err) {
+		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				 EXT_CSD_BUS_WIDTH,
+				 EXT_CSD_BUS_WIDTH_4,
+				 card->ext_csd.generic_cmd6_time);
+		bus_width = MMC_BUS_WIDTH_4;
+	}
+
+	/* switch to HS200 mode if bus width set successfully */
+	if (!err) {
+		mmc_set_bus_width(card->host, bus_width);
+		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+				 EXT_CSD_HS_TIMING, 2, 0);
+	}
+err:
+	return err;
+}
+
+/*
  * Handle the detection and initialisation of a card.
  *
  * In the case of a resume, "oldcard" will contain the card
@@ -905,11 +984,15 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	/*
 	 * Activate high speed (if supported)
 	 */
-	if ((card->ext_csd.hs_max_dtr != 0) &&
-		(host->caps & MMC_CAP_MMC_HIGHSPEED)) {
-		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-				 EXT_CSD_HS_TIMING, 1,
-				 card->ext_csd.generic_cmd6_time);
+	if (card->ext_csd.hs_max_dtr != 0) {
+		err = 0;
+		if ((card->ext_csd.hs_max_dtr > 52000000) &&
+		    (host->caps2 & MMC_CAP2_HS200))
+			err = mmc_select_hs200(card);
+		else if	(host->caps & MMC_CAP_MMC_HIGHSPEED)
+			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+					 EXT_CSD_HS_TIMING, 1, 0);
+
 		if (err && err != -EBADMSG)
 			goto free_card;
 
@@ -918,8 +1001,15 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 			       mmc_hostname(card->host));
 			err = 0;
 		} else {
-			mmc_card_set_highspeed(card);
-			mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
+			if ((card->ext_csd.hs_max_dtr > 52000000) &&
+			    (host->caps2 & MMC_CAP2_HS200)) {
+				mmc_card_set_hs200(card);
+				mmc_set_timing(card->host,
+					       MMC_TIMING_MMC_HS200);
+			} else {
+				mmc_card_set_highspeed(card);
+				mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
+			}
 		}
 	}
 
@@ -944,7 +1034,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	 */
 	max_dtr = (unsigned int)-1;
 
-	if (mmc_card_highspeed(card)) {
+	if (mmc_card_highspeed(card) || mmc_card_hs200(card)) {
 		if (max_dtr > card->ext_csd.hs_max_dtr)
 			max_dtr = card->ext_csd.hs_max_dtr;
 	} else if (max_dtr > card->csd.max_dtr) {
@@ -970,9 +1060,49 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	}
 
 	/*
+	 * Indicate HS200 SDR mode (if supported).
+	 */
+	if (mmc_card_hs200(card)) {
+		u32 ext_csd_bits;
+		u32 bus_width = card->host->ios.bus_width;
+
+		/*
+		 * For devices supporting HS200 mode, the bus width has
+		 * to be set before executing the tuning function. If
+		 * set before tuning, then device will respond with CRC
+		 * errors for responses on CMD line. So for HS200 the
+		 * sequence will be
+		 * 1. set bus width 4bit / 8 bit (1 bit not supported)
+		 * 2. switch to HS200 mode
+		 * 3. set the clock to > 52Mhz <=200MHz and
+		 * 4. execute tuning for HS200
+		 */
+		if ((host->caps2 & MMC_CAP2_HS200) &&
+		    card->host->ops->execute_tuning)
+			err = card->host->ops->execute_tuning(card->host,
+					MMC_SEND_TUNING_BLOCK_HS200);
+		if (err) {
+			pr_warning("tuning execution failed\n");
+			goto err;
+		}
+
+		ext_csd_bits = (bus_width == MMC_BUS_WIDTH_8) ?
+					EXT_CSD_BUS_WIDTH_8 :
+					EXT_CSD_BUS_WIDTH_4;
+		err = mmc_select_powerclass(card, ext_csd_bits, ext_csd);
+		if (err) {
+			pr_err("%s: power class selection to bus width"
+			       "%d failed\n", mmc_hostname(card->host),
+			       1 << bus_width);
+			goto err;
+		}
+	}
+
+	/*
 	 * Activate wide bus and DDR (if supported).
 	 */
-	if ((card->csd.mmca_vsn >= CSD_SPEC_VER_4) &&
+	if (!mmc_card_hs200(card) &&
+	    (card->csd.mmca_vsn >= CSD_SPEC_VER_3) &&
 	    (host->caps & (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA))) {
 		static unsigned ext_csd_bits[][2] = {
 			{ EXT_CSD_BUS_WIDTH_8, EXT_CSD_DDR_BUS_WIDTH_8 },
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 6f27d35..a775131 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -661,7 +661,8 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
 
 	/* SPI mode doesn't define CMD19 */
 	if (!mmc_host_is_spi(card->host) && card->host->ops->execute_tuning)
-		err = card->host->ops->execute_tuning(card->host);
+		err = card->host->ops->execute_tuning(card->host,	\
+						      MMC_SEND_TUNING_BLOCK);
 
 out:
 	kfree(status);
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index b77f770..bd7bacc 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -14,6 +14,7 @@
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
+#include <linux/mmc/mmc.h>
 #include <linux/mmc/sdio.h>
 #include <linux/mmc/sdio_func.h>
 #include <linux/mmc/sdio_ids.h>
@@ -556,7 +557,8 @@ static int mmc_sdio_init_uhs_card(struct mmc_card *card)
 
 	/* Initialize and start re-tuning timer */
 	if (!mmc_host_is_spi(card->host) && card->host->ops->execute_tuning)
-		err = card->host->ops->execute_tuning(card->host);
+		err = card->host->ops->execute_tuning(card->host,
+						      MMC_SEND_TUNING_BLOCK);
 
 out:
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 9478a6b..9f22ba5 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -216,6 +216,7 @@ struct mmc_card {
 #define MMC_STATE_ULTRAHIGHSPEED (1<<5)		/* card is in ultra high speed mode */
 #define MMC_CARD_SDXC		(1<<6)		/* card is SDXC */
 #define MMC_CARD_REMOVED	(1<<7)		/* card has been removed */
+#define MMC_STATE_HIGHSPEED_200	(1<<8)		/* card is in HS200 mode */
 	unsigned int		quirks; 	/* card quirks */
 #define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes outside of the VS CCCR range */
 #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)	/* use func->cur_blksize */
@@ -374,6 +375,7 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_card_present(c)	((c)->state & MMC_STATE_PRESENT)
 #define mmc_card_readonly(c)	((c)->state & MMC_STATE_READONLY)
 #define mmc_card_highspeed(c)	((c)->state & MMC_STATE_HIGHSPEED)
+#define mmc_card_hs200(c)	((c)->state & MMC_STATE_HIGHSPEED_200)
 #define mmc_card_blockaddr(c)	((c)->state & MMC_STATE_BLOCKADDR)
 #define mmc_card_ddr_mode(c)	((c)->state & MMC_STATE_HIGHSPEED_DDR)
 #define mmc_card_uhs(c)		((c)->state & MMC_STATE_ULTRAHIGHSPEED)
@@ -384,6 +386,7 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
 #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
 #define mmc_card_set_highspeed(c) ((c)->state |= MMC_STATE_HIGHSPEED)
+#define mmc_card_set_hs200(c)	((c)->state |= MMC_STATE_HIGHSPEED_200)
 #define mmc_card_set_blockaddr(c) ((c)->state |= MMC_STATE_BLOCKADDR)
 #define mmc_card_set_ddr_mode(c) ((c)->state |= MMC_STATE_HIGHSPEED_DDR)
 #define mmc_card_set_uhs(c) ((c)->state |= MMC_STATE_ULTRAHIGHSPEED)
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 9a03d03..606c8c3 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -56,10 +56,13 @@ struct mmc_ios {
 #define MMC_TIMING_UHS_SDR50	3
 #define MMC_TIMING_UHS_SDR104	4
 #define MMC_TIMING_UHS_DDR50	5
+#define MMC_TIMING_MMC_HS200	6
 
 #define MMC_SDR_MODE		0
 #define MMC_1_2V_DDR_MODE	1
 #define MMC_1_8V_DDR_MODE	2
+#define MMC_1_2V_SDR_MODE	3
+#define MMC_1_8V_SDR_MODE	4
 
 	unsigned char	signal_voltage;		/* signalling voltage (1.8V or 3.3V) */
 
@@ -148,7 +151,9 @@ struct mmc_host_ops {
 	void	(*init_card)(struct mmc_host *host, struct mmc_card *card);
 
 	int	(*start_signal_voltage_switch)(struct mmc_host *host, struct mmc_ios *ios);
-	int	(*execute_tuning)(struct mmc_host *host);
+
+	/* The tuning command opcode value is different for SD and eMMC cards */
+	int	(*execute_tuning)(struct mmc_host *host, u32 opcode);
 	void	(*enable_preset_value)(struct mmc_host *host, bool enable);
 	int	(*select_drive_strength)(unsigned int max_dtr, int host_drv, int card_drv);
 	void	(*hw_reset)(struct mmc_host *host);
@@ -242,6 +247,10 @@ struct mmc_host {
 #define MMC_CAP2_CACHE_CTRL	(1 << 1)	/* Allow cache control */
 #define MMC_CAP2_POWEROFF_NOTIFY (1 << 2)	/* Notify poweroff supported */
 #define MMC_CAP2_NO_MULTI_READ	(1 << 3)	/* Multiblock reads don't work */
+#define MMC_CAP2_HS200_1_8V_SDR	(1 << 4)	/* can support */
+#define MMC_CAP2_HS200_1_2V_SDR	(1 << 5)	/* can support */
+#define MMC_CAP2_HS200		(MMC_CAP2_HS200_1_8V_SDR | \
+				 MMC_CAP2_HS200_1_2V_SDR)
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 	unsigned int        power_notify_type;
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 665548e..2c8cc69 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -51,6 +51,7 @@
 #define MMC_READ_SINGLE_BLOCK    17   /* adtc [31:0] data addr   R1  */
 #define MMC_READ_MULTIPLE_BLOCK  18   /* adtc [31:0] data addr   R1  */
 #define MMC_SEND_TUNING_BLOCK    19   /* adtc                    R1  */
+#define MMC_SEND_TUNING_BLOCK_HS200	21	/* adtc R1  */
 
   /* class 3 */
 #define MMC_WRITE_DAT_UNTIL_STOP 20   /* adtc [31:0] data addr   R1  */
@@ -339,13 +340,76 @@ struct _mmc_csd {
 
 #define EXT_CSD_CARD_TYPE_26	(1<<0)	/* Card can run at 26MHz */
 #define EXT_CSD_CARD_TYPE_52	(1<<1)	/* Card can run at 52MHz */
-#define EXT_CSD_CARD_TYPE_MASK	0xF	/* Mask out reserved bits */
+#define EXT_CSD_CARD_TYPE_MASK	0x3F	/* Mask out reserved bits */
 #define EXT_CSD_CARD_TYPE_DDR_1_8V  (1<<2)   /* Card can run at 52MHz */
 					     /* DDR mode @1.8V or 3V I/O */
 #define EXT_CSD_CARD_TYPE_DDR_1_2V  (1<<3)   /* Card can run at 52MHz */
 					     /* DDR mode @1.2V I/O */
 #define EXT_CSD_CARD_TYPE_DDR_52       (EXT_CSD_CARD_TYPE_DDR_1_8V  \
 					| EXT_CSD_CARD_TYPE_DDR_1_2V)
+#define EXT_CSD_CARD_TYPE_SDR_1_8V	(1<<4)	/* Card can run at 200MHz */
+#define EXT_CSD_CARD_TYPE_SDR_1_2V	(1<<5)	/* Card can run at 200MHz */
+						/* SDR mode @1.2V I/O */
+
+#define EXT_CSD_CARD_TYPE_SDR_200	(EXT_CSD_CARD_TYPE_SDR_1_8V	\
+					| EXT_CSD_CARD_TYPE_SDR_1_2V)
+
+#define EXT_CSD_CARD_TYPE_SDR_ALL	(EXT_CSD_CARD_TYPE_SDR_200	\
+					| EXT_CSD_CARD_TYPE_52		\
+					| EXT_CSD_CARD_TYPE_26)
+
+#define	EXT_CSD_CARD_TYPE_SDR_1_2V_ALL	(EXT_CSD_CARD_TYPE_SDR_1_2V	\
+					| EXT_CSD_CARD_TYPE_52		\
+					| EXT_CSD_CARD_TYPE_26)
+
+#define	EXT_CSD_CARD_TYPE_SDR_1_8V_ALL	(EXT_CSD_CARD_TYPE_SDR_1_8V	\
+					| EXT_CSD_CARD_TYPE_52		\
+					| EXT_CSD_CARD_TYPE_26)
+
+#define EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_1_8V	(EXT_CSD_CARD_TYPE_SDR_1_2V  \
+						| EXT_CSD_CARD_TYPE_DDR_1_8V \
+						| EXT_CSD_CARD_TYPE_52	     \
+						| EXT_CSD_CARD_TYPE_26)
+
+#define EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_1_8V	(EXT_CSD_CARD_TYPE_SDR_1_8V  \
+						| EXT_CSD_CARD_TYPE_DDR_1_8V \
+						| EXT_CSD_CARD_TYPE_52	     \
+						| EXT_CSD_CARD_TYPE_26)
+
+#define EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_1_2V	(EXT_CSD_CARD_TYPE_SDR_1_2V  \
+						| EXT_CSD_CARD_TYPE_DDR_1_2V \
+						| EXT_CSD_CARD_TYPE_52	     \
+						| EXT_CSD_CARD_TYPE_26)
+
+#define EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_1_2V	(EXT_CSD_CARD_TYPE_SDR_1_8V  \
+						| EXT_CSD_CARD_TYPE_DDR_1_2V \
+						| EXT_CSD_CARD_TYPE_52	     \
+						| EXT_CSD_CARD_TYPE_26)
+
+#define EXT_CSD_CARD_TYPE_SDR_1_2V_DDR_52	(EXT_CSD_CARD_TYPE_SDR_1_2V  \
+						| EXT_CSD_CARD_TYPE_DDR_52   \
+						| EXT_CSD_CARD_TYPE_52	     \
+						| EXT_CSD_CARD_TYPE_26)
+
+#define EXT_CSD_CARD_TYPE_SDR_1_8V_DDR_52	(EXT_CSD_CARD_TYPE_SDR_1_8V  \
+						| EXT_CSD_CARD_TYPE_DDR_52   \
+						| EXT_CSD_CARD_TYPE_52	     \
+						| EXT_CSD_CARD_TYPE_26)
+
+#define EXT_CSD_CARD_TYPE_SDR_ALL_DDR_1_8V	(EXT_CSD_CARD_TYPE_SDR_200   \
+						| EXT_CSD_CARD_TYPE_DDR_1_8V \
+						| EXT_CSD_CARD_TYPE_52	     \
+						| EXT_CSD_CARD_TYPE_26)
+
+#define EXT_CSD_CARD_TYPE_SDR_ALL_DDR_1_2V	(EXT_CSD_CARD_TYPE_SDR_200   \
+						| EXT_CSD_CARD_TYPE_DDR_1_2V \
+						| EXT_CSD_CARD_TYPE_52	     \
+						| EXT_CSD_CARD_TYPE_26)
+
+#define EXT_CSD_CARD_TYPE_SDR_ALL_DDR_52	(EXT_CSD_CARD_TYPE_SDR_200   \
+						| EXT_CSD_CARD_TYPE_DDR_52   \
+						| EXT_CSD_CARD_TYPE_52	     \
+						| EXT_CSD_CARD_TYPE_26)
 
 #define EXT_CSD_BUS_WIDTH_1	0	/* Card is in 1 bit mode */
 #define EXT_CSD_BUS_WIDTH_4	1	/* Card is in 4 bit mode */
-- 
1.7.1

