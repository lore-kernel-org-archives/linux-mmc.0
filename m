From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 02/25] mmc: sdhci-pci: Do not disable interrupts in sdhci_intel_set_power
Date: Mon, 20 Mar 2017 19:50:30 +0200
Message-ID: <1490032253-6030-3-git-send-email-adrian.hunter@intel.com>
References: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:11845 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755699AbdCTSAJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 20 Mar 2017 14:00:09 -0400
In-Reply-To: <1490032253-6030-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Al Cooper <alcooperx@gmail.com>, Jaedon Shin <jaedon.shin@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Shawn Lin <shawn.lin@rock-chips.com>, Douglas Anderson <dianders@chromium.org>, Zach Brown <zach.brown@ni.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Jisheng Zhang <jszhang@marvell.com>, Yangbo Lu <yangbo.lu@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Weijun Yang <Weijun.Yang@csr.com>, Barry Song <Baohua.Song@csr.com>, Peter Griffin <peter.griffin@linaro.org>, Lee Jones <lee.jones@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Harjani Ritesh <riteshh@codeaurora.org>

Disabling interrupts for even a millisecond can cause problems for some
devices. That can happen when Intel host controllers wait for the present
state to propagate.

The spin lock is not necessary here. Anything that is racing with changes
to the I/O state is already broken. The mmc core already provides
synchronization via "claiming" the host.

Although the spin lock probably should be removed from the code paths that
lead to this point, such a patch would touch too much code to be suitable
for stable trees. Consequently, for this patch, just drop the spin lock
while waiting.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org # v4.9+
---
 drivers/mmc/host/sdhci-pci-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 982b3e349426..86560d590786 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -451,6 +451,8 @@ static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
 	if (mode == MMC_POWER_OFF)
 		return;
 
+	spin_unlock_irq(&host->lock);
+
 	/*
 	 * Bus power might not enable after D3 -> D0 transition due to the
 	 * present state not yet having propagated. Retry for up to 2ms.
@@ -463,6 +465,8 @@ static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
 		reg |= SDHCI_POWER_ON;
 		sdhci_writeb(host, reg, SDHCI_POWER_CONTROL);
 	}
+
+	spin_lock_irq(&host->lock);
 }
 
 static const struct sdhci_ops sdhci_intel_byt_ops = {
-- 
1.9.1

