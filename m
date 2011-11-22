From: Tony Lin <tony.lin@freescale.com>
Subject: [PATCH 1/1] mmc: sdhci-esdhc: Change delay after setting clock from 100ms to 1ms
Date: Tue, 22 Nov 2011 14:42:30 +0800
Message-ID: <1321944150-12162-1-git-send-email-tony.lin@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-va3.bigfish.com ([216.32.180.10]:52924 "EHLO
	VA3EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752371Ab1KVGan (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Nov 2011 01:30:43 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, X.Xie@freescale.com, avorontsov@ru.mvista.com

1ms is enough for hardware to change the clock to stable.
100ms is too long in the tasklet.

Signed-off-by: Tony Lin <tony.lin@freescale.com>
CC: Xiaobo Xie <X.Xie@freescale.com>
CC: Anton Vorontsov <avorontsov@ru.mvista.com>
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


