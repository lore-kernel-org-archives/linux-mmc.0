From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 2/7] mmc: sdhci-sirf: Remove redundant use of mmc_gpio_free_cd()
Date: Thu, 18 Dec 2014 15:44:31 +0100
Message-ID: <1418913876-13937-3-git-send-email-ulf.hansson@linaro.org>
References: <1418913876-13937-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:59060 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbaLROot (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Dec 2014 09:44:49 -0500
Received: by mail-wg0-f44.google.com with SMTP id b13so1825906wgh.31
        for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2014 06:44:48 -0800 (PST)
In-Reply-To: <1418913876-13937-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: Barry Song <baohua@kernel.org>

The MMC core makes use of the devm_* functions while requesting the
CD/WP GPIOs, let's rely on that.

Cc: Barry Song <baohua@kernel.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-sirf.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-sirf.c
index dd29d47..6981f4d 100644
--- a/drivers/mmc/host/sdhci-sirf.c
+++ b/drivers/mmc/host/sdhci-sirf.c
@@ -138,9 +138,6 @@ static int sdhci_sirf_remove(struct platform_device *pdev)
 
 	sdhci_pltfm_unregister(pdev);
 
-	if (gpio_is_valid(priv->gpio_cd))
-		mmc_gpio_free_cd(host->mmc);
-
 	clk_disable_unprepare(priv->clk);
 	return 0;
 }
-- 
1.9.1

