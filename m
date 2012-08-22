From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] mmc: sdhci-esdhc: break out early if clock is 0
Date: Wed, 22 Aug 2012 23:10:01 +0800
Message-ID: <1345648201-10746-1-git-send-email-shawn.guo@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:55521 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932467Ab2HVPJ4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Aug 2012 11:09:56 -0400
Received: by pbbrr13 with SMTP id rr13so1615895pbb.19
        for <linux-mmc@vger.kernel.org>; Wed, 22 Aug 2012 08:09:55 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, stable@vger.kernel.org

Since commit 30832ab (mmc: sdhci: Always pass clock request value zero
to set_clock host op) gets in, esdhc_set_clock starts hitting
"if (clock == 0)" where ESDHC_SYSTEM_CONTROL has been operated.  This
causes SDHCI card-detection function being broken.  Fix the regression
by moving "if (clock == 0)" above ESDHC_SYSTEM_CONTROL operation.

Cc: <stable@vger.kernel.org>
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index b97b2f5..d25f9ab 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -48,14 +48,14 @@ static inline void esdhc_set_clock(struct sdhci_host *host, unsigned int clock)
 	int div = 1;
 	u32 temp;
 
+	if (clock == 0)
+		goto out;
+
 	temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
 	temp &= ~(ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN | ESDHC_CLOCK_PEREN
 		| ESDHC_CLOCK_MASK);
 	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
 
-	if (clock == 0)
-		goto out;
-
 	while (host->max_clk / pre_div / 16 > clock && pre_div < 256)
 		pre_div *= 2;
 
-- 
1.7.5.4

