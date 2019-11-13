From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] mmc: atmel-mci: Use dma_request_chan() directly for channel request
Date: Wed, 13 Nov 2019 11:36:15 +0200
Message-ID: <20191113093616.32474-2-peter.ujfalusi@ti.com>
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
 drivers/mmc/host/atmel-mci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 34c992d87529..6f065bb5c55a 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2347,8 +2347,7 @@ static void atmci_cleanup_slot(struct atmel_mci_slot *slot,
 
 static int atmci_configure_dma(struct atmel_mci *host)
 {
-	host->dma.chan = dma_request_slave_channel_reason(&host->pdev->dev,
-							"rxtx");
+	host->dma.chan = dma_request_chan(&host->pdev->dev, "rxtx");
 
 	if (PTR_ERR(host->dma.chan) == -ENODEV) {
 		struct mci_platform_data *pdata = host->pdev->dev.platform_data;
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
