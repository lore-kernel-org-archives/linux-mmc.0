From: Bing Zhao <bzhao@marvell.com>
Subject: [PATCH] mmc/sdio: add a quirk for broken SDIO_CCCR_INTx polling
Date: Mon, 25 Nov 2013 15:53:58 -0800
Message-ID: <1385423638-24791-1-git-send-email-bzhao@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:62803 "EHLO
	mx0a-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751888Ab3KYXyK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 25 Nov 2013 18:54:10 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Paul Stewart <pstew@chromium.org>, Doug Anderson <dianders@chromium.org>, Bing Zhao <bzhao@marvell.com>

Polling SDIO_CCCR_INTx could create a fake interrupt with Marvell
SD8797 card. Add a quirk to handle this case. The fixup here is
to issue a dummy CMD52 read to function 0 register 0xff, and this
dummy read must be right after SDIO_CCCR_INTx is read.

Patch has been verified on a dw_mmc controller (Samsung Chromebook)
with MMC_CAP_SDIO_IRQ disabled.

Reviewed-by: Paul Stewart <pstew@chromium.org>
Reviewed-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Bing Zhao <bzhao@marvell.com>
---
 drivers/mmc/core/quirks.c   | 21 +++++++++++++++++++++
 drivers/mmc/core/sdio_irq.c |  5 +++++
 include/linux/mmc/card.h    |  4 +++-
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/quirks.c b/drivers/mmc/core/quirks.c
index 06ee1ae..870bcc3 100644
--- a/drivers/mmc/core/quirks.c
+++ b/drivers/mmc/core/quirks.c
@@ -13,6 +13,9 @@
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/mmc/card.h>
+#include <linux/mmc/sdio_ids.h>
+
+#include "sdio_ops.h"
 
 #ifndef SDIO_VENDOR_ID_TI
 #define SDIO_VENDOR_ID_TI		0x0097
@@ -30,6 +33,10 @@
 #define SDIO_DEVICE_ID_STE_CW1200	0x2280
 #endif
 
+#ifndef SDIO_DEVICE_ID_MARVELL_8797_F0
+#define SDIO_DEVICE_ID_MARVELL_8797_F0	0x9128
+#endif
+
 /*
  * This hook just adds a quirk for all sdio devices
  */
@@ -58,6 +65,9 @@ static const struct mmc_fixup mmc_fixup_methods[] = {
 	SDIO_FIXUP(SDIO_VENDOR_ID_STE, SDIO_DEVICE_ID_STE_CW1200,
 		   add_quirk, MMC_QUIRK_BROKEN_BYTE_MODE_512),
 
+	SDIO_FIXUP(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8797_F0,
+		   add_quirk, MMC_QUIRK_BROKEN_IRQ_POLLING),
+
 	END_FIXUP
 };
 
@@ -89,3 +99,14 @@ void mmc_fixup_device(struct mmc_card *card, const struct mmc_fixup *table)
 	}
 }
 EXPORT_SYMBOL(mmc_fixup_device);
+
+void mmc_fixup_broken_irq_polling(struct mmc_card *card)
+{
+	unsigned char dummy;
+
+	/* A fake interrupt could be created when we poll SDIO_CCCR_INTx
+	 * register with a Marvell SD8797 card. A dummy CMD52 read to
+	 * function 0 register 0xff can aviod this.
+	 */
+	mmc_io_rw_direct(card, 0, 0, 0xff, 0, &dummy);
+}
diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index 3d8ceb4..afb00e1 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -47,6 +47,11 @@ static int process_sdio_pending_irqs(struct mmc_host *host)
 	}
 
 	ret = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_INTx, 0, &pending);
+
+	if (pending && (card->quirks & MMC_QUIRK_BROKEN_IRQ_POLLING) &&
+	    !(host->caps & MMC_CAP_SDIO_IRQ))
+		mmc_fixup_broken_irq_polling(card);
+
 	if (ret) {
 		pr_debug("%s: error %d reading SDIO_CCCR_INTx\n",
 		       mmc_card_id(card), ret);
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 176fdf8..08a065b 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -271,9 +271,10 @@ struct mmc_card {
 #define MMC_QUIRK_INAND_CMD38	(1<<6)		/* iNAND devices have broken CMD38 */
 #define MMC_QUIRK_BLK_NO_CMD23	(1<<7)		/* Avoid CMD23 for regular multiblock */
 #define MMC_QUIRK_BROKEN_BYTE_MODE_512 (1<<8)	/* Avoid sending 512 bytes in */
+						/* byte mode */
 #define MMC_QUIRK_LONG_READ_TIME (1<<9)		/* Data read time > CSD says */
 #define MMC_QUIRK_SEC_ERASE_TRIM_BROKEN (1<<10)	/* Skip secure for erase/trim */
-						/* byte mode */
+#define MMC_QUIRK_BROKEN_IRQ_POLLING	(1<<11)	/* Polling SDIO_CCCR_INTx could create a fake interrupt */
 
 	unsigned int		erase_size;	/* erase size in sectors */
  	unsigned int		erase_shift;	/* if erase unit is power 2 */
@@ -531,5 +532,6 @@ extern void mmc_unregister_driver(struct mmc_driver *);
 
 extern void mmc_fixup_device(struct mmc_card *card,
 			     const struct mmc_fixup *table);
+extern void mmc_fixup_broken_irq_polling(struct mmc_card *card);
 
 #endif /* LINUX_MMC_CARD_H */
-- 
1.8.0

