From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH v2 2/2] mmc: core: fix the signaling 1.8V for HS200
Date: Wed, 25 Apr 2012 16:18:01 +0900
Message-ID: <004c01cd22b3$8cd76870$a6863950$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:8585 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534Ab2DYHSD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Apr 2012 03:18:03 -0400
Received: from epcpsbgm1.samsung.com (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M30009U1XKX0J10@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 25 Apr 2012 16:18:02 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M30005IEXM1JEA0@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 25 Apr 2012 16:18:02 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <cjb@laptop.org>, 'Subhash Jadavani' <subhashj@codeaurora.org>, 'Girish K S' <girish.shivananjappa@linaro.org>

Currently only 1.2V is treated for HS200 mode. If the host has
only 1.8V I/O capability not 1.2V, mmc_set_signal_voltage can't
be called for 1.8V HS200. EXT_CSD_CARD_TYPE_SDR_1_8V needs to be
considered.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/core/mmc.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 0477769..2a9b7b1 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -728,7 +728,7 @@ static int mmc_select_powerclass(struct mmc_card *card,
  */
 static int mmc_select_hs200(struct mmc_card *card)
 {
-	int idx, err = 0;
+	int idx, err = -EINVAL;
 	struct mmc_host *host;
 	static unsigned ext_csd_bits[] = {
 		EXT_CSD_BUS_WIDTH_4,
@@ -744,10 +744,12 @@ static int mmc_select_hs200(struct mmc_card *card)
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


