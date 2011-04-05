From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 1/2] mmc: add MMC_QUIRK_NONSTD_FUNC_IF
Date: Tue,  5 Apr 2011 17:50:14 +0300
Message-ID: <1302015015-8178-1-git-send-email-ohad@wizery.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42444 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088Ab1DEOu6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Apr 2011 10:50:58 -0400
Received: by fxm17 with SMTP id 17so318856fxm.19
        for <linux-mmc@vger.kernel.org>; Tue, 05 Apr 2011 07:50:56 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>

Introduce MMC_QUIRK_NONSTD_FUNC_IF to ignore the "SDIO Standard Function
interface code" as indicated by the card's FBR, and instead treat all
functions as non-standard interfaces.

This is required to prevent standard drivers from facing
errors when trying to communicate with SDIO cards that erroneously
indicate standard function interface codes.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
Chris, I've posted this one before. Sending it again, this time with a follow-up patch that uses the new mmc quirks facility. thanks!

 drivers/mmc/core/sdio.c  |    6 ++++++
 include/linux/mmc/card.h |    6 ++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 4221670..c3c2bd0 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -16,6 +16,7 @@
 #include <linux/mmc/card.h>
 #include <linux/mmc/sdio.h>
 #include <linux/mmc/sdio_func.h>
+#include <linux/mmc/sdio_ids.h>
 
 #include "core.h"
 #include "bus.h"
@@ -31,6 +32,11 @@ static int sdio_read_fbr(struct sdio_func *func)
 	int ret;
 	unsigned char data;
 
+	if (mmc_card_nonstd_func_interface(func->card)) {
+		func->class = SDIO_CLASS_NONE;
+		return 0;
+	}
+
 	ret = mmc_io_rw_direct(func->card, 0, 0,
 		SDIO_FBR_BASE(func->num) + SDIO_FBR_STD_IF, 0, &data);
 	if (ret)
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index adb4888..c7f1532 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -125,6 +125,7 @@ struct mmc_card {
 #define MMC_QUIRK_NONSTD_SDIO	(1<<2)		/* non-standard SDIO card attached */
 						/* (missing CIA registers) */
 #define MMC_QUIRK_BROKEN_CLK_GATING (1<<3)	/* clock gating the sdio bus will make card fail */
+#define MMC_QUIRK_NONSTD_FUNC_IF (1<<4)		/* SDIO card has nonstd function interfaces */
 
 	unsigned int		erase_size;	/* erase size in sectors */
  	unsigned int		erase_shift;	/* if erase unit is power 2 */
@@ -180,6 +181,11 @@ static inline int mmc_blksz_for_byte_mode(const struct mmc_card *c)
 	return c->quirks & MMC_QUIRK_BLKSZ_FOR_BYTE_MODE;
 }
 
+static inline int mmc_card_nonstd_func_interface(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_NONSTD_FUNC_IF;
+}
+
 #define mmc_card_name(c)	((c)->cid.prod_name)
 #define mmc_card_id(c)		(dev_name(&(c)->dev))
 
-- 
1.7.1

