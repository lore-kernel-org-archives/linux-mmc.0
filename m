From: dragos.tatulea@intel.com
Subject: [PATCH v2 20/26] mmc: sdhci: panic write: no tuning
Date: Thu,  8 Nov 2012 15:06:18 +0200
Message-ID: <1352379984-18381-21-git-send-email-dragos.tatulea@intel.com>
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
 drivers/mmc/host/sdhci.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index fcedcec..e096526 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1794,6 +1794,10 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	int err = 0;
 	bool requires_tuning_nonuhs = false;
 
+	/* Tuning may need a timer so it is not supported by the panic task */
+	if (mmc_am_panic_task(mmc))
+		return -EINVAL;
+
 	host = mmc_priv(mmc);
 
 	sdhci_runtime_pm_get(host);
-- 
1.7.9.5
