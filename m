From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: omap: Use dma_request_chan() for requesting DMA channel
Date: Tue, 3 May 2016 10:46:29 +0200
Message-ID: <CAPDyKFqTsJ3gcDGVWpbmQ4rzM8TQK7km3NTT=d0D9Dt7ydUafg@mail.gmail.com>
References: <1461935197-28664-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38634 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637AbcECIqb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 May 2016 04:46:31 -0400
Received: by mail-wm0-f48.google.com with SMTP id g17so25719562wme.1
        for <linux-mmc@vger.kernel.org>; Tue, 03 May 2016 01:46:30 -0700 (PDT)
In-Reply-To: <1461935197-28664-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Kishon <kishon@ti.com>, Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@ti.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 29 April 2016 at 15:06, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> With the new dma_request_chan() the client driver does not need to look for
> the DMA resource and it does not need to pass filter_fn anymore.
> By switching to the new API the driver can now support deferred probing
> against DMA.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> CC: Ulf Hansson <ulf.hansson@linaro.org>
> CC: Jarkko Nikula <jarkko.nikula@bitmer.com>
> ---
>  drivers/mmc/host/omap.c | 45 ++++++++++++++++++++++-----------------------
>  1 file changed, 22 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index b9958a123594..a8d9228657b2 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -23,7 +23,6 @@
>  #include <linux/spinlock.h>
>  #include <linux/timer.h>
>  #include <linux/of.h>
> -#include <linux/omap-dma.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/card.h>
>  #include <linux/mmc/mmc.h>
> @@ -1321,8 +1320,6 @@ static int mmc_omap_probe(struct platform_device *pdev)
>         struct omap_mmc_platform_data *pdata = pdev->dev.platform_data;
>         struct mmc_omap_host *host = NULL;
>         struct resource *res;
> -       dma_cap_mask_t mask;
> -       unsigned sig = 0;
>         int i, ret = 0;
>         int irq;
>
> @@ -1382,29 +1379,31 @@ static int mmc_omap_probe(struct platform_device *pdev)
>                 goto err_free_iclk;
>         }
>
> -       dma_cap_zero(mask);
> -       dma_cap_set(DMA_SLAVE, mask);
> -
>         host->dma_tx_burst = -1;
>         host->dma_rx_burst = -1;
>
> -       res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
> -       if (res)
> -               sig = res->start;
> -       host->dma_tx = dma_request_slave_channel_compat(mask,
> -                               omap_dma_filter_fn, &sig, &pdev->dev, "tx");
> -       if (!host->dma_tx)
> -               dev_warn(host->dev, "unable to obtain TX DMA engine channel %u\n",
> -                       sig);
> -
> -       res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
> -       if (res)
> -               sig = res->start;
> -       host->dma_rx = dma_request_slave_channel_compat(mask,
> -                               omap_dma_filter_fn, &sig, &pdev->dev, "rx");
> -       if (!host->dma_rx)
> -               dev_warn(host->dev, "unable to obtain RX DMA engine channel %u\n",
> -                       sig);
> +       host->dma_tx = dma_request_chan(&pdev->dev, "tx");
> +       if (IS_ERR(host->dma_tx)) {
> +               ret = PTR_ERR(host->dma_tx);
> +               if (ret == -EPROBE_DEFER)
> +                       goto err_free_iclk;
> +
> +               host->dma_tx = NULL;

Instead of setting this to NULL, let's keep its value and later check
it with IS_ERR() when needed.

> +               dev_warn(host->dev, "TX DMA channel request failed\n");
> +       }
> +
> +       host->dma_rx = dma_request_chan(&pdev->dev, "rx");
> +       if (IS_ERR(host->dma_rx)) {
> +               ret = PTR_ERR(host->dma_rx);
> +               if (ret == -EPROBE_DEFER) {
> +                       dma_release_channel(host->dma_tx);

host->dma_tx can be NULL here, so this isn't safe.

> +                       clk_put(host->fclk);
> +                       goto err_free_iclk;
> +               }
> +
> +               host->dma_rx = NULL;

Instead of setting this to NULL, let's keep its value and later check
it with IS_ERR() when needed.

> +               dev_warn(host->dev, "RX DMA channel request failed\n");
> +       }
>
>         ret = request_irq(host->irq, mmc_omap_irq, 0, DRIVER_NAME, host);
>         if (ret)
> --
> 2.8.1
>

Kind regards
Uffe
