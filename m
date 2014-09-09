From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/6 v4] mmc: use .multi_io_quirk on tmio_mmc
Date: Tue, 9 Sep 2014 09:00:24 +0200
Message-ID: <CAPDyKFp4sDvr-12iik=D6DvdQffhf3vxdqeihm7pqj2OA_bXBA@mail.gmail.com>
References: <87r3zvzohj.wl%kuninori.morimoto.gx@gmail.com>
	<87k35d70pz.wl%kuninori.morimoto.gx@gmail.com>
	<87ha0h70n1.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:63030 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbaIIHAY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Sep 2014 03:00:24 -0400
Received: by mail-qg0-f47.google.com with SMTP id i50so2401806qgf.20
        for <linux-mmc@vger.kernel.org>; Tue, 09 Sep 2014 00:00:24 -0700 (PDT)
In-Reply-To: <87ha0h70n1.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 9 September 2014 08:45, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Now, tmio_mmc can use .multi_io_quirk callback
> instead of MMC_CAP2_NO_MULTI_READ flags.
> let's use it.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v3 -> v4
>
>  - remove un-needed header
>
>  drivers/mmc/host/tmio_mmc_pio.c |   13 +++++++++++++
>  include/linux/mfd/tmio.h        |    3 +++

You need to send this to Lee as well, to request his ack for mfd.

Kind regards
Uffe

>  2 files changed, 16 insertions(+)
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
> index 90436d5..5738817 100644
> --- a/include/linux/mfd/tmio.h
> +++ b/include/linux/mfd/tmio.h
> @@ -5,6 +5,7 @@
>  #include <linux/fb.h>
>  #include <linux/io.h>
>  #include <linux/jiffies.h>
> +#include <linux/mmc/card.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>
> @@ -142,6 +143,8 @@ struct tmio_mmc_data {
>         /* clock management callbacks */
>         int (*clk_enable)(struct platform_device *pdev, unsigned int *f);
>         void (*clk_disable)(struct platform_device *pdev);
> +       int (*multi_io_quirk)(struct mmc_card *card,
> +                             unsigned int direction, int blk_size);
>  };
>
>  /*
> --
> 1.7.9.5
>
