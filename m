From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [RFC 1/6] dmaengine: core: Allow NULL mask pointer in __dma_device_satisfies_mask()
Date: Fri, 27 Nov 2015 10:29:37 +0200
Message-ID: <1448612982-28141-2-git-send-email-peter.ujfalusi@ti.com>
References: <1448612982-28141-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448612982-28141-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, arnd@arndb.de, andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, nsekhar@ti.com
List-Id: linux-mmc@vger.kernel.org

Treat as true condition the case when the mask is NULL.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/dma/dmaengine.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index daf54a39bcc7..52c3eee48e2e 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -184,6 +184,9 @@ __dma_device_satisfies_mask(struct dma_device *device,
 {
 	dma_cap_mask_t has;
 
+	if (!want)
+		return true;
+
 	bitmap_and(has.bits, want->bits, device->cap_mask.bits,
 		DMA_TX_TYPE_END);
 	return bitmap_equal(want->bits, has.bits, DMA_TX_TYPE_END);
-- 
2.6.3
