From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 4/4] mmc: add MMC_QUIRK_NONSTD_FUNC_IF
Date: Tue,  4 Jan 2011 23:10:16 +0200
Message-ID: <1294175416-12358-4-git-send-email-ohad@wizery.com>
References: <1294175416-12358-1-git-send-email-ohad@wizery.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59865 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547Ab1ADVKu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jan 2011 16:10:50 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so6488007eye.19
        for <linux-mmc@vger.kernel.org>; Tue, 04 Jan 2011 13:10:50 -0800 (PST)
In-Reply-To: <1294175416-12358-1-git-send-email-ohad@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>

Use MMC_QUIRK_NONSTD_FUNC_IF to ignore the "SDIO Standard Function interface
code" as indicated by the card's FBR, and instead treat all functions as
non-standard interfaces.

This is required to prevent standard drivers (e.g. btsdio) from facing
errors when trying to communicate with SDIO cards that erroneously
indicate standard function interface codes.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/mmc/core/sdio.c  |    6 ++++++
 include/linux/mmc/card.h |    6 ++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 2118df2..bee7641 100644
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
index 3a3c079..40441df 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -121,6 +121,7 @@ struct mmc_card {
 #define MMC_QUIRK_NONSTD_SDIO	(1<<2)		/* non-standard SDIO card attached */
 						/* (missing CIA registers) */
 #define MMC_QUIRK_DISABLE_CD	(1<<3)		/* disconnect CD/DAT[3] resistor */
+#define MMC_QUIRK_NONSTD_FUNC_IF (1<<4)		/* SDIO card has nonstd function interfaces */
 
 	unsigned int		erase_size;	/* erase size in sectors */
  	unsigned int		erase_shift;	/* if erase unit is power 2 */
@@ -179,6 +180,11 @@ static inline int mmc_card_disable_cd(const struct mmc_card *c)
 	return c->quirks & MMC_QUIRK_DISABLE_CD;
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

