From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
Subject: [PATCH] mmc: sdhci: Fix FSL ESDHC reset handling quirk
Date: Tue,  9 Dec 2014 09:40:38 +0100
Message-ID: <1418114438-17776-1-git-send-email-alessio.bogani@elettra.eu>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from m2.elettra.trieste.it ([140.105.206.202]:46979 "EHLO elettra.eu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751197AbaLIIk5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 9 Dec 2014 03:40:57 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Dong Aisheng <dongas86@gmail.com>
Cc: linux-mmc@vger.kernel.org, Alessio Igor Bogani <alessio.bogani@elettra.eu>

The commit 0718e59ae259 ("mmc: sdhci: move FSL ESDHC reset handling quirk into
esdhc code") states that Freescale esdhc is the only controller which needs
the interrupt registers restored after a reset. So it moves
SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET quirk handling code into the
esdhc-imx driver only. Unfortunately the same controller is used in
other boards which use the of-esdhc driver instead (like powerpc P2020).

Restore interrupts after reset in the sdhci-of-esdhc driver also.

Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 8872c85..4a654d4 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -276,6 +276,14 @@ static void esdhc_pltfm_set_bus_width(struct sdhci_host *host, int width)
 			ESDHC_CTRL_BUSWIDTH_MASK, ctrl);
 }
 
+static void esdhc_reset(struct sdhci_host *host, u8 mask)
+{
+	sdhci_reset(host, mask);
+
+	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
+	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
+}
+
 static const struct sdhci_ops sdhci_esdhc_ops = {
 	.read_l = esdhc_readl,
 	.read_w = esdhc_readw,
@@ -290,7 +298,7 @@ static const struct sdhci_ops sdhci_esdhc_ops = {
 	.platform_init = esdhc_of_platform_init,
 	.adma_workaround = esdhci_of_adma_workaround,
 	.set_bus_width = esdhc_pltfm_set_bus_width,
-	.reset = sdhci_reset,
+	.reset = esdhc_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
-- 
2.1.3

