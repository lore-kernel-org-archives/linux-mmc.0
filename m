From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 03/14] mmc: add a need_kmap flag to struct mmc_host
Date: Tue, 12 Feb 2019 08:25:17 +0100
Message-ID: <20190212072528.13167-4-hch@lst.de>
References: <20190212072528.13167-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190212072528.13167-1-hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Nicolas Pitre <nico@fluxnic.net>, linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, Ben Dooks <ben-linux@fluff.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

If we want to get rid of the block layer bounce buffering for highmem we
need to ensure no segment spans multiple pages so that we can kmap it.
Add a flag to struct mmc_host so that we can handle the block and DMA
layer interactions in common code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mmc/core/queue.c | 13 +++++++++++++
 include/linux/mmc/host.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index 35cc138b096d..71cd2411329e 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -370,6 +370,19 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
 	blk_queue_max_segments(mq->queue, host->max_segs);
 	blk_queue_max_segment_size(mq->queue, host->max_seg_size);
 
+	/*
+	 * If the host requires kmapping for PIO we need to ensure
+	 * that no segment spans a page boundary.
+	 */
+	if (host->need_kmap) {
+		unsigned int dma_boundary = host->max_seg_size - 1;
+
+		if (dma_boundary >= PAGE_SIZE)
+			dma_boundary = PAGE_SIZE - 1;
+		blk_queue_segment_boundary(mq->queue, dma_boundary);
+		dma_set_seg_boundary(mmc_dev(host), dma_boundary);
+	}
+
 	INIT_WORK(&mq->recovery_work, mmc_mq_recovery_handler);
 	INIT_WORK(&mq->complete_work, mmc_blk_mq_complete_work);
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 4eadf01b4a93..87f8a89d2f70 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -397,6 +397,7 @@ struct mmc_host {
 	unsigned int		doing_retune:1;	/* re-tuning in progress */
 	unsigned int		retune_now:1;	/* do re-tuning at next req */
 	unsigned int		retune_paused:1; /* re-tuning is temporarily disabled */
+	unsigned int		need_kmap:1;	/* only allow single page segments */
 
 	int			rescan_disable;	/* disable card detection */
 	int			rescan_entered;	/* used with nonremovable devices */
-- 
2.20.1
