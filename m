From: Phil Elwell <phil@raspberrypi.org>
Subject: [PATCH] mmc: spi: disable dma mapping code, as it does not work
Date: Mon, 22 May 2017 10:09:23 +0100
Message-ID: <c73b9ba9-1699-2aff-e2fd-b4b4f292a3ca@raspberrypi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Martin Sperl <kernel@martin.sperl.org>, Heiner Kallweit <hkallweit1@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

since:
	commit 0589342c27944e50ebd7a54f5215002b6598b748
	Author: Rob Herring <rob.herring@calxeda.com>
	Date:   Tue Oct 29 23:36:46 2013 -0500

	     of: set dma_mask to point to coherent_dma_mask

	     Platform devices created by DT code don't initialize dma_mask pointer to
	     anything. Set it to coherent_dma_mask by default if the architecture
	     code has not set it.

the mmc-spi driver no longer detects the sd-cards any longer.

This patch disables the offending section in mmc_spi
so that the driver works again and detects the sd card normally.

There is no real negative impact as the spi-framework
does no longer rely on driver-provided DMA mappings but
maps the transfers transparently.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
Submitted-by: Phil Elwell <phil@raspberrypi.org>
---
 drivers/mmc/host/mmc_spi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index ae19d83bb9de0..16946e2513afa 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1387,6 +1387,16 @@ static int mmc_spi_probe(struct spi_device *spi)
 	if (!host->data)
 		goto fail_nobuf1;
 
+	/* for some reason mmc_spi does not work with this enabled
+	 * it is not needed anyway, as the SPI framework does DMA
+	 * transfers now automatically
+	 * the patch that introduced this was:
+	 * commit 0589342c27944e50ebd7a54f5215002b6598b748
+	 * Author: Rob Herring <rob.herring@calxeda.com>
+	 * Date:   Tue Oct 29 23:36:46 2013 -0500
+	 *      of: set dma_mask to point to coherent_dma_mask
+	 */
+#if 0
 	if (spi->master->dev.parent->dma_mask) {
 		struct device	*dev = spi->master->dev.parent;
 
@@ -1402,6 +1412,7 @@ static int mmc_spi_probe(struct spi_device *spi)
 				host->data_dma, sizeof(*host->data),
 				DMA_BIDIRECTIONAL);
 	}
+#endif
 
 	/* setup message for status/busy readback */
 	spi_message_init(&host->readback);
