From: dragos.tatulea@intel.com
Subject: [PATCH v2 19/26] mmc: sdhci: panic write: no runtime pm
Date: Thu,  8 Nov 2012 15:06:17 +0200
Message-ID: <1352379984-18381-20-git-send-email-dragos.tatulea@intel.com>
References: <1352379984-18381-1-git-send-email-dragos.tatulea@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352379984-18381-1-git-send-email-dragos.tatulea@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: kirill.shutemov@linux.intel.com, irina.tirdea@intel.com, octavian.purdila@intel.com, tony.luck@intel.com, keescook@chromium.org, dragos.tatulea@gmail.com, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 drivers/mmc/host/sdhci.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 3653494..fcedcec 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2601,11 +2601,17 @@ EXPORT_SYMBOL_GPL(sdhci_enable_irq_wakeups);
 
 static int sdhci_runtime_pm_get(struct sdhci_host *host)
 {
+	if (mmc_am_panic_task(host->mmc))
+		return 0;
+
 	return pm_runtime_get_sync(host->mmc->parent);
 }
 
 static int sdhci_runtime_pm_put(struct sdhci_host *host)
 {
+	if (mmc_am_panic_task(host->mmc))
+		return 0;
+
 	pm_runtime_mark_last_busy(host->mmc->parent);
 	return pm_runtime_put_autosuspend(host->mmc->parent);
 }
-- 
1.7.9.5
