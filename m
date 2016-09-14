From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: omap: Initialize dma_slave_config to avoid random
 data in it's fields
Date: Wed, 14 Sep 2016 14:01:58 +0200
Message-ID: <CAPDyKFqxkYXatDMNc8jAH7h3kGWLCSrpQ=unVfaN8iXr5-=LxA@mail.gmail.com>
References: <20160914112154.4567-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160914112154.4567-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Kishon <kishon@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 14 September 2016 at 13:21, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> It is wrong to use uninitialized dma_slave_config and configure only
> certain fields as the DMAengine driver might look at non initialized
> (random data) fields and tries to interpret it.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Thanks, applied for fixes!

Kind regards
Uffe


> ---
> Hi,
>
> Changes since v1:
> - do the field initialization in one step
>
> would it be possible to send this patch for 4.8? I have omap-dma DMAengine
> driver changes pending, but they break the MMC/SD because of the uninitialized
> fields in dma_slave_config.
>
> Thanks,
> Peter
>
>  drivers/mmc/host/omap.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index f23d65eb070d..be3c49fa7382 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -1016,14 +1016,16 @@ mmc_omap_prepare_data(struct mmc_omap_host *host, struct mmc_request *req)
>
>                 /* Only reconfigure if we have a different burst size */
>                 if (*bp != burst) {
> -                       struct dma_slave_config cfg;
> -
> -                       cfg.src_addr = host->phys_base + OMAP_MMC_REG(host, DATA);
> -                       cfg.dst_addr = host->phys_base + OMAP_MMC_REG(host, DATA);
> -                       cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
> -                       cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
> -                       cfg.src_maxburst = burst;
> -                       cfg.dst_maxburst = burst;
> +                       struct dma_slave_config cfg = {
> +                               .src_addr = host->phys_base +
> +                                           OMAP_MMC_REG(host, DATA),
> +                               .dst_addr = host->phys_base +
> +                                           OMAP_MMC_REG(host, DATA),
> +                               .src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES,
> +                               .dst_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES,
> +                               .src_maxburst = burst,
> +                               .dst_maxburst = burst,
> +                       };
>
>                         if (dmaengine_slave_config(c, &cfg))
>                                 goto use_pio;
> --
> 2.10.0
>
