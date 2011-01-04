From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH 3/4] mmc: add MMC_QUIRK_DISABLE_CD
Date: Tue,  4 Jan 2011 23:10:15 +0200
Message-ID: <1294175416-12358-3-git-send-email-ohad@wizery.com>
References: <1294175416-12358-1-git-send-email-ohad@wizery.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59865 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508Ab1ADVKs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Jan 2011 16:10:48 -0500
Received: by mail-ey0-f174.google.com with SMTP id 27so6488007eye.19
        for <linux-mmc@vger.kernel.org>; Tue, 04 Jan 2011 13:10:47 -0800 (PST)
In-Reply-To: <1294175416-12358-1-git-send-email-ohad@wizery.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Ohad Ben-Cohen <ohad@wizery.com>

006ebd5d introduced sdio_disable_cd(), which disconnects the pull-up
resistor on CD/DAT[3] (pin 1) of the card.

Make it possible to start using sdio_disable_cd() by introducing
MMC_QUIRK_DISABLE_CD.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/mmc/core/sdio.c  |    2 +-
 include/linux/mmc/card.h |    9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 78be7d9..2118df2 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -181,7 +181,7 @@ static int sdio_disable_cd(struct mmc_card *card)
 	int ret;
 	u8 ctrl;
 
-	if (!card->cccr.disable_cd)
+	if (!mmc_card_disable_cd(card))
 		return 0;
 
 	ret = mmc_io_rw_direct(card, 0, 0, SDIO_CCCR_IF, 0, &ctrl);
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 8ce0827..3a3c079 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -80,8 +80,7 @@ struct sdio_cccr {
 				low_speed:1,
 				wide_bus:1,
 				high_power:1,
-				high_speed:1,
-				disable_cd:1;
+				high_speed:1;
 };
 
 struct sdio_cis {
@@ -121,6 +120,7 @@ struct mmc_card {
 						/* for byte mode */
 #define MMC_QUIRK_NONSTD_SDIO	(1<<2)		/* non-standard SDIO card attached */
 						/* (missing CIA registers) */
+#define MMC_QUIRK_DISABLE_CD	(1<<3)		/* disconnect CD/DAT[3] resistor */
 
 	unsigned int		erase_size;	/* erase size in sectors */
  	unsigned int		erase_shift;	/* if erase unit is power 2 */
@@ -174,6 +174,11 @@ static inline int mmc_blksz_for_byte_mode(const struct mmc_card *c)
 	return c->quirks & MMC_QUIRK_BLKSZ_FOR_BYTE_MODE;
 }
 
+static inline int mmc_card_disable_cd(const struct mmc_card *c)
+{
+	return c->quirks & MMC_QUIRK_DISABLE_CD;
+}
+
 #define mmc_card_name(c)	((c)->cid.prod_name)
 #define mmc_card_id(c)		(dev_name(&(c)->dev))
 
-- 
1.7.1

