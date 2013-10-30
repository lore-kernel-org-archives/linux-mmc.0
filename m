From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH Resend 6/7] mmc: sdhci-dove: Remove redundant of_match_ptr
Date: Wed, 30 Oct 2013 17:13:49 +0530
Message-ID: <1383133430-22079-6-git-send-email-sachin.kamat@linaro.org>
References: <1383133430-22079-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:43845 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812Ab3J3LpX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Oct 2013 07:45:23 -0400
Received: by mail-pd0-f179.google.com with SMTP id y10so846083pdj.24
        for <linux-mmc@vger.kernel.org>; Wed, 30 Oct 2013 04:45:22 -0700 (PDT)
In-Reply-To: <1383133430-22079-1-git-send-email-sachin.kamat@linaro.org>
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
index 95f1076..fc59f96 100644
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

