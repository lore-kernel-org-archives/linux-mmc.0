From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 4/4] mmc: atmel-mci: use probe deferring if dma
 controller is not ready yet
Date: Tue, 25 Nov 2014 13:37:20 +0100
Message-ID: <CAPDyKFq-0EaGSf9Mn7aMa1s9CCP5hxqRCkKrZrAnSs-h5OFmxw@mail.gmail.com>
References: <1416584018-8561-1-git-send-email-ludovic.desroches@atmel.com>
	<1416584018-8561-5-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:60161 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025AbaKYMhV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Nov 2014 07:37:21 -0500
Received: by mail-qa0-f52.google.com with SMTP id dc16so295389qab.11
        for <linux-mmc@vger.kernel.org>; Tue, 25 Nov 2014 04:37:20 -0800 (PST)
In-Reply-To: <1416584018-8561-5-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Ball <chris@printf.net>, Nicolas Ferre <nicolas.ferre@atmel.com>, Arnd Bergmann <arnd@arndb.de>

On 21 November 2014 at 16:33, Ludovic Desroches
<ludovic.desroches@atmel.com> wrote:
> Return probe defer if requesting a dma channel without a dma controller
> probed.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  drivers/mmc/host/atmel-mci.c | 46 ++++++++++++++++++++++++--------------------
>  1 file changed, 25 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 28546c3..d3c269e 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -2265,29 +2265,29 @@ static void atmci_cleanup_slot(struct atmel_mci_slot *slot,
>         mmc_free_host(slot->mmc);
>  }
>
> -static bool atmci_configure_dma(struct atmel_mci *host)
> +static int atmci_configure_dma(struct atmel_mci *host)
>  {
> -       if (host == NULL)
> -               return false;
> +       int ret = 0;
>
> -       host->dma.chan = dma_request_slave_channel(&host->pdev->dev, "rxtx");
> -       if (!host->dma.chan) {
> -               dev_warn(&host->pdev->dev, "no DMA channel available\n");
> -               return false;
> -       } else {
> -               dev_info(&host->pdev->dev,
> -                                       "using %s for DMA transfers\n",
> -                                       dma_chan_name(host->dma.chan));
> -
> -               host->dma_conf.src_addr = host->mapbase + ATMCI_RDR;
> -               host->dma_conf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> -               host->dma_conf.src_maxburst = 1;
> -               host->dma_conf.dst_addr = host->mapbase + ATMCI_TDR;
> -               host->dma_conf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> -               host->dma_conf.dst_maxburst = 1;
> -               host->dma_conf.device_fc = false;
> -               return true;
> +       host->dma.chan = dma_request_slave_channel_reason(&host->pdev->dev, "rxtx");
> +       if (IS_ERR(host->dma.chan)) {
> +               ret = PTR_ERR(host->dma.chan);
> +               host->dma.chan = NULL;
> +               return ret;

As minor improvement you could just do "return PTR_ERR(host->dma.chan);"

Then add a check for "IS_ERR(host->dma.chan)" at those other places
that needs it.

>         }
> +
> +       dev_info(&host->pdev->dev, "using %s for DMA transfers\n",
> +                dma_chan_name(host->dma.chan));
> +
> +       host->dma_conf.src_addr = host->mapbase + ATMCI_RDR;
> +       host->dma_conf.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +       host->dma_conf.src_maxburst = 1;
> +       host->dma_conf.dst_addr = host->mapbase + ATMCI_TDR;
> +       host->dma_conf.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +       host->dma_conf.dst_maxburst = 1;
> +       host->dma_conf.device_fc = false;
> +
> +       return ret;
>  }
>
>  /*
> @@ -2403,7 +2403,10 @@ static int atmci_probe(struct platform_device *pdev)
>
>         /* Get MCI capabilities and set operations according to it */
>         atmci_get_cap(host);
> -       if (atmci_configure_dma(host)) {
> +       ret = atmci_configure_dma(host);
> +       if (ret == -EPROBE_DEFER)
> +               goto err_dma_probe_defer;
> +       if (ret == 0) {
>                 host->prepare_data = &atmci_prepare_data_dma;
>                 host->submit_data = &atmci_submit_data_dma;
>                 host->stop_transfer = &atmci_stop_transfer_dma;
> @@ -2476,6 +2479,7 @@ err_init_slot:
>         del_timer_sync(&host->timer);
>         if (host->dma.chan)
>                 dma_release_channel(host->dma.chan);
> +err_dma_probe_defer:
>         free_irq(irq, host);
>         return ret;
>  }
> --
> 2.0.3
>

Kind regards
Uffe
