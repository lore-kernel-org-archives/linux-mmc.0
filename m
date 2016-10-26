From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] mmc: sdhci-msm: Fix error return code in sdhci_msm_probe()
Date: Wed, 26 Oct 2016 15:04:41 +0000
Message-ID: <1477494281-24246-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35832 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753997AbcJZPEv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Oct 2016 11:04:51 -0400
Received: by mail-pf0-f195.google.com with SMTP id s8so22998094pfj.2
        for <linux-mmc@vger.kernel.org>; Wed, 26 Oct 2016 08:04:51 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Georgi Djakov <georgi.djakov@linaro.org>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-mmc@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Fix to return a negative error code from the platform_get_irq_byname()
error handling case instead of 0, as done elsewhere in this function.

Fixes: ad81d3871004 ("mmc: sdhci-msm: Add support for UHS cards")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/mmc/host/sdhci-msm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 795f16f..b78d72f 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -649,6 +649,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	if (msm_host->pwr_irq < 0) {
 		dev_err(&pdev->dev, "Get pwr_irq failed (%d)\n",
 			msm_host->pwr_irq);
+		ret = msm_host->pwr_irq;
 		goto clk_disable;
 	}

