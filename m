From: Richard Zhu <Hong-Xing.Zhu@freescale.com>
Subject: [PATCH V3 3/4] mmc: sdhci-esdhc: remove SDHCI_QUIRK_NO_CARD_NO_RESET from ESDHC_DEFAULT_QUIRKS
Date: Mon, 28 Feb 2011 19:32:04 +0800
Message-ID: <1298892725-23672-3-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1298892725-23672-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe002.messaging.microsoft.com ([213.199.154.140]:13648
	"EHLO DB3EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753268Ab1B1LdL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Feb 2011 06:33:11 -0500
In-Reply-To: <1298892725-23672-1-git-send-email-Hong-Xing.Zhu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: kernel@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, avorontsov@ru.mvista.com, eric@eukrea.com, w.sang@pengutronix.de, linuxzsc@gmail.com, richard.zhao@freescale.com, Freescale@lists.linaro.org, eric.miao@linaro.org, Richard Zhu <Hong-Xing.Zhu@freescale.com>

sdhci-esdhc-imx does not need SDHCI_QUIRK_NO_CARD_NO_RESET. Make it OF-specific.

Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc.h    |    3 +--
 drivers/mmc/host/sdhci-of-esdhc.c |    2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index afaf1bc..303cde0 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -24,8 +24,7 @@
 				SDHCI_QUIRK_NONSTANDARD_CLOCK | \
 				SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK | \
 				SDHCI_QUIRK_PIO_NEEDS_DELAY | \
-				SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET | \
-				SDHCI_QUIRK_NO_CARD_NO_RESET)
+				SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)
 
 #define ESDHC_SYSTEM_CONTROL	0x2c
 #define ESDHC_CLOCK_MASK	0x0000fff0
diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index fcd0e1f..6337607 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -73,7 +73,7 @@ static unsigned int esdhc_of_get_min_clock(struct sdhci_host *host)
 }
 
 struct sdhci_of_data sdhci_esdhc = {
-	.quirks = ESDHC_DEFAULT_QUIRKS,
+	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_NO_CARD_NO_RESET,
 	.ops = {
 		.read_l = sdhci_be32bs_readl,
 		.read_w = esdhc_readw,
-- 
1.7.1


