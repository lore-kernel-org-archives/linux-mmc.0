From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/2] mmc: sdhci-bcm2835: Use sdhci_pltfm_unregister instead
 of open coded
Date: Tue, 17 Sep 2013 16:00:47 +0800
Message-ID: <1379404847.12080.3.camel@phoenix>
References: <1379404772.12080.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:53674 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521Ab3IQIAw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Sep 2013 04:00:52 -0400
Received: by mail-pa0-f50.google.com with SMTP id fb10so6455272pad.37
        for <linux-mmc@vger.kernel.org>; Tue, 17 Sep 2013 01:00:51 -0700 (PDT)
In-Reply-To: <1379404772.12080.1.camel@phoenix>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Christian Daudt <csd@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, linux-mmc@vger.kernel.org

This avoid duplicated implementation.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/mmc/host/sdhci-bcm2835.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-bcm2835.c b/drivers/mmc/host/sdhci-bcm2835.c
index 36fa2df..f6d8d67 100644
--- a/drivers/mmc/host/sdhci-bcm2835.c
+++ b/drivers/mmc/host/sdhci-bcm2835.c
@@ -178,13 +178,7 @@ err:
 
 static int bcm2835_sdhci_remove(struct platform_device *pdev)
 {
-	struct sdhci_host *host = platform_get_drvdata(pdev);
-	int dead = (readl(host->ioaddr + SDHCI_INT_STATUS) == 0xffffffff);
-
-	sdhci_remove_host(host, dead);
-	sdhci_pltfm_free(pdev);
-
-	return 0;
+	return sdhci_pltfm_unregister(pdev);
 }
 
 static const struct of_device_id bcm2835_sdhci_of_match[] = {
-- 
1.8.1.2



