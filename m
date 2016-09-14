From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: omap_hsmmc: Initialize dma_slave_config to avoid random data
Date: Wed, 14 Sep 2016 12:23:20 +0200
Message-ID: <3300411.hNyGPzA0ak@wuerfel>
References: <20160914101048.1061-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160914101048.1061-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: ulf.hansson@linaro.org, tony@atomide.com, kishon@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wednesday, September 14, 2016 1:10:48 PM CEST Peter Ujfalusi wrote:
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index 24ebc9a8de89..0a5640156159 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1409,7 +1409,7 @@ static int omap_hsmmc_pre_dma_transfer(struct omap_hsmmc_host *host,
>  static int omap_hsmmc_setup_dma_transfer(struct omap_hsmmc_host *host,
>                                         struct mmc_request *req)
>  {
> -       struct dma_slave_config cfg;
> +       struct dma_slave_config cfg = {};
>         struct dma_async_tx_descriptor *tx;
>         int ret = 0, i;
>         struct mmc_data *data = req->data;
> 

This change looks correct and is certainly the simplest solution if you want to
get it into v4.8, but generally speaking, I think it would be nicer to combine
it with the initialization of the fields:

	struct dma_slave_config cfg = {
		  .src_addr = host->mapbase + OMAP_HSMMC_DATA;
        .dst_addr = host->mapbase + OMAP_HSMMC_DATA;
        .src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
        .dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
        .src_maxburst = data->blksz / 4;
        .dst_maxburst = data->blksz / 4;
	};

	Arnd
