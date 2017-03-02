From: Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH 6/9] mmc: sdhci: add a quirk to restore delay in tuning
Date: Thu, 2 Mar 2017 17:47:27 +0800
Message-ID: <1488448050-7574-7-git-send-email-yangbo.lu@nxp.com>
References: <1488448050-7574-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam01on0063.outbound.protection.outlook.com ([104.47.34.63]:64704
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750867AbdCBKEU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 2 Mar 2017 05:04:20 -0500
In-Reply-To: <1488448050-7574-1-git-send-email-yangbo.lu@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Xiaobo Xie <xiaobo.xie@nxp.com>, Yangbo Lu <yangbo.lu@nxp.com>

There was a mdelay between tuning cycles which is removed since
eMMC spec didn't require that. However it's observed that eSDHC
needed this delay for HS200 successful tuning. Maybe it's also
needed for some other controllers. This patch is to add a quirk
to fix it.

Fixes: 197160d52e85 ("mmc: sdhci: remove mdelay in eMMC tuning")
Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/mmc/host/sdhci.c | 3 ++-
 drivers/mmc/host/sdhci.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 051b192..b1b6fd3 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2100,7 +2100,8 @@ static void __sdhci_execute_tuning(struct sdhci_host *host, u32 opcode,
 		}
 
 		/* eMMC spec does not require a delay between tuning cycles */
-		if (opcode == MMC_SEND_TUNING_BLOCK)
+		if ((opcode == MMC_SEND_TUNING_BLOCK) ||
+		    (host->quirks2 & SDHCI_QUIRK2_DELAY_BETWEEN_TUNING_CYCLES))
 			mdelay(1);
 	}
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d43519b..b6643bc 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -427,6 +427,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK2_ACMD23_BROKEN			(1<<14)
 /* Broken Clock divider zero in controller */
 #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)
+/* Delay is needed between tuning cycles */
+#define SDHCI_QUIRK2_DELAY_BETWEEN_TUNING_CYCLES	(1<<16)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.1.0.27.g96db324

