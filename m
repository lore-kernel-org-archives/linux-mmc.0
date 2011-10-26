From: Girish K S <girish.shivananjappa@linaro.org>
Subject: [PATCH RESEND V4] mmc: core: HS200 mode support for eMMC 4.5
Date: Wed, 26 Oct 2011 10:29:48 +0530
Message-ID: <1319605188-2909-1-git-send-email-girish.shivananjappa@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>
List-Id: linux-mmc@vger.kernel.org

This patch adds the support of the HS200 bus speed for eMMC 4.5 devices.
The eMMC 4.5 devices have support for 200MHz bus speed.The mmc core and
host modules have been touched to add support for this module.

It is necessary to know the card type in the sdhci.c file to add support
for eMMC tuning function. So card.h file is included to import the card
data structure.

cc: Chris Ball <cjb@laptop.org>
Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
---
Changes in v4:
	Rebased onto chris-mmc/mmc-next branch. This patch is successfully 
	applied on commit with id de022ed3fdc14808299b2fa66dbb1ed5ab921912.
Changes in v3:
	In the previous commits of chris-mmc/mmc-next branch, the patch with
	commit id (c0f22a2c92e357e7cb3988b0b13034d70b7461f9) defines caps2 for
	more capabilities. This patch version deletes the member ext_caps(created
	in my earlier patch) from struct mmc_host and reuses already accepted
	caps2 member.
Changes in v2:
	Rebased to latest chris-mmc/mmc-next branch. Resolved indentation
	problems identified in review. This patch has to be applied before
	the patch released for modifying the printk messages.
Changes in v1:
	Case statements in switch that produce same result have
	been combined to reduce repeated assignments.
	patch recreated after rebase to chris balls mmc-next branch.

 drivers/mmc/core/bus.c    |    3 +-
 drivers/mmc/core/mmc.c    |   92 ++++++++++++++++++++++++++++++++++++++++----
 drivers/mmc/host/sdhci.c  |   36 +++++++++++++++---
 include/linux/mmc/card.h  |    3 +
 include/linux/mmc/host.h  |    6 +++
 include/linux/mmc/mmc.h   |    8 +++-
 include/linux/mmc/sdhci.h |    1 +
 7 files changed, 132 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 46b6e84..2f82f6b 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -301,10 +301,11 @@ int mmc_add_card(struct mmc_card *card)
 			mmc_card_ddr_mode(card) ? "DDR " : "",
 			type);
 	} else {
-		printk(KERN_INFO "%s: new %s%s%s card at address %04x\n",
+		pr_info("%s: new %s%s%s%s card at address %04x\n",
 			mmc_hostname(card->host),
 			mmc_sd_card_uhs(card) ? "ultra high speed " :
 			(mmc_card_highspeed(card) ? "high speed " : ""),
+			(mmc_card_hs200(card) ? "HS200 " : ""),
 			mmc_card_ddr_mode(card) ? "DDR " : "",
 			type, card->rca);
 	}
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 3627044..4db248c 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -285,6 +285,39 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 	}
 	card->ext_csd.raw_card_type = ext_csd[EXT_CSD_CARD_TYPE];
 	switch (ext_csd[EXT_CSD_CARD_TYPE] & EXT_CSD_CARD_TYPE_MASK) {
+	case EXT_CSD_CARD_TYPE_SDR_200 |
+	     EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
+	case EXT_CSD_CARD_TYPE_SDR_200 | EXT_CSD_CARD_TYPE_DDR_1_8V |
+	     EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
+	case EXT_CSD_CARD_TYPE_SDR_200 | EXT_CSD_CARD_TYPE_DDR_1_2V |
+	     EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
+	case EXT_CSD_CARD_TYPE_SDR_200 | EXT_CSD_CARD_TYPE_DDR_52 |
+	     EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
+		card->ext_csd.hs_max_dtr = 200000000;
+		card->ext_csd.card_type = EXT_CSD_CARD_TYPE_SDR_200;
+		break;
+	case EXT_CSD_CARD_TYPE_SDR_1_2V |
+	     EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
+	case EXT_CSD_CARD_TYPE_SDR_1_2V | EXT_CSD_CARD_TYPE_DDR_1_8V |
+	     EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
+	case EXT_CSD_CARD_TYPE_SDR_1_2V | EXT_CSD_CARD_TYPE_DDR_1_2V |
+	     EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
+	case EXT_CSD_CARD_TYPE_SDR_1_2V | EXT_CSD_CARD_TYPE_DDR_52 |
+	     EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
+		card->ext_csd.hs_max_dtr = 200000000;
+		card->ext_csd.card_type = EXT_CSD_CARD_TYPE_SDR_1_2V;
+		break;
+	case EXT_CSD_CARD_TYPE_SDR_1_8V |
+	     EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
+	case EXT_CSD_CARD_TYPE_SDR_1_8V | EXT_CSD_CARD_TYPE_DDR_1_8V |
+	     EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
+	case EXT_CSD_CARD_TYPE_SDR_1_8V | EXT_CSD_CARD_TYPE_DDR_1_2V |
+	     EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
+	case EXT_CSD_CARD_TYPE_SDR_1_8V | EXT_CSD_CARD_TYPE_DDR_52 |
+	     EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
+		card->ext_csd.hs_max_dtr = 200000000;
+		card->ext_csd.card_type = EXT_CSD_CARD_TYPE_SDR_1_8V;
+		break;
 	case EXT_CSD_CARD_TYPE_DDR_52 | EXT_CSD_CARD_TYPE_52 |
 	     EXT_CSD_CARD_TYPE_26:
 		card->ext_csd.hs_max_dtr = 52000000;
@@ -699,6 +732,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 {
 	struct mmc_card *card;
 	int err, ddr = 0;
+	int hs_sdr = 0;
 	u32 cid[4];
 	unsigned int max_dtr;
 	u32 rocr;
@@ -890,11 +924,15 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	/*
 	 * Activate high speed (if supported)
 	 */
-	if ((card->ext_csd.hs_max_dtr != 0) &&
-		(host->caps & MMC_CAP_MMC_HIGHSPEED)) {
-		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-				 EXT_CSD_HS_TIMING, 1,
-				 card->ext_csd.generic_cmd6_time);
+	if (card->ext_csd.hs_max_dtr != 0) {
+		if ((card->ext_csd.hs_max_dtr > 52000000) &&
+		    (host->caps2 & MMC_CAP2_HIGHSPEED_200))
+			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+					 EXT_CSD_HS_TIMING, 2, 0);
+		else if	(host->caps & MMC_CAP_MMC_HIGHSPEED)
+			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+					 EXT_CSD_HS_TIMING, 1, 0);
+
 		if (err && err != -EBADMSG)
 			goto free_card;
 
@@ -903,7 +941,10 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 			       mmc_hostname(card->host));
 			err = 0;
 		} else {
-			mmc_card_set_highspeed(card);
+			if (card->ext_csd.hs_max_dtr > 52000000)
+				mmc_card_set_hs200(card);
+			else
+				mmc_card_set_highspeed(card);
 			mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
 		}
 	}
@@ -929,7 +970,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	 */
 	max_dtr = (unsigned int)-1;
 
-	if (mmc_card_highspeed(card)) {
+	if (mmc_card_highspeed(card) || mmc_card_hs200(card)) {
 		if (max_dtr > card->ext_csd.hs_max_dtr)
 			max_dtr = card->ext_csd.hs_max_dtr;
 	} else if (max_dtr > card->csd.max_dtr) {
@@ -955,6 +996,22 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	}
 
 	/*
+	 * Indicate HS200 SDR mode (if supported).
+	 */
+	if (mmc_card_hs200(card)) {
+		if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_SDR_1_8V)
+			&& ((host->caps2 & (MMC_CAP2_HS200_1_8V_SDR |
+			     MMC_CAP2_HS200))
+				== (MMC_CAP2_HS200_1_8V_SDR | MMC_CAP2_HS200)))
+				hs_sdr = MMC_1_8V_SDR_MODE;
+		else if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_SDR_1_2V)
+			 && ((host->caps2 & (MMC_CAP2_HS200_1_2V_SDR |
+			      MMC_CAP2_HS200))
+				== (MMC_CAP2_HS200_1_2V_SDR | MMC_CAP2_HS200)))
+				hs_sdr = MMC_1_2V_SDR_MODE;
+	}
+
+	/*
 	 * Activate wide bus and DDR (if supported).
 	 */
 	if ((card->csd.mmca_vsn >= CSD_SPEC_VER_4) &&
@@ -994,16 +1051,24 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 			if (!err) {
 				mmc_set_bus_width(card->host, bus_width);
 
+				if ((host->caps2 & MMC_CAP2_HS200) &&
+				    card->host->ops->execute_tuning)
+					err = card->host->ops->	\
+					      execute_tuning(card->host);
+
 				/*
 				 * If controller can't handle bus width test,
 				 * compare ext_csd previously read in 1 bit mode
 				 * against ext_csd at new bus width
 				 */
-				if (!(host->caps & MMC_CAP_BUS_WIDTH_TEST))
+				if (!(host->caps & MMC_CAP_BUS_WIDTH_TEST) &&
+				    !err)
 					err = mmc_compare_ext_csds(card,
 						bus_width);
-				else
+				else if (!err)
 					err = mmc_bus_test(card, bus_width);
+				else
+					pr_warning("tuning execution failed\n");
 				if (!err)
 					break;
 			}
@@ -1052,6 +1117,15 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 			mmc_card_set_ddr_mode(card);
 			mmc_set_timing(card->host, MMC_TIMING_UHS_DDR50);
 			mmc_set_bus_width(card->host, bus_width);
+		} else if (hs_sdr) {
+			if (hs_sdr == EXT_CSD_CARD_TYPE_SDR_1_2V) {
+				err = mmc_set_signal_voltage(host,
+					MMC_SIGNAL_VOLTAGE_120, 0);
+				if (err)
+					goto err;
+			}
+			mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
+			mmc_set_bus_width(card->host, bus_width);
 		}
 	}
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a69d269..28fb747 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -27,6 +27,7 @@
 
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/card.h>
 
 #include "sdhci.h"
 
@@ -1016,7 +1017,8 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		flags |= SDHCI_CMD_INDEX;
 
 	/* CMD19 is special in that the Data Present Select should be set */
-	if (cmd->data || (cmd->opcode == MMC_SEND_TUNING_BLOCK))
+	if (cmd->data || (cmd->opcode == MMC_SEND_TUNING_BLOCK) ||
+	    (cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200))
 		flags |= SDHCI_CMD_DATA;
 
 	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
@@ -1684,10 +1686,13 @@ static int sdhci_execute_tuning(struct mmc_host *mmc)
 	 * Host Controller needs tuning only in case of SDR104 mode
 	 * and for SDR50 mode when Use Tuning for SDR50 is set in
 	 * Capabilities register.
+	 * If the Host Controller supports the HS200 mode then tuning
+	 * function has to be executed.
 	 */
 	if (((ctrl & SDHCI_CTRL_UHS_MASK) == SDHCI_CTRL_UHS_SDR104) ||
 	    (((ctrl & SDHCI_CTRL_UHS_MASK) == SDHCI_CTRL_UHS_SDR50) &&
-	    (host->flags & SDHCI_SDR50_NEEDS_TUNING)))
+	    (host->flags & SDHCI_SDR50_NEEDS_TUNING)) ||
+	    (host->flags & SDHCI_HS200_NEEDS_TUNING))
 		ctrl |= SDHCI_CTRL_EXEC_TUNING;
 	else {
 		spin_unlock(&host->lock);
@@ -1723,7 +1728,10 @@ static int sdhci_execute_tuning(struct mmc_host *mmc)
 		if (!tuning_loop_counter && !timeout)
 			break;
 
-		cmd.opcode = MMC_SEND_TUNING_BLOCK;
+		if (mmc->card->type == MMC_TYPE_MMC)
+			cmd.opcode = MMC_SEND_TUNING_BLOCK_HS200;
+		else
+			cmd.opcode = MMC_SEND_TUNING_BLOCK;
 		cmd.arg = 0;
 		cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
 		cmd.retries = 0;
@@ -1738,7 +1746,17 @@ static int sdhci_execute_tuning(struct mmc_host *mmc)
 		 * block to the Host Controller. So we set the block size
 		 * to 64 here.
 		 */
-		sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 64), SDHCI_BLOCK_SIZE);
+		if (mmc->card->type == MMC_TYPE_MMC) {
+			if (mmc->ios.bus_width == MMC_BUS_WIDTH_8)
+				sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 128),
+					     SDHCI_BLOCK_SIZE);
+			else if (mmc->ios.bus_width == MMC_BUS_WIDTH_4)
+				sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 64),
+					     SDHCI_BLOCK_SIZE);
+		} else {
+			sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 64),
+				     SDHCI_BLOCK_SIZE);
+		}
 
 		/*
 		 * The tuning block is sent by the card to the host controller.
@@ -2121,12 +2139,14 @@ static void sdhci_show_adma_error(struct sdhci_host *host) { }
 
 static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 {
+	u32 command;
 	BUG_ON(intmask == 0);
 
 	/* CMD19 generates _only_ Buffer Read Ready interrupt */
 	if (intmask & SDHCI_INT_DATA_AVAIL) {
-		if (SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND)) ==
-		    MMC_SEND_TUNING_BLOCK) {
+		command = SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND));
+		if ((command == MMC_SEND_TUNING_BLOCK) ||
+		    (command == MMC_SEND_TUNING_BLOCK_HS200)) {
 			host->tuning_done = 1;
 			wake_up(&host->buf_ready_int);
 			return;
@@ -2731,6 +2751,10 @@ int sdhci_add_host(struct sdhci_host *host)
 	if (caps[1] & SDHCI_USE_SDR50_TUNING)
 		host->flags |= SDHCI_SDR50_NEEDS_TUNING;
 
+	/* Does the host needs tuning for HS200? */
+	if (mmc->caps2 & MMC_CAP2_HS200)
+		host->flags |= SDHCI_HS200_NEEDS_TUNING;
+
 	/* Driver Type(s) (A, C, D) supported by the host */
 	if (caps[1] & SDHCI_DRIVER_TYPE_A)
 		mmc->caps |= MMC_CAP_DRIVER_TYPE_A;
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 6e04e10..90af438 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -206,6 +206,7 @@ struct mmc_card {
 #define MMC_STATE_HIGHSPEED_DDR (1<<4)		/* card is in high speed mode */
 #define MMC_STATE_ULTRAHIGHSPEED (1<<5)		/* card is in ultra high speed mode */
 #define MMC_CARD_SDXC		(1<<6)		/* card is SDXC */
+#define MMC_STATE_HIGHSPEED_200	(1<<7)	/* card is in HS200 mode */
 	unsigned int		quirks; 	/* card quirks */
 #define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes outside of the VS CCCR range */
 #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)	/* use func->cur_blksize */
@@ -361,6 +362,7 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_card_present(c)	((c)->state & MMC_STATE_PRESENT)
 #define mmc_card_readonly(c)	((c)->state & MMC_STATE_READONLY)
 #define mmc_card_highspeed(c)	((c)->state & MMC_STATE_HIGHSPEED)
+#define mmc_card_hs200(c)	((c)->state & MMC_STATE_HIGHSPEED_200)
 #define mmc_card_blockaddr(c)	((c)->state & MMC_STATE_BLOCKADDR)
 #define mmc_card_ddr_mode(c)	((c)->state & MMC_STATE_HIGHSPEED_DDR)
 #define mmc_sd_card_uhs(c) ((c)->state & MMC_STATE_ULTRAHIGHSPEED)
@@ -369,6 +371,7 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
 #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
 #define mmc_card_set_highspeed(c) ((c)->state |= MMC_STATE_HIGHSPEED)
+#define mmc_card_set_hs200(c)	((c)->state |= MMC_STATE_HIGHSPEED_200)
 #define mmc_card_set_blockaddr(c) ((c)->state |= MMC_STATE_BLOCKADDR)
 #define mmc_card_set_ddr_mode(c) ((c)->state |= MMC_STATE_HIGHSPEED_DDR)
 #define mmc_sd_card_set_uhs(c) ((c)->state |= MMC_STATE_ULTRAHIGHSPEED)
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index a3ac9c4..20551f5 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -60,6 +60,8 @@ struct mmc_ios {
 #define MMC_SDR_MODE		0
 #define MMC_1_2V_DDR_MODE	1
 #define MMC_1_8V_DDR_MODE	2
+#define MMC_1_2V_SDR_MODE	3
+#define MMC_1_8V_SDR_MODE	4
 
 	unsigned char	signal_voltage;		/* signalling voltage (1.8V or 3.3V) */
 
@@ -242,6 +244,10 @@ struct mmc_host {
 #define MMC_CAP2_CACHE_CTRL	(1 << 1)	/* Allow cache control */
 #define MMC_CAP2_POWEROFF_NOTIFY (1 << 2)	/* Notify poweroff supported */
 #define MMC_CAP2_NO_MULTI_READ	(1 << 3)	/* Multiblock reads don't work */
+#define MMC_CAP2_HS200		(1 << 4)	/* Host supports HS200 mode */
+#define MMC_CAP2_HS200_1_8V_SDR	(1 << 5)	/* can support */
+#define MMC_CAP2_HS200_1_2V_SDR	(1 << 6)	/* can support */
+#define MMC_CAP2_HIGHSPEED_200	(1 << 7)	/* Can do MMC HS200 timing */
 
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 	unsigned int        power_notify_type;
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 0e71356..af4fa72 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -51,6 +51,7 @@
 #define MMC_READ_SINGLE_BLOCK    17   /* adtc [31:0] data addr   R1  */
 #define MMC_READ_MULTIPLE_BLOCK  18   /* adtc [31:0] data addr   R1  */
 #define MMC_SEND_TUNING_BLOCK    19   /* adtc                    R1  */
+#define MMC_SEND_TUNING_BLOCK_HS200	21	/* adtc R1  */
 
   /* class 3 */
 #define MMC_WRITE_DAT_UNTIL_STOP 20   /* adtc [31:0] data addr   R1  */
@@ -333,13 +334,18 @@ struct _mmc_csd {
 
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
+#define EXT_CSD_CARD_TYPE_SDR_200	(EXT_CSD_CARD_TYPE_SDR_1_8V	\
+					| EXT_CSD_CARD_TYPE_SDR_1_2V)
 
 #define EXT_CSD_BUS_WIDTH_1	0	/* Card is in 1 bit mode */
 #define EXT_CSD_BUS_WIDTH_4	1	/* Card is in 4 bit mode */
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index e4b6935..d9a2222 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -121,6 +121,7 @@ struct sdhci_host {
 #define SDHCI_AUTO_CMD23	(1<<7)	/* Auto CMD23 support */
 #define SDHCI_PV_ENABLED	(1<<8)	/* Preset value enabled */
 #define SDHCI_SDIO_IRQ_ENABLED	(1<<9)	/* SDIO irq enabled */
+#define SDHCI_HS200_NEEDS_TUNING (1<<10)	/* HS200 needs tuning */
 
 	unsigned int version;	/* SDHCI spec. version */
 
-- 
1.7.1
