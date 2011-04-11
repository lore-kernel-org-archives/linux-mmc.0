From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v4] mmc: sdhci: add error checking for mmc_add_host
Date: Mon, 11 Apr 2011 11:11:08 +0900
Message-ID: <4DA2633C.5000103@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:46128 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753671Ab1DKCNS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 10 Apr 2011 22:13:18 -0400
Received: from epmmp1 (mailout4.samsung.com [203.254.224.34])
 by mailout4.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LJG00LDVU5GPH30@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 11 Apr 2011 11:12:52 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LJG001EMU5GTM@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 11 Apr 2011 11:12:52 +0900 (KST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Chris Ball <cjb@laptop.org>, Wolfram Sang <w.sang@pengutronix.de>, Kyungmin Park <kyungmin.park@samsung.com>

Sometimes we can't add the device,but we didn't check any error status.
Need to check error status for mmc_add_host.
And Missing regulator disable/put. Fixed them.

[PATCH v4] : merged for v3 [PATCH 1/2] and [PATCH 2/2] reviewed on Wolfram Sang


Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/mmc/host/sdhci.c |   22 ++++++++++++++++++++--
 1 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 9e15f41..e9cb09c 100644
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
@@ -2036,15 +2038,31 @@ int sdhci_add_host(struct sdhci_host *host)
 
 	return 0;
 
+err_free_mmc:
+	mmc_remove_host(host);
+
 #ifdef SDHCI_USE_LEDS_CLASS
+	led_classdev_ungregister(&host->led);
 reset:
+#endif
 	sdhci_reset(host, SDHCI_RESET_ALL);
 	free_irq(host->irq, host);
-#endif
+	del_timer_sync(&host->timer);
+	if (host->vmmc) {
+		regulator_disable(host->vmmc);
+		regulator_put(host->vmmc);
+	}
+
 untasklet:
 	tasklet_kill(&host->card_tasklet);
 	tasklet_kill(&host->finish_tasklet);
 
+	kfree(host->adma_desc);
+	kfree(host->align_buffer);
+
+	host->adma_desc = NULL;
+	host->align_buffer = NULL;
+
 	return ret;
 }
 
