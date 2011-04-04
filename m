From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: sdhci: add error checking for mmc_add_host
Date: Mon, 04 Apr 2011 11:48:57 +0900
Message-ID: <4D993199.1060206@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:51767 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753679Ab1DDCuY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 3 Apr 2011 22:50:24 -0400
Received: from epmmp2 (mailout3.samsung.com [203.254.224.33])
 by mailout3.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LJ300JVHX7X4650@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 04 Apr 2011 11:50:21 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LJ3005UFX7YYE@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 04 Apr 2011 11:50:22 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

Sometimes we can't add the device,but we didn't check any error status.
Need to check error status for mmc_add_host.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/sdhci.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9e15f41..9c777bc 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2025,7 +2025,9 @@ int sdhci_add_host(struct sdhci_host *host)
 
 	mmiowb();
 
-	mmc_add_host(mmc);
+	ret = mmc_add_host(mmc);
+	if (unlikely(ret))
+		goto err_free_mmc;
 
 	printk(KERN_INFO "%s: SDHCI controller on %s [%s] using %s\n",
 		mmc_hostname(mmc), host->hw_name, dev_name(mmc_dev(mmc)),
@@ -2041,6 +2043,9 @@ reset:
 	sdhci_reset(host, SDHCI_RESET_ALL);
 	free_irq(host->irq, host);
 #endif
+err_free_mmc:
+	mmc_free_host(host);
+
 untasklet:
 	tasklet_kill(&host->card_tasklet);
 	tasklet_kill(&host->finish_tasklet);
