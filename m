From: Ziyuan Xu <xzy.xu@rock-chips.com>
Subject: [PATCH] mmc: mmc: Fix HS switch failure in mmc_select_hs400()
Date: Thu, 26 May 2016 13:50:32 +0800
Message-ID: <1464241832-10322-1-git-send-email-xzy.xu@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from regular2.263xmail.com ([211.157.152.6]:35017 "EHLO
	regular2.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317AbcEZF6H (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 May 2016 01:58:07 -0400
Received: from regular1.263xmail.com (unknown [192.168.165.233])
	by regular2.263xmail.com (Postfix) with ESMTP id 4082F46
	for <linux-mmc@vger.kernel.org>; Thu, 26 May 2016 13:51:09 +0800 (CST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: shawn.lin@rock-chips.com, dianders@chromium.org, linux-mmc@vger.kernel.org, xzy.xu@rock-chips.com

To slove the issue which was found on gru board for hs400.

[    4.616946] sdhci: Secure Digital Host Controller Interface driver
[    4.623135] sdhci: Copyright(c) Pierre Ossman
[    4.722575] sdhci-pltfm: SDHCI platform and OF driver helper
[    4.730962] sdhci-arasan fe330000.sdhci: No vmmc regulator found
[    4.737444] sdhci-arasan fe330000.sdhci: No vqmmc regulator found
[    4.774930] mmc0: SDHCI controller on fe330000.sdhci [fe330000.sdhci] using ADMA
[    4.980295] mmc0: switch to high-speed from hs200 failed, err:-84
[    4.986487] mmc0: error -84 whilst initialising MMC card

We should change HS400 mode selection timing to meet JEDEC
specification. The JEDEC 5.1 said that change the frequency to <= 52MHZ
after HS_TIMING switch. Refer to section 6.6.2.3 "HS400" timing mode
selection:
Set the "Timing Interface" parameter in the HS_TIMING[185] field of the
Extended CSD register to 0x1 to switch to High Speed mode and then set
the clock frequency to a value not greater than 52MHZ.

Signed-off-by: Ziyuan Xu <xzy.xu@rock-chips.com>
---
 drivers/mmc/core/mmc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index b81b08f..8e4d059 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1078,10 +1078,6 @@ static int mmc_select_hs400(struct mmc_card *card)
 	if (host->caps & MMC_CAP_WAIT_WHILE_BUSY)
 		send_status = false;
 
-	/* Reduce frequency to HS frequency */
-	max_dtr = card->ext_csd.hs_max_dtr;
-	mmc_set_clock(host, max_dtr);
-
 	/* Switch card to HS mode */
 	val = EXT_CSD_TIMING_HS;
 	err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
@@ -1097,6 +1093,10 @@ static int mmc_select_hs400(struct mmc_card *card)
 	/* Set host controller to HS timing */
 	mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
 
+	/* Reduce frequency to HS frequency */
+	max_dtr = card->ext_csd.hs_max_dtr;
+	mmc_set_clock(host, max_dtr);
+
 	if (!send_status) {
 		err = mmc_switch_status(card);
 		if (err)
-- 
1.9.1


