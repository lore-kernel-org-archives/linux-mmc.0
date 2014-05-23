From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 3/5] mmc: sdhci-esdhc-imx: straighten SDHCI_QUIRK_BROKEN_CARD_DETECTION flag
Date: Fri, 23 May 2014 14:33:02 +0200
Message-ID: <1400848384-3226-4-git-send-email-s.hauer@pengutronix.de>
References: <1400848384-3226-1-git-send-email-s.hauer@pengutronix.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43525 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655AbaEWMdY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 May 2014 08:33:24 -0400
In-Reply-To: <1400848384-3226-1-git-send-email-s.hauer@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>

The driver always sets the flag and clears it afterwards in some
cases. Instead, leave the flag cleared and set it when needed
which makes the code easier to read.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index f6f7a45..620cbcd 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -893,8 +893,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 static const struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
 	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_NO_HISPD_BIT
 			| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
-			| SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC
-			| SDHCI_QUIRK_BROKEN_CARD_DETECTION,
+			| SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC,
 	.ops = &sdhci_esdhc_ops,
 };
 
@@ -1084,18 +1083,18 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 				"failed to request card-detect gpio!\n");
 			goto disable_clk;
 		}
-		/* fall through */
+		break;
 
 	case ESDHC_CD_CONTROLLER:
-		/* we have a working card_detect back */
-		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 		break;
 
 	case ESDHC_CD_PERMANENT:
 		host->mmc->caps |= MMC_CAP_NONREMOVABLE;
+		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 		break;
 
 	case ESDHC_CD_NONE:
+		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 		break;
 	}
 
-- 
2.0.0.rc0

