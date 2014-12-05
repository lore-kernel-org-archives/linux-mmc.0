From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
Subject: [PATCH] mmc: sdhci: Fix FSL ESDHC reset handling quirk
Date: Fri,  5 Dec 2014 10:58:53 +0100
Message-ID: <1417773533-10052-1-git-send-email-alessio.bogani@elettra.eu>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from m2.elettra.trieste.it ([140.105.206.202]:37034 "EHLO elettra.eu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751122AbaLEK7L (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 5 Dec 2014 05:59:11 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: linux-mmc@vger.kernel.org, Alessio Igor Bogani <alessio.bogani@elettra.eu>

The commit 0718e59ae259 ("mmc: sdhci: move FSL ESDHC reset handling quirk into
esdhc code") states that Freescale esdhc is the only controller which needs
the interrupt registers restored after a reset. So it moves
SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET quirk handling code into the
esdhc-imx driver only. Unfortunately the same controller is used in
other boards which use the of-esdhc driver instead (like powerpc P2020).

This patch partially reverts the above mentioned commit and make
SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET dependency explicit in both drivers.

Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 13 +++----------
 drivers/mmc/host/sdhci-of-esdhc.c  |  1 +
 drivers/mmc/host/sdhci.c           |  5 +++++
 include/linux/mmc/sdhci.h          |  2 ++
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 587ee0e..216e765 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -872,14 +872,6 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
 	esdhc_change_pinstate(host, timing);
 }
 
-static void esdhc_reset(struct sdhci_host *host, u8 mask)
-{
-	sdhci_reset(host, mask);
-
-	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
-	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
-}
-
 static unsigned int esdhc_get_max_timeout_count(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -912,14 +904,15 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 	.set_timeout = esdhc_set_timeout,
 	.set_bus_width = esdhc_pltfm_set_bus_width,
 	.set_uhs_signaling = esdhc_set_uhs_signaling,
-	.reset = esdhc_reset,
+	.reset = sdhci_reset,
 };
 
 static const struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
 	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_NO_HISPD_BIT
 			| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
 			| SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC
-			| SDHCI_QUIRK_BROKEN_CARD_DETECTION,
+			| SDHCI_QUIRK_BROKEN_CARD_DETECTION
+			| SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET,
 	.ops = &sdhci_esdhc_ops,
 };
 
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 8872c85..9121078 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -359,6 +359,7 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 		 * host control register
 		 */
 		host->quirks2 |= SDHCI_QUIRK2_BROKEN_HOST_CONTROL;
+		host->quirks |= SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET;
 	}
 
 	/* call to generic mmc_of_parse to support additional capabilities */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ada1a3e..ac86775 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -205,6 +205,11 @@ static void sdhci_do_reset(struct sdhci_host *host, u8 mask)
 
 	host->ops->reset(host, mask);
 
+	if (host->quirks & SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET) {
+		sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
+		sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
+	}
+
 	if (mask & SDHCI_RESET_ALL) {
 		if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
 			if (host->ops->enable_dma)
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index dba793e..201978d 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -59,6 +59,8 @@ struct sdhci_host {
 #define SDHCI_QUIRK_INVERTED_WRITE_PROTECT		(1<<16)
 /* Controller does not like fast PIO transfers */
 #define SDHCI_QUIRK_PIO_NEEDS_DELAY			(1<<18)
+/* Controller losing signal/interrupt enable states after reset */
+#define SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET		(1<<19)
 /* Controller has to be forced to use block size of 2048 bytes */
 #define SDHCI_QUIRK_FORCE_BLK_SZ_2048			(1<<20)
 /* Controller cannot do multi-block transfers */
-- 
2.1.3

