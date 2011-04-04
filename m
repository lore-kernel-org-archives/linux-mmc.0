From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v2] mmc: sdhci: add error checking for mmc_add_host
Date: Mon, 04 Apr 2011 15:07:02 +0900
Message-ID: <4D996006.9030402@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:60677 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654Ab1DDGIu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2011 02:08:50 -0400
Received: from epmmp2 (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LJ400F7J6E4QPF0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 04 Apr 2011 15:08:28 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LJ400IES6E4WX@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 04 Apr 2011 15:08:28 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, Kyungmin Park <kyungmin.park@samsung.com>

Sometimes we can't add the device,but we didn't check any error status.
Need to check error status for mmc_add_host.

Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/sdhci.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9e15f41..7070716 100644
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
@@ -2036,11 +2038,19 @@ int sdhci_add_host(struct sdhci_host *host)
 
 	return 0;
 
+err_free_mmc:
+	mmc_free_host(host);
+
 #ifdef SDHCI_USE_LEDS_CLASS
 reset:
+#endif
 	sdhci_reset(host, SDHCI_RESET_ALL);
 	free_irq(host->irq, host);
-#endif
+	if (host->vmmc) {
+		regulator_disable(host->vmmc);
+		regulator_put(host->vmmc);
+	}
+
 untasklet:
 	tasklet_kill(&host->card_tasklet);
 	tasklet_kill(&host->finish_tasklet);
