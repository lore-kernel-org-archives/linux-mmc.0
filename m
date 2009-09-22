From: akpm@linux-foundation.org
Subject: [patch 085/232] sdio: add MMC_QUIRK_LENIENT_FN0
Date: Tue, 22 Sep 2009 16:45:18 -0700
Message-ID: <200909222345.n8MNjIlM014061@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58900 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752984AbZIWABW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Sep 2009 20:01:22 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, ohad@wizery.com, linux-mmc@vger.kernel.org

From: Ohad Ben-Cohen <ohad@wizery.com>

Normally writes to SDIO function 0 outside the vendor specific CCCR
registers are prohibited.

To support embedded devices that require writes to SDIO function 0 outside
this range (e.g.  TI WL127x embedded sdio wifi device),
MMC_QUIRK_LENIENT_FN0 is introduced.

A card quirks field is added to `struct mmc_card' to support non-standard
devices (e.g.  embedded sdio devices).

[akpm@linux-foundation.org: code in C, not cpp!]
Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/core/sdio_io.c |    2 +-
 include/linux/mmc/card.h   |    7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff -puN drivers/mmc/core/sdio_io.c~sdio-add-mmc_quirk_lenient_fn0 drivers/mmc/core/sdio_io.c
--- a/drivers/mmc/core/sdio_io.c~sdio-add-mmc_quirk_lenient_fn0
+++ a/drivers/mmc/core/sdio_io.c
@@ -624,7 +624,7 @@ void sdio_f0_writeb(struct sdio_func *fu
 
 	BUG_ON(!func);
 
-	if (addr < 0xF0 || addr > 0xFF) {
+	if ((addr < 0xF0 || addr > 0xFF) && (!mmc_card_lenient_fn0(func->card))) {
 		if (err_ret)
 			*err_ret = -EINVAL;
 		return;
diff -puN include/linux/mmc/card.h~sdio-add-mmc_quirk_lenient_fn0 include/linux/mmc/card.h
--- a/include/linux/mmc/card.h~sdio-add-mmc_quirk_lenient_fn0
+++ a/include/linux/mmc/card.h
@@ -97,6 +97,8 @@ struct mmc_card {
 #define MMC_STATE_READONLY	(1<<1)		/* card is read-only */
 #define MMC_STATE_HIGHSPEED	(1<<2)		/* card is in high speed mode */
 #define MMC_STATE_BLOCKADDR	(1<<3)		/* card uses block-addressing */
+	unsigned int		quirks; 	/* card quirks */
+#define MMC_QUIRK_LENIENT_FN0	(1<<0)		/* allow SDIO FN0 writes outside of the VS CCCR range */
 
 	u32			raw_cid[4];	/* raw card CID */
 	u32			raw_csd[4];	/* raw card CSD */
@@ -132,6 +134,11 @@ struct mmc_card {
 #define mmc_card_set_highspeed(c) ((c)->state |= MMC_STATE_HIGHSPEED)
 #define mmc_card_set_blockaddr(c) ((c)->state |= MMC_STATE_BLOCKADDR)
 
+static inline int mmc_card_lenient_fn0(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_LENIENT_FN0;
+}
+
 #define mmc_card_name(c)	((c)->cid.prod_name)
 #define mmc_card_id(c)		(dev_name(&(c)->dev))
 
_
