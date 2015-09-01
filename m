From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: [PATCH 2/2] mmc: sdhci-pxav3: Print ret value on error from sdhci_add_host() fn
Date: Wed,  2 Sep 2015 00:54:14 +0530
Message-ID: <1441135454-6902-3-git-send-email-vaibhav.hiremath@linaro.org>
References: <1441135454-6902-1-git-send-email-vaibhav.hiremath@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34292 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754311AbbIAT1B (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Sep 2015 15:27:01 -0400
Received: by padhy1 with SMTP id hy1so5223696pad.1
        for <linux-mmc@vger.kernel.org>; Tue, 01 Sep 2015 12:27:00 -0700 (PDT)
In-Reply-To: <1441135454-6902-1-git-send-email-vaibhav.hiremath@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <vaibhav.hiremath@linaro.org>

Return value would give clear information about the actual root-cause
of the failure.

Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
---
 drivers/mmc/host/sdhci-pxav3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index d02bc37..5d26fe0 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -455,7 +455,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 
 	ret = sdhci_add_host(host);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to add host\n");
+		dev_err(&pdev->dev, "failed to add host ret - %d\n", ret);
 		goto err_add_host;
 	}
 
-- 
1.9.1

