From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 4/7 v3] mmc: use .multi_io_quirk on sh_mobile
Date: Mon, 8 Sep 2014 12:28:55 +0200
Message-ID: <CAPDyKFqGmVoe91jCpDq5=b4JG6WTJE8TQyZXu7D01DNY=yUi0A@mail.gmail.com>
References: <87r3zvzohj.wl%kuninori.morimoto.gx@gmail.com>
	<87bnqx78xr.wl%kuninori.morimoto.gx@gmail.com>
	<8761h578ux.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <8761h578ux.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 3 September 2014 04:09, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Now, sh_mobile_sdhi can use .multi_io_quirk callback
> instead of MMC_CAP2_NO_MULTI_READ flags.
> let's use it.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks! Applied for next!

Kind regards
Uffe

> ---
> v2 -> v3
>
>  - blk_size_workaround -> multi_io_quirk
>
>  drivers/mmc/host/sh_mobile_sdhi.c |   20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index f2585b6..a2e81a1 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -58,7 +58,6 @@ static const struct sh_mobile_sdhi_of_data of_rcar_gen2_compatible = {
>         .tmio_flags     = TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE |
>                           TMIO_MMC_CLK_ACTUAL,
>         .capabilities   = MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
> -       .capabilities2  = MMC_CAP2_NO_MULTI_READ,
>         .dma_rx_offset  = 0x2000,
>  };
>
> @@ -139,6 +138,24 @@ static int sh_mobile_sdhi_write16_hook(struct tmio_mmc_host *host, int addr)
>         return 0;
>  }
>
> +static int sh_mobile_sdhi_multi_io_quirk(struct mmc_card *card,
> +                                        unsigned int direction, int blk_size)
> +{
> +       /*
> +        * In Renesas controllers, when performing a
> +        * multiple block read of one or two blocks,
> +        * depending on the timing with which the
> +        * response register is read, the response
> +        * value may not be read properly.
> +        * Use single block read for this HW bug
> +        */
> +       if ((direction == MMC_DATA_READ) &&
> +           blk_size == 2)
> +               return 1;
> +
> +       return blk_size;
> +}
> +
>  static void sh_mobile_sdhi_cd_wakeup(const struct platform_device *pdev)
>  {
>         mmc_detect_change(platform_get_drvdata(pdev), msecs_to_jiffies(100));
> @@ -194,6 +211,7 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
>         mmc_data->clk_disable = sh_mobile_sdhi_clk_disable;
>         mmc_data->capabilities = MMC_CAP_MMC_HIGHSPEED;
>         mmc_data->write16_hook = sh_mobile_sdhi_write16_hook;
> +       mmc_data->multi_io_quirk = sh_mobile_sdhi_multi_io_quirk;
>         if (p) {
>                 mmc_data->flags = p->tmio_flags;
>                 mmc_data->ocr_mask = p->tmio_ocr_mask;
> --
> 1.7.9.5
>
