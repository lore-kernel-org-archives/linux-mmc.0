From: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Subject: [RFC PATCH v2 14/16] spi: omap2-mcspi: convert to
	dma_request_slave_channel_compat()
Date: Thu, 11 Oct 2012 15:04:39 -0400
Message-ID: <1349982281-10785-15-git-send-email-mporter@ti.com>
References: <1349982281-10785-1-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1349982281-10785-1-git-send-email-mporter-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Convert dmaengine channel requests to use
dma_request_slave_channel_compat(). This supports the DT case of
platforms requiring channel selection from either the OMAP DMA or
the EDMA engine. AM33xx only boots from DT and is the only user
implementing EDMA so in the !DT case we can default to the OMAP DMA
filter.

Signed-off-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c |   65 ++++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 3542fdc..793ae8c 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -103,6 +103,9 @@ struct omap2_mcspi_dma {
 
 	struct completion dma_tx_completion;
 	struct completion dma_rx_completion;
+
+	char dma_rx_ch_name[14];
+	char dma_tx_ch_name[14];
 };
 
 /* use PIO for small transfers, avoiding DMA setup/teardown overhead and
@@ -819,14 +822,23 @@ static int omap2_mcspi_request_dma(struct spi_device *spi)
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 	sig = mcspi_dma->dma_rx_sync_dev;
-	mcspi_dma->dma_rx = dma_request_channel(mask, omap_dma_filter_fn, &sig);
+
+	mcspi_dma->dma_rx =
+		dma_request_slave_channel_compat(mask, omap_dma_filter_fn,
+						 &sig, &master->dev,
+						 mcspi_dma->dma_rx_ch_name);
+
 	if (!mcspi_dma->dma_rx) {
 		dev_err(&spi->dev, "no RX DMA engine channel for McSPI\n");
 		return -EAGAIN;
 	}
 
 	sig = mcspi_dma->dma_tx_sync_dev;
-	mcspi_dma->dma_tx = dma_request_channel(mask, omap_dma_filter_fn, &sig);
+	mcspi_dma->dma_tx =
+		dma_request_slave_channel_compat(mask, omap_dma_filter_fn,
+						 &sig, &master->dev,
+						 mcspi_dma->dma_tx_ch_name);
+
 	if (!mcspi_dma->dma_tx) {
 		dev_err(&spi->dev, "no TX DMA engine channel for McSPI\n");
 		dma_release_channel(mcspi_dma->dma_rx);
@@ -1217,29 +1229,42 @@ static int __devinit omap2_mcspi_probe(struct platform_device *pdev)
 		goto free_master;
 
 	for (i = 0; i < master->num_chipselect; i++) {
-		char dma_ch_name[14];
+		char *dma_rx_ch_name = mcspi->dma_channels[i].dma_rx_ch_name;
+		char *dma_tx_ch_name = mcspi->dma_channels[i].dma_tx_ch_name;
 		struct resource *dma_res;
 
-		sprintf(dma_ch_name, "rx%d", i);
-		dma_res = platform_get_resource_byname(pdev, IORESOURCE_DMA,
-							dma_ch_name);
-		if (!dma_res) {
-			dev_dbg(&pdev->dev, "cannot get DMA RX channel\n");
-			status = -ENODEV;
-			break;
-		}
+		sprintf(dma_rx_ch_name, "rx%d", i);
+		if (!pdev->dev.of_node) {
+			dma_res =
+				platform_get_resource_byname(pdev,
+							     IORESOURCE_DMA,
+							     dma_rx_ch_name);
+			if (!dma_res) {
+				dev_dbg(&pdev->dev,
+					"cannot get DMA RX channel\n");
+				status = -ENODEV;
+				break;
+			}
 
-		mcspi->dma_channels[i].dma_rx_sync_dev = dma_res->start;
-		sprintf(dma_ch_name, "tx%d", i);
-		dma_res = platform_get_resource_byname(pdev, IORESOURCE_DMA,
-							dma_ch_name);
-		if (!dma_res) {
-			dev_dbg(&pdev->dev, "cannot get DMA TX channel\n");
-			status = -ENODEV;
-			break;
+			mcspi->dma_channels[i].dma_rx_sync_dev =
+				dma_res->start;
 		}
+		sprintf(dma_tx_ch_name, "tx%d", i);
+		if (!pdev->dev.of_node) {
+			dma_res =
+				platform_get_resource_byname(pdev,
+							     IORESOURCE_DMA,
+							     dma_tx_ch_name);
+			if (!dma_res) {
+				dev_dbg(&pdev->dev,
+					"cannot get DMA TX channel\n");
+				status = -ENODEV;
+				break;
+			}
 
-		mcspi->dma_channels[i].dma_tx_sync_dev = dma_res->start;
+			mcspi->dma_channels[i].dma_tx_sync_dev =
+				dma_res->start;
+		}
 	}
 
 	if (status < 0)
-- 
1.7.9.5


------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev
