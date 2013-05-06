From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 17/22] mmc: sdhci-pxa: remove unnecessary platform_set_drvdata()
Date: Mon, 06 May 2013 15:34:00 +0900
Message-ID: <005c01ce4a23$b1d43bb0$157cb310$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:16276 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117Ab3EFGeC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 May 2013 02:34:02 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MMD0087O68GMVH0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 06 May 2013 15:34:01 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, 'Kevin Liu' <kliu5@marvell.com>

The driver core clears the driver data to NULL after device_release
or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
(device-core: Ensure drvdata = NULL when no driver is bound).
Thus, it is not needed to manually clear the device driver data to NULL.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/mmc/host/sdhci-pxav2.c |    2 --
 drivers/mmc/host/sdhci-pxav3.c |    2 --
 2 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index 6a3f702..98b5145 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -253,8 +253,6 @@ static int sdhci_pxav2_remove(struct platform_device *pdev)
 	sdhci_pltfm_free(pdev);
 	kfree(pxa);
 
-	platform_set_drvdata(pdev, NULL);
-
 	return 0;
 }
 
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 1ae358e..90ee262 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -339,8 +339,6 @@ static int sdhci_pxav3_remove(struct platform_device *pdev)
 	sdhci_pltfm_free(pdev);
 	kfree(pxa);
 
-	platform_set_drvdata(pdev, NULL);
-
 	return 0;
 }
 
-- 
1.7.2.5


