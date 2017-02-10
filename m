From: Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH] mmc: sdhci-pxav2: add error handling of clk_prepare_enable()
Date: Sat, 11 Feb 2017 01:54:46 +0300
Message-ID: <1486767286-3361-1-git-send-email-khoroshilov@ispras.ru>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.ispras.ru ([83.149.199.45]:59522 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751123AbdBJWy4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 10 Feb 2017 17:54:56 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org

There is no check if clk_prepare_enable() succeed in sdhci_pxav2_probe().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/mmc/host/sdhci-pxav2.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index 347eae2d7b6a..80513f54e9d4 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -185,7 +185,11 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 		goto err_clk_get;
 	}
 	pltfm_host->clk = clk;
-	clk_prepare_enable(clk);
+	ret = clk_prepare_enable(clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable io clock\n");
+		goto err_clk_enable;
+	}
 
 	host->quirks = SDHCI_QUIRK_BROKEN_ADMA
 		| SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
@@ -228,6 +232,7 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 
 err_add_host:
 	clk_disable_unprepare(clk);
+err_clk_enable:
 	clk_put(clk);
 err_clk_get:
 	sdhci_pltfm_free(pdev);
-- 
2.7.4

