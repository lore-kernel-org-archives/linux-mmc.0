From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] mmc: sdhci: Avoid swiotlb buffer being full
Date: Mon, 27 Nov 2017 11:28:50 +0100
Message-ID: <1511778530-6761-1-git-send-email-ulf.hansson@linaro.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Linus <torvalds@linux-foundation.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Konrad Rzeszutek Wilk <konrad@kernel.org>, Jiri Slaby <jslaby@suse.cz>, "# v4 . 14+" <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

The commit de3ee99b097d ("mmc: Delete bounce buffer handling") deletes the
bounce buffer handling, but also causes the max_req_size for sdhci to be
increased, in case when max_segs == 1. This causes errors for sdhci-pci
Ricoh variant, about the swiotlb buffer to become full.

Fix the issue, by taking IO_TLB_SEGSIZE and IO_TLB_SHIFT into account when
deciding the max_req_size for sdhci.

Reported-by: Jiri Slaby <jslaby@suse.cz>
Fixes: de3ee99b097d ("mmc: Delete bounce buffer handling")
Cc: <stable@vger.kernel.org> # v4.14+
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Tested-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/mmc/host/sdhci.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2f14334..e9290a3 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -21,6 +21,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
 #include <linux/scatterlist.h>
+#include <linux/swiotlb.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
@@ -3651,22 +3652,29 @@ int sdhci_setup_host(struct sdhci_host *host)
 	spin_lock_init(&host->lock);
 
 	/*
+	 * Maximum number of sectors in one transfer. Limited by SDMA boundary
+	 * size (512KiB). Note some tuning modes impose a 4MiB limit, but this
+	 * is less anyway.
+	 */
+	mmc->max_req_size = 524288;
+
+	/*
 	 * Maximum number of segments. Depends on if the hardware
 	 * can do scatter/gather or not.
 	 */
-	if (host->flags & SDHCI_USE_ADMA)
+	if (host->flags & SDHCI_USE_ADMA) {
 		mmc->max_segs = SDHCI_MAX_SEGS;
-	else if (host->flags & SDHCI_USE_SDMA)
+	} else if (host->flags & SDHCI_USE_SDMA) {
 		mmc->max_segs = 1;
-	else /* PIO */
+		if (swiotlb_max_segment()) {
+			unsigned int max_req_size = (1 << IO_TLB_SHIFT) *
+						IO_TLB_SEGSIZE;
+			mmc->max_req_size = min(mmc->max_req_size,
+						max_req_size);
+		}
+	} else { /* PIO */
 		mmc->max_segs = SDHCI_MAX_SEGS;
-
-	/*
-	 * Maximum number of sectors in one transfer. Limited by SDMA boundary
-	 * size (512KiB). Note some tuning modes impose a 4MiB limit, but this
-	 * is less anyway.
-	 */
-	mmc->max_req_size = 524288;
+	}
 
 	/*
 	 * Maximum segment size. Could be one segment with the maximum number
-- 
2.7.4
