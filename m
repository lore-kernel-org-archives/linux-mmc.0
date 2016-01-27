From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 06/21] mmc: sdhci-of-esdhc: consolidate parsing path
Date: Wed, 27 Jan 2016 13:07:15 +0800
Message-ID: <1453871235-3535-1-git-send-email-shawn.lin@rock-chips.com>
References: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, yangbo lu <yangbo.lu@freescale.com>
List-Id: linux-mmc@vger.kernel.org

This patch remove mmc_of_parse and check return value
of sdhci_get_of_property.

Cc: yangbo lu <yangbo.lu@freescale.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci-of-esdhc.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 83b1226..7fc0edc 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -600,7 +600,9 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 
 	esdhc_init(pdev, host);
 
-	sdhci_get_of_property(pdev);
+	ret = sdhci_get_of_property(pdev);
+	if (ret)
+		goto err;
 
 	pltfm_host = sdhci_priv(host);
 	esdhc = pltfm_host->priv;
@@ -629,11 +631,6 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 		host->quirks2 |= SDHCI_QUIRK2_BROKEN_HOST_CONTROL;
 	}
 
-	/* call to generic mmc_of_parse to support additional capabilities */
-	ret = mmc_of_parse(host->mmc);
-	if (ret)
-		goto err;
-
 	mmc_of_parse_voltage(np, &host->ocr_mask);
 
 	ret = sdhci_add_host(host);
-- 
2.3.7
