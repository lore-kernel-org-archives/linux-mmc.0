From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: toshsd: Fix unbalanced locking
Date: Fri, 19 Dec 2014 11:58:10 +0100
Message-ID: <CAPDyKFpyakr0duaEdw2FzqMvwSZ+zbpWR9biA2cE-RKnB=DAgA@mail.gmail.com>
References: <1418267444.21421.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:53766 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230AbaLSK6M (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Dec 2014 05:58:12 -0500
Received: by mail-qa0-f44.google.com with SMTP id bm13so443695qab.17
        for <linux-mmc@vger.kernel.org>; Fri, 19 Dec 2014 02:58:11 -0800 (PST)
In-Reply-To: <1418267444.21421.1.camel@phoenix>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Chris Ball <chris@printf.net>, Ondrej Zary <linux@rainbow-software.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 11 December 2014 at 04:10, Axel Lin <axel.lin@ingics.com> wrote:
> Fix returning IRQ_HANDLED with spin_lock held.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Thanks! Queued for 3.20.

Kind regards
Uffe

> ---
>  drivers/mmc/host/toshsd.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/toshsd.c b/drivers/mmc/host/toshsd.c
> index 4666262..a5aa539 100644
> --- a/drivers/mmc/host/toshsd.c
> +++ b/drivers/mmc/host/toshsd.c
> @@ -176,7 +176,8 @@ static irqreturn_t toshsd_thread_irq(int irq, void *dev_id)
>         spin_lock_irqsave(&host->lock, flags);
>
>         if (!sg_miter_next(sg_miter))
> -               return IRQ_HANDLED;
> +               goto done;
> +
>         buf = sg_miter->addr;
>
>         /* Ensure we dont read more than one block. The chip will interrupt us
> @@ -198,6 +199,7 @@ static irqreturn_t toshsd_thread_irq(int irq, void *dev_id)
>         sg_miter->consumed = count;
>         sg_miter_stop(sg_miter);
>
> +done:
>         spin_unlock_irqrestore(&host->lock, flags);
>
>         return IRQ_HANDLED;
> --
> 1.9.1
>
>
>
