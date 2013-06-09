From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/6] mmc: jz4740: Use SIMPLE_DEV_PM_OPS
Date: Sun,  9 Jun 2013 21:10:03 +0200
Message-ID: <1370805005-8104-4-git-send-email-lars@metafoo.de>
References: <1370805005-8104-1-git-send-email-lars@metafoo.de>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-out-250.synserver.de ([212.40.185.250]:1036 "EHLO
	smtp-out-250.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488Ab3FITG4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 9 Jun 2013 15:06:56 -0400
In-Reply-To: <1370805005-8104-1-git-send-email-lars@metafoo.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Paul Cercueil <paul@crapouillou.net>, Maarten ter Huurne <maarten@treewalker.org>, linux-mmc@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>

It's a bit shorter than open-conding it. While we are at it also make
jz4740_mmc_pm_ops static.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/mmc/host/jz4740_mmc.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/jz4740_mmc.c b/drivers/mmc/host/jz4740_mmc.c
index 3f86592..c97ef6d 100644
--- a/drivers/mmc/host/jz4740_mmc.c
+++ b/drivers/mmc/host/jz4740_mmc.c
@@ -967,7 +967,7 @@ static int jz4740_mmc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM
+#ifdef CONFIG_PM_SLEEP
 
 static int jz4740_mmc_suspend(struct device *dev)
 {
@@ -991,13 +991,8 @@ static int jz4740_mmc_resume(struct device *dev)
 	return 0;
 }
 
-const struct dev_pm_ops jz4740_mmc_pm_ops = {
-	.suspend	= jz4740_mmc_suspend,
-	.resume		= jz4740_mmc_resume,
-	.poweroff	= jz4740_mmc_suspend,
-	.restore	= jz4740_mmc_resume,
-};
-
+static SIMPLE_DEV_PM_OPS(jz4740_mmc_pm_ops, jz4740_mmc_suspend,
+	jz4740_mmc_resume);
 #define JZ4740_MMC_PM_OPS (&jz4740_mmc_pm_ops)
 #else
 #define JZ4740_MMC_PM_OPS NULL
-- 
1.8.2.1

