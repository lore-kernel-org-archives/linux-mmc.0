From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/6] mmc: sdhci-bcm-kona: Handle error from mmc_of_parse()
Date: Thu, 18 Dec 2014 10:41:40 +0100
Message-ID: <1418895704-25908-3-git-send-email-ulf.hansson@linaro.org>
References: <1418895704-25908-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f53.google.com ([74.125.82.53]:60082 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751653AbaLRJl7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Dec 2014 04:41:59 -0500
Received: by mail-wg0-f53.google.com with SMTP id l18so1095481wgh.12
        for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2014 01:41:58 -0800 (PST)
In-Reply-To: <1418895704-25908-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: Christian Daudt <bcm@fixthebug.org>, Matt Porter <mporter@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>

Since mmc_of_parse() may fail, let's deal with it and thus do proper
error handling.

Cc: Christian Daudt <bcm@fixthebug.org>
Cc: Matt Porter <mporter@linaro.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-bcm-kona.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
index e7e4fbd..34bb8f9 100644
--- a/drivers/mmc/host/sdhci-bcm-kona.c
+++ b/drivers/mmc/host/sdhci-bcm-kona.c
@@ -254,7 +254,9 @@ static int sdhci_bcm_kona_probe(struct platform_device *pdev)
 	kona_dev = sdhci_pltfm_priv(pltfm_priv);
 	mutex_init(&kona_dev->write_lock);
 
-	mmc_of_parse(host->mmc);
+	ret = mmc_of_parse(host->mmc);
+	if (ret)
+		goto err_pltfm_free;
 
 	if (!host->mmc->f_max) {
 		dev_err(&pdev->dev, "Missing max-freq for SDHCI cfg\n");
-- 
1.9.1

