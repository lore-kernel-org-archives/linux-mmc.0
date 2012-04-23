From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH 2/2] mmc: core: fix the signaling 1.8V for HS200
Date: Mon, 23 Apr 2012 18:11:12 +0900
Message-ID: <003001cd2131$07773760$1665a620$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:50398 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819Ab2DWJLO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Apr 2012 05:11:14 -0400
Received: from epcpsbgm1.samsung.com (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M2X00IA1DIJ3JT0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 23 Apr 2012 18:11:12 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M2X00AVADIO8DP1@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 23 Apr 2012 18:11:12 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Girish K S' <girish.shivananjappa@linaro.org>

Currently only 1.2V is treated for HS200 mode. If the host has
only 1.8V I/O capability not 1.2V, mmc_set_signal_voltage can't
be called for 1.8V HS200. EXT_CSD_CARD_TYPE_SDR_1_8V needs to be
considered.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/core/mmc.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index ebb9522..71eb320 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -732,7 +732,7 @@ static int mmc_select_powerclass(struct mmc_card *card,
  */
 static int mmc_select_hs200(struct mmc_card *card)
 {
-	int idx, err = 0;
+	int idx, err = -EINVAL;
 	struct mmc_host *host;
 	static unsigned ext_csd_bits[] = {
 		EXT_CSD_BUS_WIDTH_4,
@@ -748,10 +748,12 @@ static int mmc_select_hs200(struct mmc_card *card)
 	host = card->host;
 
 	if (card->ext_csd.card_type & EXT_CSD_CARD_TYPE_SDR_1_2V &&
-	    host->caps2 & MMC_CAP2_HS200_1_2V_SDR)
-		if (mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120, 0))
-			err = mmc_set_signal_voltage(host,
-						     MMC_SIGNAL_VOLTAGE_180, 0);
+			host->caps2 & MMC_CAP2_HS200_1_2V_SDR)
+		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_120, 0);
+
+	if (err && card->ext_csd.card_type & EXT_CSD_CARD_TYPE_SDR_1_8V &&
+			host->caps2 & MMC_CAP2_HS200_1_8V_SDR)
+		err = mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_180, 0);
 
 	/* If fails try again during next card power cycle */
 	if (err)
-- 
1.7.0.4


