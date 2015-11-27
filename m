From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC 4/6] dmaengine: edma: Add support for DMA filter mapping to slave devices
Date: Fri, 27 Nov 2015 10:29:40 +0200
Message-ID: <1448612982-28141-5-git-send-email-peter.ujfalusi@ti.com>
References: <1448612982-28141-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448612982-28141-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, arnd@arndb.de, andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, nsekhar@ti.com
List-Id: linux-mmc@vger.kernel.org

Add support for providing device to filter_fn mapping so client drivers
can switch to use the dma_request_chan() API.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/edma.c                 | 6 ++++++
 include/linux/platform_data/edma.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 0675e268d577..587ceb9308b3 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -2297,6 +2297,12 @@ static int edma_probe(struct platform_device *pdev)
 		edma_set_chmap(&ecc->slave_chans[i], ecc->dummy_slot);
 	}
 
+	if (info->devnames) {
+		ecc->dma_slave.filter_map.devnames = info->devnames;
+		ecc->dma_slave.filter_map.devcnt = info->devcnt;
+		ecc->dma_slave.filter_map.filter_fn = edma_filter_fn;
+	}
+
 	ret = dma_async_device_register(&ecc->dma_slave);
 	if (ret) {
 		dev_err(dev, "slave ddev registration failed (%d)\n", ret);
diff --git a/include/linux/platform_data/edma.h b/include/linux/platform_data/edma.h
index e2878baeb90e..58a4dcba0bdf 100644
--- a/include/linux/platform_data/edma.h
+++ b/include/linux/platform_data/edma.h
@@ -76,6 +76,9 @@ struct edma_soc_info {
 
 	s8	(*queue_priority_mapping)[2];
 	const s16	(*xbar_chans)[2];
+
+	char **devnames;
+	int devcnt;
 };
 
 #endif
-- 
2.6.3
