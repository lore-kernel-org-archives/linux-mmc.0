From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/7 v3] mmc: use .multi_io_quirk on tmio_mmc
Date: Mon, 8 Sep 2014 12:43:32 +0200
Message-ID: <CAPDyKFoVQjO7CLAQM-9DX12H5bOwwP6aqJtb=y3uRMNaWqV89A@mail.gmail.com>
References: <87r3zvzohj.wl%kuninori.morimoto.gx@gmail.com>
	<87bnqx78xr.wl%kuninori.morimoto.gx@gmail.com>
	<877g1l78v9.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <877g1l78v9.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Lee Jones <lee.jones@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 3 September 2014 04:09, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Now, tmio_mmc can use .multi_io_quirk callback
> instead of MMC_CAP2_NO_MULTI_READ flags.
> let's use it.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v2 -> v3
>
>  - blk_size_workaround -> multi_io_quirk
>
>  drivers/mmc/host/tmio_mmc_pio.c |   13 +++++++++++++
>  include/linux/mfd/tmio.h        |    4 ++++

"mfd"? That was an odd place for storing the tmio mmc specific platform data.

So, we need an ack for the mfd maintainer on this one as well. Lee,
can you have a look?

Future wise, I would also suggest the include/linux/mfd/tmio.h to be
split up in proper pieces.

>  2 files changed, 17 insertions(+)
>
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index ba45413..ff5ff0f 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -970,12 +970,25 @@ static int tmio_mmc_get_ro(struct mmc_host *mmc)
>         return ret;
>  }
>
> +static int tmio_multi_io_quirk(struct mmc_card *card,
> +                              unsigned int direction, int blk_size)
> +{
> +       struct tmio_mmc_host *host = mmc_priv(card->host);
> +       struct tmio_mmc_data *pdata = host->pdata;
> +
> +       if (pdata->multi_io_quirk)
> +               return pdata->multi_io_quirk(card, direction, blk_size);
> +
> +       return blk_size;
> +}
> +
>  static const struct mmc_host_ops tmio_mmc_ops = {
>         .request        = tmio_mmc_request,
>         .set_ios        = tmio_mmc_set_ios,
>         .get_ro         = tmio_mmc_get_ro,
>         .get_cd         = mmc_gpio_get_cd,
>         .enable_sdio_irq = tmio_mmc_enable_sdio_irq,
> +       .multi_io_quirk = tmio_multi_io_quirk,
>  };
>
>  static int tmio_mmc_init_ocr(struct tmio_mmc_host *host)
> diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> index 90436d5..dec750e 100644
> --- a/include/linux/mfd/tmio.h
> +++ b/include/linux/mfd/tmio.h
> @@ -1,10 +1,12 @@
>  #ifndef MFD_TMIO_H
>  #define MFD_TMIO_H
>
> +#include <linux/blkdev.h>

This isn't needed, right?

>  #include <linux/device.h>
>  #include <linux/fb.h>
>  #include <linux/io.h>
>  #include <linux/jiffies.h>
> +#include <linux/mmc/card.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>
> @@ -142,6 +144,8 @@ struct tmio_mmc_data {
>         /* clock management callbacks */
>         int (*clk_enable)(struct platform_device *pdev, unsigned int *f);
>         void (*clk_disable)(struct platform_device *pdev);
> +       int (*multi_io_quirk)(struct mmc_card *card,
> +                             unsigned int direction, int blk_size);

Do you really need to invent new platform callbacks for this? Wouldn't
it be possible to let the driver handle the quirk by itself?


Kind regards
Uffe
