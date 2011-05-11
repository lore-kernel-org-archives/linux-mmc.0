From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] dw_mmc: fixed wrong regulator_enable in suspend/resume
Date: Wed, 11 May 2011 15:52:39 +0900
Message-ID: <4DCA3237.3080609@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:49070 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754477Ab1EKRCy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 May 2011 13:02:54 -0400
Received: from epcpsbgm1.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LL0003LQR3JFZ90@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 11 May 2011 15:52:32 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LL000I0OR3K5L@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 11 May 2011 15:52:32 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, will.newton@imgtec.com, Kyungmin Park <kyungmin.park@samsung.com>

In suspend function, regulator_enable() need not.
regulator_enable() should be locate in resume function.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 87e1f57..66dcddb 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1769,9 +1769,6 @@ static int dw_mci_suspend(struct platform_device *pdev, pm_message_t mesg)
 	int i, ret;
 	struct dw_mci *host = platform_get_drvdata(pdev);
 
-	if (host->vmmc)
-		regulator_enable(host->vmmc);
-
 	for (i = 0; i < host->num_slots; i++) {
 		struct dw_mci_slot *slot = host->slot[i];
 		if (!slot)
@@ -1798,6 +1795,9 @@ static int dw_mci_resume(struct platform_device *pdev)
 	int i, ret;
 	struct dw_mci *host = platform_get_drvdata(pdev);
 
+	if (host->vmmc)
+		regulator_enable(host->vmmc);
+
 	if (host->dma_ops->init)
 		host->dma_ops->init(host);
 
