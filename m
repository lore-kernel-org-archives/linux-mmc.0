From: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: [RFC PATCH v5 8/8] mmc: renesas_sdhi: use multiple segments if
	possible
Date: Wed,  5 Jun 2019 20:11:54 +0900
Message-ID: <1559733114-4221-9-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1559733114-4221-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1559733114-4221-1-git-send-email-yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, robin.murphy-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

If the IOMMU driver has a capable for merging segments to
a segment strictly, this can expose the host->mmc->max_segs with
multiple segments to a block layer by using blk_queue_max_segments()
that mmc_setup_queue() calls. Notes that an sdio card may be
possible to use multiple segments with non page aligned size, so
that this will not expose multiple segments to avoid failing
dma_map_sg() every time.

Notes that on renesas_sdhi_sys_dmac, the max_segs value will change
from 32 to 512, but the sys_dmac can handle 512 segments, so that
this init_card ops is added on "TMIO_MMC_MIN_RCAR2" environment.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
---
 drivers/mmc/host/renesas_sdhi_core.c          | 27 +++++++++++++++++++++++++++
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  4 ++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index c5ee4a6..379cefa 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -20,6 +20,7 @@
 
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/iommu.h>
 #include <linux/kernel.h>
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
@@ -46,6 +47,8 @@
 #define SDHI_VER_GEN3_SD	0xcc10
 #define SDHI_VER_GEN3_SDMMC	0xcd10
 
+#define SDHI_MAX_SEGS_IN_IOMMU	512
+
 struct renesas_sdhi_quirks {
 	bool hs400_disabled;
 	bool hs400_4taps;
@@ -203,6 +206,28 @@ static void renesas_sdhi_clk_disable(struct tmio_mmc_host *host)
 	clk_disable_unprepare(priv->clk_cd);
 }
 
+static void renesas_sdhi_init_card(struct mmc_host *mmc, struct mmc_card *card)
+{
+	struct tmio_mmc_host *host = mmc_priv(mmc);
+
+	/*
+	 * If the IOMMU driver has a capable for merging segments to
+	 * a segment strictly, this can expose the host->mmc->max_segs with
+	 * multiple segments to a block layer by using blk_queue_max_segments()
+	 * that mmc_setup_queue() calls. Notes that an sdio card may be
+	 * possible to use multiple segments with non page aligned size, so
+	 * that this will not expose multiple segments to avoid failing
+	 * dma_map_sg() every time.
+	 */
+	if (host->pdata->max_segs < SDHI_MAX_SEGS_IN_IOMMU &&
+	    iommu_capable(host->pdev->dev.bus, IOMMU_CAP_MERGING) &&
+	    (mmc_card_mmc(card) || mmc_card_sd(card)))
+		host->mmc->max_segs = SDHI_MAX_SEGS_IN_IOMMU;
+	else
+		host->mmc->max_segs = host->pdata->max_segs ? :
+				      TMIO_DEFAULT_MAX_SEGS;
+}
+
 static int renesas_sdhi_card_busy(struct mmc_host *mmc)
 {
 	struct tmio_mmc_host *host = mmc_priv(mmc);
@@ -726,6 +751,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 
 	/* SDR speeds are only available on Gen2+ */
 	if (mmc_data->flags & TMIO_MMC_MIN_RCAR2) {
+		host->ops.init_card = renesas_sdhi_init_card;
+
 		/* card_busy caused issues on r8a73a4 (pre-Gen2) CD-less SDHI */
 		host->ops.card_busy = renesas_sdhi_card_busy;
 		host->ops.start_signal_voltage_switch =
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 751fe91..a442f86 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -11,6 +11,7 @@
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/io-64-nonatomic-hi-lo.h>
+#include <linux/iommu.h>
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
 #include <linux/mod_devicetable.h>
@@ -337,6 +338,9 @@ static int renesas_sdhi_internal_dmac_probe(struct platform_device *pdev)
 	/* value is max of SD_SECCNT. Confirmed by HW engineers */
 	dma_set_max_seg_size(dev, 0xffffffff);
 
+	if (iommu_capable(dev->bus, IOMMU_CAP_MERGING))
+		dma_set_iova_contiguous(dev, true);
+
 	return renesas_sdhi_probe(pdev, &renesas_sdhi_internal_dmac_dma_ops);
 }
 
-- 
2.7.4
