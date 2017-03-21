From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC] mmc: tmio: always unmap DMA before waiting for interrupt
Date: Tue, 21 Mar 2017 11:09:04 +0100
Message-ID: <CAPDyKFpGj2iz9_rh7gsWpZ83QxHUBvcz1Hoy9gcn2DBSPqkVcw@mail.gmail.com>
References: <20170316105602.2581-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:36693 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756327AbdCUKJn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Mar 2017 06:09:43 -0400
Received: by mail-vk0-f53.google.com with SMTP id j64so74391471vkg.3
        for <linux-mmc@vger.kernel.org>; Tue, 21 Mar 2017 03:09:05 -0700 (PDT)
In-Reply-To: <20170316105602.2581-1-wsa+renesas@sang-engineering.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

On 16 March 2017 at 11:56, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> In the (maybe academical) case, we don't get a DATAEND interrupt after
> DMA completed, we will wait endlessly for the completion to complete.
> This is not bad per se, since we have a more generic completion tracking
> a timeout. In that rare case, however, the DMA buffer will not get
> unmapped and we have a leak. Reorder the code, so unmapping will always
> take place.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
> It's probably academical, still I think it is better to not have any leaks in
> favor of slightly more lock hazzling. Open for opionions, though, this is why
> I send out as RFC.
>
>  drivers/mmc/host/tmio_mmc_dma.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
> index c7684fa91f1f9c..e2093db2b7ffce 100644
> --- a/drivers/mmc/host/tmio_mmc_dma.c
> +++ b/drivers/mmc/host/tmio_mmc_dma.c
> @@ -47,8 +47,6 @@ static void tmio_mmc_dma_callback(void *arg)
>  {
>         struct tmio_mmc_host *host = arg;
>
> -       wait_for_completion(&host->dma_dataend);
> -
>         spin_lock_irq(&host->lock);
>
>         if (!host->data)
> @@ -63,6 +61,11 @@ static void tmio_mmc_dma_callback(void *arg)
>                              host->sg_ptr, host->sg_len,
>                              DMA_TO_DEVICE);
>
> +       spin_unlock_irq(&host->lock);
> +
> +       wait_for_completion(&host->dma_dataend);
> +
> +       spin_lock_irq(&host->lock);
>         tmio_mmc_do_data_irq(host);
>  out:
>         spin_unlock_irq(&host->lock);
> --
> 2.11.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
