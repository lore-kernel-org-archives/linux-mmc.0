From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH] mmc: sdhci-of-arasan: Trivial print fix
Date: Tue, 2 May 2017 17:13:03 +0530
Message-ID: <1493725383-17180-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam01on0049.outbound.protection.outlook.com ([104.47.34.49]:29324
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750886AbdEBLnU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 2 May 2017 07:43:20 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com, michal.simek@xilinx.com, shubhrajyoti.datta@gmail.com, Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>

ret is signed however is printed as unsigned fix the same.
If printed as a negative number the result is easier to read.
No functional change.

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
v2:
Change the subject

 drivers/mmc/host/sdhci-of-arasan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 1de40e6..77cc68b 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -704,7 +704,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 
 	ret = mmc_of_parse(host->mmc);
 	if (ret) {
-		dev_err(&pdev->dev, "parsing dt failed (%u)\n", ret);
+		dev_err(&pdev->dev, "parsing dt failed (%d)\n", ret);
 		goto unreg_clk;
 	}
 
-- 
2.7.4

