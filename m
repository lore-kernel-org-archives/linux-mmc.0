From: Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v10 7/8] spi: omap2-mcspi: convert to
	dma_request_slave_channel_compat()
Date: Fri, 14 Jun 2013 21:32:49 -0500
Message-ID: <1371263570-9323-7-git-send-email-joelagnel@ti.com>
References: <1371263570-9323-1-git-send-email-joelagnel@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1371263570-9323-1-git-send-email-joelagnel-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Matt Porter <matt-agtwNxEcTQJWk0Htik3J/w@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Koen Kooi <koen-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
Cc: Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

From: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>

Convert dmaengine channel requests to use
dma_request_slave_channel_compat(). This supports the DT case of
platforms requiring channel selection from either the OMAP DMA or
the EDMA engine. AM33xx only boots from DT and is the only user
implementing EDMA so in the !DT case we can default to the OMAP DMA
filter.

Signed-off-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Acked-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Signed-off-by: Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c |   64 ++++++++++++++++++++++++++++-------------
 1 file changed, 44 insertions(+), 20 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 86d2158..ca4ab78 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -102,6 +102,9 @@ struct omap2_mcspi_dma {
 
 	struct completion dma_tx_completion;
 	struct completion dma_rx_completion;
+
+	char dma_rx_ch_name[14];
+	char dma_tx_ch_name[14];
 };
 
 /* use PIO for small transfers, avoiding DMA setup/teardown overhead and
@@ -830,12 +833,20 @@ static int omap2_mcspi_request_dma(struct spi_device *spi)
 	dma_cap_zero(mask);
 	dma_cap_set(DMA_SLAVE, mask);
 	sig = mcspi_dma->dma_rx_sync_dev;
-	mcspi_dma->dma_rx = dma_request_channel(mask, omap_dma_filter_fn, &sig);
+
+	mcspi_dma->dma_rx =
+		dma_request_slave_channel_compat(mask, omap_dma_filter_fn,
+						 &sig, &master->dev,
+						 mcspi_dma->dma_rx_ch_name);
 	if (!mcspi_dma->dma_rx)
 		goto no_dma;
 
 	sig = mcspi_dma->dma_tx_sync_dev;
-	mcspi_dma->dma_tx = dma_request_channel(mask, omap_dma_filter_fn, &sig);
+	mcspi_dma->dma_tx =
+		dma_request_slave_channel_compat(mask, omap_dma_filter_fn,
+						 &sig, &master->dev,
+						 mcspi_dma->dma_tx_ch_name);
+
 	if (!mcspi_dma->dma_tx) {
 		dma_release_channel(mcspi_dma->dma_rx);
 		mcspi_dma->dma_rx = NULL;
@@ -1256,29 +1267,42 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
 		goto free_master;
 
 	for (i = 0; i < master->num_chipselect; i++) {
-		char dma_ch_name[14];
+		char *dma_rx_ch_name = mcspi->dma_channels[i].dma_rx_ch_name;
+		char *dma_tx_ch_name = mcspi->dma_channels[i].dma_tx_ch_name;
 		struct resource *dma_res;
 
-		sprintf(dma_ch_name, "rx%d", i);
-		dma_res = platform_get_resource_byname(pdev, IORESOURCE_DMA,
-				dma_ch_name);
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
-				dma_ch_name);
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
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
