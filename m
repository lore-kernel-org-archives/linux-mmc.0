From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH v3 07/11] mmc: sd: report correct speed and capacity of uhs cards
Date: Wed, 20 Apr 2011 15:00:57 +0530
Message-ID: <1303291861-1788-8-git-send-email-arindam.nath@amd.com>
References: <1303291861-1788-1-git-send-email-arindam.nath@amd.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56478 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753717Ab1DTJcw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Apr 2011 05:32:52 -0400
Received: by pwi15 with SMTP id 15so308745pwi.19
        for <linux-mmc@vger.kernel.org>; Wed, 20 Apr 2011 02:32:52 -0700 (PDT)
In-Reply-To: <1303291861-1788-1-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, prakity@marvell.com, subhashj@codeaurora.org, zhangfei.gao@gmail.com, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com, Arindam Nath <arindam.nath@amd.com>

Since only UHS-I cards respond with S18A set in response to ACMD41,
we set the card as ultra-high-speed after successfull initialization.
We need to decide whether a card is SDXC based on the C_SIZE field
of CSDv2.0 register. According to Physical Layer spec v3.01, the
minimum value of C_SIZE for SDXC card is 00FFFFh.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/mmc/core/bus.c   |   11 ++++++++---
 drivers/mmc/core/sd.c    |   10 +++++++++-
 include/linux/mmc/card.h |    7 +++++++
 3 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index d6d62fd..393d817 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -274,8 +274,12 @@ int mmc_add_card(struct mmc_card *card)
 		break;
 	case MMC_TYPE_SD:
 		type = "SD";
-		if (mmc_card_blockaddr(card))
-			type = "SDHC";
+		if (mmc_card_blockaddr(card)) {
+			if (mmc_card_ext_capacity(card))
+				type = "SDXC";
+			else
+				type = "SDHC";
+		}
 		break;
 	case MMC_TYPE_SDIO:
 		type = "SDIO";
@@ -299,7 +303,8 @@ int mmc_add_card(struct mmc_card *card)
 	} else {
 		printk(KERN_INFO "%s: new %s%s%s card at address %04x\n",
 			mmc_hostname(card->host),
-			mmc_card_highspeed(card) ? "high speed " : "",
+			mmc_sd_card_uhs(card) ? "ultra high speed " :
+			(mmc_card_highspeed(card) ? "high speed " : ""),
 			mmc_card_ddr_mode(card) ? "DDR " : "",
 			type, card->rca);
 	}
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 9af0c94..1594e51 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -130,7 +130,7 @@ static int mmc_decode_csd(struct mmc_card *card)
 		break;
 	case 1:
 		/*
-		 * This is a block-addressed SDHC card. Most
+		 * This is a block-addressed SDHC or SDXC card. Most
 		 * interesting fields are unused and have fixed
 		 * values. To avoid getting tripped by buggy cards,
 		 * we assume those fixed values ourselves.
@@ -144,6 +144,11 @@ static int mmc_decode_csd(struct mmc_card *card)
 		e = UNSTUFF_BITS(resp, 96, 3);
 		csd->max_dtr	  = tran_exp[e] * tran_mant[m];
 		csd->cmdclass	  = UNSTUFF_BITS(resp, 84, 12);
+		csd->c_size	  = UNSTUFF_BITS(resp, 48, 22);
+
+		/* SDXC cards have a minimum C_SIZE of 0x00FFFF */
+		if (csd->c_size >= 0xFFFF)
+			mmc_card_set_ext_capacity(card);
 
 		m = UNSTUFF_BITS(resp, 48, 22);
 		csd->capacity     = (1 + m) << 10;
@@ -917,6 +922,9 @@ static int mmc_sd_init_card(struct mmc_host *host, u32 ocr,
 		err = mmc_sd_init_uhs_card(card);
 		if (err)
 			goto free_card;
+
+		/* Card is an ultra-high-speed card */
+		mmc_sd_card_set_uhs(card);
 	} else {
 		/*
 		 * Attempt to change to high-speed (if supported)
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 47b5ad3..d8dffc9 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -30,6 +30,7 @@ struct mmc_csd {
 	unsigned short		cmdclass;
 	unsigned short		tacc_clks;
 	unsigned int		tacc_ns;
+	unsigned int		c_size;
 	unsigned int		r2w_factor;
 	unsigned int		max_dtr;
 	unsigned int		erase_size;		/* In sectors */
@@ -158,6 +159,8 @@ struct mmc_card {
 #define MMC_STATE_HIGHSPEED	(1<<2)		/* card is in high speed mode */
 #define MMC_STATE_BLOCKADDR	(1<<3)		/* card uses block-addressing */
 #define MMC_STATE_HIGHSPEED_DDR (1<<4)		/* card is in high speed mode */
+#define MMC_STATE_ULTRAHIGHSPEED (1<<5)		/* card is in ultra high speed mode */
+#define MMC_CARD_SDXC		(1<<6)		/* card is SDXC */
 	unsigned int		quirks; 	/* card quirks */
 #define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes outside of the VS CCCR range */
 #define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)	/* use func->cur_blksize */
@@ -293,12 +296,16 @@ static inline void __maybe_unused remove_quirk(struct mmc_card *card, int data)
 #define mmc_card_highspeed(c)	((c)->state & MMC_STATE_HIGHSPEED)
 #define mmc_card_blockaddr(c)	((c)->state & MMC_STATE_BLOCKADDR)
 #define mmc_card_ddr_mode(c)	((c)->state & MMC_STATE_HIGHSPEED_DDR)
+#define mmc_sd_card_uhs(c) ((c)->state & MMC_STATE_ULTRAHIGHSPEED)
+#define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
 
 #define mmc_card_set_present(c)	((c)->state |= MMC_STATE_PRESENT)
 #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
 #define mmc_card_set_highspeed(c) ((c)->state |= MMC_STATE_HIGHSPEED)
 #define mmc_card_set_blockaddr(c) ((c)->state |= MMC_STATE_BLOCKADDR)
 #define mmc_card_set_ddr_mode(c) ((c)->state |= MMC_STATE_HIGHSPEED_DDR)
+#define mmc_sd_card_set_uhs(c) ((c)->state |= MMC_STATE_ULTRAHIGHSPEED)
+#define mmc_card_set_ext_capacity(c) ((c)->state |= MMC_CARD_SDXC)
 
 static inline int mmc_card_lenient_fn0(const struct mmc_card *c)
 {
-- 
1.7.1

