From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH] mmc: sdhci: switch voltage before sdhci_set_ios in runtime resume
Date: Thu, 29 Jan 2015 17:42:12 +0800
Message-ID: <1422524532-4275-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:23851 "EHLO
	mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753751AbbA2Jpe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 29 Jan 2015 04:45:34 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, ulf.hansson@linaro.org, sebastian.hesselbarth@gmail.com
Cc: thomas.petazzoni@free-electrons.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jisheng Zhang <jszhang@marvell.com>

I observed the Host Control2 register isn't correctly restored
after runtime resuming on BG2Q. For example, the register reads
as 0x800c before runtime suspend, but it's set as 0x8004 after runtime
resuming. This could results in a non working host.

The reason is the Host Control2 is incorrectly reset when switching
voltage. We fix this by following the same sequence during initialization.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/mmc/host/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c9881ca..0ad412a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2871,9 +2871,9 @@ int sdhci_runtime_resume_host(struct sdhci_host *host)
 	/* Force clock and power re-program */
 	host->pwr = 0;
 	host->clock = 0;
+	sdhci_do_start_signal_voltage_switch(host, &host->mmc->ios);
 	sdhci_do_set_ios(host, &host->mmc->ios);
 
-	sdhci_do_start_signal_voltage_switch(host, &host->mmc->ios);
 	if ((host_flags & SDHCI_PV_ENABLED) &&
 		!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN)) {
 		spin_lock_irqsave(&host->lock, flags);
-- 
2.1.4

