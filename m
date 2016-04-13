From: Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 1/6] mmc: core: in _init, exclude FW revision from CID check.
Date: Wed, 13 Apr 2016 15:33:39 -0700
Message-ID: <1460586824-40688-2-git-send-email-gwendal@chromium.org>
References: <1460586824-40688-1-git-send-email-gwendal@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35483 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754329AbcDMWeQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Apr 2016 18:34:16 -0400
Received: by mail-pf0-f169.google.com with SMTP id n1so39263633pfn.2
        for <linux-mmc@vger.kernel.org>; Wed, 13 Apr 2016 15:34:16 -0700 (PDT)
In-Reply-To: <1460586824-40688-1-git-send-email-gwendal@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, Alex.Lemberg@sandisk.com, avi.shchislowski@sandisk.com, yaniv.agman@sandisk.com, holgerschurig@gmail.com, chris@printf.net, baolin.wang@linaro.org
Cc: linux-mmc@vger.kernel.org

In mmc_card_init() when we reset a card we check the newly found
card is indeed the previous card by comparing the CID.
If the firmware is upgraded, we need to exclude the Product Revision,
it can change if the firmware is upgraded.

Reviewed-by: Puthikorn Voravootivat <puthik@chromium.org>
Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/mmc/core/mmc.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index e37ab34..4fe3208 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1406,12 +1406,24 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		goto err;
 
 	if (oldcard) {
-		if (memcmp(cid, oldcard->raw_cid, sizeof(cid)) != 0) {
+		/*
+		 * When comparing the CID, we should exclude the product
+		 * revision (Field PRV, offset 55:48), because it can change if
+		 * the firmware is upgraded. The new CRC can then be different.
+		 * Therefore we test if offset 8 - 48 and 128 - 56 are checked.
+		 */
+		if ((cid[0] != oldcard->raw_cid[0]) ||
+		    (cid[1] != oldcard->raw_cid[1]) ||
+		    ((cid[2] & 0xFF00FFFF) !=
+		     (oldcard->raw_cid[2] & 0xFF00FFFF)) ||
+		    ((cid[3] & 0xFFFFFF00) !=
+		     (oldcard->raw_cid[3] & 0xFFFFFF00))) {
 			err = -ENOENT;
 			goto err;
 		}
 
 		card = oldcard;
+		memcpy(card->raw_cid, cid, sizeof(cid));
 	} else {
 		/*
 		 * Allocate card structure.
@@ -1456,10 +1468,10 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 		err = mmc_decode_csd(card);
 		if (err)
 			goto free_card;
-		err = mmc_decode_cid(card);
-		if (err)
-			goto free_card;
 	}
+	err = mmc_decode_cid(card);
+	if (err)
+		goto free_card;
 
 	/*
 	 * handling only for cards supporting DSR and hosts requesting
-- 
2.8.0.rc3.226.g39d4020

