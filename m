From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: [PATCH] sdhci-of-esdhc: Pre divider starts at 1
Date: Mon, 20 Apr 2015 23:12:13 +0200
Message-ID: <1429564333-30474-1-git-send-email-joakim.tjernlund@transmode.se>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.transmode.se ([31.15.61.139]:55990 "EHLO smtp.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751360AbbDTVTE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 20 Apr 2015 17:19:04 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Joakim Tjernlund <joakim.tjernlund@transmode.se>

For PowerPC esdhc pre divider starts at 1, fixing the increases
the actual clock from 40KHz to 50 KHz.

Signed-off-by: Joakim Tjernlund <joakim.tjernlund@transmode.se>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 7130130..ffd5625 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -207,7 +207,7 @@ static unsigned int esdhc_of_get_min_clock(struct sdhci_host *host)
 
 static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 {
-	int pre_div = 2;
+	int pre_div = 1;
 	int div = 1;
 	u32 temp;
 
@@ -237,7 +237,7 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 
 	dev_dbg(mmc_dev(host->mmc), "desired SD clock: %d, actual: %d\n",
 		clock, host->max_clk / pre_div / div);
-
+	host->mmc->actual_clock = host->max_clk / pre_div / div;
 	pre_div >>= 1;
 	div--;
 
-- 
2.0.5

