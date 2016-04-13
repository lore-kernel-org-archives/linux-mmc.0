From: Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 2/6] mmc: core: resecan [EXT_]CSD at card init.
Date: Wed, 13 Apr 2016 15:33:40 -0700
Message-ID: <1460586824-40688-3-git-send-email-gwendal@chromium.org>
References: <1460586824-40688-1-git-send-email-gwendal@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:34734 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754330AbcDMWeT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Apr 2016 18:34:19 -0400
Received: by mail-pf0-f179.google.com with SMTP id c20so39263445pfc.1
        for <linux-mmc@vger.kernel.org>; Wed, 13 Apr 2016 15:34:19 -0700 (PDT)
In-Reply-To: <1460586824-40688-1-git-send-email-gwendal@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, Alex.Lemberg@sandisk.com, avi.shchislowski@sandisk.com, yaniv.agman@sandisk.com, holgerschurig@gmail.com, chris@printf.net, baolin.wang@linaro.org
Cc: linux-mmc@vger.kernel.org

When the card is restarted we need to reread ext_csd to get
the new firmware version and possibly other changes.

Reviewed-by: Puthikorn Voravootivat <puthik@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/mmc/core/mmc.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 4fe3208..c816502 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -343,6 +343,9 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 	struct device_node *np;
 	bool broken_hpi = false;
 
+	/* Reset partition, they will be rescaned. */
+	card->nr_parts = 0;
+
 	/* Version is coded in the CSD_STRUCTURE byte in the EXT_CSD register */
 	card->ext_csd.raw_ext_csd_structure = ext_csd[EXT_CSD_STRUCTURE];
 	if (card->csd.structure == 3) {
@@ -1457,18 +1460,17 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		mmc_set_bus_mode(host, MMC_BUSMODE_PUSHPULL);
 	}
 
-	if (!oldcard) {
-		/*
-		 * Fetch CSD from card.
-		 */
-		err = mmc_send_csd(card, card->raw_csd);
-		if (err)
-			goto free_card;
+	/*
+	 * Fetch CSD from card.
+	 */
+	err = mmc_send_csd(card, card->raw_csd);
+	if (err)
+		goto free_card;
+
+	err = mmc_decode_csd(card);
+	if (err)
+		goto free_card;
 
-		err = mmc_decode_csd(card);
-		if (err)
-			goto free_card;
-	}
 	err = mmc_decode_cid(card);
 	if (err)
 		goto free_card;
@@ -1489,12 +1491,12 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 			goto free_card;
 	}
 
-	if (!oldcard) {
-		/* Read extended CSD. */
-		err = mmc_read_ext_csd(card);
-		if (err)
-			goto free_card;
+	/* Read extended CSD. */
+	err = mmc_read_ext_csd(card);
+	if (err)
+		goto free_card;
 
+	if (!oldcard) {
 		/* If doing byte addressing, check if required to do sector
 		 * addressing.  Handle the case of <2GB cards needing sector
 		 * addressing.  See section 8.1 JEDEC Standard JED84-A441;
-- 
2.8.0.rc3.226.g39d4020

