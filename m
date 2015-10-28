From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 3/4] mmc: mmc: Move mmc_switch_status()
Date: Wed, 28 Oct 2015 14:25:42 +0200
Message-ID: <1446035143-4949-4-git-send-email-adrian.hunter@intel.com>
References: <1446035143-4949-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:8119 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932178AbbJ1M3N (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 28 Oct 2015 08:29:13 -0400
In-Reply-To: <1446035143-4949-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Chaotian Jing <chaotian.jing@mediatek.com>

Move the mmc_switch_status() function in preparation for calling it
in mmc_select_hs400().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 14fb767ee8dd..5884c79346da 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1040,6 +1040,19 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
 	return err;
 }
 
+/* Caller must hold re-tuning */
+static int mmc_switch_status(struct mmc_card *card)
+{
+	u32 status;
+	int err;
+
+	err = mmc_send_status(card, &status);
+	if (err)
+		return err;
+
+	return mmc_switch_status_error(card->host, status);
+}
+
 static int mmc_select_hs400(struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
@@ -1107,19 +1120,6 @@ int mmc_hs200_to_hs400(struct mmc_card *card)
 	return mmc_select_hs400(card);
 }
 
-/* Caller must hold re-tuning */
-static int mmc_switch_status(struct mmc_card *card)
-{
-	u32 status;
-	int err;
-
-	err = mmc_send_status(card, &status);
-	if (err)
-		return err;
-
-	return mmc_switch_status_error(card->host, status);
-}
-
 int mmc_hs400_to_hs200(struct mmc_card *card)
 {
 	struct mmc_host *host = card->host;
-- 
1.9.1

