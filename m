From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: sdhci-of-esdhc: Fixup compile error
Date: Fri, 23 May 2014 10:36:44 +0200
Message-ID: <1400834204-1933-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:44605 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781AbaEWIgu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 May 2014 04:36:50 -0400
Received: by mail-la0-f52.google.com with SMTP id gl10so3719371lab.25
        for <linux-mmc@vger.kernel.org>; Fri, 23 May 2014 01:36:48 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Russell King <rmk+kernel@arm.linux.org.uk>

The commit below introduced compile errors, let's fix them.
mmc: sdhci-of-esdhc: remove platform_suspend/platform_resume callbacks

Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/sdhci-of-esdhc.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 605815e..8be4dcf 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -306,7 +306,7 @@ static int esdhc_of_suspend(struct device *dev)
 	return sdhci_suspend_host(host);
 }
 
-static void esdhc_of_resume(device *dev)
+static int esdhc_of_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	int ret = sdhci_resume_host(host);
@@ -321,8 +321,8 @@ static void esdhc_of_resume(device *dev)
 }
 
 static const struct dev_pm_ops esdhc_pmops = {
-	.suspend	= esdhci_of_suspend,
-	.resume		= esdhci_of_resume,
+	.suspend	= esdhc_of_suspend,
+	.resume		= esdhc_of_resume,
 };
 #define ESDHC_PMOPS (&esdhc_pmops)
 #else
-- 
1.7.9.5

