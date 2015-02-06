From: Kevin Hao <haokexin@gmail.com>
Subject: [PATCH 1/7] mmc: sdhci-dove: remove the unneeded error check
Date: Fri,  6 Feb 2015 11:15:16 +0800
Message-ID: <1423192522-6056-2-git-send-email-haokexin@gmail.com>
References: <1423192522-6056-1-git-send-email-haokexin@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yh0-f50.google.com ([209.85.213.50]:59913 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbbBFDPi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Feb 2015 22:15:38 -0500
Received: by mail-yh0-f50.google.com with SMTP id a41so785981yho.9
        for <linux-mmc@vger.kernel.org>; Thu, 05 Feb 2015 19:15:37 -0800 (PST)
In-Reply-To: <1423192522-6056-1-git-send-email-haokexin@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hao <haokexin@gmail.com>

The function clk_disable_unprepare() already take care of either error
or null cases.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
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

