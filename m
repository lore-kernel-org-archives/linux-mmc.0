From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH v2 1/7] mmc: sdhci-dove: remove the unneeded error check
Date: Fri, 27 Feb 2015 15:47:25 +0800
Message-ID: <1425023251-4544-2-git-send-email-haokexin@gmail.com>
References: <1425023251-4544-1-git-send-email-haokexin@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:44378 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbbB0Hr5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Feb 2015 02:47:57 -0500
Received: by ykp131 with SMTP id 131so6486914ykp.11
        for <linux-mmc@vger.kernel.org>; Thu, 26 Feb 2015 23:47:56 -0800 (PST)
In-Reply-To: <1425023251-4544-1-git-send-email-haokexin@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>

The function clk_disable_unprepare() already take care of either error
or null cases.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
v2: No change.

 drivers/mmc/host/sdhci-dove.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
index ca969d271a27..0a7aeb162497 100644
--- a/drivers/mmc/host/sdhci-dove.c
+++ b/drivers/mmc/host/sdhci-dove.c
@@ -117,8 +117,7 @@ static int sdhci_dove_probe(struct platform_device *pdev)
 	return 0;
 
 err_sdhci_add:
-	if (!IS_ERR(priv->clk))
-		clk_disable_unprepare(priv->clk);
+	clk_disable_unprepare(priv->clk);
 	sdhci_pltfm_free(pdev);
 	return ret;
 }
@@ -131,8 +130,7 @@ static int sdhci_dove_remove(struct platform_device *pdev)
 
 	sdhci_pltfm_unregister(pdev);
 
-	if (!IS_ERR(priv->clk))
-		clk_disable_unprepare(priv->clk);
+	clk_disable_unprepare(priv->clk);
 
 	return 0;
 }
-- 
1.9.3

