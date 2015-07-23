From: houjingj <houjingj@marvell.com>
Subject: [PATCH] mmc: sdhci-pxav3: fix platform_data is not initialized
Date: Thu, 23 Jul 2015 12:24:58 +0800
Message-ID: <1437625498-9364-1-git-send-email-houjingj@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:23910 "EHLO
	mx0a-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750779AbbGWE2R (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Jul 2015 00:28:17 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, houjingj <houjingj@marvell.com>

pdev->dev.platform_data is not initialized if match is true in function
sdhci_pxav3_probe. Just local variable pdata is assigned the return value
from function pxav3_get_mmc_pdata().

static int sdhci_pxav3_probe(struct platform_device *pdev) {

    struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
    ...
    if (match) {
		ret = mmc_of_parse(host->mmc);
		if (ret)
			goto err_of_parse;
		sdhci_get_of_property(pdev);
		pdata = pxav3_get_mmc_pdata(dev);
     }
     ...
}

Signed-off-by: houjingj <houjingj@marvell.com>
---
 drivers/mmc/host/sdhci-pxav3.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 9cd5fc6..946d37f 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -411,6 +411,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 			goto err_of_parse;
 		sdhci_get_of_property(pdev);
 		pdata = pxav3_get_mmc_pdata(dev);
+		pdev->dev.platform_data = pdata;
 	} else if (pdata) {
 		/* on-chip device */
 		if (pdata->flags & PXA_FLAG_CARD_PERMANENT)
-- 
1.7.9.5

