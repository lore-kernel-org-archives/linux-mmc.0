From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 14/21] mmc: sdhci-esdhc-imx: remove SDHCI_QUIRK_BROKEN_CARD_DETECTION
Date: Wed, 27 Jan 2016 13:08:38 +0800
Message-ID: <1453871318-3888-1-git-send-email-shawn.lin@rock-chips.com>
References: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:46357 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753729AbcA0FNM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jan 2016 00:13:12 -0500
In-Reply-To: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, Dong Aisheng <aisheng.dong@freescale.com>, Haibo Chen <haibo.chen@freescale.com>

sdhci_esdhc_imx_pdata need SDHCI_QUIRK_BROKEN_CARD_DETECTION,
so we replace it with MMC_CAP_NEEDS_POLL while probing. For other
cases, we directly remove SDHCI_QUIRK_BROKEN_CARD_DETECTION.

Cc: Dong Aisheng <aisheng.dong@freescale.com>
Cc: Haibo Chen <haibo.chen@freescale.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci-esdhc-imx.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index f25f292..5705be1 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -952,8 +952,7 @@ static struct sdhci_ops sdhci_esdhc_ops = {
 static const struct sdhci_pltfm_data sdhci_esdhc_imx_pdata = {
 	.quirks = ESDHC_DEFAULT_QUIRKS | SDHCI_QUIRK_NO_HISPD_BIT
 			| SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
-			| SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC
-			| SDHCI_QUIRK_BROKEN_CARD_DETECTION,
+			| SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC,
 	.ops = &sdhci_esdhc_ops,
 };
 
@@ -1012,7 +1011,7 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
 		return ret;
 
 	if (!IS_ERR_VALUE(mmc_gpio_get_cd(host->mmc)))
-		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+		host->mmc->caps &= MMC_CAP_NEEDS_POLL;
 
 	return 0;
 }
@@ -1064,7 +1063,7 @@ static int sdhci_esdhc_imx_probe_nondt(struct platform_device *pdev,
 
 	case ESDHC_CD_CONTROLLER:
 		/* we have a working card_detect back */
-		host->quirks &= ~SDHCI_QUIRK_BROKEN_CARD_DETECTION;
+		host->mmc->caps &= MMC_CAP_NEEDS_POLL;
 		break;
 
 	case ESDHC_CD_PERMANENT:
@@ -1104,6 +1103,8 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
+	host->mmc->caps |= MMC_CAP_NEEDS_POLL;
+
 	pltfm_host = sdhci_priv(host);
 
 	imx_data = devm_kzalloc(&pdev->dev, sizeof(*imx_data), GFP_KERNEL);
-- 
2.3.7


