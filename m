From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/2] mmc: moxart: Use dma_request_chan() directly for channel request
Date: Wed, 13 Nov 2019 11:36:16 +0200
Message-ID: <20191113093616.32474-3-peter.ujfalusi@ti.com>
References: <20191113093616.32474-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191113093616.32474-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, ludovic.desroches@microchip.com
Cc: vkoul@kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
List-Id: linux-mmc@vger.kernel.org

dma_request_slave_channel_reason() is:
#define dma_request_slave_channel_reason(dev, name) \
	dma_request_chan(dev, name)

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mmc/host/moxart-mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index a0670e9cd012..fc6b9cf27d0b 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -608,8 +608,8 @@ static int moxart_probe(struct platform_device *pdev)
 	host->timeout = msecs_to_jiffies(1000);
 	host->sysclk = clk_get_rate(clk);
 	host->fifo_width = readl(host->base + REG_FEATURE) << 2;
-	host->dma_chan_tx = dma_request_slave_channel_reason(dev, "tx");
-	host->dma_chan_rx = dma_request_slave_channel_reason(dev, "rx");
+	host->dma_chan_tx = dma_request_chan(dev, "tx");
+	host->dma_chan_rx = dma_request_chan(dev, "rx");
 
 	spin_lock_init(&host->lock);
 
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
