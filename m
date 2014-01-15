From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 6/9] mmc: sdhci-dove: Remove redundant of_match_ptr
Date: Wed, 15 Jan 2014 11:25:10 +0530
Message-ID: <1389765313-16744-6-git-send-email-sachin.kamat@linaro.org>
References: <1389765313-16744-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:37257 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbaAOF7i (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 00:59:38 -0500
Received: by mail-pb0-f45.google.com with SMTP id rp16so679599pbb.18
        for <linux-mmc@vger.kernel.org>; Tue, 14 Jan 2014 21:59:38 -0800 (PST)
In-Reply-To: <1389765313-16744-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: chris@printf.net, sachin.kamat@linaro.org, patches@linaro.org

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

