From: Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH] mmc: sdhci: disable irq in sdhci host suspend ranther than free this irq
Date: Thu, 28 Jan 2016 17:42:26 +0800
Message-ID: <1453974146-20951-1-git-send-email-haibo.chen@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-db3on0060.outbound.protection.outlook.com ([157.55.234.60]:18228
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751138AbcA1KKS (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 28 Jan 2016 05:10:18 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: rmk+kernel@arm.linux.org.uk, haibo.chen@nxp.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Currently sdhci driver free irq in host suspend, and call
request_threaded_irq() in host resume. But during host resume,
Ctrl+C can impact sdhci host resume, see the error log:

CPU1 is up
PM: noirq resume of devices complete after 0.637 msecs imx-sdma 30bd0000.sdma: loaded firmware 4.1
PM: early resume of devices complete after 0.774 msecs
dpm_run_callback(): platform_pm_resume+0x0/0x44 returns -4
PM: Device 30b40000.usdhc failed to resume: error -4
dpm_run_callback(): platform_pm_resume+0x0/0x44 returns -4
PM: Device 30b50000.usdhc failed to resume: error -4
dpm_run_callback(): platform_pm_resume+0x0/0x44 returns -4
PM: Device 30b60000.usdhc failed to resume: error -4 fec 30be0000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx
mmc0: Timeout waiting for hardware interrupt.
mmc0: Timeout waiting for hardware interrupt.
mmc0: Timeout waiting for hardware interrupt.
mmc0: Timeout waiting for hardware interrupt.
mmc0: Timeout waiting for hardware interrupt.
mmc0: Timeout waiting for hardware interrupt.
mmc0: error -110 during resume (card was removed?)
mmc2: Timeout waiting for hardware interrupt.
mmc2: Timeout waiting for hardware interrupt.
mmc2: error -110 during resume (card was removed?)

In request_threaded_irq-> __setup_irq-> kthread_create
->kthread_create_on_node, the comment shows that SIGKILLed will
impact the kthread create, and return -EINTR.

This patch replace them with disable|enable_irq(), that will prevent
IRQs from being propagated to the sdhci driver.

Fixes: 781e989cf593 ("mmc: sdhci: convert to new SDIO IRQ handling")
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/mmc/host/sdhci.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index d622435..4b1646b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2686,7 +2686,7 @@ int sdhci_suspend_host(struct sdhci_host *host)
 		host->ier = 0;
 		sdhci_writel(host, 0, SDHCI_INT_ENABLE);
 		sdhci_writel(host, 0, SDHCI_SIGNAL_ENABLE);
-		free_irq(host->irq, host);
+		disable_irq(host->irq);
 	} else {
 		sdhci_enable_irq_wakeups(host);
 		enable_irq_wake(host->irq);
@@ -2698,8 +2698,6 @@ EXPORT_SYMBOL_GPL(sdhci_suspend_host);
 
 int sdhci_resume_host(struct sdhci_host *host)
 {
-	int ret = 0;
-
 	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
 		if (host->ops->enable_dma)
 			host->ops->enable_dma(host);
@@ -2718,11 +2716,7 @@ int sdhci_resume_host(struct sdhci_host *host)
 	}
 
 	if (!device_may_wakeup(mmc_dev(host->mmc))) {
-		ret = request_threaded_irq(host->irq, sdhci_irq,
-					   sdhci_thread_irq, IRQF_SHARED,
-					   mmc_hostname(host->mmc), host);
-		if (ret)
-			return ret;
+		enable_irq(host->irq);
 	} else {
 		sdhci_disable_irq_wakeups(host);
 		disable_irq_wake(host->irq);
@@ -2730,7 +2724,7 @@ int sdhci_resume_host(struct sdhci_host *host)
 
 	sdhci_enable_card_detection(host);
 
-	return ret;
+	return 0;
 }
 
 EXPORT_SYMBOL_GPL(sdhci_resume_host);
-- 
1.9.1

