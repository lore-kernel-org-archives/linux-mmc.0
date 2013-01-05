From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH] mmc: sdhci: disable interrupt before free_irq
Date: Sat,  5 Jan 2013 17:18:28 +0800
Message-ID: <1357377508-12043-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:57889 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754833Ab3AEJTz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 5 Jan 2013 04:19:55 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
Cc: Philip Rakity <prakity@nvidia.com>, Aaron Lu <aaron.lu@intel.com>, Shawn Guo <shawn.guo@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Adrian Hunter <adrian.hunter@intel.com>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Alexander Stein <alexander.stein@systec-electronic.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Jaehoon Chung <jh80.chung@samsung.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, key

Current code missed disabling interrupts before free irq which is shared.

Notice below comments for function free_irq (kernel/irq/manage.c):
On a shared IRQ the caller must ensure the interrupt is disabled
on the card it drives before calling this function.

Original code has below issue during suspend/resume when multiple SD hosts
share the same IRQ:
1. Assume there are two hosts (host1 for emmc while host2 for sd) share
the same mmc irq.
2. When system suspend, host2 will be suspended before host1.
So the sequence is below:
	step1: irq handler for host2 removed ->
	step2: irq handler for host1 removed and irq disabled ->
	... system suspended ...
	... system resumed ...
	step3: irq enabled and the irq handler for host1 restored ->
	step4: irq handler for host2 restored
3. So there is the buggy time slot that the irq is enabled but the irq handler
for host2 is removed. Then host2 interrupt can be triggered but can't be handled
at that moment.

Signed-off-by: Jialing Fu <jlfu@marvell.com>
Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/host/sdhci.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6f0bfc0..089182e 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2484,6 +2484,7 @@ int sdhci_suspend_host(struct sdhci_host *host)
 		return ret;
 	}
 
+	sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK);
 	free_irq(host->irq, host);
 
 	return ret;
@@ -3139,6 +3140,7 @@ int sdhci_add_host(struct sdhci_host *host)
 #ifdef SDHCI_USE_LEDS_CLASS
 reset:
 	sdhci_reset(host, SDHCI_RESET_ALL);
+	sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK);
 	free_irq(host->irq, host);
 #endif
 untasklet:
@@ -3181,6 +3183,7 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 	if (!dead)
 		sdhci_reset(host, SDHCI_RESET_ALL);
 
+	sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK);
 	free_irq(host->irq, host);
 
 	del_timer_sync(&host->timer);
-- 
1.7.9.5

