From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RESEND][PATCH] mmc: wmt-sdmmc: Remove deprecated IRQF_DISABLED
Date: Mon, 16 Jun 2014 13:55:52 +0200
Message-ID: <CAPDyKFrRT55ZMUPsyu+iubtVJPs+tH=A0UEtFYM==4_LH05+rQ@mail.gmail.com>
References: <1398594331.6291.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:52813 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbaFPLzx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Jun 2014 07:55:53 -0400
Received: by mail-qa0-f53.google.com with SMTP id j15so7122078qaq.40
        for <linux-mmc@vger.kernel.org>; Mon, 16 Jun 2014 04:55:52 -0700 (PDT)
In-Reply-To: <1398594331.6291.4.camel@phoenix>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Chris Ball <chris@printf.net>, Tony Prisk <linux@prisktech.co.nz>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 27 April 2014 12:25, Axel Lin <axel.lin@ingics.com> wrote:
> It's a NOOP since 2.6.35 and it will be removed one day.
> This is not trivial because current code uses hard coded 32 instead of
> IRQF_DISABLED in the request_irq call.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Thanks! Applied for next.

Kind regards
Uffe

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
>         if (ret) {
>                 dev_err(&pdev->dev, "Register DMA IRQ fail\n");
>                 goto fail4;
> --
> 1.8.1.2
>
>
>
