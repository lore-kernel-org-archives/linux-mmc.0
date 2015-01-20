From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 01/17] mmc: tmio: add tmio_mmc_host_alloc/free()
Date: Tue, 20 Jan 2015 10:10:26 +0100
Message-ID: <CAPDyKFpYQ5tHeWHiZMwS1zJpgrgP_qC8vbv3ExLkLTbn9X8MyQ@mail.gmail.com>
References: <87twzvuvl1.wl%kuninori.morimoto.gx@renesas.com>
	<87siffuvj8.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50]:42807 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbbATJK1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jan 2015 04:10:27 -0500
Received: by mail-qg0-f50.google.com with SMTP id f51so1882107qge.9
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2015 01:10:26 -0800 (PST)
In-Reply-To: <87siffuvj8.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

+ MFD maintainer

On 13 January 2015 at 05:57, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Current tmio_mmc driver is using tmio_mmc_data for driver/platform
> specific data/callback, and it is needed for tmio_mmc_host_probe()
> function. Because of this style, include/linux/mfd/tmio.h header has
> tmio driver/framework specific data which is not needed from platform.
>
> This patch adds new tmio_mmc_host_alloc/free() as cleanup preparation.
> tmio driver specific data/callback will be implemented in tmio_mmc_host,
> and platform specific data/callback will be implemented in tmio_mmc_data
> in this cleanup.
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/mmc/host/sh_mobile_sdhi.c |   14 +++++++++---
>  drivers/mmc/host/tmio_mmc.c       |   10 +++++++--
>  drivers/mmc/host/tmio_mmc.h       |    5 +++--
>  drivers/mmc/host/tmio_mmc_pio.c   |   43 +++++++++++++++++++++++--------------
>  include/linux/mfd/tmio.h          |    1 -
>  5 files changed, 49 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index 00c8ebd..cf062c4 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -113,7 +113,7 @@ static int sh_mobile_sdhi_wait_idle(struct tmio_mmc_host *host)
>                 udelay(1);
>
>         if (!timeout) {
> -               dev_warn(host->pdata->dev, "timeout waiting for SD bus idle\n");
> +               dev_warn(&host->pdev->dev, "timeout waiting for SD bus idle\n");
>                 return -EBUSY;
>         }
>
> @@ -207,6 +207,12 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
>                 goto eclkget;
>         }
>
> +       host = tmio_mmc_host_alloc(pdev);
> +       if (!host) {
> +               ret = -ENOMEM;
> +               goto eprobe;
> +       }
> +
>         mmc_data->clk_enable = sh_mobile_sdhi_clk_enable;
>         mmc_data->clk_disable = sh_mobile_sdhi_clk_disable;
>         mmc_data->capabilities = MMC_CAP_MMC_HIGHSPEED;
> @@ -274,9 +280,9 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
>         /* SD control register space size is 0x100, 0x200 for bus_shift=1 */
>         mmc_data->bus_shift = resource_size(res) >> 9;
>
> -       ret = tmio_mmc_host_probe(&host, pdev, mmc_data);
> +       ret = tmio_mmc_host_probe(host, mmc_data);
>         if (ret < 0)
> -               goto eprobe;
> +               goto efree;
>
>         /*
>          * FIXME:
> @@ -351,6 +357,8 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
>
>  eirq:
>         tmio_mmc_host_remove(host);
> +efree:
> +       tmio_mmc_host_free(host);
>  eprobe:
>  eclkget:
>         if (p && p->cleanup)
> diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
> index 2616fdf..f47ae08 100644
> --- a/drivers/mmc/host/tmio_mmc.c
> +++ b/drivers/mmc/host/tmio_mmc.c
> @@ -92,10 +92,14 @@ static int tmio_mmc_probe(struct platform_device *pdev)
>         pdata->bus_shift = resource_size(res) >> 10;
>         pdata->flags |= TMIO_MMC_HAVE_HIGH_REG;
>
> -       ret = tmio_mmc_host_probe(&host, pdev, pdata);
> -       if (ret)
> +       host = tmio_mmc_host_alloc(pdev);
> +       if (!host)
>                 goto cell_disable;
>
> +       ret = tmio_mmc_host_probe(host, pdata);
> +       if (ret)
> +               goto host_free;
> +
>         ret = request_irq(irq, tmio_mmc_irq, IRQF_TRIGGER_FALLING,
>                                 dev_name(&pdev->dev), host);
>         if (ret)
> @@ -108,6 +112,8 @@ static int tmio_mmc_probe(struct platform_device *pdev)
>
>  host_remove:
>         tmio_mmc_host_remove(host);
> +host_free:
> +       tmio_mmc_host_free(host);
>  cell_disable:
>         if (cell->disable)
>                 cell->disable(pdev);
> diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
> index a34ecbe..60d6747 100644
> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -85,8 +85,9 @@ struct tmio_mmc_host {
>         bool                    sdio_irq_enabled;
>  };
>
> -int tmio_mmc_host_probe(struct tmio_mmc_host **host,
> -                       struct platform_device *pdev,
> +struct tmio_mmc_host *tmio_mmc_host_alloc(struct platform_device *pdev);
> +void tmio_mmc_host_free(struct tmio_mmc_host *host);
> +int tmio_mmc_host_probe(struct tmio_mmc_host *host,
>                         struct tmio_mmc_data *pdata);
>  void tmio_mmc_host_remove(struct tmio_mmc_host *host);
>  void tmio_mmc_do_data_irq(struct tmio_mmc_host *host);
> diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
> index 250bf8c..1a9a13f 100644
> --- a/drivers/mmc/host/tmio_mmc_pio.c
> +++ b/drivers/mmc/host/tmio_mmc_pio.c
> @@ -1054,12 +1054,35 @@ static void tmio_mmc_of_parse(struct platform_device *pdev,
>                 pdata->flags |= TMIO_MMC_WRPROTECT_DISABLE;
>  }
>
> -int tmio_mmc_host_probe(struct tmio_mmc_host **host,
> -                                 struct platform_device *pdev,
> -                                 struct tmio_mmc_data *pdata)
> +struct tmio_mmc_host*
> +tmio_mmc_host_alloc(struct platform_device *pdev)
>  {
> -       struct tmio_mmc_host *_host;
> +       struct tmio_mmc_host *host;
>         struct mmc_host *mmc;
> +
> +       mmc = mmc_alloc_host(sizeof(struct tmio_mmc_host), &pdev->dev);
> +       if (!mmc)
> +               return NULL;
> +
> +       host = mmc_priv(mmc);
> +       host->mmc = mmc;
> +       host->pdev = pdev;
> +
> +       return host;
> +}
> +
> +void tmio_mmc_host_free(struct tmio_mmc_host *host)
> +{
> +       mmc_free_host(host->mmc);
> +
> +       host->mmc = NULL;
> +}
> +
> +int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
> +                       struct tmio_mmc_data *pdata)
> +{
> +       struct platform_device *pdev = _host->pdev;
> +       struct mmc_host *mmc = _host->mmc;
>         struct resource *res_ctl;
>         int ret;
>         u32 irq_mask = TMIO_MASK_CMD;
> @@ -1073,19 +1096,11 @@ int tmio_mmc_host_probe(struct tmio_mmc_host **host,
>         if (!res_ctl)
>                 return -EINVAL;
>
> -       mmc = mmc_alloc_host(sizeof(struct tmio_mmc_host), &pdev->dev);
> -       if (!mmc)
> -               return -ENOMEM;
> -
>         ret = mmc_of_parse(mmc);
>         if (ret < 0)
>                 goto host_free;
>
> -       pdata->dev = &pdev->dev;
> -       _host = mmc_priv(mmc);
>         _host->pdata = pdata;
> -       _host->mmc = mmc;
> -       _host->pdev = pdev;
>         platform_set_drvdata(pdev, mmc);
>
>         _host->set_pwr = pdata->set_pwr;
> @@ -1192,12 +1207,9 @@ int tmio_mmc_host_probe(struct tmio_mmc_host **host,
>                 mmc_gpiod_request_cd_irq(mmc);
>         }
>
> -       *host = _host;
> -
>         return 0;
>
>  host_free:
> -       mmc_free_host(mmc);
>
>         return ret;
>  }
> @@ -1222,7 +1234,6 @@ void tmio_mmc_host_remove(struct tmio_mmc_host *host)
>         pm_runtime_disable(&pdev->dev);
>
>         iounmap(host->ctl);
> -       mmc_free_host(mmc);
>  }
>  EXPORT_SYMBOL(tmio_mmc_host_remove);
>
> diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> index 5738817..c7d9af0 100644
> --- a/include/linux/mfd/tmio.h
> +++ b/include/linux/mfd/tmio.h
> @@ -135,7 +135,6 @@ struct tmio_mmc_data {
>         unsigned long                   bus_shift;
>         u32                             ocr_mask;       /* available voltages */
>         struct tmio_mmc_dma             *dma;
> -       struct device                   *dev;
>         unsigned int                    cd_gpio;
>         void (*set_pwr)(struct platform_device *host, int state);
>         void (*set_clk_div)(struct platform_device *host, int state);
> --
> 1.7.9.5
>
