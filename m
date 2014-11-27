From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: davinci_mmc: add warnings for edma failures
Date: Thu, 27 Nov 2014 11:04:25 +0100
Message-ID: <CAPDyKFrBgv9OTzwNfiOSn58Ai7QTbrZm4pKgLrzrM1MgD4=zAA@mail.gmail.com>
References: <546FD21C.7010208@sysam.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:52175 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754085AbaK0KEZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Nov 2014 05:04:25 -0500
Received: by mail-ob0-f170.google.com with SMTP id wp18so3530784obc.29
        for <linux-mmc@vger.kernel.org>; Thu, 27 Nov 2014 02:04:25 -0800 (PST)
In-Reply-To: <546FD21C.7010208@sysam.it>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Angelo Dureghello <angelo@sysam.it>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 22 November 2014 at 01:00, Angelo Dureghello <angelo@sysam.it> wrote:
> Add warnings in case the edma engine driver fails to allocate slots or
> channels requested from the davinci_mmc driver.
>
> Some ti-davinci based boards (i.e. board-da850-evm.c) are asking for
> some reserved chans / slots at board init stage. Later, the mmc driver
> results in a silent locked state.

So why does davinci_acquire_dma_channels() succeed then? Isn't that
real problem you should be looking into?

Kind regards
Uffe

>
> Signed-off-by: Angelo Dureghello <angelo <at> sysam.it>
>
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index 5d4c5e0..65d4990 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -439,8 +439,8 @@ static int mmc_davinci_send_dma_request(struct
> mmc_davinci_host *host,
>                                 DMA_MEM_TO_DEV,
>                                 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>                 if (!desc) {
> -                       dev_dbg(mmc_dev(host->mmc),
> -                               "failed to allocate DMA TX descriptor");
> +                       WARN(1, KERN_WARNING
> +                               "failed to allocate DMA TX descriptor\n");
>                         ret = -1;
>                         goto out;
>                 }
> @@ -461,8 +461,8 @@ static int mmc_davinci_send_dma_request(struct
> mmc_davinci_host *host,
>                                 DMA_DEV_TO_MEM,
>                                 DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
>                 if (!desc) {
> -                       dev_dbg(mmc_dev(host->mmc),
> -                               "failed to allocate DMA RX descriptor");
> +                       WARN(1, KERN_WARNING
> +                               "failed to allocate DMA RX descriptor\n");
>                         ret = -1;
>                         goto out;
>                 }
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
