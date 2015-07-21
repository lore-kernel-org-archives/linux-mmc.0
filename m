From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdio: avoid using NULL sdio_irq_thread pointer
Date: Tue, 21 Jul 2015 13:11:58 +0200
Message-ID: <CAPDyKFoDXe_bO6M_XMw74OKnZxdp2sAizZORVg4NZQJyqxs+OQ@mail.gmail.com>
References: <1436499405-41847-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35884 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752173AbbGULL7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jul 2015 07:11:59 -0400
Received: by qkdv3 with SMTP id v3so130063502qkd.3
        for <linux-mmc@vger.kernel.org>; Tue, 21 Jul 2015 04:11:58 -0700 (PDT)
In-Reply-To: <1436499405-41847-1-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 10 July 2015 at 05:36, Yangbo Lu <yangbo.lu@freescale.com> wrote:
> For Freescale QorIQ LS1021AQDS board, there is a SDIO interrupt
> in the process of resume without inserting SD adapter because of
> some unknown issue. But the driver doesn't assign sdio_irq_thread
> pointer. This will block the resume of kernel. This patch is used
> to avoid using NULL sdio_irq_thread pointer.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>

Thanks, applied!

Kind regards
Uffe

> ---
>  include/linux/mmc/host.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 1369e54..83b81fd 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -412,7 +412,8 @@ static inline void mmc_signal_sdio_irq(struct mmc_host *host)
>  {
>         host->ops->enable_sdio_irq(host, 0);
>         host->sdio_irq_pending = true;
> -       wake_up_process(host->sdio_irq_thread);
> +       if (host->sdio_irq_thread)
> +               wake_up_process(host->sdio_irq_thread);
>  }
>
>  void sdio_run_irqs(struct mmc_host *host);
> --
> 2.1.0.27.g96db324
>
