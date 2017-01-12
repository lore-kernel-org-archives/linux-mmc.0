From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: vub300: Remove bogus check of irqs_queued
Date: Thu, 12 Jan 2017 13:01:35 +0100
Message-ID: <CAPDyKFqY=1nm3aAzbCDo-e=_3v_fXUat+qoE=YgdPnm1F_nEow@mail.gmail.com>
References: <1484108089-5454-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:34466 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751675AbdALMBh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Jan 2017 07:01:37 -0500
Received: by mail-wm0-f53.google.com with SMTP id f73so3621408wmf.1
        for <linux-mmc@vger.kernel.org>; Thu, 12 Jan 2017 04:01:36 -0800 (PST)
In-Reply-To: <1484108089-5454-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 11 January 2017 at 05:14, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> It's unnecessary to check the irqs_queued value as
> it always needs to queue one if irq isn't enabled.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
>  drivers/mmc/host/vub300.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> index bb3e0d1..21ea776 100644
> --- a/drivers/mmc/host/vub300.c
> +++ b/drivers/mmc/host/vub300.c
> @@ -640,8 +640,6 @@ static void __vub300_irqpoll_response(struct vub300_mmc_host *vub300)
>                 mutex_lock(&vub300->irq_mutex);
>                 if (vub300->irq_enabled)
>                         mmc_signal_sdio_irq(vub300->mmc);
> -               else if (vub300->irqs_queued)
> -                       vub300->irqs_queued += 1;
>                 else
>                         vub300->irqs_queued += 1;
>                 vub300->irq_disabled = 0;
> --
> 1.9.1
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
