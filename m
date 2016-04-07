From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH v3 3/3] mmc: sdhci: removal of SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST
Date: Thu, 7 Apr 2016 11:13:10 +0200
Message-ID: <1460020390-503-4-git-send-email-ludovic.desroches@atmel.com>
References: <1460020390-503-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460020390-503-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, nicolas.ferre@atmel.com, Ludovic Desroches <ludovic.desroches@atmel.com>
List-Id: linux-mmc@vger.kernel.org

SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST quirk is not used anymore so
remove it.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/host/sdhci.c | 2 --
 drivers/mmc/host/sdhci.h | 5 -----
 2 files changed, 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index abd34d1..0ca16ee 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1192,8 +1192,6 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	host->mmc->actual_clock = 0;
 
 	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
-	if (host->quirks2 & SDHCI_QUIRK2_NEED_DELAY_AFTER_INT_CLK_RST)
-		mdelay(1);
 
 	if (clock == 0)
 		return;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 9db5090..0decc85 100644
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
