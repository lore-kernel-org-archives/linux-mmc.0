From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH Resend 6/7] mmc: sdhci-dove: Remove redundant of_match_ptr
Date: Thu, 19 Dec 2013 14:13:33 +0530
Message-ID: <1387442614-4193-6-git-send-email-sachin.kamat@linaro.org>
References: <1387442614-4193-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:50050 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813Ab3LSIrD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Dec 2013 03:47:03 -0500
Received: by mail-pa0-f51.google.com with SMTP id fa1so873100pad.38
        for <linux-mmc@vger.kernel.org>; Thu, 19 Dec 2013 00:47:03 -0800 (PST)
In-Reply-To: <1387442614-4193-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, sachin.kamat@linaro.org

The data structure of_match_ptr() protects is always compiled in.
Hence of_match_ptr() is not needed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/mmc/host/sdhci-dove.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
index 8424839660f8..736d7a2eb7ec 100644
--- a/drivers/mmc/host/sdhci-dove.c
+++ b/drivers/mmc/host/sdhci-dove.c
@@ -208,7 +208,7 @@ static struct platform_driver sdhci_dove_driver = {
 		.name	= "sdhci-dove",
 		.owner	= THIS_MODULE,
 		.pm	= SDHCI_PLTFM_PMOPS,
-		.of_match_table = of_match_ptr(sdhci_dove_of_match_table),
+		.of_match_table = sdhci_dove_of_match_table,
 	},
 	.probe		= sdhci_dove_probe,
 	.remove		= sdhci_dove_remove,
-- 
1.7.9.5

