From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 06/10] mmc: sdhci-dove: Remove redundant of_match_ptr
Date: Tue, 25 Feb 2014 15:18:24 +0530
Message-ID: <1393321708-9719-6-git-send-email-sachin.kamat@linaro.org>
References: <1393321708-9719-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:61259 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbaBYJyX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Feb 2014 04:54:23 -0500
Received: by mail-pb0-f47.google.com with SMTP id up15so1367225pbc.20
        for <linux-mmc@vger.kernel.org>; Tue, 25 Feb 2014 01:54:22 -0800 (PST)
In-Reply-To: <1393321708-9719-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, sachin.kamat@linaro.org

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

