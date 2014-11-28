From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: atmel-mci: use probe deferring if dma controller is
 not ready yet
Date: Fri, 28 Nov 2014 12:09:47 +0100
Message-ID: <CAPDyKFr5GBuWW4UxvAKz6++Qc=wACtn-+c4_s0tNLLjL3mhhMA@mail.gmail.com>
References: <CAPDyKFq-0EaGSf9Mn7aMa1s9CCP5hxqRCkKrZrAnSs-h5OFmxw@mail.gmail.com>
	<1416925541-6857-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:33105 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbaK1LJs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Nov 2014 06:09:48 -0500
Received: by mail-qc0-f176.google.com with SMTP id i17so4605585qcy.7
        for <linux-mmc@vger.kernel.org>; Fri, 28 Nov 2014 03:09:48 -0800 (PST)
In-Reply-To: <1416925541-6857-1-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Chris Ball <chris@printf.net>, Nicolas Ferre <nicolas.ferre@atmel.com>, Arnd Bergmann <arnd@arndb.de>

On 25 November 2014 at 15:25, Ludovic Desroches
<ludovic.desroches@atmel.com> wrote:
> Return probe defer if requesting a dma channel without a dma controller
> probed.
>
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>
> Hi Ulf,
>
> I didn't send the whole set of patches for this small change, tell me if you
> want a new series.

I tried to apply the patchset and get two problems.

1) This patch 4 has checkpatch errors.
2) I hit conflicts on patch2.

Please resend the complete patchset fixing the above.

Kind regards
Uffe

>
>  drivers/mmc/host/atmel-mci.c | 49 ++++++++++++++++++++++----------------------
>  1 file changed, 25 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 28546c3..f4daef9 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -2265,29 +2265,26 @@ static void atmci_cleanup_slot(struct atmel_mci_slot *slot,
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
> -       }
> +       host->dma.chan = dma_request_slave_channel_reason(&host->pdev->dev, "rxtx");
> +       if (IS_ERR(host->dma.chan))
> +               return PTR_ERR(host->dma.chan);
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
> @@ -2403,7 +2400,10 @@ static int atmci_probe(struct platform_device *pdev)
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
> @@ -2474,8 +2474,9 @@ err_dma_alloc:
>         }
>  err_init_slot:
>         del_timer_sync(&host->timer);
> -       if (host->dma.chan)
> +       if (!IS_ERR(host->dma.chan))
>                 dma_release_channel(host->dma.chan);
> +err_dma_probe_defer:
>         free_irq(irq, host);
>         return ret;
>  }
> @@ -2501,7 +2502,7 @@ static int atmci_remove(struct platform_device *pdev)
>         clk_disable_unprepare(host->mck);
>
>         del_timer_sync(&host->timer);
> -       if (host->dma.chan)
> +       if (!IS_ERR(host->dma.chan))
>                 dma_release_channel(host->dma.chan);
>
>         free_irq(platform_get_irq(pdev, 0), host);
> --
> 2.0.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
