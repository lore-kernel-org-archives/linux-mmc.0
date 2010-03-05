From: akpm@linux-foundation.org
Subject: [patch 098/160] sdio: add quirk to clamp byte mode transfer
Date: Fri, 05 Mar 2010 13:43:25 -0800
Message-ID: <201003052143.o25LhQHR029757@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44152 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755358Ab0CEVn3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Mar 2010 16:43:29 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, bzhao@marvell.com, linux-mmc@vger.kernel.org, nico@marvell.com

From: Bing Zhao <bzhao@marvell.com>

Some SDIO cards expect byte transfers not to exceed the configured block
transfer size.  Add a quirk to that effect.

Patches to make use of this quirk will be sent separately.

Signed-off-by: Bing Zhao <bzhao@marvell.com>
Signed-off-by: Nicolas Pitre <nico@marvell.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/core/sdio_io.c |    7 ++++++-
 include/linux/mmc/card.h   |    7 +++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff -puN drivers/mmc/core/sdio_io.c~sdio-add-quirk-to-clamp-byte-mode-transfer drivers/mmc/core/sdio_io.c
--- a/drivers/mmc/core/sdio_io.c~sdio-add-quirk-to-clamp-byte-mode-transfer
+++ a/drivers/mmc/core/sdio_io.c
@@ -189,7 +189,12 @@ static inline unsigned int sdio_max_byte
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
 
diff -puN include/linux/mmc/card.h~sdio-add-quirk-to-clamp-byte-mode-transfer include/linux/mmc/card.h
--- a/include/linux/mmc/card.h~sdio-add-quirk-to-clamp-byte-mode-transfer
+++ a/include/linux/mmc/card.h
@@ -99,6 +99,8 @@ struct mmc_card {
 #define MMC_STATE_BLOCKADDR	(1<<3)		/* card uses block-addressing */
 	unsigned int		quirks; 	/* card quirks */
 #define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes outside of the VS CCCR range */
+#define MMC_QUIRK_BLKSZ_FOR_BYTE_MODE (1<<1)	/* use func->cur_blksize */
+						/* for byte mode */
 
 	u32			raw_cid[4];	/* raw card CID */
 	u32			raw_csd[4];	/* raw card CSD */
@@ -139,6 +141,11 @@ static inline int mmc_card_lenient_fn0(c
 	return c->quirks & MMC_QUIRK_LENIENT_FN0;
 }
 
+static inline int mmc_blksz_for_byte_mode(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_BLKSZ_FOR_BYTE_MODE;
+}
+
 #define mmc_card_name(c)	((c)->cid.prod_name)
 #define mmc_card_id(c)		(dev_name(&(c)->dev))
 
_
