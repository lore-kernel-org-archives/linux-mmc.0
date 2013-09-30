From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 3/3] mmc: sdhci-dove: Remove redundant of_match_ptr
Date: Mon, 30 Sep 2013 10:29:33 +0530
Message-ID: <1380517173-10537-3-git-send-email-sachin.kamat@linaro.org>
References: <1380517173-10537-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:51446 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990Ab3I3E7u (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Sep 2013 00:59:50 -0400
Received: by mail-pb0-f43.google.com with SMTP id md4so5046786pbc.30
        for <linux-mmc@vger.kernel.org>; Sun, 29 Sep 2013 21:59:50 -0700 (PDT)
In-Reply-To: <1380517173-10537-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: cjb@laptop.org, tgih.jun@samsung.com, jh80.chung@samsung.com, sachin.kamat@linaro.org

The data structure of_match_ptr() protects is always compiled in.
Hence of_match_ptr() is not needed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/mmc/host/sdhci-dove.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
index 8424839..736d7a2 100644
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

