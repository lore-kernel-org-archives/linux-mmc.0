From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/7 v3] mmc: use .multi_io_quirk on omap_hsmmc
Date: Mon, 8 Sep 2014 11:10:40 +0200
Message-ID: <CAPDyKFoj2_3APb1q_tJ8P8qmDb8RftOyx4+j_Sbb74kDSKEe7Q@mail.gmail.com>
References: <87r3zvzohj.wl%kuninori.morimoto.gx@gmail.com>
	<87bnqx78xr.wl%kuninori.morimoto.gx@gmail.com>
	<878um178vn.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <878um178vn.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 3 September 2014 04:09, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Now, omap_hsmmc can use .multi_io_quirk callback
> instead of MMC_CAP2_NO_MULTI_READ flags.
> let's use it.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v2 -> v3
>
>  - blk_size_workaround -> multi_io_quirk
>
>  drivers/mmc/host/omap_hsmmc.c |   17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index ece1634..7b41f57 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -219,6 +219,7 @@ struct omap_hsmmc_host {
>  #define AUTO_CMD23             (1 << 0)        /* Auto CMD23 support */
>  #define HSMMC_SDIO_IRQ_ENABLED (1 << 1)        /* SDIO irq enabled */
>  #define HSMMC_WAKE_IRQ_ENABLED (1 << 2)
> +#define HSMMC_NO_MULTI_READ    (1 << 3)
>         struct omap_hsmmc_next  next_data;
>         struct  omap_mmc_platform_data  *pdata;
>  };
> @@ -1829,6 +1830,19 @@ static int omap_hsmmc_disable_fclk(struct mmc_host *mmc)
>         return 0;
>  }
>
> +static int *omap_hsmmc_multi_io_quirk(struct mmc_card *card,
> +                                     unsigned int direction, int blk_size)
> +{
> +       struct omap_hsmmc_host *host = mmc_priv(card->host);
> +
> +       /* This controller can't do multiblock reads due to hw bugs */
> +       if ((host->flags & HSMMC_NO_MULTI_READ) &&
> +           (direction == MMC_DATA_READ))
> +               return 1;
> +
> +       return blk_size;
> +}
> +
>  static const struct mmc_host_ops omap_hsmmc_ops = {
>         .enable = omap_hsmmc_enable_fclk,
>         .disable = omap_hsmmc_disable_fclk,
> @@ -1840,6 +1854,7 @@ static const struct mmc_host_ops omap_hsmmc_ops = {
>         .get_ro = omap_hsmmc_get_ro,
>         .init_card = omap_hsmmc_init_card,
>         .enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
> +       .multi_io_quirk = omap_hsmmc_multi_io_quirk,
>  };
>
>  #ifdef CONFIG_DEBUG_FS
> @@ -2101,7 +2116,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
>
>         if (host->pdata->controller_flags & OMAP_HSMMC_BROKEN_MULTIBLOCK_READ) {
>                 dev_info(&pdev->dev, "multiblock reads disabled due to 35xx erratum 2.1.1.128; MMC read performance may suffer\n");
> -               mmc->caps2 |= MMC_CAP2_NO_MULTI_READ;

An option to adding yet another flag, would be to assign
->multi_io_quirk = omap_hsmmc_multi_io_quirk() here? Isn't that
actually better for those variants that doesn't suffer from this HW
bug?

Kind regards
Uffe


> +               host->flags |= HSMMC_NO_MULTI_READ;
>         }
>
>         pm_runtime_enable(host->dev);
> --
> 1.7.9.5
>
