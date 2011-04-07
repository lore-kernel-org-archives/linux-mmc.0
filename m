From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: sdhci: fixed regulator control when suspend/resume
Date: Thu, 07 Apr 2011 13:23:52 +0900
Message-ID: <4D9D3C58.5030901@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:12114 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052Ab1DGEZ1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 Apr 2011 00:25:27 -0400
Received: from epmmp2 (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LJ90032ULMDRJ20@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 07 Apr 2011 13:25:25 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LJ900108LMDS5@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 07 Apr 2011 13:25:25 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

Suspend/resume is working always enable regulator after resuming. 
(if there is host->vmmc)
I assume that if regulator is enabled, card is inserted.
Then We need to restore "vmmc".

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/sdhci.c  |    8 +++++---
 include/linux/mmc/sdhci.h |    1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9e15f41..70cbbd6 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1663,8 +1663,10 @@ int sdhci_suspend_host(struct sdhci_host *host, pm_message_t state)
 
 	free_irq(host->irq, host);
 
-	if (host->vmmc)
+	if (host->vmmc && regulator_is_enabled(host->vmmc)) {
 		ret = regulator_disable(host->vmmc);
+		host->restore_vmmc = true;
+	}
 
 	return ret;
 }
@@ -1675,8 +1677,8 @@ int sdhci_resume_host(struct sdhci_host *host)
 {
 	int ret;
 
-	if (host->vmmc) {
-		int ret = regulator_enable(host->vmmc);
+	if (host->vmmc && host->restore_vmmc) {
+		ret = regulator_enable(host->vmmc);
 		if (ret)
 			return ret;
 	}
diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
index 83bd9f7..1c38261 100644
--- a/include/linux/mmc/sdhci.h
+++ b/include/linux/mmc/sdhci.h
@@ -92,6 +92,7 @@ struct sdhci_host {
 	const struct sdhci_ops *ops;	/* Low level hw interface */
 
 	struct regulator *vmmc;	/* Power regulator */
+	bool restore_vmmc;	/* Restore vmmc */
 
 	/* Internal data */
 	struct mmc_host *mmc;	/* MMC structure */
-- 
