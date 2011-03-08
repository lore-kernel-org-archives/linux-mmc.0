From: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Subject: [PATCH V6 1/4] mmc: sdhci-esdhc: remove SDHCI_QUIRK_NO_CARD_NO_RESET from ESDHC_DEFAULT_QUIRKS
Date: Tue, 8 Mar 2011 10:55:33 +0800
Message-ID: <1299552936-17202-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe004.messaging.microsoft.com ([65.55.88.14]:29225 "EHLO
	TX2EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753604Ab1CHC4J (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Mar 2011 21:56:09 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: kernel@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, avorontsov@ru.mvista.com, eric@eukrea.com, w.sang@pengutronix.de, linuxzsc@gmail.com, richard.zhao@freescale.com, eric.miao@linaro.org, Richard Zhu <Hong-Xing.Zhu@freescale.com>

sdhci-esdhc-imx does not need SDHCI_QUIRK_NO_CARD_NO_RESET. Make it OF-specific.

Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Tested-by: Wolfram Sang <w.sang@pengutronix.de>
---
 drivers/mmc/host/sdhci-esdhc.h    |    3 +--
 drivers/mmc/host/sdhci-of-esdhc.c |    3 ++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index c55aae8..c3b08f1 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -23,8 +23,7 @@
 				SDHCI_QUIRK_NONSTANDARD_CLOCK | \
 				SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK | \
 				SDHCI_QUIRK_PIO_NEEDS_DELAY | \
-				SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET | \
-				SDHCI_QUIRK_NO_CARD_NO_RESET)
+				SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
 
 #define ESDHC_SYSTEM_CONTROL	0x2c
 #define ESDHC_CLOCK_MASK	0x0000fff0
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 08161f6..ba40d6d 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -74,7 +74,8 @@ static unsigned int esdhc_of_get_min_clock(struct sdhci_host *host)
 
 struct sdhci_of_data sdhci_esdhc = {
 	/* card detection could be handled via GPIO */
-	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_CARD_DETECTION,
+	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_BROKEN_CARD_DETECTION
+		| SDHCI_QUIRK_NO_CARD_NO_RESET,
 	.ops = {
 		.read_l = sdhci_be32bs_readl,
 		.read_w = esdhc_readw,
-- 
1.7.1


