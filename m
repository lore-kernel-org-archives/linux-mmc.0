From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V2 06/54] mmc: sdhci-pci: Do not runtime suspend at the end of sdhci_pci_probe()
Date: Wed, 29 Jun 2016 16:24:19 +0300
Message-ID: <1467206707-30185-7-git-send-email-adrian.hunter@intel.com>
References: <1467206707-30185-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:35817 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751982AbcF2N3m (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 29 Jun 2016 09:29:42 -0400
In-Reply-To: <1467206707-30185-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>

At the successful conclusion of sdhci_pci_probe(), if runtime pm was
allowed, the device would be runtime suspended.  That wastes a lot of time
during initialization.  Instead leave the device active until the mmc core
scans for a card.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 5b03a7ecc6c9..6fbf7086d0b0 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1768,11 +1768,12 @@ static void sdhci_pci_remove_slot(struct sdhci_pci_slot *slot)
 
 static void sdhci_pci_runtime_pm_allow(struct device *dev)
 {
-	pm_runtime_put_noidle(dev);
-	pm_runtime_allow(dev);
+	pm_suspend_ignore_children(dev, 1);
 	pm_runtime_set_autosuspend_delay(dev, 50);
 	pm_runtime_use_autosuspend(dev);
-	pm_suspend_ignore_children(dev, 1);
+	pm_runtime_allow(dev);
+	/* Stay active until mmc core scans for a card */
+	pm_runtime_put_noidle(dev);
 }
 
 static void sdhci_pci_runtime_pm_forbid(struct device *dev)
-- 
1.9.1

