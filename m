From: dragos.tatulea@intel.com
Subject: [PATCH v2 24/26] mmc: sdhci: panic write: abort request in progress
Date: Thu,  8 Nov 2012 15:06:22 +0200
Message-ID: <1352379984-18381-25-git-send-email-dragos.tatulea@intel.com>
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
 drivers/mmc/host/sdhci.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 496adc8..9a24417 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1351,6 +1351,11 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	sdhci_lock_irqsave(host, flags);
 
+	if (mmc_am_panic_task(mmc) && host->mrq) {
+		host->mrq->cmd->error = -EILSEQ;
+		sdhci_sched_tasklet(host, finish);
+	}
+
 	WARN_ON(host->mrq != NULL);
 
 #ifndef SDHCI_USE_LEDS_CLASS
-- 
1.7.9.5
