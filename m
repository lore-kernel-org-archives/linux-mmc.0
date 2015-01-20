From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 17/17] mmc: tmio: remove TMIO_MMC_HAVE_CTL_DMA_REG flag
Date: Tue, 20 Jan 2015 10:14:34 +0100
Message-ID: <CAPDyKFp9NUs3FCHkOJe9dEdOdHzi1MiCB0RsD_V=7RiYL3OGzA@mail.gmail.com>
References: <87twzvuvl1.wl%kuninori.morimoto.gx@renesas.com>
	<8761cbuvdt.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:43056 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbbATJOf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jan 2015 04:14:35 -0500
Received: by mail-qa0-f46.google.com with SMTP id j7so27132763qaq.5
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jan 2015 01:14:34 -0800 (PST)
In-Reply-To: <8761cbuvdt.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

+ MFD maintainer

On 13 January 2015 at 06:00, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> tmio_mmc_host has .enable_dma callback now.
> We don't need TMIO_MMC_HAVE_CTL_DMA_REG anymore.
> Let's remove it
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/mmc/host/sh_mobile_sdhi.c |    5 -----
>  drivers/mmc/host/tmio_mmc_dma.c   |    3 ---
>  include/linux/mfd/tmio.h          |    5 -----
>  3 files changed, 13 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index 7dbcb57..6906a90 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -291,11 +291,6 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
>          */
>         mmc_data->flags |= TMIO_MMC_SDIO_STATUS_QUIRK;
>
> -       /*
> -        * All SDHI have DMA control register
> -        */
> -       mmc_data->flags |= TMIO_MMC_HAVE_CTL_DMA_REG;
> -
>         if (of_id && of_id->data) {
>                 const struct sh_mobile_sdhi_of_data *of_data = of_id->data;
>                 mmc_data->flags |= of_data->tmio_flags;
> diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
> index aa5f4b6..331bb61 100644
> --- a/drivers/mmc/host/tmio_mmc_dma.c
> +++ b/drivers/mmc/host/tmio_mmc_dma.c
> @@ -28,9 +28,6 @@ void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
>         if (!host->chan_tx || !host->chan_rx)
>                 return;
>
> -       if (host->pdata->flags & TMIO_MMC_HAVE_CTL_DMA_REG)
> -               sd_ctrl_write16(host, CTL_DMA_ENABLE, enable ? 2 : 0);
> -
>         if (host->dma->enable)
>                 host->dma->enable(host, enable);
>  }
> diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> index 807ecfb..6058128 100644
> --- a/include/linux/mfd/tmio.h
> +++ b/include/linux/mfd/tmio.h
> @@ -96,11 +96,6 @@
>  #define TMIO_MMC_SDIO_STATUS_QUIRK     (1 << 8)
>
>  /*
> - * Some controllers have DMA enable/disable register
> - */
> -#define TMIO_MMC_HAVE_CTL_DMA_REG      (1 << 9)
> -
> -/*
>   * Some controllers allows to set SDx actual clock
>   */
>  #define TMIO_MMC_CLK_ACTUAL            (1 << 10)
> --
> 1.7.9.5
>
