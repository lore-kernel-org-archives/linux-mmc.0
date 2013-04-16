From: <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/6] i2c: at91: convert to dma_request_slave_channel_compat()
Date: Tue, 16 Apr 2013 15:03:07 +0200
Message-ID: <1366117390-24686-4-git-send-email-ludovic.desroches@atmel.com>
References: <1366117390-24686-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1366117390-24686-1-git-send-email-ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org, Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>

Use generic DMA DT helper. Platforms booting with or without DT populated are
both supported.

Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 drivers/i2c/busses/i2c-at91.c | 49 ++++++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
index 75195e3..7ffd544 100644
--- a/drivers/i2c/busses/i2c-at91.c
+++ b/drivers/i2c/busses/i2c-at91.c
@@ -607,11 +607,16 @@ MODULE_DEVICE_TABLE(of, atmel_twi_dt_ids);
 #define atmel_twi_dt_ids NULL
 #endif
 
-static bool filter(struct dma_chan *chan, void *slave)
+static bool filter(struct dma_chan *chan, void *pdata)
 {
-	struct at_dma_slave *sl = slave;
+	struct at91_twi_pdata *sl_pdata = pdata;
+	struct at_dma_slave *sl;
 
-	if (sl->dma_dev == chan->device->dev) {
+	if (!sl_pdata)
+		return false;
+
+	sl = &sl_pdata->dma_slave;
+	if (sl && (sl->dma_dev == chan->device->dev)) {
 		chan->private = sl;
 		return true;
 	} else {
@@ -622,11 +627,10 @@ static bool filter(struct dma_chan *chan, void *slave)
 static int at91_twi_configure_dma(struct at91_twi_dev *dev, u32 phy_addr)
 {
 	int ret = 0;
-	struct at_dma_slave *sdata;
+	struct at91_twi_pdata *pdata = dev->pdata;
 	struct dma_slave_config slave_config;
 	struct at91_twi_dma *dma = &dev->dma;
-
-	sdata = &dev->pdata->dma_slave;
+	dma_cap_mask_t mask;
 
 	memset(&slave_config, 0, sizeof(slave_config));
 	slave_config.src_addr = (dma_addr_t)phy_addr + AT91_TWI_RHR;
@@ -637,25 +641,22 @@ static int at91_twi_configure_dma(struct at91_twi_dev *dev, u32 phy_addr)
 	slave_config.dst_maxburst = 1;
 	slave_config.device_fc = false;
 
-	if (sdata && sdata->dma_dev) {
-		dma_cap_mask_t mask;
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
 
-		dma_cap_zero(mask);
-		dma_cap_set(DMA_SLAVE, mask);
-		dma->chan_tx = dma_request_channel(mask, filter, sdata);
-		if (!dma->chan_tx) {
-			dev_err(dev->dev, "no DMA channel available for tx\n");
-			ret = -EBUSY;
-			goto error;
-		}
-		dma->chan_rx = dma_request_channel(mask, filter, sdata);
-		if (!dma->chan_rx) {
-			dev_err(dev->dev, "no DMA channel available for rx\n");
-			ret = -EBUSY;
-			goto error;
-		}
-	} else {
-		ret = -EINVAL;
+	dma->chan_tx = dma_request_slave_channel_compat(mask, filter, pdata,
+							dev->dev, "tx");
+	if (!dma->chan_tx) {
+		dev_err(dev->dev, "can't get a DMA channel for tx\n");
+		ret = -EBUSY;
+		goto error;
+	}
+
+	dma->chan_rx = dma_request_slave_channel_compat(mask, filter, pdata,
+							dev->dev, "rx");
+	if (!dma->chan_rx) {
+		dev_err(dev->dev, "can't get a DMA channel for rx\n");
+		ret = -EBUSY;
 		goto error;
 	}
 
-- 
1.7.11.3
