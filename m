From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 04/17] mmc: tmio: tmio_mmc_host has .clk_enable
Date: Tue, 20 Jan 2015 10:11:34 +0100
Message-ID: <CAPDyKFqeQnUFNCzqzhZcve2djwV7sw4Ymf9SLpYGOm_+v5dFmA@mail.gmail.com>
References: <87twzvuvl1.wl%kuninori.morimoto.gx@renesas.com>
	<87oaq3uvif.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:61282 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752279AbbATJLf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jan 2015 04:11:35 -0500
Received: by mail-qg0-f45.google.com with SMTP id q107so9205877qgd.4
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2015 01:11:34 -0800 (PST)
In-Reply-To: <87oaq3uvif.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

+ MFD maintainer

On 13 January 2015 at 05:57, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Current .clk_enable is implemented under tmio_mmc_data.
> It goes to tmio_mmc_host by this patch.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/mmc/host/sh_mobile_sdhi.c |    2 +-
>  drivers/mmc/host/tmio_mmc.h       |    1 +
>  drivers/mmc/host/tmio_mmc_pio.c   |    5 ++---
>  include/linux/mfd/tmio.h          |    1 -
>  4 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index 77ff062..87af77d 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -215,8 +215,8 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
>
>         host->dma               = dma_priv;
>         host->write16_hook      = sh_mobile_sdhi_write16_hook;
> +       host->clk_enable        = sh_mobile_sdhi_clk_enable;
>
> -       mmc_data->clk_enable = sh_mobile_sdhi_clk_enable;
>         mmc_data->clk_disable = sh_mobile_sdhi_clk_disable;
>         mmc_data->capabilities = MMC_CAP_MMC_HIGHSPEED;
>         mmc_data->multi_io_quirk = sh_mobile_sdhi_multi_io_quirk;
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index 3fa96b1..5cd2986 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -96,6 +96,7 @@ struct tmio_mmc_host {
>         bool                    sdio_irq_enabled;
>
>         int (*write16_hook)(struct tmio_mmc_host *host, int addr);
> +       int (*clk_enable)(struct platform_device *pdev, unsigned int *f);
>  };
>
>  struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev);
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index fe434cc..1528c88 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -835,13 +835,12 @@ fail:
>  static int tmio_mmc_clk_update(struct tmio_mmc_host *host)
>  {
>         struct mmc_host *mmc = host->mmc;
> -       struct tmio_mmc_data *pdata = host->pdata;
>         int ret;
>
> -       if (!pdata->clk_enable)
> +       if (!host->clk_enable)
>                 return -ENOTSUPP;
>
> -       ret = pdata->clk_enable(host->pdev, &mmc->f_max);
> +       ret = host->clk_enable(host->pdev, &mmc->f_max);
>         if (!ret)
>                 mmc->f_min = mmc->f_max / 512;
>
> diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> index 0872ca1..472587a 100644
> --- a/include/linux/mfd/tmio.h
> +++ b/include/linux/mfd/tmio.h
> @@ -126,7 +126,6 @@ struct tmio_mmc_data {
>         void (*set_pwr)(struct platform_device *host, int state);
>         void (*set_clk_div)(struct platform_device *host, int state);
>         /* clock management callbacks */
> -       int (*clk_enable)(struct platform_device *pdev, unsigned int *f);
>         void (*clk_disable)(struct platform_device *pdev);
>         int (*multi_io_quirk)(struct mmc_card *card,
>                               unsigned int direction, int blk_size);
> --
> 1.7.9.5
>
