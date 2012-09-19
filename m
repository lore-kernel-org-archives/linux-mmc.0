From: Kevin Liu <keyuan.liu@gmail.com>
Subject: [PATCH 1/6] mmc: sdhci-pxav3: fix build error
Date: Wed, 19 Sep 2012 10:12:37 +0800
Message-ID: <1348020762-12932-2-git-send-email-keyuan.liu@gmail.com>
References: <1348020762-12932-1-git-send-email-keyuan.liu@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:33252 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753224Ab2ISCSE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Sep 2012 22:18:04 -0400
In-Reply-To: <1348020762-12932-1-git-send-email-keyuan.liu@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu
Cc: hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

From: Kevin Liu <kliu5@marvell.com>

Commit 18c75479 introduced build error with slot-gpio.h missing
and pdata undeclared

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci-pxav3.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 223a5d4..f69d6c1 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -30,6 +30,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/mmc/slot-gpio.h>
 
 #include "sdhci.h"
 #include "sdhci-pltfm.h"
@@ -317,6 +318,7 @@ static int __devexit sdhci_pxav3_remove(struct platform_device *pdev)
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_pxa *pxa = pltfm_host->priv;
+	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
 
 	sdhci_remove_host(host, 1);
 
-- 
1.7.0.4

