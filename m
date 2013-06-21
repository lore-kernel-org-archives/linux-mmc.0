From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v12 09/11] spi: omap2-mcspi: convert to
	dma_request_slave_channel_compat()
Date: Fri, 21 Jun 2013 15:56:57 +0530
Message-ID: <51C42A71.1090403@ti.com>
References: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
	<1371762407-24544-10-git-send-email-joelagnel@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1371762407-24544-10-git-send-email-joelagnel-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: Koen, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Kooi <koen-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Vinod, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Morton <akpm@linux-fo>
List-Id: linux-mmc@vger.kernel.org

Hi Mark,
On Friday 21 June 2013 02:36 AM, Joel A Fernandes wrote:
> From: Matt Porter<mporter-l0cyMroinI0@public.gmane.org>
>
> Convert dmaengine channel requests to use
> dma_request_slave_channel_compat(). This supports the DT case of
> platforms requiring channel selection from either the OMAP DMA or
> the EDMA engine. AM33xx only boots from DT and is the only user
> implementing EDMA so in the !DT case we can default to the OMAP DMA
> filter.
>
> Signed-off-by: Matt Porter<mporter-l0cyMroinI0@public.gmane.org>
> Acked-by: Mark Brown<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
> Signed-off-by: Joel A Fernandes<joelagnel-l0cyMroinI0@public.gmane.org>
> ---
>   drivers/spi/spi-omap2-mcspi.c |   64 ++++++++++++++++++++++++++++-------------
>   1 file changed, 44 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> index 86d2158..ca4ab78 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -102,6 +102,9 @@ struct omap2_mcspi_dma {
>
>   	struct completion dma_tx_completion;
>   	struct completion dma_rx_completion;
> +
> +	char dma_rx_ch_name[14];
> +	char dma_tx_ch_name[14];
>   };
>
>   /* use PIO for small transfers, avoiding DMA setup/teardown overhead and
> @@ -830,12 +833,20 @@ static int omap2_mcspi_request_dma(struct spi_device *spi)
>   	dma_cap_zero(mask);
>   	dma_cap_set(DMA_SLAVE, mask);
>   	sig = mcspi_dma->dma_rx_sync_dev;
> -	mcspi_dma->dma_rx = dma_request_channel(mask, omap_dma_filter_fn,&sig);
> +
> +	mcspi_dma->dma_rx =
> +		dma_request_slave_channel_compat(mask, omap_dma_filter_fn,
> +						&sig,&master->dev,
> +						 mcspi_dma->dma_rx_ch_name);
>   	if (!mcspi_dma->dma_rx)
>   		goto no_dma;
>
>   	sig = mcspi_dma->dma_tx_sync_dev;
> -	mcspi_dma->dma_tx = dma_request_channel(mask, omap_dma_filter_fn,&sig);
> +	mcspi_dma->dma_tx =
> +		dma_request_slave_channel_compat(mask, omap_dma_filter_fn,
> +						&sig,&master->dev,
> +						 mcspi_dma->dma_tx_ch_name);
> +
>   	if (!mcspi_dma->dma_tx) {
>   		dma_release_channel(mcspi_dma->dma_rx);
>   		mcspi_dma->dma_rx = NULL;
> @@ -1256,29 +1267,42 @@ static int omap2_mcspi_probe(struct platform_device *pdev)
>   		goto free_master;
>
>   	for (i = 0; i<  master->num_chipselect; i++) {
> -		char dma_ch_name[14];
> +		char *dma_rx_ch_name = mcspi->dma_channels[i].dma_rx_ch_name;
> +		char *dma_tx_ch_name = mcspi->dma_channels[i].dma_tx_ch_name;
>   		struct resource *dma_res;
>
> -		sprintf(dma_ch_name, "rx%d", i);
> -		dma_res = platform_get_resource_byname(pdev, IORESOURCE_DMA,
> -				dma_ch_name);
> -		if (!dma_res) {
> -			dev_dbg(&pdev->dev, "cannot get DMA RX channel\n");
> -			status = -ENODEV;
> -			break;
> -		}
> +		sprintf(dma_rx_ch_name, "rx%d", i);
> +		if (!pdev->dev.of_node) {
> +			dma_res =
> +				platform_get_resource_byname(pdev,
> +							     IORESOURCE_DMA,
> +							     dma_rx_ch_name);
> +			if (!dma_res) {
> +				dev_dbg(&pdev->dev,
> +					"cannot get DMA RX channel\n");
> +				status = -ENODEV;
> +				break;
> +			}
>
> -		mcspi->dma_channels[i].dma_rx_sync_dev = dma_res->start;
> -		sprintf(dma_ch_name, "tx%d", i);
> -		dma_res = platform_get_resource_byname(pdev, IORESOURCE_DMA,
> -				dma_ch_name);
> -		if (!dma_res) {
> -			dev_dbg(&pdev->dev, "cannot get DMA TX channel\n");
> -			status = -ENODEV;
> -			break;
> +			mcspi->dma_channels[i].dma_rx_sync_dev =
> +				dma_res->start;
>   		}
> +		sprintf(dma_tx_ch_name, "tx%d", i);
> +		if (!pdev->dev.of_node) {
> +			dma_res =
> +				platform_get_resource_byname(pdev,
> +							     IORESOURCE_DMA,
> +							     dma_tx_ch_name);
> +			if (!dma_res) {
> +				dev_dbg(&pdev->dev,
> +					"cannot get DMA TX channel\n");
> +				status = -ENODEV;
> +				break;
> +			}
>
> -		mcspi->dma_channels[i].dma_tx_sync_dev = dma_res->start;
> +			mcspi->dma_channels[i].dma_tx_sync_dev =
> +				dma_res->start;
> +		}
>   	}
>
>   	if (status<  0)
Acked-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Tested-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>

This patch can go independently and does not depend on the rest of the
series.
Can these patch be pulled?




------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
