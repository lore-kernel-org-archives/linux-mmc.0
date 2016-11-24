From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/1] mmc: mmc: Relax checking for switch errors after HS200 switch
Date: Thu, 24 Nov 2016 14:02:49 +0200
Message-ID: <1479988969-1747-2-git-send-email-adrian.hunter@intel.com>
References: <1479988969-1747-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:12810 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933453AbcKXMLH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 24 Nov 2016 07:11:07 -0500
In-Reply-To: <1479988969-1747-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Walle <michael@walle.cc>, Yong Mao <yong.mao@mediatek.com>, Shawn Lin <shawn.lin@rock-chips.com>

The JEDEC specification indicates CMD13 can be used after a HS200 switch
to check for errors. However in practice some boards experience CRC errors
in the CMD13 response. Consequently, for HS200, CRC errors are not a
reliable way to know the switch failed. If there really is a problem, we
would expect tuning will fail and the result ends up the same. So change
the error condition to ignore CRC errors in that case.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/mmc.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 3268fcd3378d..34d30e2a09ff 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1223,7 +1223,12 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 	mmc_set_timing(host, MMC_TIMING_MMC_HS200);
 
 	err = mmc_switch_status(card);
-	if (err)
+	/*
+	 * For HS200, CRC errors are not a reliable way to know the switch
+	 * failed. If there really is a problem, we would expect tuning will
+	 * fail and the result ends up the same.
+	 */
+	if (err && err != -EILSEQ)
 		goto out_err;
 
 	mmc_set_bus_speed(card);
@@ -1387,6 +1392,14 @@ static int mmc_select_hs200(struct mmc_card *card)
 
 		err = mmc_switch_status(card);
 		/*
+		 * For HS200, CRC errors are not a reliable way to know the
+		 * switch failed. If there really is a problem, we would expect
+		 * tuning will fail and the result ends up the same.
+		 */
+		if (err == -EILSEQ)
+			err = 0;
+
+		/*
 		 * mmc_select_timing() assumes timing has not changed if
 		 * it is a switch error.
 		 */
-- 
1.9.1

