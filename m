From: Girish K S <girish.shivananjappa@linaro.org>
Subject: [PATCH V1] mmc: core: HS200 mode support for eMMC 4.5
Date: Thu, 22 Sep 2011 16:43:40 +0530
Message-ID: <1316690020-8742-1-git-send-email-girish.shivananjappa@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>
List-Id: linux-mmc@vger.kernel.org

This patch adds the support of the HS200 bus speed for
eMMC 4.5 devices.
The eMMC 4.5 devices have support for 200MHz bus speed.
The mmc core and host modules have been touched to add support
for this module.
It is necessary to know the card type in the sdhci.c file to
add support for eMMC tuning function. So card.h file is included
to import the card data structure.

Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
---
 v1:
 cases which produce same result have been combined to reduce
 repeated assignments. patch recreated after rebase to chris 
 balls mmc-next branch.

 drivers/mmc/core/bus.c   |    3 +-
 drivers/mmc/core/mmc.c   |   89 +++++++++++++++++++++++++++++++++++++++++-----
 drivers/mmc/host/sdhci.c |   18 ++++++++--
 include/linux/mmc/card.h |    3 ++
 include/linux/mmc/host.h |    8 ++++
 include/linux/mmc/mmc.h  |    9 ++++-
 6 files changed, 116 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 393d817..a0aa7ab 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -301,10 +301,11 @@ int mmc_add_card(struct mmc_card *card)
 			mmc_card_ddr_mode(card) ? "DDR " : "",
 			type);
 	} else {
-		printk(KERN_INFO "%s: new %s%s%s card at address %04x\n",
+		printk(KERN_INFO "%s: new %s%s%s%s card at address %04x\n",
 			mmc_hostname(card->host),
 			mmc_sd_card_uhs(card) ? "ultra high speed " :
 			(mmc_card_highspeed(card) ? "high speed " : ""),
+			(mmc_card_hs200(card) ? "HS200 " : ""),
 			mmc_card_ddr_mode(card) ? "DDR " : "",
 			type, card->rca);
 	}
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 9dd6c82..2159ff6 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -283,6 +283,39 @@ static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
 	}
 	card->ext_csd.raw_card_type = ext_csd[EXT_CSD_CARD_TYPE];
 	switch (ext_csd[EXT_CSD_CARD_TYPE] & EXT_CSD_CARD_TYPE_MASK) {
+	case EXT_CSD_CARD_TYPE_SDR_200 | EXT_CSD_CARD_TYPE_52 |
+	     EXT_CSD_CARD_TYPE_26:
+	case EXT_CSD_CARD_TYPE_SDR_200 | EXT_CSD_CARD_TYPE_DDR_1_8V |
+		 EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
+	case EXT_CSD_CARD_TYPE_SDR_200 | EXT_CSD_CARD_TYPE_DDR_1_2V |
+		 EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
+	case EXT_CSD_CARD_TYPE_SDR_200 | EXT_CSD_CARD_TYPE_DDR_52 |
+		 EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
+		card->ext_csd.hs_max_dtr = 200000000;
+		card->ext_csd.card_type = EXT_CSD_CARD_TYPE_SDR_200;
+		break;
+	case EXT_CSD_CARD_TYPE_SDR_1_2V | EXT_CSD_CARD_TYPE_52 |
+	     EXT_CSD_CARD_TYPE_26:
+	case EXT_CSD_CARD_TYPE_SDR_1_2V | EXT_CSD_CARD_TYPE_DDR_1_8V |
+		 EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
+	case EXT_CSD_CARD_TYPE_SDR_1_2V | EXT_CSD_CARD_TYPE_DDR_1_2V |
+		 EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
+	case EXT_CSD_CARD_TYPE_SDR_1_2V | EXT_CSD_CARD_TYPE_DDR_52 |
+		 EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
+		card->ext_csd.hs_max_dtr = 200000000;
+		card->ext_csd.card_type = EXT_CSD_CARD_TYPE_SDR_1_2V;
+		break;
+	case EXT_CSD_CARD_TYPE_SDR_1_8V | EXT_CSD_CARD_TYPE_52 |
+	     EXT_CSD_CARD_TYPE_26:
+	case EXT_CSD_CARD_TYPE_SDR_1_8V | EXT_CSD_CARD_TYPE_DDR_1_8V |
+		 EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
+	case EXT_CSD_CARD_TYPE_SDR_1_8V | EXT_CSD_CARD_TYPE_DDR_1_2V |
+		 EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
+	case EXT_CSD_CARD_TYPE_SDR_1_8V | EXT_CSD_CARD_TYPE_DDR_52 |
+		 EXT_CSD_CARD_TYPE_52 | EXT_CSD_CARD_TYPE_26:
+		card->ext_csd.hs_max_dtr = 200000000;
+		card->ext_csd.card_type = EXT_CSD_CARD_TYPE_SDR_1_8V;
+		break;
 	case EXT_CSD_CARD_TYPE_DDR_52 | EXT_CSD_CARD_TYPE_52 |
 	     EXT_CSD_CARD_TYPE_26:
 		card->ext_csd.hs_max_dtr = 52000000;
@@ -620,7 +653,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	struct mmc_card *oldcard)
 {
 	struct mmc_card *card;
-	int err, ddr = 0;
+	int err, ddr = 0, hs_sdr = 0;
 	u32 cid[4];
 	unsigned int max_dtr;
 	u32 rocr;
@@ -810,10 +843,15 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	/*
 	 * Activate high speed (if supported)
 	 */
-	if ((card->ext_csd.hs_max_dtr != 0) &&
-		(host->caps & MMC_CAP_MMC_HIGHSPEED)) {
-		err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
-				 EXT_CSD_HS_TIMING, 1, 0);
+	if (card->ext_csd.hs_max_dtr != 0) {
+		if ((card->ext_csd.hs_max_dtr > 52000000) &&
+			(host->ext_caps & MMC_CAP_MMC_HIGHSPEED_200))
+			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+					EXT_CSD_HS_TIMING, 2, 0);
+		else if	(host->caps & MMC_CAP_MMC_HIGHSPEED)
+			err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+					EXT_CSD_HS_TIMING, 1, 0);
+
 		if (err && err != -EBADMSG)
 			goto free_card;
 
@@ -822,7 +860,10 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
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
@@ -832,7 +873,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	 */
 	max_dtr = (unsigned int)-1;
 
-	if (mmc_card_highspeed(card)) {
+	if (mmc_card_highspeed(card) || mmc_card_hs200(card)) {
 		if (max_dtr > card->ext_csd.hs_max_dtr)
 			max_dtr = card->ext_csd.hs_max_dtr;
 	} else if (max_dtr > card->csd.max_dtr) {
@@ -858,6 +899,22 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	}
 
 	/*
+	 * Indicate HS200 SDR mode (if supported).
+	 */
+	if (mmc_card_hs200(card)) {
+		if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_SDR_1_8V)
+			&& ((host->ext_caps & (MMC_CAP_HS200_1_8V_SDR |
+			     MMC_CAP_HS200))
+				== (MMC_CAP_HS200_1_8V_SDR | MMC_CAP_HS200)))
+				hs_sdr = MMC_1_8V_SDR_MODE;
+		else if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_SDR_1_2V)
+			&& ((host->ext_caps & (MMC_CAP_HS200_1_2V_SDR |
+			     MMC_CAP_HS200))
+				== (MMC_CAP_HS200_1_2V_SDR | MMC_CAP_HS200)))
+				hs_sdr = MMC_1_2V_SDR_MODE;
+	}
+
+	/*
 	 * Activate wide bus and DDR (if supported).
 	 */
 	if ((card->csd.mmca_vsn >= CSD_SPEC_VER_4) &&
@@ -897,16 +954,21 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 			if (!err) {
 				mmc_set_bus_width(card->host, bus_width);
 
+				if ((host->ext_caps & MMC_CAP_HS200) &&
+						card->host->ops->execute_tuning)
+					err = card->host->ops->execute_tuning(card->host);
 				/*
 				 * If controller can't handle bus width test,
 				 * compare ext_csd previously read in 1 bit mode
 				 * against ext_csd at new bus width
 				 */
-				if (!(host->caps & MMC_CAP_BUS_WIDTH_TEST))
+				if (!(host->caps & MMC_CAP_BUS_WIDTH_TEST) && !err)
 					err = mmc_compare_ext_csds(card,
 						bus_width);
-				else
+				else if (!err)
 					err = mmc_bus_test(card, bus_width);
+				else
+					printk(KERN_WARNING "tuning execution failed\n");
 				if (!err)
 					break;
 			}
@@ -955,6 +1017,15 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 			mmc_card_set_ddr_mode(card);
 			mmc_set_timing(card->host, MMC_TIMING_UHS_DDR50);
 			mmc_set_bus_width(card->host, bus_width);
+		} else if (hs_sdr) {
+			if (hs_sdr == EXT_CSD_CARD_TYPE_SDR_1_2V) {
+				err = mmc_set_signal_voltage(host,
+					MMC_SIGNAL_VOLTAGE_120, 0);
+				if (err)
+					goto err;
+		   }
+		   mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
+		   mmc_set_bus_width(card->host, bus_width);
 		}
 	}
 
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 04abd45..d63d971 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -25,6 +25,7 @@
 
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/card.h>
 
 #include "sdhci.h"
 
@@ -993,7 +994,8 @@ static void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 		flags |= SDHCI_CMD_INDEX;
 
 	/* CMD19 is special in that the Data Present Select should be set */
-	if (cmd->data || (cmd->opcode == MMC_SEND_TUNING_BLOCK))
+	if (cmd->data || (cmd->opcode == MMC_SEND_TUNING_BLOCK) ||
+			(cmd->opcode == MMC_SEND_TUNING_BLOCK_HS200))
 		flags |= SDHCI_CMD_DATA;
 
 	sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), SDHCI_COMMAND);
@@ -1661,7 +1663,10 @@ static int sdhci_execute_tuning(struct mmc_host *mmc)
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
@@ -1676,7 +1681,14 @@ static int sdhci_execute_tuning(struct mmc_host *mmc)
 		 * block to the Host Controller. So we set the block size
 		 * to 64 here.
 		 */
-		sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 64), SDHCI_BLOCK_SIZE);
+		if (mmc->card->type == MMC_TYPE_MMC) {
+			if (mmc->ios.bus_width == MMC_BUS_WIDTH_8)
+				sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 128), SDHCI_BLOCK_SIZE);
+			else if (mmc->ios.bus_width == MMC_BUS_WIDTH_4)
+				sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 64), SDHCI_BLOCK_SIZE);
+		} else {
+			sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 64), SDHCI_BLOCK_SIZE);
+		}
 
 		/*
 		 * The tuning block is sent by the card to the host controller.
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 3bc1995..c7feec4 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -179,6 +179,7 @@ struct mmc_card {
 #define MMC_STATE_HIGHSPEED_DDR (1<<4)		/* card is in high speed mode */
 #define MMC_STATE_ULTRAHIGHSPEED (1<<5)		/* card is in ultra high speed mode */
 #define MMC_CARD_SDXC		(1<<6)		/* card is SDXC */
+#define MMC_STATE_HIGHSPEED_200	(1<<7)		/* card is in HS200 mode */
 	unsigned int		quirks; 	/* card quirks */
 #define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes outside of the VS CCCR range */
 #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)	/* use func->cur_blksize */
@@ -319,6 +320,7 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_card_present(c)	((c)->state & MMC_STATE_PRESENT)
 #define mmc_card_readonly(c)	((c)->state & MMC_STATE_READONLY)
 #define mmc_card_highspeed(c)	((c)->state & MMC_STATE_HIGHSPEED)
+#define mmc_card_hs200(c)	((c)->state & MMC_STATE_HIGHSPEED_200)
 #define mmc_card_blockaddr(c)	((c)->state & MMC_STATE_BLOCKADDR)
 #define mmc_card_ddr_mode(c)	((c)->state & MMC_STATE_HIGHSPEED_DDR)
 #define mmc_sd_card_uhs(c) ((c)->state & MMC_STATE_ULTRAHIGHSPEED)
@@ -327,6 +329,7 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
 #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
 #define mmc_card_set_highspeed(c) ((c)->state |= MMC_STATE_HIGHSPEED)
+#define mmc_card_set_hs200(c) ((c)->state |= MMC_STATE_HIGHSPEED_200)
 #define mmc_card_set_blockaddr(c) ((c)->state |= MMC_STATE_BLOCKADDR)
 #define mmc_card_set_ddr_mode(c) ((c)->state |= MMC_STATE_HIGHSPEED_DDR)
 #define mmc_sd_card_set_uhs(c) ((c)->state |= MMC_STATE_ULTRAHIGHSPEED)
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index d8a3a72..de68354 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -60,6 +60,8 @@ struct mmc_ios {
 #define MMC_SDR_MODE		0
 #define MMC_1_2V_DDR_MODE	1
 #define MMC_1_8V_DDR_MODE	2
+#define MMC_1_2V_SDR_MODE	3
+#define MMC_1_8V_SDR_MODE	4
 
 	unsigned char	signal_voltage;		/* signalling voltage (1.8V or 3.3V) */
 
@@ -237,6 +239,12 @@ struct mmc_host {
 #define MMC_CAP_HW_RESET	(1 << 31)	/* Hardware reset */
 #define MMC_CAP_POWER_OFF_NOTIFY    (1 << 31)/*Notify poweroff supported */
 
+	unsigned long		ext_caps;		/* extended Host capabilities */
+#define MMC_CAP_HS200	(1 << 0)	/* Host supports HS200 mode */
+#define MMC_CAP_HS200_1_8V_SDR	(1 << 1)	/* can support */
+#define MMC_CAP_HS200_1_2V_SDR	(1 << 2)	/* can support */
+#define MMC_CAP_MMC_HIGHSPEED_200	(1 << 3)/* Can do MMC HS200 timing */
+
 	mmc_pm_flag_t		pm_caps;	/* supported pm features */
 	unsigned int        power_notify_type;
 #define MMC_HOST_PW_NOTIFY_NONE	0
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index d72d550..3674f2e 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -51,6 +51,7 @@
 #define MMC_READ_SINGLE_BLOCK    17   /* adtc [31:0] data addr   R1  */
 #define MMC_READ_MULTIPLE_BLOCK  18   /* adtc [31:0] data addr   R1  */
 #define MMC_SEND_TUNING_BLOCK    19   /* adtc                    R1  */
+#define MMC_SEND_TUNING_BLOCK_HS200    21   /* adtc                    R1  */
 
   /* class 3 */
 #define MMC_WRITE_DAT_UNTIL_STOP 20   /* adtc [31:0] data addr   R1  */
@@ -322,7 +323,7 @@ struct _mmc_csd {
 
 #define EXT_CSD_CARD_TYPE_26	(1<<0)	/* Card can run at 26MHz */
 #define EXT_CSD_CARD_TYPE_52	(1<<1)	/* Card can run at 52MHz */
-#define EXT_CSD_CARD_TYPE_MASK	0xF	/* Mask out reserved bits */
+#define EXT_CSD_CARD_TYPE_MASK	0x3F	/* Mask out reserved bits */
 #define EXT_CSD_CARD_TYPE_DDR_1_8V  (1<<2)   /* Card can run at 52MHz */
 					     /* DDR mode @1.8V or 3V I/O */
 #define EXT_CSD_CARD_TYPE_DDR_1_2V  (1<<3)   /* Card can run at 52MHz */
@@ -330,6 +331,12 @@ struct _mmc_csd {
 #define EXT_CSD_CARD_TYPE_DDR_52       (EXT_CSD_CARD_TYPE_DDR_1_8V  \
 					| EXT_CSD_CARD_TYPE_DDR_1_2V)
 
+#define EXT_CSD_CARD_TYPE_SDR_1_8V  (1<<4)   /* Card can run at 200MHz */
+					     /* SDR mode @1.8V I/O */
+#define EXT_CSD_CARD_TYPE_SDR_1_2V  (1<<5)   /* Card can run at 200MHz */
+					     /* SDR mode @1.2V I/O */
+#define EXT_CSD_CARD_TYPE_SDR_200       (EXT_CSD_CARD_TYPE_SDR_1_8V  \
+					| EXT_CSD_CARD_TYPE_SDR_1_2V)
 #define EXT_CSD_BUS_WIDTH_1	0	/* Card is in 1 bit mode */
 #define EXT_CSD_BUS_WIDTH_4	1	/* Card is in 4 bit mode */
 #define EXT_CSD_BUS_WIDTH_8	2	/* Card is in 8 bit mode */
-- 
1.7.1
