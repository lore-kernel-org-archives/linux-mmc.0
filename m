From: Tony Lin <tony.lin@freescale.com>
Subject: [PATCH 1/1] mmc: sdhci-esdhc: Change delay after setting clock from 100ms to 1ms
Date: Thu, 1 Sep 2011 13:51:15 +0800
Message-ID: <1314856275-12131-1-git-send-email-tony.lin@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:43207 "EHLO
	TX2EHSOBE009.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751286Ab1IAFgG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Sep 2011 01:36:06 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, w.sang@pengutronix.de

1ms is enough for hardware to change the clock to stable.
100ms is too long.

Signed-off-by: Tony Lin <tony.lin@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index c3b08f1..b97b2f5 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -73,7 +73,7 @@ static inline void esdhc_set_clock(struct sdhci_host *host, unsigned int clock)
 		| (div << ESDHC_DIVIDER_SHIFT)
 		| (pre_div << ESDHC_PREDIV_SHIFT));
 	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
-	mdelay(100);
+	mdelay(1);
 out:
 	host->clock = clock;
 }
-- 
1.7.0.4


