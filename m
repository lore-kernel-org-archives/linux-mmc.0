From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC v03 04/15] dmaengine: edma: Add support for DMA filter mapping
 to slave devices
Date: Wed, 2 Dec 2015 15:59:14 +0200
Message-ID: <1449064765-27427-5-git-send-email-peter.ujfalusi@ti.com>
References: <1449064765-27427-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449064765-27427-1-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: vinod.koul@intel.com, arnd@arndb.de, andy.shevchenko@gmail.com
Cc: tony@atomide.com, linux-mmc@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Add support for providing device to filter_fn mapping so client drivers
can switch to use the dma_request_chan() API.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c                 | 6 ++++++
 include/linux/platform_data/edma.h | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 0675e268d577..46b305ea0d21 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -2297,6 +2297,12 @@ static int edma_probe(struct platform_device *pdev)
 		edma_set_chmap(&ecc->slave_chans[i], ecc->dummy_slot);
 	}
 
+	if (info->slave_map) {
+		ecc->dma_slave.filter_map.map = info->slave_map;
+		ecc->dma_slave.filter_map.mapcnt = info->slavecnt;
+		ecc->dma_slave.filter_map.filter_fn = edma_filter_fn;
+	}
+
 	ret = dma_async_device_register(&ecc->dma_slave);
 	if (ret) {
 		dev_err(dev, "slave ddev registration failed (%d)\n", ret);
diff --git a/include/linux/platform_data/edma.h b/include/linux/platform_data/edma.h
index e2878baeb90e..4e78a946e0c1 100644
--- a/include/linux/platform_data/edma.h
+++ b/include/linux/platform_data/edma.h
@@ -53,12 +53,16 @@ enum dma_event_q {
 #define EDMA_CTLR(i)			((i) >> 16)
 #define EDMA_CHAN_SLOT(i)		((i) & 0xffff)
 
+#define EDMA_FILTER_PARAM(ctlr, chan)	((int[]) { EDMA_CTLR_CHAN(ctlr, chan) })
+
 struct edma_rsv_info {
 
 	const s16	(*rsv_chans)[2];
 	const s16	(*rsv_slots)[2];
 };
 
+struct dma_filter_map;
+
 /* platform_data for EDMA driver */
 struct edma_soc_info {
 	/*
@@ -76,6 +80,9 @@ struct edma_soc_info {
 
 	s8	(*queue_priority_mapping)[2];
 	const s16	(*xbar_chans)[2];
+
+	const struct dma_filter_map *slave_map;
+	int slavecnt;
 };
 
 #endif
-- 
2.6.3
