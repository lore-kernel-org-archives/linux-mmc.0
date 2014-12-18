From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 3/6] mmc: sdhci-of-esdhc: Handle error from mmc_of_parse()
Date: Thu, 18 Dec 2014 10:41:41 +0100
Message-ID: <1418895704-25908-4-git-send-email-ulf.hansson@linaro.org>
References: <1418895704-25908-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:39038 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbaLRJmA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Dec 2014 04:42:00 -0500
Received: by mail-wi0-f177.google.com with SMTP id l15so1140238wiw.4
        for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2014 01:41:59 -0800 (PST)
In-Reply-To: <1418895704-25908-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>

Since mmc_of_parse() may fail, let's deal with it and thus do proper
error handling.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 8872c85..429bf41 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -362,13 +362,19 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 	}
 
 	/* call to generic mmc_of_parse to support additional capabilities */
-	mmc_of_parse(host->mmc);
+	ret = mmc_of_parse(host->mmc);
+	if (ret)
+		goto err;
+
 	mmc_of_parse_voltage(np, &host->ocr_mask);
 
 	ret = sdhci_add_host(host);
 	if (ret)
-		sdhci_pltfm_free(pdev);
+		goto err;
 
+	return 0;
+ err:
+	sdhci_pltfm_free(pdev);
 	return ret;
 }
 
-- 
1.9.1

