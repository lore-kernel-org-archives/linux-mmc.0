From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH] sdio: add quirk to clamp byte mode transfer
Date: Tue, 26 Jan 2010 20:55:58 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001262046370.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:37352 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636Ab0A0CC1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Jan 2010 21:02:27 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KWV002WHUPAU6D0@VL-MR-MR001.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Tue, 26 Jan 2010 20:55:59 -0500 (EST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org

From: Bing Zhao <bzhao@marvell.com>

Some SDIO cards expect byte transfers not to exceed the configured
block transfer size.  Add a quirk to that effect.

Signed-off-by: Bing Zhao <bzhao@marvell.com>
Signed-off-by: Nicolas Pitre <nico@marvell.com>
---

Patches to make use of this quirk will be sent separately.


diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
index f9aa8a7..f87ec97 100644
--- a/drivers/mmc/core/sdio_io.c
+++ b/drivers/mmc/core/sdio_io.c
@@ -189,7 +189,12 @@ static inline unsigned int sdio_max_byte_size(struct sdio_func *func)
 {
 	unsigned mval =	min(func->card->host->max_seg_size,
 			    func->card->host->max_blk_size);
-	mval = min(mval, func->max_blksize);
+
+	if (mmc_blksz_for_byte_mode(func->card))
+		mval = min(mval, func->cur_blksize);
+	else
+		mval = min(mval, func->max_blksize);
+
 	return min(mval, 512u); /* maximum size for byte mode */
 }
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 2ee22e8..5330ad8 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -99,6 +99,8 @@ struct mmc_card {
 #define MMC_STATE_BLOCKADDR	(1<<3)		/* card uses block-addressing */
 	unsigned int		quirks; 	/* card quirks */
 #define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes outside of the VS CCCR range */
+#define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)	/* use func->cur_blksize */
+						/* for byte mode */
 
 	u32			raw_cid[4];	/* raw card CID */
 	u32			raw_csd[4];	/* raw card CSD */
@@ -139,6 +141,11 @@ static inline int mmc_card_lenient_fn0(const struct mmc_card *c)
 	return c->quirks & MMC_QUIRK_LENIENT_FN0;
 }
 
+static inline int mmc_blksz_for_byte_mode(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_BLKSZ_FOR_BYTE_MODE;
+}
+
 #define mmc_card_name(c)	((c)->cid.prod_name)
 #define mmc_card_id(c)		(dev_name(&(c)->dev))
 
