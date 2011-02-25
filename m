From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 2/3] dw_mmc: support mmc power control with regulator
Date: Fri, 25 Feb 2011 11:08:14 +0900
Message-ID: <4D670F0E.7000800@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:37823 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756347Ab1BYCI7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Feb 2011 21:08:59 -0500
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LH500EP2HXQ3RA0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 25 Feb 2011 11:08:14 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LH500IAFHXRO0@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 25 Feb 2011 11:08:15 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: will.newton@imgtec.com, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

This patch is applied the power control with regulator.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/dw_mmc.c  |   25 +++++++++++++++++++++++++
 include/linux/mmc/dw_mmc.h |    2 ++
 2 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 46e5a89..338fedc 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -32,6 +32,7 @@
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/dw_mmc.h>
 #include <linux/bitops.h>
+#include <linux/regulator/consumer.h>
 
 #include "dw_mmc.h"
 
@@ -1438,6 +1439,13 @@ static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	}
 #endif /* CONFIG_MMC_DW_IDMAC */
 
+	host->vmmc = regulator_get(mmc_dev(mmc), "vmmc");
+	if (IS_ERR(host->vmmc)) {
+		printk(KERN_INFO "%s: no vmmc regulator found\n", mmc_hostname(mmc));
+		host->vmmc = NULL;
+	} else
+		regulator_enable(host->vmmc);
+
 	if (dw_mci_get_cd(mmc))
 		set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
 	else
@@ -1701,6 +1709,12 @@ err_dmaunmap:
 			  host->sg_cpu, host->sg_dma);
 	iounmap(host->regs);
 
+	if (host->vmmc) {
+		regulator_disable(host->vmmc);
+		regulator_put(host->vmmc);
+	}
+
+
 err_freehost:
 	kfree(host);
 	return ret;
@@ -1732,6 +1746,11 @@ static int __exit dw_mci_remove(struct platform_device *pdev)
 	if (host->use_dma && host->dma_ops->exit)
 		host->dma_ops->exit(host);
 
+	if (host->vmmc) {
+		regulator_disable(host->vmmc);
+		regulator_put(host->vmmc);
+	}
+
 	iounmap(host->regs);
 
 	kfree(host);
@@ -1762,6 +1781,9 @@ static int dw_mci_suspend(struct platform_device *pdev, pm_message_t mesg)
 		}
 	}
 
+	if (host->vmmc)
+		regulator_disable(host->vmmc);
+
 	return 0;
 }
 
@@ -1770,6 +1792,9 @@ static int dw_mci_resume(struct platform_device *pdev)
 	int i, ret;
 	struct dw_mci *host = platform_get_drvdata(pdev);
 
+	if (host->vmmc)
+		regulator_enable(host->vmmc);
+
 	for (i = 0; i < host->num_slots; i++) {
 		struct dw_mci_slot *slot = host->slot[i];
 		if (!slot)
diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
index 3f22c20..a39c497 100644
--- a/include/linux/mmc/dw_mmc.h
+++ b/include/linux/mmc/dw_mmc.h
@@ -151,6 +151,8 @@ struct dw_mci {
 
 	/* Workaround flags */
 	u32			quirks;
+
+	struct regulator	*vmmc;	/* Power regulator */
 };
 
 /* DMA ops for Internal/External DMAC interface */
