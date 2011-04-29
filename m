From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] dw_mmc: fixed regulator control
Date: Fri, 29 Apr 2011 19:19:41 +0900
Message-ID: <4DBA90BD.8070804@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:35970 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754247Ab1D2KWR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Apr 2011 06:22:17 -0400
Received: from epcpsbgm1.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LKE005AISSZ05R0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 29 Apr 2011 19:22:15 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LKE0029ZST207@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 29 Apr 2011 19:22:14 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, will.newton@imgtec.com, Kyungmin Park <kyungmin.park@samsung.com>

This patch fixed regulator control in dw_mmc.c
If we didn't set CONFIG_REGULATOR, always entered error condition.
But that's not error..because we didn't use regulator framework.

So when we only used CONFIG_REGULATOR, i think that need to get regulator.

And In suspend function, regulator_enable() need not..
need that in resume function.
(i didn't know why located there...)

Thanks,
Jaehoon Chung

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyumgmin.park@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 87e1f57..62b900f 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1441,12 +1441,14 @@ static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	}
 #endif /* CONFIG_MMC_DW_IDMAC */
 
+#ifdef CONFIG_REGULATOR
 	host->vmmc = regulator_get(mmc_dev(mmc), "vmmc");
 	if (IS_ERR(host->vmmc)) {
 		printk(KERN_INFO "%s: no vmmc regulator found\n", mmc_hostname(mmc));
 		host->vmmc = NULL;
 	} else
 		regulator_enable(host->vmmc);
+#endif /* CONFIG_REGULATOR */
 
 	if (dw_mci_get_cd(mmc))
 		set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
@@ -1769,9 +1771,6 @@ static int dw_mci_suspend(struct platform_device *pdev, pm_message_t mesg)
 	int i, ret;
 	struct dw_mci *host = platform_get_drvdata(pdev);
 
-	if (host->vmmc)
-		regulator_enable(host->vmmc);
-
 	for (i = 0; i < host->num_slots; i++) {
 		struct dw_mci_slot *slot = host->slot[i];
 		if (!slot)
@@ -1798,6 +1797,9 @@ static int dw_mci_resume(struct platform_device *pdev)
 	int i, ret;
 	struct dw_mci *host = platform_get_drvdata(pdev);
 
+	if (host->vmmc)
+		regulator_enable(host->vmmc);
+
 	if (host->dma_ops->init)
 		host->dma_ops->init(host);
 
