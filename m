From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH v2 3/3] mmc: sdhci: removal of SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST
Date: Mon, 4 Apr 2016 17:27:55 +0200
Message-ID: <1459783675-7798-4-git-send-email-ludovic.desroches@atmel.com>
References: <1459783675-7798-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:15950 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932314AbcDDP1w (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2016 11:27:52 -0400
In-Reply-To: <1459783675-7798-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, nicolas.ferre@atmel.com, Ludovic Desroches <ludovic.desroches@atmel.com>

SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST quirk is not used anymore so
remove it.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/sdhci.c | 2 --
 drivers/mmc/host/sdhci.h | 5 -----
 2 files changed, 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2c3dede..e2cfe6c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1191,8 +1191,6 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	host->mmc->actual_clock = 0;
 
 	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
-	if (host->quirks2 & SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST)
-		mdelay(1);
 
 	if (clock == 0)
 		return;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 23ddd6e..4f60105 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -417,11 +417,6 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_ACMD23_BROKEN			(1<<14)
 /* Broken Clock divider zero in controller */
 #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)
-/*
- * When internal clock is disabled, a delay is needed before modifying the
- * SD clock frequency or enabling back the internal clock.
- */
-#define SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST	(1<<16)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.5.0

