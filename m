From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4/6] mmc: sdhci-s3c: Handle error from mmc_of_parse()
Date: Thu, 18 Dec 2014 10:41:42 +0100
Message-ID: <1418895704-25908-5-git-send-email-ulf.hansson@linaro.org>
References: <1418895704-25908-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33056 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbaLRJmD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Dec 2014 04:42:03 -0500
Received: by mail-wi0-f182.google.com with SMTP id h11so1125528wiw.9
        for <linux-mmc@vger.kernel.org>; Thu, 18 Dec 2014 01:42:02 -0800 (PST)
In-Reply-To: <1418895704-25908-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: Jaehoon Chung <jh80.chung@samsung.com>

Since mmc_of_parse() may fail, let's deal with it and thus do proper
error handling.

Cc: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-s3c.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index c45b893..a282822 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -607,7 +607,9 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_suspend_ignore_children(&pdev->dev, 1);
 
-	mmc_of_parse(host->mmc);
+	ret = mmc_of_parse(host->mmc);
+	if (ret)
+		goto err_req_regs;
 
 	ret = sdhci_add_host(host);
 	if (ret) {
-- 
1.9.1

