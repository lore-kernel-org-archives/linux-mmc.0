From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 2/5] mmc: sdhci-esdhc: broken card detection is not a default quirk
Date: Thu, 10 Feb 2011 20:14:48 +0100
Message-ID: <1297365291-1038-3-git-send-email-w.sang@pengutronix.de>
References: <1297365291-1038-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49271 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334Ab1BJTPK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Feb 2011 14:15:10 -0500
In-Reply-To: <1297365291-1038-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, =?UTF-8?q?Eric=20B=C3=A9nard?= <eric@eukrea.com>, Zhu Richard-R65037 <r65037@freescale.com>, Wolfram Sang <w.sang@pengutronix.de>

It can be worked around using a GPIO which will be done for i.MX later.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    3 ++-
 drivers/mmc/host/sdhci-esdhc.h     |    1 -
 drivers/mmc/host/sdhci-of-esdhc.c  |    3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 83d178b..e0fa1f3 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -170,7 +170,8 @@ static void esdhc_pltfm_exit(struct sdhci_host *host)
 }
 
 struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
-	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_ADMA,
+	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_ADMA
+			| SDHCI_QUIRK_BROKEN_CARD_DETECTION,
 	/* ADMA has issues. Might be fixable */
 	.ops = &sdhci_esdhc_ops,
 	.init = esdhc_pltfm_init,
diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index afaf1bc..c55aae8 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -19,7 +19,6 @@
  */
 
 #define ESDHC_DEFAULT_QUIRKS	(SDHCI_QUIRK_FORCE_BLK_SZ_2048 | \
-				SDHCI_QUIRK_BROKEN_CARD_DETECTION | \
 				SDHCI_QUIRK_NO_BUSY_IRQ | \
 				SDHCI_QUIRK_NONSTANDARD_CLOCK | \
 				SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK | \
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index fcd0e1f..08161f6 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -73,7 +73,8 @@ static unsigned int esdhc_of_get_min_clock(struct sdhci_host *host)
 }
 
 struct sdhci_of_data sdhci_esdhc = {
-	.quirks = ESDHC_DEFAULT_QUIRKS,
+	/* card detection could be handled via GPIO */
+	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_CARD_DETECTION,
 	.ops = {
 		.read_l = sdhci_be32bs_readl,
 		.read_w = esdhc_readw,
-- 
1.7.2.3

