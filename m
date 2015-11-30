From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC v02 04/15] dmaengine: edma: Add support for DMA filter mapping
 to slave devices
Date: Mon, 30 Nov 2015 15:45:34 +0200
Message-ID: <1448891145-10766-5-git-send-email-peter.ujfalusi@ti.com>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: linux-mmc@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Add support for providing device to filter_fn mapping so client drivers
can switch to use the dma_request_chan() API.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c                 | 24 ++++++++++++++++++++++++
 include/linux/platform_data/edma.h |  5 +++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 0675e268d577..386f8c9bd606 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -2098,6 +2098,8 @@ static struct dma_chan *of_edma_xlate(struct of_phandle_args *dma_spec,
 }
 #endif
 
+static bool edma_filter_for_map(struct dma_chan *chan, void *param);
+
 static int edma_probe(struct platform_device *pdev)
 {
 	struct edma_soc_info	*info = pdev->dev.platform_data;
@@ -2297,6 +2299,12 @@ static int edma_probe(struct platform_device *pdev)
 		edma_set_chmap(&ecc->slave_chans[i], ecc->dummy_slot);
 	}
 
+	if (info->filter_map) {
+		ecc->dma_slave.filter_map.map = info->filter_map;
+		ecc->dma_slave.filter_map.mapcnt = info->filtercnt;
+		ecc->dma_slave.filter_map.filter_fn = edma_filter_for_map;
+	}
+
 	ret = dma_async_device_register(&ecc->dma_slave);
 	if (ret) {
 		dev_err(dev, "slave ddev registration failed (%d)\n", ret);
@@ -2428,6 +2436,22 @@ bool edma_filter_fn(struct dma_chan *chan, void *param)
 }
 EXPORT_SYMBOL(edma_filter_fn);
 
+static bool edma_filter_for_map(struct dma_chan *chan, void *param)
+{
+	bool match = false;
+
+	if (chan->device->dev->driver == &edma_driver.driver) {
+		struct edma_chan *echan = to_edma_chan(chan);
+		unsigned ch_req = (unsigned)param;
+		if (ch_req == echan->ch_num) {
+			/* The channel is going to be used as HW synchronized */
+			echan->hw_triggered = true;
+			match = true;
+		}
+	}
+	return match;
+}
+
 static int edma_init(void)
 {
 	int ret;
diff --git a/include/linux/platform_data/edma.h b/include/linux/platform_data/edma.h
index e2878baeb90e..117a36d63840 100644
--- a/include/linux/platform_data/edma.h
+++ b/include/linux/platform_data/edma.h
@@ -59,6 +59,8 @@ struct edma_rsv_info {
 	const s16	(*rsv_slots)[2];
 };
 
+struct dma_filter_map;
+
 /* platform_data for EDMA driver */
 struct edma_soc_info {
 	/*
@@ -76,6 +78,9 @@ struct edma_soc_info {
 
 	s8	(*queue_priority_mapping)[2];
 	const s16	(*xbar_chans)[2];
+
+	struct dma_filter_map *filter_map;
+	int filtercnt;
 };
 
 #endif
-- 
2.6.3
