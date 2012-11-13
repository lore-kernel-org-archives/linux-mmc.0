From: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: [PATCH 1/2 V2] Powerpc/eSDHC: Calculate the applicable mmc erase timeout value
Date: Tue, 13 Nov 2012 17:09:22 +0800
Message-ID: <1352797762-30526-2-git-send-email-Haijun.Zhang@freescale.com>
References: <1352797762-30526-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from co1ehsobe005.messaging.microsoft.com ([216.32.180.188]:20714
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754412Ab2KMJaZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Nov 2012 04:30:25 -0500
In-Reply-To: <1352797762-30526-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Haijun Zhang <Haijun.Zhang@freescale.com>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Anton Vorontsov <cbouatmailru@gmail.com>

As large area erase needs long time usually a few minutes,
which the host can't wait will bring about timeout error.
So we need to split the large area to small sections which
only need short erase time to avoid timeout error.

Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
CC: Anton Vorontsov <cbouatmailru@gmail.com>
---
changes for v2:
        - Recompute the timeout value and max_discard_to for mmc erase
	- split the V1 patch into two V2 patchs.

 drivers/mmc/host/sdhci-esdhc.h    |    1 -
 drivers/mmc/host/sdhci-of-esdhc.c |   13 +++++++++++++
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index d25f9ab..bb6d664 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -21,7 +21,6 @@
 #define ESDHC_DEFAULT_QUIRKS	(SDHCI_QUIRK_FORCE_BLK_SZ_2048 | \
 				SDHCI_QUIRK_NO_BUSY_IRQ | \
 				SDHCI_QUIRK_NONSTANDARD_CLOCK | \
-				SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK | \
 				SDHCI_QUIRK_PIO_NEEDS_DELAY | \
 				SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
 
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 63d219f..a09ea67 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -154,6 +154,18 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 	/* Set the clock */
 	esdhc_set_clock(host, clock);
 }
+/*
+ * As host dosn't supply us the method to calculate the timeout value,
+ * we assigned one for high speed SDHC card. So we can use this to calculate
+ * the max discard timeout value to limit the max discard sectors to avoid the
+ * timeout issue during large area erase.
+ */
+static unsigned int esdhc_of_get_timeout_clock(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	return pltfm_host->clock / 1000 / 32;
+}
 
 #ifdef CONFIG_PM
 static u32 esdhc_proctl;
@@ -190,6 +202,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.enable_dma = esdhc_of_enable_dma,
 	.get_max_clock = esdhc_of_get_max_clock,
 	.get_min_clock = esdhc_of_get_min_clock,
+	.get_timeout_clock = esdhc_of_get_timeout_clock,
 	.platform_init = esdhc_of_platform_init,
 #ifdef CONFIG_PM
 	.platform_suspend = esdhc_of_suspend,
-- 
1.7.0.4


