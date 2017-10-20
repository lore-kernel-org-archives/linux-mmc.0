From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2 1/2] mmc: tmio: fix swiotlb buffer is full
Date: Fri, 20 Oct 2017 12:12:41 +0900
Message-ID: <1508469162-12322-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1508469162-12322-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1508469162-12322-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: wsa+renesas@sang-engineering.com, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-mmc@vger.kernel.org

Since the commit de3ee99b097d ("mmc: Delete bounce buffer handling")
deletes the bounce buffer handling, a request data size will be referred
to max_{req,seg}_size instead of MMC_QUEUE_BOUNCESZ (64k bytes).

In other hand, renesas_sdhi_internal_dmac.c will set very big value of
max_{req,seg}_size because the max_blk_count is set to 0xffffffff.
And then, "swiotlb buffer is full" happens because swiotlb can handle
a memory size up to 256k bytes only (IO_TLB_SEGSIZE = 128 and
IO_TLB_SHIFT = 11).

So, as a workaround, this patch avoids the issue by setting
the max_{req,seg}_size up to 256k bytes if swiotlb is running.

Reported-by: Dirk Behme <dirk.behme@de.bosch.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/mmc/host/tmio_mmc_core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index a7293e1..9c4e619 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -47,6 +47,7 @@
 #include <linux/mmc/sdio.h>
 #include <linux/scatterlist.h>
 #include <linux/spinlock.h>
+#include <linux/swiotlb.h>
 #include <linux/workqueue.h>
 
 #include "tmio_mmc.h"
@@ -1215,6 +1216,18 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 	mmc->max_blk_count = pdata->max_blk_count ? :
 		(PAGE_SIZE / mmc->max_blk_size) * mmc->max_segs;
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
+	/*
+	 * Since swiotlb has memory size limitation, this will calculate
+	 * the maximum size locally (because we don't have any APIs for it now)
+	 * and check the current max_req_size. And then, this will update
+	 * the max_req_size if needed as a workaround.
+	 */
+	if (swiotlb_max_segment()) {
+		unsigned int max_size = (1 << IO_TLB_SHIFT) * IO_TLB_SEGSIZE;
+
+		if (mmc->max_req_size > max_size)
+			mmc->max_req_size = max_size;
+	}
 	mmc->max_seg_size = mmc->max_req_size;
 
 	_host->native_hotplug = !(pdata->flags & TMIO_MMC_USE_GPIO_CD ||
-- 
1.9.1
