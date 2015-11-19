From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: omap_hsmmc: No need to check DMA channel validity at
 module remove
Date: Thu, 19 Nov 2015 12:33:59 +0100
Message-ID: <CAPDyKFrbMrJSnTFDrkJt-oFa88CgVmUMNva-C4LUnf96QTiugQ@mail.gmail.com>
References: <1446550651-7977-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f174.google.com ([209.85.160.174]:35988 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbbKSLeA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Nov 2015 06:34:00 -0500
Received: by ykdr82 with SMTP id r82so103523269ykd.3
        for <linux-mmc@vger.kernel.org>; Thu, 19 Nov 2015 03:34:00 -0800 (PST)
In-Reply-To: <1446550651-7977-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Kishon <kishon@ti.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 3 November 2015 at 12:37, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> The driver will not probe without valid DMA channels so no need to check
> if they are valid when the module is removed.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> CC: Ulf Hansson <ulf.hansson@linaro.org>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/omap_hsmmc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index f70e52b05648..712c74fd0401 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -2262,10 +2262,8 @@ static int omap_hsmmc_remove(struct platform_device *pdev)
>         pm_runtime_get_sync(host->dev);
>         mmc_remove_host(host->mmc);
>
> -       if (host->tx_chan)
> -               dma_release_channel(host->tx_chan);
> -       if (host->rx_chan)
> -               dma_release_channel(host->rx_chan);
> +       dma_release_channel(host->tx_chan);
> +       dma_release_channel(host->rx_chan);
>
>         pm_runtime_put_sync(host->dev);
>         pm_runtime_disable(host->dev);
> --
> 2.6.2
>
