From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 03/17] mmc: tmio: tmio_mmc_host has .write16_hook
Date: Tue, 20 Jan 2015 10:11:15 +0100
Message-ID: <CAPDyKFo2v8TLOMuxJOZwjqRji4+QmYRkk3CSGgi-JCbVriP7MQ@mail.gmail.com>
References: <87twzvuvl1.wl%kuninori.morimoto.gx@renesas.com>
	<87ppajuvip.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54]:40818 "EHLO
	mail-qa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140AbbATJLQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jan 2015 04:11:16 -0500
Received: by mail-qa0-f54.google.com with SMTP id w8so26595240qac.13
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2015 01:11:15 -0800 (PST)
In-Reply-To: <87ppajuvip.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

+ MFD maintainer

On 13 January 2015 at 05:57, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Current .write16_hook is implemented under tmio_mmc_data.
> It goes to tmio_mmc_host by this patch.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/mmc/host/sh_mobile_sdhi.c |    2 +-
>  drivers/mmc/host/tmio_mmc.h       |    4 +++-
>  drivers/mmc/host/tmio_mmc_pio.c   |    2 +-
>  include/linux/mfd/tmio.h          |    3 ---
>  4 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index 288e78d..77ff062 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -214,11 +214,11 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
>         }
>
>         host->dma               = dma_priv;
> +       host->write16_hook      = sh_mobile_sdhi_write16_hook;
>
>         mmc_data->clk_enable = sh_mobile_sdhi_clk_enable;
>         mmc_data->clk_disable = sh_mobile_sdhi_clk_disable;
>         mmc_data->capabilities = MMC_CAP_MMC_HIGHSPEED;
> -       mmc_data->write16_hook = sh_mobile_sdhi_write16_hook;
>         mmc_data->multi_io_quirk = sh_mobile_sdhi_multi_io_quirk;
>         if (p) {
>                 mmc_data->flags = p->tmio_flags;
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index 49a2559..3fa96b1 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -94,6 +94,8 @@ struct tmio_mmc_host {
>         struct mutex            ios_lock;       /* protect set_ios() context */
>         bool                    native_hotplug;
>         bool                    sdio_irq_enabled;
> +
> +       int (*write16_hook)(struct tmio_mmc_host *host, int addr);
>  };
>
>  struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev);
> @@ -183,7 +185,7 @@ static inline void sd_ctrl_write16(struct tmio_mmc_host *host, int addr, u16 val
>         /* If there is a hook and it returns non-zero then there
>          * is an error and the write should be skipped
>          */
> -       if (host->pdata->write16_hook && host->pdata->write16_hook(host, addr))
> +       if (host->write16_hook && host->write16_hook(host, addr))
>                 return;
>         writew(val, host->ctl + (addr << host->pdata->bus_shift));
>  }
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index 1a9a13f..fe434cc 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -1090,7 +1090,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
>         tmio_mmc_of_parse(pdev, pdata);
>
>         if (!(pdata->flags & TMIO_MMC_HAS_IDLE_WAIT))
> -               pdata->write16_hook = NULL;
> +               _host->write16_hook = NULL;
>
>         res_ctl = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>         if (!res_ctl)
> diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> index 8d708c7..0872ca1 100644
> --- a/include/linux/mfd/tmio.h
> +++ b/include/linux/mfd/tmio.h
> @@ -112,8 +112,6 @@ void tmio_core_mmc_clk_div(void __iomem *cnf, int shift, int state);
>
>  struct dma_chan;
>
> -struct tmio_mmc_host;
> -
>  /*
>   * data for the MMC controller
>   */
> @@ -127,7 +125,6 @@ struct tmio_mmc_data {
>         unsigned int                    cd_gpio;
>         void (*set_pwr)(struct platform_device *host, int state);
>         void (*set_clk_div)(struct platform_device *host, int state);
> -       int (*write16_hook)(struct tmio_mmc_host *host, int addr);
>         /* clock management callbacks */
>         int (*clk_enable)(struct platform_device *pdev, unsigned int *f);
>         void (*clk_disable)(struct platform_device *pdev);
> --
> 1.7.9.5
>
