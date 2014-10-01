From: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Subject: [PATCH 5/5] mmc: core: Fix error paths and messages in mmc_init_card
Date: Wed, 1 Oct 2014 07:14:11 -0500
Message-ID: <1412165651-2652-6-git-send-email-andrew_gabbasov@mentor.com>
References: <1412165651-2652-1-git-send-email-andrew_gabbasov@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relay1.mentorg.com ([192.94.38.131]:62102 "EHLO
	relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbaJAMPI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Oct 2014 08:15:08 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-FEM-03.mgc.mentorg.com)
	by relay1.mentorg.com with esmtp
	id 1XZIoF-0001wY-U9 from Andrew_Gabbasov@mentor.com
	for linux-mmc@vger.kernel.org; Wed, 01 Oct 2014 05:15:08 -0700
In-Reply-To: <1412165651-2652-1-git-send-email-andrew_gabbasov@mentor.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

In mmc_init_card function some of the branches in error handling paths
go to "err" label, which skips removing of newly allocated card structure,
that will actually not be used. Fix that by using proper "free_card" label.

Also, some messages in these branches are reported as warnings,
although the operation processing is not continued. Change these
messages to error level.

Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
---
 drivers/mmc/core/mmc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 1eda8dd..a818703 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -973,7 +973,7 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
 			ext_csd_bits,
 			card->ext_csd.generic_cmd6_time);
 	if (err) {
-		pr_warn("%s: switch to bus width %d ddr failed\n",
+		pr_err("%s: switch to bus width %d ddr failed\n",
 			mmc_hostname(host), 1 << bus_width);
 		return err;
 	}
@@ -1028,7 +1028,7 @@ static int mmc_select_hs400(struct mmc_card *card)
 			   card->ext_csd.generic_cmd6_time,
 			   true, true, true);
 	if (err) {
-		pr_warn("%s: switch to high-speed from hs200 failed, err:%d\n",
+		pr_err("%s: switch to high-speed from hs200 failed, err:%d\n",
 			mmc_hostname(host), err);
 		return err;
 	}
@@ -1038,7 +1038,7 @@ static int mmc_select_hs400(struct mmc_card *card)
 			 EXT_CSD_DDR_BUS_WIDTH_8,
 			 card->ext_csd.generic_cmd6_time);
 	if (err) {
-		pr_warn("%s: switch to bus width for hs400 failed, err:%d\n",
+		pr_err("%s: switch to bus width for hs400 failed, err:%d\n",
 			mmc_hostname(host), err);
 		return err;
 	}
@@ -1048,7 +1048,7 @@ static int mmc_select_hs400(struct mmc_card *card)
 			   card->ext_csd.generic_cmd6_time,
 			   true, true, true);
 	if (err) {
-		pr_warn("%s: switch to hs400 failed, err:%d\n",
+		pr_err("%s: switch to hs400 failed, err:%d\n",
 			 mmc_hostname(host), err);
 		return err;
 	}
@@ -1159,7 +1159,7 @@ static int mmc_hs200_tuning(struct mmc_card *card)
 		mmc_host_clk_release(host);
 
 		if (err)
-			pr_warn("%s: tuning execution failed\n",
+			pr_err("%s: tuning execution failed\n",
 				mmc_hostname(host));
 	}
 
@@ -1378,18 +1378,18 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 	if (mmc_card_hs200(card)) {
 		err = mmc_hs200_tuning(card);
 		if (err)
-			goto err;
+			goto free_card;
 
 		err = mmc_select_hs400(card);
 		if (err)
-			goto err;
+			goto free_card;
 	} else if (mmc_card_hs(card)) {
 		/* Select the desired bus width optionally */
 		err = mmc_select_bus_width(card);
 		if (!IS_ERR_VALUE(err)) {
 			err = mmc_select_hs_ddr(card);
 			if (err)
-				goto err;
+				goto free_card;
 		}
 	}
 
-- 
2.1.0

