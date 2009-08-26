From: Ohad Ben-Cohen <ohad@bencohen.org>
Subject: [PATCH 2/2] sdio: add MMC_QUIRK_LENIENT_FN0
Date: Wed, 26 Aug 2009 04:10:01 +0300
Message-ID: <1251249001.31954.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f206.google.com ([209.85.219.206]:37922 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932497AbZHZBET (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2009 21:04:19 -0400
Received: by ewy2 with SMTP id 2so981058ewy.17
        for <linux-mmc@vger.kernel.org>; Tue, 25 Aug 2009 18:04:20 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org

From: Ohad Ben-Cohen <ohad@wizery.com>

Normally writes to SDIO function 0 outside the vendor
specific CCCR registers are prohibited. To support embedded
devices that require writes to SDIO function 0 outside this
range (e.g. TI WL127x embedded sdio wifi device),
MMC_QUIRK_LENIENT_FN0 is introduced.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/mmc/core/sdio_io.c |    2 +-
 include/linux/mmc/card.h   |    3 +++
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
index f61fc2d..f9aa8a7 100644
--- a/drivers/mmc/core/sdio_io.c
+++ b/drivers/mmc/core/sdio_io.c
@@ -624,7 +624,7 @@ void sdio_f0_writeb(struct sdio_func *func, unsigned char b, unsigned int addr,
 
 	BUG_ON(!func);
 
-	if (addr < 0xF0 || addr > 0xFF) {
+	if ((addr < 0xF0 || addr > 0xFF) && (!mmc_card_lenient_fn0(func->card))) {
 		if (err_ret)
 			*err_ret = -EINVAL;
 		return;
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index eac86fe..bff96cf 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -95,6 +95,7 @@ struct mmc_card {
 #define MMC_STATE_HIGHSPEED	(1<<2)		/* card is in high speed mode */
 #define MMC_STATE_BLOCKADDR	(1<<3)		/* card uses block-addressing */
 	unsigned int		quirks; 	/* card quirks */
+#define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes outside of the VS CCCR range */
 
 	u32			raw_cid[4];	/* raw card CID */
 	u32			raw_csd[4];	/* raw card CSD */
@@ -130,6 +131,8 @@ struct mmc_card {
 #define mmc_card_set_highspeed(c) ((c)->state |= MMC_STATE_HIGHSPEED)
 #define mmc_card_set_blockaddr(c) ((c)->state |= MMC_STATE_BLOCKADDR)
 
+#define mmc_card_lenient_fn0(c)	((c)->quirks & MMC_QUIRK_LENIENT_FN0)
+
 #define mmc_card_name(c)	((c)->cid.prod_name)
 #define mmc_card_id(c)		(dev_name(&(c)->dev))
 
-- 
1.5.4.3



