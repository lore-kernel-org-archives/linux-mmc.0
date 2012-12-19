From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH 2/3] mmc: sdhci: add wake up support
Date: Wed, 19 Dec 2012 19:56:55 +0800
Message-ID: <1355918216-28213-3-git-send-email-kliu5@marvell.com>
References: <1355918216-28213-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog137.obsmtp.com ([74.125.149.18]:51433 "EHLO
	na3sys009aog137.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752286Ab2LSL5Y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Dec 2012 06:57:24 -0500
In-Reply-To: <1355918216-28213-1-git-send-email-kliu5@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Philip Rakity <prakity@nvidia.com>, Aaron Lu <aaron.lu@amd.com>, Shawn Guo <shawn.guo@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Adrian Hunter <adrian.hunter@intel.com>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Jaehoon Chung <jh80.chung@samsung.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Al Cooper <acooper@gmail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>Cha

Not to disable SD Host IRQ during suspend if it is wake up source.
Enable wakeup event during suspend.

Signed-off-by: Jialing Fu <jlfu@marvell.com>
Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |   60 ++++++++++++++++++++++++++++++++-------------
 1 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 089182e..04af0fd 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2455,6 +2455,32 @@ out:
 \*****************************************************************************/
 
 #ifdef CONFIG_PM
+void sdhci_enable_irq_wakeups(struct sdhci_host *host)
+{
+	u8 val;
+	u8 mask = SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE
+			| SDHCI_WAKE_ON_INT;
+
+	val = sdhci_readb(host, SDHCI_WAKE_UP_CONTROL);
+	val |= mask ;
+	/* Avoid fake wake up */
+	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
+		val &= ~(SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE);
+	sdhci_writeb(host, val, SDHCI_WAKE_UP_CONTROL);
+}
+EXPORT_SYMBOL_GPL(sdhci_enable_irq_wakeups);
+
+void sdhci_disable_irq_wakeups(struct sdhci_host *host)
+{
+	u8 val;
+	u8 mask = SDHCI_WAKE_ON_INSERT | SDHCI_WAKE_ON_REMOVE
+			| SDHCI_WAKE_ON_INT;
+
+	val = sdhci_readb(host, SDHCI_WAKE_UP_CONTROL);
+	val &= ~mask;
+	sdhci_writeb(host, val, SDHCI_WAKE_UP_CONTROL);
+}
+EXPORT_SYMBOL_GPL(sdhci_disable_irq_wakeups);
 
 int sdhci_suspend_host(struct sdhci_host *host)
 {
@@ -2484,9 +2510,13 @@ int sdhci_suspend_host(struct sdhci_host *host)
 		return ret;
 	}
 
-	sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK);
-	free_irq(host->irq, host);
-
+	if (!device_may_wakeup(mmc_dev(host->mmc))) {
+		sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK);
+		free_irq(host->irq, host);
+	} else {
+		sdhci_enable_irq_wakeups(host);
+		enable_irq_wake(host->irq);
+	}
 	return ret;
 }
 
@@ -2501,10 +2531,15 @@ int sdhci_resume_host(struct sdhci_host *host)
 			host->ops->enable_dma(host);
 	}
 
-	ret = request_irq(host->irq, sdhci_irq, IRQF_SHARED,
-			  mmc_hostname(host->mmc), host);
-	if (ret)
-		return ret;
+	if (!device_may_wakeup(mmc_dev(host->mmc))) {
+		ret = request_irq(host->irq, sdhci_irq, IRQF_SHARED,
+				  mmc_hostname(host->mmc), host);
+		if (ret)
+			return ret;
+	} else {
+		sdhci_disable_irq_wakeups(host);
+		disable_irq_wake(host->irq);
+	}
 
 	if ((host->mmc->pm_flags & MMC_PM_KEEP_POWER) &&
 	    (host->quirks2 & SDHCI_QUIRK2_HOST_OFF_CARD_ON)) {
@@ -2532,17 +2567,6 @@ int sdhci_resume_host(struct sdhci_host *host)
 }
 
 EXPORT_SYMBOL_GPL(sdhci_resume_host);
-
-void sdhci_enable_irq_wakeups(struct sdhci_host *host)
-{
-	u8 val;
-	val = sdhci_readb(host, SDHCI_WAKE_UP_CONTROL);
-	val |= SDHCI_WAKE_ON_INT;
-	sdhci_writeb(host, val, SDHCI_WAKE_UP_CONTROL);
-}
-
-EXPORT_SYMBOL_GPL(sdhci_enable_irq_wakeups);
-
 #endif /* CONFIG_PM */
 
 #ifdef CONFIG_PM_RUNTIME
-- 
1.7.0.4

