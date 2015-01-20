From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 05/17] mmc: tmio: tmio_mmc_host has .clk_disable
Date: Tue, 20 Jan 2015 10:11:56 +0100
Message-ID: <CAPDyKFqVwvmvE0D+P__uYg=JRtQj3AatcMi5G6ejEmk+RtAuyg@mail.gmail.com>
References: <87twzvuvl1.wl%kuninori.morimoto.gx@renesas.com>
	<87mw5nuvi5.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:63250 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbbATJL4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jan 2015 04:11:56 -0500
Received: by mail-qg0-f43.google.com with SMTP id e89so9333644qgf.2
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2015 01:11:56 -0800 (PST)
In-Reply-To: <87mw5nuvi5.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

+ MFD maintainer

On 13 January 2015 at 05:58, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Current .clk_disable is implemented under tmio_mmc_data.
> It goes to tmio_mmc_host by this patch.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/mmc/host/sh_mobile_sdhi.c |    2 +-
>  drivers/mmc/host/tmio_mmc.h       |    1 +
>  drivers/mmc/host/tmio_mmc_pio.c   |    4 ++--
>  include/linux/mfd/tmio.h          |    3 +--
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index 87af77d..5e02a6a 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -216,8 +216,8 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
>         host->dma               = dma_priv;
>         host->write16_hook      = sh_mobile_sdhi_write16_hook;
>         host->clk_enable        = sh_mobile_sdhi_clk_enable;
> +       host->clk_disable       = sh_mobile_sdhi_clk_disable;
>
> -       mmc_data->clk_disable = sh_mobile_sdhi_clk_disable;
>         mmc_data->capabilities = MMC_CAP_MMC_HIGHSPEED;
>         mmc_data->multi_io_quirk = sh_mobile_sdhi_multi_io_quirk;
>         if (p) {
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index 5cd2986..28234ec 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -97,6 +97,7 @@ struct tmio_mmc_host {
>
>         int (*write16_hook)(struct tmio_mmc_host *host, int addr);
>         int (*clk_enable)(struct platform_device *pdev, unsigned int *f);
> +       void (*clk_disable)(struct platform_device *pdev);
>  };
>
>  struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev);
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index 1528c88..94fbf4a 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -1247,8 +1247,8 @@ int tmio_mmc_host_runtime_suspend(struct device *dev)
>         if (host->clk_cache)
>                 tmio_mmc_clk_stop(host);
>
> -       if (host->pdata->clk_disable)
> -               host->pdata->clk_disable(host->pdev);
> +       if (host->clk_disable)
> +               host->clk_disable(host->pdev);
>
>         return 0;
>  }
> diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> index 472587a..a3f78da 100644
> --- a/include/linux/mfd/tmio.h
> +++ b/include/linux/mfd/tmio.h
> @@ -125,8 +125,7 @@ struct tmio_mmc_data {
>         unsigned int                    cd_gpio;
>         void (*set_pwr)(struct platform_device *host, int state);
>         void (*set_clk_div)(struct platform_device *host, int state);
> -       /* clock management callbacks */
> -       void (*clk_disable)(struct platform_device *pdev);
> +
>         int (*multi_io_quirk)(struct mmc_card *card,
>                               unsigned int direction, int blk_size);
>  };
> --
> 1.7.9.5
>
