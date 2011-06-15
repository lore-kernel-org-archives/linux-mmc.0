From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v2 3/4] mmc: sdhci-esdhc-imx: remove "WP" from flag ESDHC_FLAG_GPIO_FOR_CD_WP
Date: Wed, 15 Jun 2011 19:15:21 +0800
Message-ID: <1308136522-3403-4-git-send-email-shawn.guo@linaro.org>
References: <1308136522-3403-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe006.messaging.microsoft.com ([213.199.154.209]:24402
	"EHLO AM1EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754402Ab1FOLKI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jun 2011 07:10:08 -0400
In-Reply-To: <1308136522-3403-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, Arnaud Patard <arnaud.patard@rtp-net.org>, Eric Benard <eric@eukrea.com>, Pavel Machek <pma@sysgo.com>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, patches@linaro.org, Shawn Guo <shawn.guo@linaro.org>

The use of flag ESDHC_FLAG_GPIO_FOR_CD_WP is all CD related.  It does
not necessarily need to bother WP in the flag name.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/sdhci-esdhc-imx.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 94097c0..79b7a9a 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -29,7 +29,7 @@
 #define SDHCI_VENDOR_SPEC		0xC0
 #define  SDHCI_VENDOR_SPEC_SDIO_QUIRK	0x00000002
 
-#define ESDHC_FLAG_GPIO_FOR_CD_WP	(1 << 0)
+#define ESDHC_FLAG_GPIO_FOR_CD		(1 << 0)
 /*
  * The CMDTYPE of the CMD register (offset 0xE) should be set to
  * "11" when the STOP CMD12 is issued on imx53 to abort one
@@ -77,7 +77,7 @@ static u32 esdhc_readl_le(struct sdhci_host *host, int reg)
 	u32 val = readl(host->ioaddr + reg);
 
 	if (unlikely((reg == SDHCI_PRESENT_STATE)
-			&& (imx_data->flags & ESDHC_FLAG_GPIO_FOR_CD_WP))) {
+			&& (imx_data->flags & ESDHC_FLAG_GPIO_FOR_CD))) {
 		struct esdhc_platform_data *boarddata =
 				host->mmc->parent->platform_data;
 
@@ -99,7 +99,7 @@ static void esdhc_writel_le(struct sdhci_host *host, u32 val, int reg)
 	struct pltfm_imx_data *imx_data = pltfm_host->priv;
 
 	if (unlikely((reg == SDHCI_INT_ENABLE || reg == SDHCI_SIGNAL_ENABLE)
-			&& (imx_data->flags & ESDHC_FLAG_GPIO_FOR_CD_WP)))
+			&& (imx_data->flags & ESDHC_FLAG_GPIO_FOR_CD)))
 		/*
 		 * these interrupts won't work with a custom card_detect gpio
 		 * (only applied to mx25/35)
@@ -308,7 +308,7 @@ static int __devinit sdhci_esdhc_imx_probe(struct platform_device *pdev)
 			goto no_card_detect_irq;
 		}
 
-		imx_data->flags |= ESDHC_FLAG_GPIO_FOR_CD_WP;
+		imx_data->flags |= ESDHC_FLAG_GPIO_FOR_CD;
 		/* Now we have a working card_detect again */
 		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 	}
-- 
1.7.4.1


