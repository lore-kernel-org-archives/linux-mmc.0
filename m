From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: omap_hsmmc: don't print uninitialized variables
Date: Fri, 29 Jan 2016 12:40:32 +0100
Message-ID: <CAPDyKFoto2BLyxfko6VX8CZC99LBhJiM1POJOC_Sk=UxnrWcLQ@mail.gmail.com>
References: <3411189.gO0215GrNM@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3411189.gO0215GrNM@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Kishon Vijay Abraham I <kishon@ti.com>, Andreas Fenkart <afenkart@gmail.com>, Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-mmc@vger.kernel.org

On 26 January 2016 at 16:26, Arnd Bergmann <arnd@arndb.de> wrote:
> When DT based probing is used but the DMA request fails, the
> driver will print uninitialized stack data from the rx_req
> and tx_req variables, as indicated by this warning:
>
> drivers/mmc/host/omap_hsmmc.c: In function 'omap_hsmmc_probe':
> drivers/mmc/host/omap_hsmmc.c:2162:3: warning: 'rx_req' may be used uninitialized in this function [-Wmaybe-uninitialized]
>    dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channel %u\n", rx_req);
>
> This removes the DMA request line number from the warning, which
> is the easiest solution and won't hurt us any more as we are
> planning to remove the legacy code path anyway.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, applied for next!

Kind regards
Uffe

> ---
> A simpler patch as v1 with the same result, as suggested by Peter Ujfalusi.
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index b6639ea0bf18..87f0d840a166 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2159,7 +2159,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>                                                  &rx_req, &pdev->dev, "rx");
>
>         if (!host->rx_chan) {
> -               dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channel %u\n", rx_req);
> +               dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channel\n");
>                 ret = -ENXIO;
>                 goto err_irq;
>         }
> @@ -2169,7 +2169,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>                                                  &tx_req, &pdev->dev, "tx");
>
>         if (!host->tx_chan) {
> -               dev_err(mmc_dev(host->mmc), "unable to obtain TX DMA engine channel %u\n", tx_req);
> +               dev_err(mmc_dev(host->mmc), "unable to obtain TX DMA engine channel\n");
>                 ret = -ENXIO;
>                 goto err_irq;
>         }
>
