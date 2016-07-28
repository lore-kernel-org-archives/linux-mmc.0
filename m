From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] mmc: sdhci-bcm-kona: fix error return code in sdhci_bcm_kona_probe()
Date: Thu, 28 Jul 2016 16:17:44 +0000
Message-ID: <1469722664-15136-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35635 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759013AbcG1QRu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Jul 2016 12:17:50 -0400
Received: by mail-pf0-f194.google.com with SMTP id h186so3934820pfg.2
        for <linux-mmc@vger.kernel.org>; Thu, 28 Jul 2016 09:17:50 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, bcm-kernel-feedback-list@broadcom.com, linux-mmc@vger.kernel.org

In clk_set_rate() or clk_prepare_enable() error handling case, the
error return code ret is not set, so sdhci_bcm_kona_probe() return
0 in those error cases.

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 drivers/mmc/host/sdhci-bcm-kona.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-bcm-kona.c b/drivers/mmc/host/sdhci-bcm-kona.c
index e5c634b..51dd2fd 100644
--- a/drivers/mmc/host/sdhci-bcm-kona.c
+++ b/drivers/mmc/host/sdhci-bcm-kona.c
@@ -253,12 +253,14 @@ static int sdhci_bcm_kona_probe(struct platform_device *pdev)
 		goto err_pltfm_free;
 	}
 
-	if (clk_set_rate(pltfm_priv->clk, host->mmc->f_max) != 0) {
+	ret = clk_set_rate(pltfm_priv->clk, host->mmc->f_max);
+	if (ret) {
 		dev_err(dev, "Failed to set rate core clock\n");
 		goto err_pltfm_free;
 	}
 
-	if (clk_prepare_enable(pltfm_priv->clk) != 0) {
+	ret = clk_prepare_enable(pltfm_priv->clk);
+	if (ret) {
 		dev_err(dev, "Failed to enable core clock\n");
 		goto err_pltfm_free;
 	}

