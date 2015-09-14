From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [PATCH 5/6] mmc: sdhci: add SDHCI_QUIRK2_DELAY_BETWEEN_TUNING_CYCLES quirk
Date: Mon, 14 Sep 2015 19:44:03 +0800
Message-ID: <1442231043-10759-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0137.outbound.protection.outlook.com ([207.46.100.137]:8789
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754911AbbINLt7 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Sep 2015 07:49:59 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: Yangbo Lu <yangbo.lu@freescale.com>

Although eMMC spec does not require a delay between tuning cycles,
some hosts need it to avoid tuning failure.

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
 drivers/mmc/host/sdhci.c | 3 ++-
 drivers/mmc/host/sdhci.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9da4644..d61061b5 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2038,7 +2038,8 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 
 		/* eMMC spec does not require a delay between tuning cycles */
-		if (opcode == MMC_SEND_TUNING_BLOCK)
+		if ((opcode == MMC_SEND_TUNING_BLOCK) ||
+		    (host->quirks2 & SDHCI_QUIRK2_DELAY_BETWEEN_TUNING_CYCLES))
 			mdelay(1);
 	} while (ctrl & SDHCI_CTRL_EXEC_TUNING);
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 98f239b..7223f96 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -412,6 +412,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_ACMD23_BROKEN			(1<<14)
 /* Broken Clock divider zero in controller */
 #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)
+/* Need delay between tuning cycles */
+#define SDHCI_QUIRK2_DELAY_BETWEEN_TUNING_CYCLES	(1<<16)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.1.0.27.g96db324

