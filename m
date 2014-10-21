From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 07/15] mmc: core: Fetch and decode EXT_CSD from mmc_read_ext_csd()
Date: Tue, 21 Oct 2014 19:19:05 +0200
Message-ID: <1413911953-19012-8-git-send-email-ulf.hansson@linaro.org>
References: <1413911953-19012-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f50.google.com ([209.85.215.50]:56276 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933117AbaJURTc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Oct 2014 13:19:32 -0400
Received: by mail-la0-f50.google.com with SMTP id s18so1486141lam.37
        for <linux-mmc@vger.kernel.org>; Tue, 21 Oct 2014 10:19:31 -0700 (PDT)
In-Reply-To: <1413911953-19012-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>

As a step in cleaning up code around reading/decoding EXT_CSD, convert
the current mmc_read_ext_csd(), to handle both fetching the EXT_CSD
and decoding its data.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 24dc30f..f10f932 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -388,7 +388,7 @@ static void mmc_manage_gp_partitions(struct mmc_card *card, u8 *ext_csd)
 /*
  * Decode extended CSD.
  */
-static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
+static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 {
 	int err = 0, idx;
 	unsigned int part_size;
@@ -629,6 +629,20 @@ out:
 	return err;
 }
 
+static int mmc_read_ext_csd(struct mmc_card *card)
+{
+	u8 *ext_csd = NULL;
+	int err;
+
+	err = mmc_get_ext_csd(card, &ext_csd);
+	if (err)
+		return err;
+
+	err = mmc_decode_ext_csd(card, ext_csd);
+	kfree(ext_csd);
+	return err;
+}
+
 static int mmc_compare_ext_csds(struct mmc_card *card, unsigned bus_width)
 {
 	u8 *bw_ext_csd;
@@ -1234,7 +1248,6 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	int err;
 	u32 cid[4];
 	u32 rocr;
-	u8 *ext_csd = NULL;
 
 	BUG_ON(!host);
 	WARN_ON(!host->claimed);
@@ -1343,14 +1356,8 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	}
 
 	if (!oldcard) {
-		/*
-		 * Fetch and process extended CSD.
-		 */
-
-		err = mmc_get_ext_csd(card, &ext_csd);
-		if (err)
-			goto free_card;
-		err = mmc_read_ext_csd(card, ext_csd);
+		/* Read extended CSD. */
+		err = mmc_read_ext_csd(card);
 		if (err)
 			goto free_card;
 
@@ -1527,15 +1534,12 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	if (!oldcard)
 		host->card = card;
 
-	kfree(ext_csd);
 	return 0;
 
 free_card:
 	if (!oldcard)
 		mmc_remove_card(card);
 err:
-	kfree(ext_csd);
-
 	return err;
 }
 
-- 
1.9.1

