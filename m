From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] mmc: sdhci-bcm2835: Staticize bcm2835_sdhci_get_min_clock
Date: Wed, 26 Jun 2013 11:57:01 +0530
Message-ID: <1372228021-28895-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:49450 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309Ab3FZGmH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 Jun 2013 02:42:07 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld11so13815603pab.36
        for <linux-mmc@vger.kernel.org>; Tue, 25 Jun 2013 23:42:06 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, swarren@wwwdotorg.org, sachin.kamat@linaro.org

'bcm2835_sdhci_get_min_clock' is used only in this file.
Make it static.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/mmc/host/sdhci-bcm2835.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-bcm2835.c b/drivers/mmc/host/sdhci-bcm2835.c
index 0584a1c..36fa2df 100644
--- a/drivers/mmc/host/sdhci-bcm2835.c
+++ b/drivers/mmc/host/sdhci-bcm2835.c
@@ -119,7 +119,7 @@ static u8 bcm2835_sdhci_readb(struct sdhci_host *host, int reg)
 	return byte;
 }
 
-unsigned int bcm2835_sdhci_get_min_clock(struct sdhci_host *host)
+static unsigned int bcm2835_sdhci_get_min_clock(struct sdhci_host *host)
 {
 	return MIN_FREQ;
 }
-- 
1.7.9.5

