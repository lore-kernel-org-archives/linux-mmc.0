From: Axel Lin <axel.lin@ingics.com>
Subject: Re: [RESEND][PATCH] mmc: wmt-sdmmc: Remove deprecated IRQF_DISABLED
Date: Fri, 23 May 2014 16:39:00 +0800
Message-ID: <CAFRkauB7OsS8kDy81BnMhZkR55p6JsjqL4atqohDxTFKYXWx3Q@mail.gmail.com>
References: <1398594331.6291.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:55052 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbaEWIjB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 May 2014 04:39:01 -0400
Received: by mail-qc0-f171.google.com with SMTP id x13so7592047qcv.16
        for <linux-mmc@vger.kernel.org>; Fri, 23 May 2014 01:39:00 -0700 (PDT)
In-Reply-To: <1398594331.6291.4.camel@phoenix>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Tony Prisk <linux@prisktech.co.nz>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-mmc@vger.kernel.org

2014-04-27 18:25 GMT+08:00 Axel Lin <axel.lin@ingics.com>:
> It's a NOOP since 2.6.35 and it will be removed one day.
> This is not trivial because current code uses hard coded 32 instead of
> IRQF_DISABLED in the request_irq call.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> This patch was sent on:
> http://www.spinics.net/lists/linux-mmc/msg22644.html
>
>  drivers/mmc/host/wmt-sdmmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
> index 5501c9f..8a48a50 100644
> --- a/drivers/mmc/host/wmt-sdmmc.c
> +++ b/drivers/mmc/host/wmt-sdmmc.c
> @@ -829,7 +829,7 @@ static int wmt_mci_probe(struct platform_device *pdev)
>                 goto fail3;
>         }
>
> -       ret = request_irq(dma_irq, wmt_mci_dma_isr, 32, "sdmmc", priv);
> +       ret = request_irq(dma_irq, wmt_mci_dma_isr, 0, "sdmmc", priv);


Hi Ulf,
Would you pick up this one?

I have no idea why current uses hard-coded 32 rather than IRQF_DISABLED.
IRQF_DISABLED is marked as DEPRECATED anyway, so just set 0 for the flags
field of request_irq.

Regards,
Axel
