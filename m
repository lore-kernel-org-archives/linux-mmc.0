From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH RESEND 1/5] mmc: drop the speed mode of card's state
Date: Sat, 15 Feb 2014 23:18:45 +0900
Message-ID: <006801cf2a58$d5e49610$81adc230$%jun@samsung.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:26951 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153AbaBOOSq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 15 Feb 2014 09:18:46 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N11000MCJR8XG70@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Sat, 15 Feb 2014 23:18:45 +0900 (KST)
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <chris@printf.net>, 'Ulf Hansson' <ulf.hansson@linaro.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Jackey Shen' <jackey.shen@amd.com>, 'Alim Akhtar' <alim.akhtar@samsung.com>

Timing mode identifier has same role and can take the place
of speed mode. This change removes all related speed mode.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/core/bus.c   |    9 +++++----
 drivers/mmc/core/core.c  |    3 +--
 drivers/mmc/core/mmc.c   |   11 +++--------
 drivers/mmc/core/sd.c    |   16 +++-------------
 drivers/mmc/core/sd.h    |    1 -
 drivers/mmc/core/sdio.c  |    8 ++------
 include/linux/mmc/card.h |   24 +++++++-----------------
 include/linux/mmc/host.h |   23 +++++++++++++++++++++++
 8 files changed, 44 insertions(+), 51 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 64145a3..e8a21fb 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -286,6 +286,7 @@ struct mmc_card *mmc_alloc_card(struct mmc_host *host, struct device_type *type)
 		return ERR_PTR(-ENOMEM);
 
 	card->host = host;
+	card->ios = &host->ios;
 
 	device_initialize(&card->dev);
 
@@ -349,16 +350,16 @@ int mmc_add_card(struct mmc_card *card)
 	if (mmc_host_is_spi(card->host)) {
 		pr_info("%s: new %s%s%s card on SPI\n",
 			mmc_hostname(card->host),
-			mmc_card_highspeed(card) ? "high speed " : "",
-			mmc_card_ddr_mode(card) ? "DDR " : "",
+			mmc_card_hs(card) ? "high speed " : "",
+			mmc_card_ddr52(card) ? "DDR " : "",
 			type);
 	} else {
 		pr_info("%s: new %s%s%s%s%s card at address %04x\n",
 			mmc_hostname(card->host),
 			mmc_card_uhs(card) ? "ultra high speed " :
-			(mmc_card_highspeed(card) ? "high speed " : ""),
+			(mmc_card_hs(card) ? "high speed " : ""),
 			(mmc_card_hs200(card) ? "HS200 " : ""),
-			mmc_card_ddr_mode(card) ? "DDR " : "",
+			mmc_card_ddr52(card) ? "DDR " : "",
 			uhs_bus_speed_mode, type, card->rca);
 	}
 
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 098374b..88433bd 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2198,7 +2198,7 @@ int mmc_set_blocklen(struct mmc_card *card, unsigned int blocklen)
 {
 	struct mmc_command cmd = {0};
 
-	if (mmc_card_blockaddr(card) || mmc_card_ddr_mode(card))
+	if (mmc_card_blockaddr(card) || mmc_card_ddr52(card))
 		return 0;
 
 	cmd.opcode = MMC_SET_BLOCKLEN;
@@ -2281,7 +2281,6 @@ static int mmc_do_hw_reset(struct mmc_host *host, int check)
 		}
 	}
 
-	host->card->state &= ~(MMC_STATE_HIGHSPEED | MMC_STATE_HIGHSPEED_DDR);
 	if (mmc_host_is_spi(host)) {
 		host->ios.chip_select = MMC_CS_HIGH;
 		host->ios.bus_mode = MMC_BUSMODE_PUSHPULL;
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 6d91ff7..613e641 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1088,11 +1088,9 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		} else {
 			if (card->ext_csd.hs_max_dtr > 52000000 &&
 			    host->caps2 & MMC_CAP2_HS200) {
-				mmc_card_set_hs200(card);
 				mmc_set_timing(card->host,
 					       MMC_TIMING_MMC_HS200);
 			} else {
-				mmc_card_set_highspeed(card);
 				mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
 			}
 		}
@@ -1103,10 +1101,10 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	 */
 	max_dtr = (unsigned int)-1;
 
-	if (mmc_card_highspeed(card) || mmc_card_hs200(card)) {
+	if (mmc_card_hs(card) || mmc_card_hs200(card)) {
 		if (max_dtr > card->ext_csd.hs_max_dtr)
 			max_dtr = card->ext_csd.hs_max_dtr;
-		if (mmc_card_highspeed(card) && (max_dtr > 52000000))
+		if (mmc_card_hs(card) && (max_dtr > 52000000))
 			max_dtr = 52000000;
 	} else if (max_dtr > card->csd.max_dtr) {
 		max_dtr = card->csd.max_dtr;
@@ -1117,7 +1115,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	/*
 	 * Indicate DDR mode (if supported).
 	 */
-	if (mmc_card_highspeed(card)) {
+	if (mmc_card_hs(card)) {
 		if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_DDR_1_8V)
 			&& (host->caps & MMC_CAP_1_8V_DDR))
 				ddr = MMC_1_8V_DDR_MODE;
@@ -1260,7 +1258,6 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 				if (err)
 					goto err;
 			}
-			mmc_card_set_ddr_mode(card);
 			mmc_set_timing(card->host, MMC_TIMING_MMC_DDR52);
 			mmc_set_bus_width(card->host, bus_width);
 		}
@@ -1495,7 +1492,6 @@ static int _mmc_suspend(struct mmc_host *host, bool is_suspend)
 		err = mmc_sleep(host);
 	else if (!mmc_host_is_spi(host))
 		err = mmc_deselect_cards(host);
-	host->card->state &= ~(MMC_STATE_HIGHSPEED | MMC_STATE_HIGHSPEED_200);
 
 	if (!err) {
 		mmc_power_off(host);
@@ -1625,7 +1621,6 @@ static int mmc_power_restore(struct mmc_host *host)
 {
 	int ret;
 
-	host->card->state &= ~(MMC_STATE_HIGHSPEED | MMC_STATE_HIGHSPEED_200);
 	mmc_claim_host(host);
 	ret = mmc_init_card(host, host->card->ocr, host->card);
 	mmc_release_host(host);
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 692fdb1..54dd3d1 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -895,7 +895,7 @@ unsigned mmc_sd_get_max_clock(struct mmc_card *card)
 {
 	unsigned max_dtr = (unsigned int)-1;
 
-	if (mmc_card_highspeed(card)) {
+	if (mmc_card_hs(card)) {
 		if (max_dtr > card->sw_caps.hs_max_dtr)
 			max_dtr = card->sw_caps.hs_max_dtr;
 	} else if (max_dtr > card->csd.max_dtr) {
@@ -905,12 +905,6 @@ unsigned mmc_sd_get_max_clock(struct mmc_card *card)
 	return max_dtr;
 }
 
-void mmc_sd_go_highspeed(struct mmc_card *card)
-{
-	mmc_card_set_highspeed(card);
-	mmc_set_timing(card->host, MMC_TIMING_SD_HS);
-}
-
 /*
  * Handle the detection and initialisation of a card.
  *
@@ -985,16 +979,13 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 		err = mmc_sd_init_uhs_card(card);
 		if (err)
 			goto free_card;
-
-		/* Card is an ultra-high-speed card */
-		mmc_card_set_uhs(card);
 	} else {
 		/*
 		 * Attempt to change to high-speed (if supported)
 		 */
 		err = mmc_sd_switch_hs(card);
 		if (err > 0)
-			mmc_sd_go_highspeed(card);
+			mmc_set_timing(card->host, MMC_TIMING_SD_HS);
 		else if (err)
 			goto free_card;
 
@@ -1089,7 +1080,7 @@ static int _mmc_sd_suspend(struct mmc_host *host)
 
 	if (!mmc_host_is_spi(host))
 		err = mmc_deselect_cards(host);
-	host->card->state &= ~MMC_STATE_HIGHSPEED;
+
 	if (!err) {
 		mmc_power_off(host);
 		mmc_card_set_suspended(host->card);
@@ -1198,7 +1189,6 @@ static int mmc_sd_power_restore(struct mmc_host *host)
 {
 	int ret;
 
-	host->card->state &= ~MMC_STATE_HIGHSPEED;
 	mmc_claim_host(host);
 	ret = mmc_sd_init_card(host, host->card->ocr, host->card);
 	mmc_release_host(host);
diff --git a/drivers/mmc/core/sd.h b/drivers/mmc/core/sd.h
index 4b34b24..aab824a 100644
--- a/drivers/mmc/core/sd.h
+++ b/drivers/mmc/core/sd.h
@@ -12,6 +12,5 @@ int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
 	bool reinit);
 unsigned mmc_sd_get_max_clock(struct mmc_card *card);
 int mmc_sd_switch_hs(struct mmc_card *card);
-void mmc_sd_go_highspeed(struct mmc_card *card);
 
 #endif
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 4d721c6..ef57d2d 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -363,7 +363,7 @@ static unsigned mmc_sdio_get_max_clock(struct mmc_card *card)
 {
 	unsigned max_dtr;
 
-	if (mmc_card_highspeed(card)) {
+	if (mmc_card_hs(card)) {
 		/*
 		 * The SDIO specification doesn't mention how
 		 * the CIS transfer speed register relates to
@@ -733,7 +733,6 @@ try_again:
 		mmc_set_clock(host, card->cis.max_dtr);
 
 		if (card->cccr.high_speed) {
-			mmc_card_set_highspeed(card);
 			mmc_set_timing(card->host, MMC_TIMING_SD_HS);
 		}
 
@@ -792,16 +791,13 @@ try_again:
 		err = mmc_sdio_init_uhs_card(card);
 		if (err)
 			goto remove;
-
-		/* Card is an ultra-high-speed card */
-		mmc_card_set_uhs(card);
 	} else {
 		/*
 		 * Switch to high-speed (if supported).
 		 */
 		err = sdio_enable_hs(card);
 		if (err > 0)
-			mmc_sd_go_highspeed(card);
+			mmc_set_timing(card->host, MMC_TIMING_SD_HS);
 		else if (err)
 			goto remove;
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index b730272..e6ce178 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -194,6 +194,7 @@ struct sdio_cis {
 };
 
 struct mmc_host;
+struct mmc_ios;
 struct sdio_func;
 struct sdio_func_tuple;
 
@@ -239,6 +240,7 @@ struct mmc_part {
  */
 struct mmc_card {
 	struct mmc_host		*host;		/* the host this device belongs to */
+	struct mmc_ios		*ios;		/* bus settings of host */
 	struct device		dev;		/* the device */
 	u32			ocr;		/* the current OCR setting */
 	unsigned int		rca;		/* relative card address of device */
@@ -250,15 +252,11 @@ struct mmc_card {
 	unsigned int		state;		/* (our) card state */
 #define MMC_STATE_PRESENT	(1<<0)		/* present in sysfs */
 #define MMC_STATE_READONLY	(1<<1)		/* card is read-only */
-#define MMC_STATE_HIGHSPEED	(1<<2)		/* card is in high speed mode */
-#define MMC_STATE_BLOCKADDR	(1<<3)		/* card uses block-addressing */
-#define MMC_STATE_HIGHSPEED_DDR (1<<4)		/* card is in high speed mode */
-#define MMC_STATE_ULTRAHIGHSPEED (1<<5)		/* card is in ultra high speed mode */
-#define MMC_CARD_SDXC		(1<<6)		/* card is SDXC */
-#define MMC_CARD_REMOVED	(1<<7)		/* card has been removed */
-#define MMC_STATE_HIGHSPEED_200	(1<<8)		/* card is in HS200 mode */
-#define MMC_STATE_DOING_BKOPS	(1<<10)		/* card is doing BKOPS */
-#define MMC_STATE_SUSPENDED	(1<<11)		/* card is suspended */
+#define MMC_STATE_BLOCKADDR	(1<<2)		/* card uses block-addressing */
+#define MMC_CARD_SDXC		(1<<3)		/* card is SDXC */
+#define MMC_CARD_REMOVED	(1<<4)		/* card has been removed */
+#define MMC_STATE_DOING_BKOPS	(1<<5)		/* card is doing BKOPS */
+#define MMC_STATE_SUSPENDED	(1<<6)		/* card is suspended */
 	unsigned int		quirks; 	/* card quirks */
 #define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes outside of the VS CCCR range */
 #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)	/* use func->cur_blksize */
@@ -418,11 +416,7 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 
 #define mmc_card_present(c)	((c)->state & MMC_STATE_PRESENT)
 #define mmc_card_readonly(c)	((c)->state & MMC_STATE_READONLY)
-#define mmc_card_highspeed(c)	((c)->state & MMC_STATE_HIGHSPEED)
-#define mmc_card_hs200(c)	((c)->state & MMC_STATE_HIGHSPEED_200)
 #define mmc_card_blockaddr(c)	((c)->state & MMC_STATE_BLOCKADDR)
-#define mmc_card_ddr_mode(c)	((c)->state & MMC_STATE_HIGHSPEED_DDR)
-#define mmc_card_uhs(c)		((c)->state & MMC_STATE_ULTRAHIGHSPEED)
 #define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
 #define mmc_card_removed(c)	((c) && ((c)->state & MMC_CARD_REMOVED))
 #define mmc_card_doing_bkops(c)	((c)->state & MMC_STATE_DOING_BKOPS)
@@ -430,11 +424,7 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 
 #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
 #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
-#define mmc_card_set_highspeed(c) ((c)->state |= MMC_STATE_HIGHSPEED)
-#define mmc_card_set_hs200(c)	((c)->state |= MMC_STATE_HIGHSPEED_200)
 #define mmc_card_set_blockaddr(c) ((c)->state |= MMC_STATE_BLOCKADDR)
-#define mmc_card_set_ddr_mode(c) ((c)->state |= MMC_STATE_HIGHSPEED_DDR)
-#define mmc_card_set_uhs(c) ((c)->state |= MMC_STATE_ULTRAHIGHSPEED)
 #define mmc_card_set_ext_capacity(c) ((c)->state |= MMC_CARD_SDXC)
 #define mmc_card_set_removed(c) ((c)->state |= MMC_CARD_REMOVED)
 #define mmc_card_set_doing_bkops(c)	((c)->state |= MMC_STATE_DOING_BKOPS)
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 87b1f4f..71977f4 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -17,6 +17,7 @@
 #include <linux/fault-inject.h>
 
 #include <linux/mmc/core.h>
+#include <linux/mmc/card.h>
 #include <linux/mmc/pm.h>
 
 struct mmc_ios {
@@ -485,4 +486,26 @@ static inline unsigned int mmc_host_clk_rate(struct mmc_host *host)
 	return host->ios.clock;
 }
 #endif
+
+static inline int mmc_card_hs(struct mmc_card *card)
+{
+	return card->ios->timing == MMC_TIMING_SD_HS ||
+		card->ios->timing == MMC_TIMING_MMC_HS;
+}
+
+static inline int mmc_card_uhs(struct mmc_card *card)
+{
+	return card->ios->timing >= MMC_TIMING_UHS_SDR12 &&
+		card->ios->timing <= MMC_TIMING_UHS_DDR50;
+}
+
+static inline bool mmc_card_hs200(struct mmc_card *card)
+{
+	return card->ios->timing == MMC_TIMING_MMC_HS200;
+}
+
+static inline bool mmc_card_ddr52(struct mmc_card *card)
+{
+	return card->ios->timing == MMC_TIMING_MMC_DDR52;
+}
 #endif /* LINUX_MMC_HOST_H */
-- 
1.7.0.4


